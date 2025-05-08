local QBCore = exports[Config.Core]:GetCoreObject()

local beanseat = nil
local sitting = false
local Chairs = {}

CreateThread(function()
	for k, v in pairs(Config.Chairs) do
		Chairs["coolbeans"..k] =
		exports['qb-target']:AddBoxZone("coolbeans"..k, vec3(v.coords.x, v.coords.y, v.coords.z-1), 0.7, 0.7, { name="coolbeans"..k, heading = v.coords.w, debugPoly=Config.Debug, minZ = v.coords.z-1.2, maxZ = v.coords.z+0.1, },
			{ options = { { event = "qb-coolbeans:Chair", icon = "fas fa-chair", label = Loc[Config.Lan].targetinfo["sit_down"], loc = v.coords, stand = v.stand }, },
				distance = 2.2 })
	end
end)

RegisterNetEvent('qb-coolbeans:Chair', function(data)
	local canSit = true
	local sitting = false
	local ped = PlayerPedId()
	for _, v in pairs(QBCore.Functions.GetPlayersFromCoords(data.loc.xyz, 0.6)) do
		local dist = #(GetEntityCoords(GetPlayerPed(v)) - data.loc.xyz)
		if dist <= 0.4 then triggerNotify(nil, Loc[Config.Lan].error["someone_already_sitting"]) canSit = false end
	end
	if canSit then
		if not IsPedHeadingTowardsPosition(ped, data.loc.xyz, 20.0) then TaskTurnPedToFaceCoord(ped, data.loc.xyz, 1500) Wait(1500)	end
		if #(data.loc.xyz - GetEntityCoords(PlayerPedId())) > 1.5 then TaskGoStraightToCoord(ped, data.loc.xyz, 0.5, 1000, 0.0, 0) Wait(1100) end
		TaskStartScenarioAtPosition(PlayerPedId(), "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", data.loc.x, data.loc.y, data.loc.z-0.5, data.loc[4], 0, 1, true)
		beanseat = data.stand
		sitting = true
	end
	while sitting do
		if sitting then
			if IsControlJustReleased(0, 202) and IsPedUsingScenario(ped, "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER") then
				sitting = false
				ClearPedTasks(ped)
				if beanseat then SetEntityCoords(ped, beanseat) end
				beanseat = nil
			end
		end
		Wait(5) if not IsPedUsingScenario(ped, "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER") then sitting = false end
	end
end)

Config.Chairs = {}
for k, v in pairs(Config.Locations) do
	if v.zoneEnable and k == "beangabzlegion" then
		--STOOLS
		Config.Chairs[#Config.Chairs+1] = { coords = vec4(0, 0, 0, 0), stand = vec3(0, 0, 0) }
	end
	if v.zoneEnable and k == "beanunclejust" then
		--STOOLS
		Config.Chairs[#Config.Chairs+1] = { coords = vec4(0, 0, 0, 0), stand = vec3(0, 0, 0) }
	end
	if v.zoneEnable and k == "beanrflx" then
		Config.Chairs[#Config.Chairs+1] = { coords = vec4(0, 0, 0, 0), stand = vec3(0, 0, 0) }
	end
end

AddEventHandler('onResourceStop', function(r) if r ~= GetCurrentResourceName() then return end
	if GetResourceState("qb-target") == "started" or GetResourceState("ox_target") == "started" then
		for k, v in pairs(Chairs) do exports['qb-target']:RemoveZone(k) end
	end
end)