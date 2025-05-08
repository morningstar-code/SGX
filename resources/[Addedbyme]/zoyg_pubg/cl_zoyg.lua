local QBCore = exports['qb-core']:GetCoreObject()

local currentSafezoneBlip
local currentSafezoneCoord
local currentSafezoneRadius
local startpressed = false
menuOpen = false
draw = true
status = "INACTIVE"
isInMatch = false
isZoneActive = false
isOutOfTheZone = false
hasExitedMap = true
inQueue = false
-- aeroplano
local PlaneNet = 0
InPlane = false
local allSeats = {{ pos = vector3(1.0, -9.2, 0.0), rot = 90.0 }}
local StartTime
local plane
local driver = nil
local playersin = 0
viewCam = nil


Citizen.CreateThread(function()

	while QBCore.Functions.GetPlayerData().job == nil do
		Wait(100)
	end
	
	while QBCore.Functions.GetPlayerData().citizenid == nil do
        Wait(100)
    end
	
	--ESX.PlayerData = QBCore.Functions.GetPlayerData()
	Wait(250)
	--if ESX.IsPlayerLoaded() then
		--Citizen.Wait(81)
		--[[ESX.TriggerServerCallback("zoyg_pubg:getstatus", function(result) 
			isEnablePUBG = result
		end)]]
	--end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(PlayerData)
	Citizen.Wait(81)
	status = "INACTIVE"
	QBCore.Functions.TriggerCallback("zoyg_pubg:getstatus", function(result) 
		isEnablePUBG = result
	end)

end)



Citizen.CreateThread(function()
	
	while QBCore.Functions.GetPlayerData().job == nil do
		Wait(100)
	end
	
end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local dist =  #(vector3(Config.NpcCoords.x,Config.NpcCoords.y,Config.NpcCoords.z) - coords)
		
		if dist <= 5 then
			if draw then
				DrawText3D(Config.NpcCoords.x,Config.NpcCoords.y,Config.NpcCoords.z,"Press ~r~[E]~s~ to open ~y~PUBG~s~ menu")
				DrawText3Ds(Config.NpcCoords.x,Config.NpcCoords.y,Config.NpcCoords.z+1,"~y~PUBG")
			end
			if not menuOpen then
				if IsControlJustReleased(0, 38) then
					OpenPUBGMenu()
					--print('you presssed fucking eee')
				end
			else
				Citizen.Wait(3000)
			end
		elseif dist >= 5 and dist <= 10 then
			if draw then
				DrawText3Ds(Config.NpcCoords.x,Config.NpcCoords.y,Config.NpcCoords.z+1,"~y~PUBG")
			end
		end
	end
end)

Citizen.CreateThread(function()
	npcHash = GetHashKey("s_m_y_swat_01")
    RequestModel(npcHash)
    while not HasModelLoaded(npcHash) do
        Wait(1)
    end
    npc = CreatePed(1, npcHash, Config.NpcCoords.x,Config.NpcCoords.y,Config.NpcCoords.z-1, Config.NpcCoords.h, false, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    SetPedDiesWhenInjured(npc, false)
    SetPedCanPlayAmbientAnims(npc, true)
    SetPedCanRagdollFromPlayerImpact(npc, false)
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)
    TaskStartScenarioInPlace(npc, "WORLD_HUMAN_COP_IDLES", 0, true);
end)

--==========================--
--=======NUICALLBACKS=======--
--==========================--

RegisterNUICallback('ClosePUBGMenu', function(data, cb)
	if hasExitedMap then
		SetNuiFocus(false, false)
	end
	menuOpen = false
	cb(false)
	draw = true
	SetNuiFocus(false, false)
end)

RegisterNUICallback('joinmatch', function(data)
	if not startpressed then
		startpressed = true
		ExecuteCommand("envanterisil")
		TriggerServerEvent("zoygpubg:joingame")
	end
end)



--=======================--
--=======FUNCTIONS=======--
--=======================--





function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local factor = #text / 370
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.4, 0.4)
	SetTextFont(1)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextDropshadow(2, 2, 0, 0, 0)
	AddTextComponentString(text)
	DrawText(_x,_y)
	--DrawRect(_x,_y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 120)
end


