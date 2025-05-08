fuelSynced, nuiLoaded, nuiOpened, Core, pumpGrabbed,isNearPump,nozzleInVehicle = false, false, false, nil, false, nil,false
speedMultiplier = Config.SpeedUnit == "KMH" and 3.6 or 2.23694

CreateThread(function()
	Core, Config.Framework = GetCore()
    DecorRegister(Config.FuelDecor, 1)
	NuiMessage("SET_DEFAULT_CAR_PHOTO", Config.defaultVehicleImage)
	NuiMessage("SET_SPEED_UNITH", Config.SpeedUnit)
	NuiMessage("SET_FUEL_PRICES", Config.Prices)
    NuiMessage("SET_LOCALES", Config.Locales)
end)

-- Blip

if Config.showNearestBlips then
	CreateThread(function()
		local currentGasBlip = 0
		while true do
			local coords = GetEntityCoords(PlayerPedId())
			local closest = 1000
			local closestCoords
			for _, gasStationCoords in pairs(Config.Locations) do
				local dstcheck = GetDistanceBetweenCoords(coords, gasStationCoords)

				if dstcheck < closest then
					closest = dstcheck
					closestCoords = gasStationCoords
				end
			end
			if DoesBlipExist(currentGasBlip) then
				RemoveBlip(currentGasBlip)
			end
			currentGasBlip = CreateBlip(closestCoords)
			Wait(10000)
		end
	end)
elseif Config.showAllBlips then
	CreateThread(function()
		for _, gasStationCoords in pairs(Config.Locations) do
			CreateBlip(gasStationCoords)
		end
	end)
end

-- Fuel Usage

CreateThread(function()
	while true do
		Wait(1000)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)
			inBlacklisted = IsVehicleBlacklisted(vehicle)
			if not inBlacklisted and GetPedInVehicleSeat(vehicle, -1) == ped then
				HandleFuelConsumption(vehicle)
			end
		else
			if fuelSynced then fuelSynced = false end
			if inBlacklisted then inBlacklisted = false end
			Wait(500)
		end
	end
end)

RegisterNUICallback("LOADED", function(data, cb)
    nuiLoaded = true
    cb("ok")
end)

RegisterNUICallback("CLOSE_FUEL_MENU", function(data, cb)
	closeFuelMenu()
	cb("ok")
end)

CreateThread(function()
    while not nuiLoaded do
        if Config.Debug then
            print('Waiting for nui to load')
        end
        if NetworkIsSessionStarted() then
            SendNUIMessage({
                action = "CHECK_NUI",
            }) 
        end
        Wait(2000)
    end
end)

RegisterNetEvent(Config.eventPrefix .. ":client:openFuelMenu", function()
	openFuelMenu()
end)

local nozzleBasedOnClass = {
    0.65, -- Compacts
    0.65, -- Sedans
    0.85, -- SUVs
    0.6, -- Coupes
    0.55, -- Muscle
    0.6, -- Sports Classics
    0.6, -- Sports
    0.55, -- Super
    0.12, -- Motorcycles
    0.8, -- Off-road
    0.7, -- Industrial
    0.6, -- Utility
    0.7, -- Vans
    0.0, -- Cycles
    0.0, -- Boats
    0.0, -- Helicopters
    0.0, -- Planes
    0.6, -- Service
    0.65, -- Emergency
    0.65, -- Military
    0.75, -- Commercial
    0.0 -- Trains
}

