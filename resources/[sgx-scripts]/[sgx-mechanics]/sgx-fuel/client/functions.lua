function WaitCore()
    while not Core do
        Wait(0) 
    end
end

function IsVehicleBlacklisted(veh)
	if Config.Debug then print("IsVehicleBlacklisted("..tostring(veh)..")") end
	if veh and veh ~= 0 then
		veh = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(veh) or veh))
		if Config.Debug then print("Vehicle: "..veh) end
		if Config.blacklistedVehicles[veh] then
			if Config.Debug then print("Vehicle: "..veh.." is in the Blacklist.") end
			return true
		end
		if Config.Debug then print("Vehicle is not blacklisted.") end
		return false
	else
		if Config.Debug then print("veh is nil!") end
		return false
	end
end

function HandleFuelConsumption(vehicle)
	if not DecorExistOn(vehicle, Config.FuelDecor) then
		SetFuel(vehicle, math.random(200, 800) / 10)
	elseif not fuelSynced then
		SetFuel(vehicle, GetFuel(vehicle))
		fuelSynced = true
	end
	if IsVehicleEngineOn(vehicle) then
		SetFuel(vehicle, GetVehicleFuelLevel(vehicle) - Config.fuelUsage[Round(GetVehicleCurrentRpm(vehicle), 1)] * (Config.Classes[GetVehicleClass(vehicle)] or 1.0) / 10)
	end
end

function NuiMessage(action, payload)
    while not nuiLoaded do
        Wait(0)
    end
    SendNUIMessage({
        action = action,
        payload = payload
    }) 
end

function closeFuelMenu()
	SetNuiFocus(false, false)
	nuiOpened = false
end

function vehicleInFront()
	local ped = PlayerPedId()
	local pedCoords = GetEntityCoords(ped)
    local entity = nil
    local offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 2.0, 0.0)
    local rayHandle = CastRayPointToPoint(pedCoords.x, pedCoords.y, pedCoords.z - 1.3, offset.x, offset.y, offset.z, 10, ped, 0)
    local A, B, C, D, entity = GetRaycastResult(rayHandle)
    if IsEntityAVehicle(entity) then
        return entity
    end
end

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function LoadAnimDict(dict)
	if not HasAnimDictLoaded(dict) then
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Wait(1)
		end
	end
end

function FindNearestFuelPump()
	local coords = GetEntityCoords(PlayerPedId())
	local fuelPumps = {}
	local handle, object = FindFirstObject()
	local success

	repeat
		if Config.pumpModels[GetEntityModel(object)] then
			table.insert(fuelPumps, object)
		end

		success, object = FindNextObject(handle, object)
	until not success

	EndFindObject(handle)

	local pumpObject = 0
	local pumpDistance = 1000

	for _, fuelPumpObject in pairs(fuelPumps) do
		local dstcheck = #(coords - GetEntityCoords(fuelPumpObject))

		if dstcheck < pumpDistance then
			pumpDistance = dstcheck
			pumpObject = fuelPumpObject
		end
	end
	return pumpObject, pumpDistance
end

function grabNozzle(pump,pumpHandle)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		return
	end
	LoadAnimDict("anim@am_hold_up@male")
    TaskPlayAnim(ped, "anim@am_hold_up@male", "shoplift_high", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
    Wait(300)
    nozzle = CreateObject(`prop_cs_fuel_nozle`, 0, 0, 0, true, true, true)
    AttachEntityToEntity(nozzle, ped, GetPedBoneIndex(ped, 0x49D9), 0.11, 0.02, 0.02, -80.0, -90.0, 15.0, true, true, false, true, 1, true)
    RopeLoadTextures()
    while not RopeAreTexturesLoaded() do
        Wait(0)
    end
    RopeLoadTextures()
    while not pump do
        Wait(0)
    end
    rope = AddRope(pump.x, pump.y, pump.z, 0.0, 0.0, 0.0, 3.0, 1, 1000.0, 0.0, 1.0, false, false, false, 1.0, true)
    while not rope do
        Wait(0)
    end
    ActivatePhysics(rope)
    Wait(50)
    local nozzlePos = GetEntityCoords(nozzle)
    nozzlePos = GetOffsetFromEntityInWorldCoords(nozzle, 0.0, -0.033, -0.195)
    AttachEntitiesToRope(rope, pumpHandle, nozzle, pump.x, pump.y, pump.z + 1.45, nozzlePos.x, nozzlePos.y, nozzlePos.z, 5.0, false, false, nil, nil)
	usedPump = pumpHandle
	pumpGrabbed = true
	Wait(1000)
	ClearPedTasks(PlayerPedId())
end

function deleteNozzle()
	pumpGrabbed = false
    nozzleInVehicle = false
    nozzleDropped = false
    holdingNozzle = false
    usedPump = nil
	LoadAnimDict("anim@am_hold_up@male")
	TaskPlayAnim(PlayerPedId(), "anim@am_hold_up@male", "shoplift_high", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
	Wait(300)
	DeleteEntity(nozzle)
    RopeUnloadTextures()
    DeleteRope(rope)
	Wait(1000)
	ClearPedTasks(PlayerPedId())
end

function returnNozzle()
    DeleteEntity(nozzle)
    RopeUnloadTextures()
    DeleteRope(rope)
    pumpGrabbed = false
    nozzleDropped = false
    holdingNozzle = false
    nozzleInVehicle = false
    usedPump = nil
end

function dropNozzle()
    DetachEntity(nozzle, true, true)
	nozzleDropped = true
    holdingNozzle = false
    nozzleInVehicle = false
end

function grabExistingNozzle()
	local ped = PlayerPedId()
    AttachEntityToEntity(nozzle, ped, GetPedBoneIndex(ped, 0x49D9), 0.11, 0.02, 0.02, -80.0, -90.0, 15.0, true, true, false, true, 1, true)
    nozzleDropped = false
	holdingNozzle = true
	nozzleInVehicle = false
end

function putNozzleInVehicle(vehicle, ptankBone, isBike, dontClear, newTankPosition)
    AttachEntityToEntity(nozzle, vehicle, ptankBone, -0.18 + newTankPosition.x, 0.0 + newTankPosition.y, 0.75 + newTankPosition.z, -125.0, -90.0, -90.0, true, true, false, false, 1, true)
    if not dontClear and IsEntityPlayingAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3) then
        ClearPedTasks(ped)
    end
    nozzleDropped = false
    holdingNozzle = false
	nozzleInVehicle = true
	openFuelMenu()
end