function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local factor = #text / 370
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.3, 0.3)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextDropshadow(2, 2, 0, 0, 0)
	AddTextComponentString(text)
	DrawText(_x,_y)
	DrawRect(_x,_y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 120)
end



function OpenPUBGMenu()
	menuOpen = true


	draw = false
	SetNuiFocus(true, true)
	local datmon = -1
	TriggerServerEvent('zoyg_pubg_getbppoints')
end


RegisterNetEvent("zoyg_pubg_openmenu")
AddEventHandler("zoyg_pubg_openmenu", function(name,bppoints,players,status)

	SendNUIMessage({
		type = "showmenu",
		npame = name,
		bp = bppoints,
		playerson = players,
		statuss = status,
		Configg = Config,

	})

end)

RegisterNUICallback('buyWeapon', function(data)
	if data.weaponName then
		local weapon = data.weaponName
		TriggerServerEvent("zoygpubg:buyWeapon", weapon)
	end
end)



function GetIntFromBlob(blob,byte)
	r = 0
	for i=1,8,1 do
		r = r | (string.byte(blob,byte+i)<<(i-1)*8)
	end
	return r
end


RegisterNUICallback('weaponstats', function(data)
	if data.weaponName then
		local native = 0xD92C739EE34C9EBA
		local weapon = data.weaponName
		--print(weapon)
		local hashed = GetHashKey(weapon)
		--print(hashed)
		local blob = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
		local retval = Citizen.InvokeNative(tonumber(native), tonumber(hashed), blob, Citizen.ReturnResultAnyway())
		local Damage = GetIntFromBlob(blob,0)
		local Speed = GetIntFromBlob(blob,8)
		local Capacity = GetIntFromBlob(blob,16)
		local Accuracy = GetIntFromBlob(blob,24)
		local Range = GetIntFromBlob(blob,32)
		SendNUIMessage({
			type = "previewtheweapon",
			damage = Damage,
			speed = Speed,
			capacity = Capacity,
			accuracy = Accuracy,
			range = Range,
	
		})
	end
end)




RegisterNetEvent("zoygpubg:showmystatss")
AddEventHandler("zoygpubg:showmystatss", function(wins,kills,games)
	local rank
	local killss
	local rankpoints
	local barwidth
	local winss
	local nextrank
	local gamess

	if games < 10 then
		rank = "Unranked"
		killss = kills
		rankpoints = games
		gamess = games
		barwidth = ((games / 10) * 100)
		winss = wins
		nextrank = "Bronze"
	elseif games >= 10 then
		killss = kills
		winss = wins
		gamess = games
		local rpfrwins = (winss * Config.RankPointsFromWins)
		local rpfrkills = (kills * Config.RankPointsFromKills)
		local rankpointssunolo = (rpfrwins + rpfrkills)
		if rankpointssunolo >= 0 and rankpointssunolo < 1000 then
			rank = "Bronze"
			rankpoints = rankpointssunolo
			barwidth = ((rankpointssunolo / 1000) * 100)
			nextrank = "Silver"
		elseif rankpointssunolo >= 1000 and rankpointssunolo < 2000 then
			rank = "Silver"
			rankpoints = (rankpointssunolo - 1000)
			barwidth = (((rankpointssunolo - 1000) / 1000) * 100)
			nextrank = "Gold"
		elseif rankpointssunolo >= 2000 and rankpointssunolo < 3000 then
			rank = "Gold"
			rankpoints = (rankpointssunolo - 2000)
			barwidth = (((rankpointssunolo - 2000) / 1000) * 100)
			nextrank = "Platinum"
		elseif rankpointssunolo >= 3000 and rankpointssunolo < 4000 then
			rank = "Platinum"
			rankpoints = (rankpointssunolo - 3000)
			barwidth = (((rankpointssunolo - 3000) / 1000) * 100)
			nextrank = "Diamond"
		elseif rankpointssunolo >= 4000 and rankpointssunolo < 5000 then
			rank = "Diamond"
			rankpoints = (rankpointssunolo - 4000)
			barwidth = (((rankpointssunolo - 4000) / 1000) * 100)
			nextrank = "Elite"
		elseif rankpointssunolo >= 5000 and rankpointssunolo < 6000 then
			rank = "Elite"
			rankpoints = (rankpointssunolo - 5000)
			barwidth = (((rankpointssunolo - 5000) / 1000) * 100)
			nextrank = "Master"
		elseif rankpointssunolo >= 6000  and rankpointssunolo < 7000 then
			rank = "Master"
			rankpoints = (rankpointssunolo - 6000)
			barwidth = (((rankpointssunolo - 6000) / 1000) * 100)
			nextrank = "Grandmaster"
		elseif rankpointssunolo >= 7000 then
			rank = "Grandmaster"
			rankpoints = rankpointssunolo
			barwidth = 100
			nextrank = ""
		end
	
	
	
	
	end
	Wait(0)
	SendNUIMessage({
		type = "mystatsappdata",
		rank = rank,
		kills = killss,
		rankpoints = rankpoints,
		barwidth = barwidth,
		wins = winss,
		nextrank = nextrank,
		games = gamess,
	})
end)