CreateThread(function()
    local wait = 1500
    while true do
        Wait(wait)
        if pumpGrabbed then
            wait = 0

			if usedPump then
                pumpCoords = GetEntityCoords(usedPump)
            end

            if nozzle and pumpCoords then
                local ped = PlayerPedId()
				local pedCoords = GetEntityCoords(ped)
				local nozzleLocation = GetEntityCoords(nozzle)
                if #(nozzleLocation - pumpCoords) > 6.0 then
                    dropNozzle()
                elseif #(nozzleLocation - pedCoords) > 5.0 and IsPedInAnyVehicle(PlayerPedId()) then
                    Wait(500)
                    if Config.Debug then
                        print('Vehicle detected, dropping nozzle')
                    end
                    deleteNozzle()
                elseif #(pumpCoords - pedCoords) > 25.0 then
                    returnNozzle()
                end
                if nozzleDropped and #(nozzleLocation - pedCoords) < 1.5 then
                    DrawText3D(nozzleLocation.x, nozzleLocation.y, nozzleLocation.z, '[E]' .. Config.Locales['GRAB_NOZZLE'])
                    if IsControlJustPressed(0, 51) then
                        LoadAnimDict("anim@mp_snowball")
                        TaskPlayAnim(ped, "anim@mp_snowball", "pickup_snowball", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
                        Wait(700)
                        grabExistingNozzle()
                        ClearPedTasks(ped)
                    end
                end
            end


			local veh = vehicleInFront()

            if veh and not IsVehicleBlacklisted(veh) then
                local vehClass = GetVehicleClass(veh)
                local zPos = nozzleBasedOnClass[vehClass + 1]
                local isBike = false
                local nozzleModifiedPosition = {
                    x = 0.0,
                    y = 0.0,
                    z = 0.0
                }
                local textModifiedPosition = {
                    x = 0.0,
                    y = 0.0,
                    z = 0.0
                }
                
                if vehClass == 8 and vehClass ~= 13 then
                    tankBone = GetEntityBoneIndexByName(veh, "petrolcap")
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "petroltank")
                    end
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "engine")
                    end
                    isBike = true
                elseif vehClass ~= 13 then
                    tankBone = GetEntityBoneIndexByName(veh, "petrolcap")
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "petroltank_l")
                    end
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "hub_lr")
                    end
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "handle_dside_r")
                        nozzleModifiedPosition.x = 0.1
                        nozzleModifiedPosition.y = -0.5
                        nozzleModifiedPosition.z = -0.6
                        textModifiedPosition.x = 0.55
                        textModifiedPosition.y = 0.1
                        textModifiedPosition.z = -0.2
                    end
                end
                tankPosition = GetWorldPositionOfEntityBone(veh, tankBone)
				local ped = PlayerPedId()
				local pedCoords = GetEntityCoords(ped)
                if tankPosition and #(pedCoords - tankPosition) < 1.2 then
                    if not nozzleInVehicle then
                        nearTank = true
                        DrawText3D(tankPosition.x + textModifiedPosition.x, tankPosition.y + textModifiedPosition.y, tankPosition.z + zPos + textModifiedPosition.z, Config.Locales['ATTACH_NOZZLE'])
                        if IsControlJustPressed(0, 38) then
                            LoadAnimDict("timetable@gardener@filling_can")
                            TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
                            Wait(300)
                            putNozzleInVehicle(veh, tankBone, isBike, true, nozzleModifiedPosition)
                            Wait(300)
                            ClearPedTasks(ped)
                        end
                    elseif nozzleInVehicle then
                        DrawText3D(tankPosition.x + textModifiedPosition.x, tankPosition.y + textModifiedPosition.y, tankPosition.z + zPos + textModifiedPosition.z, '[E] '.. Config.Locales['GRAB_NOZZLE'])
                        if IsControlJustPressed(0, 38) then
                            LoadAnimDict("timetable@gardener@filling_can")
                            TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
                            Wait(300)
                            grabExistingNozzle()
                            Wait(300)
                            ClearPedTasks(ped)
                        end
                    end 
                end
            else
                nearTank = false
            end

        else
            wait = 500
        end
    end
end)

if Config.InteractionHandler == 'drawtext' then
    CreateThread(function()
        while true do

            local pumpObject, pumpDistance = FindNearestFuelPump()
            if pumpDistance < 2.5 then
                isNearPump = pumpObject
            else
                isNearPump = nil
                if Config.Debug then
                    print('No pump found',math.ceil(pumpDistance * 20))
                end
                Wait(math.ceil(pumpDistance * 20))
            end
            Wait(500)
        end
    end)
end