RegisterNUICallback('showmystats', function()
	TriggerServerEvent("zoygpubg:showmystats")
end)


RegisterNUICallback('showtopwinners', function()
	TriggerServerEvent("zoygpubg:topwinners")
end)

RegisterNUICallback('showtopkillers', function()
	TriggerServerEvent("zoygpubg:topkillers")
end)

RegisterNetEvent("zoygpubg:showtopwinars")
AddEventHandler("zoygpubg:showtopwinars", function(res)

	SendNUIMessage({
		type = "showtop10winners",
		topwin = res,
	})
end)

RegisterNetEvent("zoygpubg:showtopkillerss")
AddEventHandler("zoygpubg:showtopkillerss", function(res)

	SendNUIMessage({
		type = "showtop10killers",
		topkill = res,
	})
end)



RegisterNUICallback('buyItem', function(data)
	if data.itemName then
		local item = data.itemName
		TriggerServerEvent("zoygpubg:buyItem", item)
	end
end)

RegisterNetEvent("zoygpubg:updatebppoints")
AddEventHandler("zoygpubg:updatebppoints", function(bp)
	
	SendNUIMessage({
		type = "updatebppoints",
		bpoints = bp,
	})
end)

RegisterNetEvent('oyuncuazaltpubg')
AddEventHandler('oyuncuazaltpubg', function(source)

	
	playersin = (playersin - 1)

end) 

RegisterNetEvent("zoygpubg:donotjoinedgame")
AddEventHandler("zoygpubg:donotjoinedgame", function()
	startpressed = false
	OpenPUBGMenu()
end)


RegisterNetEvent("zoygpubg:joinedgame")
AddEventHandler("zoygpubg:joinedgame", function(game_data)
	local _playerPed = PlayerPedId()
	--ResetSafezone()
	isInMatch = true
	inQueue = true
	startpressed = false
	hasExitedMap = false
	--SetNuiFocus(false, false)
	SendNUIMessage({
		type = "show_game_ui"
	})
	SendNUIMessage({
		type = "updatetimer"
	})
	SetEntityCoords(_playerPed, Config.QueueLobby.x,Config.QueueLobby.y, Config.QueueLobby.z)
		--SetCanAttackFriendly(_playerPed, false, false)
end)

RegisterNetEvent("zoygpubg:startendtimer")
AddEventHandler("zoygpubg:startendtimer", function()
	if not hasExitedMap then
		SendNUIMessage({
			type = "startexitmaptimer"
		})
	end
end)

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		sleep = true
		if inQueue then
			--SetEntityCanBeDamaged(playerPed, false)
			SetPlayerCanDoDriveBy(playerPed, false)
			DisablePlayerFiring(playerPed, true)
			DisableControlAction(0, 140)
			sleep = false
		end
		Wait(0)
		if sleep then Wait(400) end
    end
end)

RegisterNetEvent("zoygpubg:createnetplane")
AddEventHandler("zoygpubg:createnetplane", function()
	Wait(32000)
	local netID = CreateStartPlane()
	local plane = NetworkDoesNetworkIdExist(netID) and NetworkGetEntityFromNetworkId(netID)
	TriggerServerEvent("zoygpubg:shareplane", netID,plane)
	if Config.spawnVehicles then
		for k,v in pairs(Config.Vehicles) do
			
			QBCore.Functions.SpawnVehicle(Config.Vehicles[k].model, vector3(Config.Vehicles[k].x,Config.Vehicles[k].y,Config.Vehicles[k].z), Config.Vehicles[k].h, function()
				
			end)
		end
	end
end)

RegisterNetEvent("zoygpubg:sharePlaneToCl")
AddEventHandler("zoygpubg:sharePlaneToCl", function(planee,planet)
	--local plane = NetworkDoesNetworkIdExist(planee) and NetworkGetEntityFromNetworkId(planee)
	--print(planee .. " - " .. plane .. " - " .. tostring(NetworkDoesNetworkIdExist(planee)))
	--print(planee .. " - " .. planet .. " - " .. tostring(NetworkDoesNetworkIdExist(planee)))
	PlaneNet = planee
	
end)

RegisterNUICallback('exitmapcheck', function()
	if not hasExitedMap then
		RespawnPedpl(PlayerPedId())
		StopScreenEffect('DeathFailOut')
	end
end)


RegisterNetEvent("zoygpubg:startgame")
AddEventHandler("zoygpubg:startgame", function()
	local _playerPed = PlayerPedId()
	FreezeEntityPosition(_playerPed, false)
	SendNUIMessage({
		type = "game_start"
	})
	Citizen.Wait(32000)
	--local netID = CreateStartPlane()
	--PlaneNet = netID
	--DoScreenFadeOut(1000)
	while PlaneNet == 0 do
		Citizen.Wait(0)
	end
	--Citizen.Wait(1000)
	
	local ped, plane = PlayerPedId() --GetPlayerPed()
	local planePos = vector3(Config.PlaneStartingPosition.x, Config.PlaneStartingPosition.y, Config.PlaneStartingPosition.z)
	--print(PlaneNet)
	while not plane do
		Citizen.Wait(100)
		SetEntityCoords(ped, planePos)
		plane = NetworkDoesNetworkIdExist(PlaneNet) and NetworkGetEntityFromNetworkId(PlaneNet)
		--print(plane)
	end

	print("plane found")





	--PlayAudio("PUBG", { volume = 0.1 })

	FreezeEntityPosition(ped, false)

	--print(PlaneNet .. " - " .. tostring(plane) .. " - " .. tostring(NetworkDoesNetworkIdExist(PlaneNet)))
	SeatInPlane(plane)
	CreatePlaneCam(plane)
	TriggerServerEvent('zoyg_pubg_updatealive')

	--NetworkSetFriendlyFireOption(true)
    --SetCanAttackFriendly(PlayerPedId(), true, true)

	inQueue = false
	StartTime = GetGameTimer()
	TriggerEvent('zoygpubg:startzone')
	Wait(Config.JumpTime * 1000)
	SendNUIMessage({
		type = "updatetimer"
	})
	Wait(2000)
	isZoneActive = true
	local plane = NetworkDoesNetworkIdExist(PlaneNet) and NetworkGetEntityFromNetworkId(PlaneNet)
	if plane then
		if driver ~= nil then
			SetEntityAsNoLongerNeeded(driver)
		end
		DeleteVehicle(plane)
	end
	--[[TriggerEvent('pvpmode:setCurrentSafezone')
	TriggerEvent('pvpmode:setTargetSafezone')]]
end)

RegisterNetEvent("zoyg_pubg_updatealivee")
AddEventHandler("zoyg_pubg_updatealivee", function(playerss)
	local playersin = playerss
	SendNUIMessage({
		type = "updatejumptimer",
		timercount = Config.JumpTime,
		players = playersin,
	})
end)

RegisterNetEvent("zoygpubg:updatealivepl")
AddEventHandler("zoygpubg:updatealivepl", function(playerss)
	local aliveplayers = playerss
	SendNUIMessage({
		type = "updatealiveplayers",
		players = aliveplayers,
	})
end)

RegisterNetEvent("zoygpubg:updateplkills")
AddEventHandler("zoygpubg:updateplkills", function(killss)
	local playerkills = killss
	SendNUIMessage({
		type = "updateplayerkills",
		kills = playerkills,
	})
end)

RegisterNetEvent("zoygpubg:startzone")
AddEventHandler('zoygpubg:startzone', function()
    currentSafezoneCoord = Config.MapCenter
    currentSafezoneRadius = Config.Circle.startradius
end)




Citizen.CreateThread(function()   
    while true do
		if currentSafezoneCoord ~= nil and currentSafezoneRadius ~= nil and isInMatch and isZoneActive then
				local playerPed = PlayerPedId()
				local playerPos = GetEntityCoords(GetPlayerPed(PlayerId()))
				local distance = math.abs(GetDistanceBetweenCoords(playerPos.x, playerPos.y, 0, currentSafezoneCoord.x, currentSafezoneCoord.y, 0, false))
  
				if distance > currentSafezoneRadius then
					isOutOfTheZone = true
				else
					isOutOfTheZone = false
				end
				if currentSafezoneRadius > Config.Circle.endradius then
					currentSafezoneRadius = currentSafezoneRadius - Config.CircleSpeed
				end
		else
			Wait(500)
        end
        Wait(30)
    end 
end)

Citizen.CreateThread(function()   
    while true do
		if isOutOfTheZone and isInMatch then
			local playerPed = PlayerPedId()
			ApplyDamageToPed(playerPed ,Config.CircleDamage.damage,true)
        end
		Wait(Config.CircleDamage.tickrate)
    end 
end)

Citizen.CreateThread(function()   
    while true do
		if StartTime ~= nil and isInMatch then
			local gameTime = math.max(0, math.floor((StartTime + Config.MaxGameTime * 1000 - GetGameTimer()) / 1000))
			if gameTime <= 0 then
				currentSafezoneRadius = 0.0
			end
		end
		Wait(10000)
    end 
end)

Citizen.CreateThread(function()
	while true do
		if currentSafezoneCoord ~= nil and currentSafezoneRadius ~= nil and isInMatch then
            DrawMarker(Config.Circle.MarkerId, currentSafezoneCoord.x, currentSafezoneCoord.y, currentSafezoneCoord.z, 0, 0, 0, 0, 0, 0, currentSafezoneRadius, currentSafezoneRadius, Config.Circle.Height, Config.Circle.Colour.r, Config.Circle.Colour.g, Config.Circle.Colour.b, Config.Circle.Colour.a, 0, 0, 0, 0, 0, 0, 0)
			currentSafezoneBlip = SetSafeZoneBlip(currentSafezoneBlip, currentSafezoneCoord, currentSafezoneRadius, Config.Circle.BlipColour)
			SetBlipPriority(currentSafezoneBlip, 1)
		else
			Wait(500)
        end
        Wait(0)
    end 
end)



function CreateStartPlane()
	local planeModel = "Titan"
	local pilotModel = "s_m_y_pilot_01"
	local planePos = vector3(Config.PlaneStartingPosition.x, Config.PlaneStartingPosition.y, Config.PlaneStartingPosition.z)
	RequestAndWaitModel(planeModel)

	local centerVector = vector3(Config.MapCenter.x, Config.MapCenter.y, Config.PlaneStartingPosition.z)
	local destPos = centerVector + (centerVector - planePos)

	local heading = GetHeadingFromVector_2d(destPos.x - planePos.x, destPos.y - planePos.y)

	local planeEntity = CreateVehicle(GetHashKey(planeModel), planePos, heading, true, 0)
	SetModelAsNoLongerNeeded(GetHashKey(planeModel))
	SetEntityInvincible(planeEntity, true)
	SetVehicleEngineOn(planeEntity, 1, 1, 0)
	SetVehicleForwardSpeed(planeEntity, 50.0)
	SetHeliBladesSpeed(planeEntity, 50.0)
	SetEntityCollision(planeEntity, 0, 1)
	SetEntityHeading(planeEntity, heading)
	SetVehicleLandingGear(planeEntity, 1)
	Citizen.InvokeNative(0xCFC8BE9A5E1FE575, planeEntity, 0)

	RequestAndWaitModel(pilotModel)
	driver = CreatePed(29, GetHashKey(pilotModel), GetEntityCoords(planeEntity), 0.0, true, 0)
	SetPedIntoVehicle(driver, planeEntity, -1)
	SetEntityInvincible(driver, true)
	SetBlockingOfNonTemporaryEvents(driver, true)

	Citizen.Wait(0)

	TaskVehicleDriveToCoord(driver, planeEntity, destPos.x, destPos.y, destPos.z, 70.0, 0, GetEntityModel(planeEntity), 786603, 2.0, 2.0)

	SetNetworkIdCanMigrate(VehToNet(planeEntity), false)
	SetNetworkIdCanMigrate(VehToNet(driver), false)


	print("plane created " .. VehToNet(planeEntity) .. " - " .. tostring(NetworkDoesEntityExistWithNetworkId( VehToNet(planeEntity))))

	return VehToNet(planeEntity)
end

function SeatInPlane(plane)
	forceAnim({"amb@code_human_in_bus_passenger_idles@female@sit@base", "base"}, 1)
	local seatPos = allSeats[1]
	if seatPos and plane then
		AttachEntityToEntity(PlayerPedId(), plane, 0, seatPos.pos, 0.0, 0.0, seatPos.rot, 0, 0, 0, 0, 2, true)

		--local planeBlip = AddBlipForEntity(plane)
		--SetBlipSprite(planeBlip, 307)
		--SetBlipScale(planeBlip, 1.5)
		--SetBlipRotation(planeBlip, math.floor(GetEntityHeading(plane)))
		--SetBlipDisplay(planeBlip, 8)
	end

	InPlane = true
end

function CreatePlaneCam(plane)
	viewCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
	SetCamActive(viewCam,  true)
	RenderScriptCams(true, false, 0, true, false)
	AttachCamToEntity(viewCam, plane, vector3(0.0, -30.0, 10.0), true)
	--local rot = GetGameplayCamRot(0)
	--print(rot)
	SetCamRot(viewCam, Config.PlaneCameraPosition.x, Config.PlaneCameraPosition.y, Config.PlaneCameraPosition.z, 2)
end

Citizen.CreateThread(function()
	while true do
		if InPlane then
			PlaneTick(plane)
		else
			Wait(1000)
		end
		Citizen.Wait(0)
	end
end)
--[[ find camera coords from f8 console]]
--[[
Citizen.CreateThread(function()
	while true do
		if not InPlane then

			local rot = GetGameplayCamRot(0)
			print(rot)
			Wait(1000)

			Citizen.Wait(0)
		end
	end
end)
]]

function PlaneTick(plane)
	ShowHelp("~n~Press ~INPUT_ENTER~ to jump.")
	local ped = PlayerPedId()

	--local playerCount = tableCount(self.Players)
	--local paddingX = DrawHUDRect(0.975, topRightY, "ALIVE", tostring(playerCount))
	
	local jumpTimer = math.max(0, math.floor((StartTime + Config.JumpTime * 1000 - GetGameTimer()) / 1000))
	--DrawHUDRect(0.975 - paddingX - 0.005, topRightY, "JUMP", SecondsToClock(jumpTimer))
	--print(jumpTimer)
	-- Jump system
	--if InPlane and (IsControlJustPressed(0, 23) or jumpTimer <= 5 or not DoesEntityExist(plane)) then
	if InPlane and (IsControlJustPressed(0, 23) or jumpTimer <= 1 ) then
		InPlane = false

		DetachEntity(ped, 0, 1)
		DestroyCam(viewCam, false)
		RenderScriptCams(0, 0, 0, 1, 0)


		ClearPedTasks(ped)
		SetPedGadget(ped, GetHashKey("GADGET_PARACHUTE"), true)
		GiveWeaponToPed(ped, GetHashKey("GADGET_PARACHUTE"), 1, false, true)
	end
end

AddEventHandler('gameEventTriggered', function (eventName, data)
	--print('game event ' .. name .. ' (' .. json.encode(args) .. ')')
    if eventName == "CEventNetworkEntityDamage" and isInMatch then
        local victim = tonumber(data[1])
        local attacker = tonumber(data[2])
        local victimDied = tonumber(data[6]) == 1 and true or false 
		if victimDied then 
            if victim == PlayerPedId() then
				if victim == attacker then
					local currentKiller = "YOURSELF"
					TriggerServerEvent("zoygpubg:iamdead", currentKiller)
				elseif IsEntityAPed(attacker) and IsPedAPlayer(attacker) then
					local Killer = NetworkGetPlayerIndexFromPed(attacker)
					TriggerServerEvent("zoygpubg:iamdead", GetPlayerServerId(Killer))
				elseif IsEntityAVehicle(attacker) and IsEntityAPed(GetPedInVehicleSeat(attacker, -1)) and IsPedAPlayer(GetPedInVehicleSeat(attacker, -1)) then
					local Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(attacker, -1))
					if Killer == nil then
						local currentKiller = "UNKNOWN"
						TriggerServerEvent("zoygpubg:iamdead", currentKiller)
					else
						TriggerServerEvent("zoygpubg:iamdead", GetPlayerServerId(Killer))
					end
				else
					local currentKiller = "UNKNOWN"
					TriggerServerEvent("zoygpubg:iamdead", currentKiller)
				end
			if IsEntityAPed(attacker) and IsPedAPlayer(attacker) and attacker == PlayerPedId() then

				TriggerServerEvent("zoygpubg:ikilled", currentTeam)
            end
        end
	end
    end
end)

AddEventHandler('onClientResourceStop', function (zoyg_pubg)
	local currentKiller = "YOURSELF"
	TriggerServerEvent("zoygpubg:iamdead", currentKiller)
	local _playerPed = PlayerPedId()
	ResetSafezone()
	isInMatch = false
	menuOpen = false
	draw = true
	isZoneActive = false
	isOutOfTheZone = false
	PlaneNet = 0
	InPlane = false
	StartTime = nil
	plane = nil
	driver = nil
	playersin = 0
	viewCam = nil
	SetNuiFocus(false, false)
	ExecuteCommand("envanterisil")
end)

AddEventHandler("rebel-base:server:playerDeath",function(attackerId)
	if isInMatch then
    TriggerEvent("zoygpubg:revive")
	TriggerServerEvent("zoygpubg:iamdead", currentKiller)
	end
	
end)

RegisterNetEvent("zoygpubg:revive")
AddEventHandler("zoygpubg:revive", function()
	RespawnPedpl(PlayerPedId())
	ExecuteCommand("envanterisil")
	StopScreenEffect('DeathFailOut')
end)

function RespawnPedpl(ped)
	SetEntityCoordsNoOffset(ped, Config.NpcCoords.x, Config.NpcCoords.y, Config.NpcCoords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(Config.NpcCoords.x, Config.NpcCoords.y, Config.NpcCoords.z, (Config.NpcCoords.h + 180), true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)
	if Config.useAmbulanceJobDeathCombatLog then
		TriggerServerEvent('rebel-base:server:playerDeath', ped)
	end
	TriggerServerEvent('QBCore:Client:OnPlayerLoaded')
	TriggerEvent('QBCore:Client:OnPlayerLoaded')
	TriggerEvent('playerSpawned')
	SetNuiFocus(false, false)
	SendNUIMessage({
		type = "closeeverything",
	})
	
	SetEntityCoords(ped, Config.NpcCoords.x,Config.NpcCoords.y, Config.NpcCoords.z)
	hasExitedMap = true

end

RegisterNetEvent("zoygpubg:setinmatfalse")
AddEventHandler("zoygpubg:setinmatfalse", function(playerName,kills,bpfromkills,bpfromplacement,reward,placement,startedPlayers,killer,reason)
	local _playerPed = PlayerPedId()
	ResetSafezone()
	isInMatch = false
	menuOpen = false
	draw = true
	isZoneActive = false
	isOutOfTheZone = false
	PlaneNet = 0
	InPlane = false
	StartTime = nil
	plane = nil
	driver = nil
	playersin = 0
	viewCam = nil
	SetNuiFocus(true, true)
	ExecuteCommand("envanterisil")
	if killer == nil then
		SendNUIMessage({
			type = "endgamewinner",
			name = playerName,
			kill = kills,
			killbp = bpfromkills,
			placebp = bpfromplacement,
			rewardd = reward,
			placementt = placement,
			plfromstart = startedPlayers,
			reasonn = reason,
		})
	else
		SendNUIMessage({
			type = "endgameloser",
			name = playerName,
			kill = kills,
			killbp = bpfromkills,
			placebp = bpfromplacement,
			rewardd = reward,
			placementt = placement,
			plfromstart = startedPlayers,
			dolofon = killer,
			reasonn = reason,
		})
	end
	--ESX.Game.Teleport(_playerPed, vector3(Config.NpcCoords.x,Config.NpcCoords.y, Config.NpcCoords.z),function() 
	--end)
end)

RegisterNUICallback('exitmap', function(data)
	RespawnPedpl(PlayerPedId())
end)


function ResetSafezone()
	RemoveBlip(currentSafezoneBlip)
	currentSafezoneBlip = nil
    currentSafezoneCoord = nil
    currentSafezoneRadius = nil 
end

function SetSafeZoneBlip(blip, cSafezoneCoord, cSafezoneRadius, color)
    local safeZoneBlip = AddBlipForRadius(cSafezoneCoord.x, cSafezoneCoord.y, cSafezoneCoord.z, cSafezoneRadius * 1.0)
    SetBlipColour(safeZoneBlip, color) --
    SetBlipHighDetail(safeZoneBlip, true)
    SetBlipAlpha(safeZoneBlip, 90)
    SetBlipDisplay(safeZoneBlip, 10)
    if blip ~= nil then
      RemoveBlip(blip) -- Remove before blip(variable 'blip')
    end
    return safeZoneBlip
end



function DeleteAllVehicles()
	local handle, veh = FindFirstVehicle()
	local success
	repeat
		success, veh = FindNextVehicle(handle)
		if DoesEntityExist(veh) then 
			local vehPos = GetEntityCoords(veh)
			local distance = math.abs(GetDistanceBetweenCoords(vehPos.x, vehPos.y, 0, Config.MapCenter.x, Config.MapCenter.y, 0, false))
			if distance < Config.Circle.startradius then
				DeleteVehicle(veh) 
			end
		end
	until not success
		EndFindVehicle(handle)
end



RegisterNetEvent("zoygpubg:removeallcars")
AddEventHandler("zoygpubg:removeallcars", function()
	DeleteAllVehicles()
end)







--- DEBUG

function RequestAndWaitModel(model)
	if IsModelInCdimage(model) and not HasModelLoaded(model) then
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		return true
	end
end


function reMapData(game_data)

	local cntSolo = 0
	local sololist = game_data["SOLO"].player_list
	game_data["SOLO"].player_list = {}
	for k,v in pairs(sololist) do
		game_data["SOLO"].player_list[cntSolo] = v
	end
	print(dump(game_data))
	return game_data
end


function dump(o)
	if type(o) == 'table' then
	   local s = '{ '
	   for k,v in pairs(o) do
		  if type(k) ~= 'number' then k = '"'..k..'"' end
		  s = s .. '['..k..'] = ' .. dump(v) .. ','
	   end
	   return s .. '} '
	else
	   return tostring(o)
	end
end
function forceAnim(animName, flag, args)
	flag, args = flag and tonumber(flag) or false, args or {}
	local ped, time, clearTasks, animPos, animRot, animTime = args.ped or PlayerPedId(), args.time, args.clearTasks, args.pos, args.ang

	if IsPedInAnyVehicle(ped) and (not flag or flag < 40) then return end

	if not clearTasks then ClearPedTasks(ped) end

	if animName[2] then
		RequestAndWaitDict(animName[1])
	end

	if not animName[2] then
		ClearAreaOfObjects(GetEntityCoords(ped), 1.0)
		TaskStartScenarioInPlace(ped, animName[1], -1, not tableHasValue(animBug, animName[1]))
	else
		if not animPos then
			TaskPlayAnim(ped, animName[1], animName[2], 8.0, -8.0, -1, flag or 44, 0, 0, 0, 0, 0)
		else
			TaskPlayAnimAdvanced(ped, animName[1], animName[2], animPos.x, animPos.y, animPos.z, animRot.x, animRot.y, animRot.z, 8.0, -8.0, -1, flag or 44, animTime or -1, 0, 0)
		end
	end

	if time and type(time) == "number" then
		Citizen.Wait(time)
		ClearPedTasks(ped)
	end

	if not args.dict then RemoveAnimDict(animName[1]) end
end

function ShowHelp(txt, beep)
	SetTextComponentFormat("jamyfafi")
	AddTextComponentString(txt)
	if string.len(txt) > 99 and AddLongString then AddLongString(txt) end
	DisplayHelpTextFromStringLabel(0, 0, beep, -1)
end

function RequestAndWaitDict(dictName)
	if DoesAnimDictExist(dictName) and not HasAnimDictLoaded(dictName) then
		RequestAnimDict(dictName)
		while not HasAnimDictLoaded(dictName) do Citizen.Wait(100) end
	end
end