local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

local QBCore = exports['qb-core']:GetCoreObject() 

local HasKey = false
local LastVehicle = nil
local IsHotwiring = false
local IsRobbing = false
local isLoggedIn = true
local requiredItemsShowed = false

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    print("keys beep beep boop boop")
    -- TriggerServerEvent("orangutan:keys:giveKeys")
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), true), -1) == PlayerPedId() and QBCore ~= nil then
            local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), true))
            if LastVehicle ~= GetVehiclePedIsIn(PlayerPedId(), false) then
                QBCore.Functions.TriggerCallback('vehiclekeys:CheckHasKey', function(result)
                    if result then
                        HasKey = true
                        SetVehicleEngineOn(veh, true, false, true)
                    else
                        HasKey = false
                        SetVehicleEngineOn(veh, false, false, true)
                    end
                    LastVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                end, plate)
            end
        end

        if not HasKey and IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId() and QBCore ~= nil and not IsHotwiring then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            SetVehicleEngineOn(veh, false, false, true)
            local requiredItems = {
                [1] = {name = QBCore.Shared.Items["lockpick"]["name"], image = QBCore.Shared.Items["lockpick"]["image"]},
                [2] = {name = QBCore.Shared.Items["advancedlockpick"]["name"], image = QBCore.Shared.Items["advancedlockpick"]["image"]},
            }

            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            local vehpos = GetOffsetFromEntityInWorldCoords(veh, 0, 1.5, 0.5)
            -- QBCore.Functions.DrawText3D(vehpos.x, vehpos.y, vehpos.z, "~g~H~w~ - Hotwire")
            SetVehicleEngineOn(veh, false, false, true)

            -- if IsControlJustPressed(0, Keys["H"]) then
            --     Hotwire()
            -- end
            if not requiredItemsShowed then
                requiredItemsShowed = true
                TriggerEvent('inventory:client:requiredItems', requiredItems, true)
            end
        else
            Citizen.Wait(10)
            if requiredItemsShowed then
                requiredItemsShowed = false
                TriggerEvent('inventory:client:requiredItems', requiredItems, false)
            end
        end

        --[[ if IsControlJustPressed(1, Keys["L"]) then
            LockVehicle()
        end ]]
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(7)
        if not IsRobbing and isLoggedIn and QBCore ~= nil then
            if GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= nil and GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= 0 then
                local vehicle = GetVehiclePedIsTryingToEnter(PlayerPedId())
                local driver = GetPedInVehicleSeat(vehicle, -1)
                if driver ~= 0 and not IsPedAPlayer(driver) then
                    if IsEntityDead(driver) then
                        IsRobbing = true
                        QBCore.Functions.Progressbar("rob_keys", "Taking keys.", 3000, false, true, {}, {}, {}, {}, function() -- Done
                            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                            HasKey = true
                            IsRobbing = false
                        end)
                    end
                end
            end

            --[[if QBCore.Functions.GetPlayerData().job.name ~= "police" then
                local aiming, target = GetEntityPlayerIsFreeAimingAt(PlayerId())
                if aiming and (target ~= nil and target ~= 0) then
                    if DoesEntityExist(target) and not IsPedAPlayer(target) then
                        if IsPedInAnyVehicle(target, false) and not IsPedInAnyVehicle(PlayerPedId(), false ) then
                            if not IsBlacklistedWeapon() then
                                local pos = GetEntityCoords(PlayerPedId(), true)
                                local targetpos = GetEntityCoords(target, true)
                                local vehicle = GetVehiclePedIsIn(target, true)
                                if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, targetpos.x, targetpos.y, targetpos.z, true) < 13.0 then
                                    RobVehicle(target)
                                end
                            end
                        end
                    end
                end
            end]]--
        end
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('vehiclekeys:client:SetOwner')
AddEventHandler('vehiclekeys:client:SetOwner', function(plate)
    local VehPlate = plate
    if VehPlate == nil then
        VehPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), true))
    end
    TriggerServerEvent('vehiclekeys:server:SetVehicleOwner', VehPlate)
    if IsPedInAnyVehicle(PlayerPedId()) and plate == GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), true)) then
        SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(), true), true, false, true)
    end
    HasKey = true
    QBCore.Functions.Notify('You picked the keys of the vehicle', 'success', 3500)
end)

RegisterNetEvent('vehiclekeys:client:GiveKeys')
AddEventHandler('vehiclekeys:client:GiveKeys', function(target)
    local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), true))
    TriggerServerEvent('vehiclekeys:server:GiveVehicleKeys', plate, target)
end)

RegisterNetEvent('vehiclekeys:client:ToggleEngine')
AddEventHandler('vehiclekeys:client:ToggleEngine', function()
    local EngineOn = IsVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId()))
    local veh = GetVehiclePedIsIn(PlayerPedId(), true)
    if HasKey then
        if EngineOn then
            SetVehicleEngineOn(veh, false, false, true)
        else
            SetVehicleEngineOn(veh, true, false, true)
        end
    end
end)


RegisterNetEvent('lockpicks:UseLockpickair')
AddEventHandler('lockpicks:UseLockpickair', function(isAdvanced)
    if (IsPedInAnyVehicle(PlayerPedId())) then
        if not HasKey then
            LockpickIgnitionair(isAdvanced)
        end
    else
        LockpickDoor(isAdvanced)
    end
end)

RegisterNetEvent('lockpicks:UseLockpick')
AddEventHandler('lockpicks:UseLockpick', function(isAdvanced)
    if IsPedInAnyVehicle(PlayerPedId()) then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        local vehicleClass = GetVehicleClass(vehicle)
        
        if not HasKey then
            if vehicleClass == 15 or vehicleClass == 16 then
                QBCore.Functions.Notify("You cannot use a lockpick on this type of vehicle.", "error")
            else
                LockpickIgnition(isAdvanced)
            end
        end
    else
        LockpickDoor(isAdvanced)
    end
end)

IsRobbing = false
function RobVehicle(target)
    IsRobbing = true
    Citizen.CreateThread(function()
        while IsRobbing do
            local RandWait = math.random(10000, 15000)
            loadAnimDict("random@mugging3")

            TaskLeaveVehicle(target, GetVehiclePedIsIn(target, true), 256)
            Citizen.Wait(1000)
            ClearPedTasksImmediately(target)

            TaskStandStill(target, RandWait)
            TaskHandsUp(target, RandWait, PlayerPedId(), 0, false)

            Citizen.Wait(RandWait)

            --TaskReactAndFleePed(target, PlayerPedId())
            IsRobbing = false
        end
    end)
end

function LockVehicle()
    local veh = QBCore.Functions.GetClosestVehicle()
    local coordA = GetEntityCoords(PlayerPedId(), true)
    local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 255.0, 0.0)
    local veh = GetClosestVehicleInDirection(coordA, coordB)
    local pos = GetEntityCoords(PlayerPedId(), true)
    if IsPedInAnyVehicle(PlayerPedId()) then
        veh = GetVehiclePedIsIn(PlayerPedId())
    end
    local plate = GetVehicleNumberPlateText(veh)
    local vehpos = GetEntityCoords(veh, false)
    if veh ~= nil and GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 7.5 then
        QBCore.Functions.TriggerCallback('vehiclekeys:CheckHasKey', function(result)
            print(result, HasKey)
            if result then
                HasKey = result
                if HasKey then
                    local vehLockStatus = GetVehicleDoorLockStatus(veh)
                    loadAnimDict("anim@mp_player_intmenu@key_fob@")
                    TaskPlayAnim(PlayerPedId(), 'anim@mp_player_intmenu@key_fob@', 'fob_click' ,3.0, 3.0, -1, 49, 0, false, false, false)
        
                    if vehLockStatus == 1 then
                        Citizen.Wait(750)
                        ClearPedTasks(PlayerPedId())
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 8, "lock", 0.3)
                        SetVehicleDoorsLocked(veh, 2)
                        if GetVehicleDoorLockStatus(veh) == 2 then
                            QBCore.Functions.Notify("Vehicle " .. plate .. " locked!")
                        else
                            QBCore.Functions.Notify("Something went wrong with the locking system!")
                        end
                    else
                        Citizen.Wait(750)
                        ClearPedTasks(PlayerPedId())
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 8, "unlock", 0.3)
                        SetVehicleDoorsLocked(veh, 1)
                        if GetVehicleDoorLockStatus(veh) == 1 then
                            QBCore.Functions.Notify("Vehicle " .. plate .. " Unlocked!")
                        else
                            QBCore.Functions.Notify("Something went wrong with the locking system!")
                        end
                    end
        
                    if not IsPedInAnyVehicle(PlayerPedId()) then
                        SetVehicleInteriorlight(veh, true)
                        SetVehicleIndicatorLights(veh, 0, true)
                        SetVehicleIndicatorLights(veh, 1, true)
                        Citizen.Wait(450)
                        SetVehicleIndicatorLights(veh, 0, false)
                        SetVehicleIndicatorLights(veh, 1, false)
                        Citizen.Wait(450)
                        SetVehicleInteriorlight(veh, true)
                        SetVehicleIndicatorLights(veh, 0, true)
                        SetVehicleIndicatorLights(veh, 1, true)
                        Citizen.Wait(450)
                        SetVehicleInteriorlight(veh, false)
                        SetVehicleIndicatorLights(veh, 0, false)
                        SetVehicleIndicatorLights(veh, 1, false)
                    end
                end
            else
                QBCore.Functions.Notify('You don\'t have the keys to the vehicle..', 'error')
            end
        end, plate)
    else
        QBCore.Functions.Notify('No vehicle nearby.', 'error')
    end
end

local openingDoor = false
function LockpickDoor(isAdvanced)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    if vehicle ~= nil and vehicle ~= 0 then
        local vehpos = GetEntityCoords(vehicle)
        local pos = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 1.5 then
            local vehLockStatus = GetVehicleDoorLockStatus(vehicle)
            if (vehLockStatus > 1) then
                local lockpickTime = math.random(3000, 6000)
                local lockpickItem = "lockpick"
                if isAdvanced then
                    lockpickTime = math.ceil(lockpickTime * 0.5)
                    lockpickItem = "advancedlockpick"
                end
                LockpickDoorAnim(lockpickTime)
                --exports['qb-dispatch']:VehicleTheft(vehicle)
                PoliceCall()
                IsHotwiring = true
                SetVehicleAlarm(vehicle, true)
                SetVehicleAlarmTimeLeft(vehicle, lockpickTime)
                QBCore.Functions.Progressbar("lockpick_vehicledoor", "breaking the door open.", lockpickTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    openingDoor = false
                    StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
                    IsHotwiring = false
                    if (exports["sgx-lockpick"]:startLockpick(1.0, 2, 5)) then 
                        QBCore.Functions.Notify("Door open!")
                        --exports['qb-dispatch']:VehicleTheft(vehicle)
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "unlock", 0.3)
                        SetVehicleDoorsLocked(vehicle, 0)
                        SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                    else
                        --exports['qb-dispatch']:VehicleTheft(vehicle)
                        QBCore.Functions.Notify("Failed!", "error")
                        -- Trigger the item removal event
                        if isAdvanced then
                            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["advancedlockpick"], 'remove')
                            TriggerServerEvent('QBCore:Server:RemoveItem', "advancedlockpick", 1)
                        else
                            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["lockpick"], 'remove')
                            TriggerServerEvent('QBCore:Server:RemoveItem', "lockpick", 1)
                        end
                    end
                end, function() -- Cancel
                    openingDoor = false
                    --exports['qb-dispatch']:VehicleTheft(vehicle)
                    StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
                    QBCore.Functions.Notify("Failed!", "error")
                    IsHotwiring = false
                    -- Trigger the item removal event on cancel
                    if isAdvanced then
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["advancedlockpick"], 'remove')
                        TriggerServerEvent('QBCore:Server:RemoveItem', "advancedlockpick", 1)
                    else
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["lockpick"], 'remove')
                        TriggerServerEvent('QBCore:Server:RemoveItem', "lockpick", 1)
                    end
                end)
            end
        end
    end
end


function LockpickDoorAnim(time)
    time = time / 1000
    loadAnimDict("veh@break_in@0h@p_m_one@")
    TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    Citizen.CreateThread(function()
        while openingDoor do
            TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Citizen.Wait(1000)
            time = time - 1
            if time <= 0 then
                openingDoor = false
                StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
            end
        end
    end)
end

function LockpickIgnition(isAdvanced)
    if not HasKey then 
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
        IsHotwiring = true
        PoliceCall()
        local lockpickTime = math.random(3000, 4000)
        local lockpickItem = "lockpick"
        if isAdvanced then
            lockpickTime = math.ceil(lockpickTime * 0.5)
            lockpickItem = "advancedlockpick"
        end
        --exports['qb-dispatch']:VehicleTheft(vehicle)
        QBCore.Functions.Progressbar("lockpick_ignition", "Lockpicking..", lockpickTime, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            IsHotwiring = false
            if exports["sgx-lockpick"]:startLockpick(1.0, 2, 5) then 
                QBCore.Functions.Notify("Lockpick successful!")
                HasKey = true
                --exports['qb-dispatch']:VehicleTheft(vehicle)
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
            else
                --exports['qb-dispatch']:VehicleTheft(vehicle)
                QBCore.Functions.Notify("Lockpick failed!", "error")
                TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[lockpickItem], 'remove')
                print("Triggering server event to remove item:", lockpickItem)
                TriggerServerEvent('QBCore:Server:RemoveItem', lockpickItem, 1)
            end
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            HasKey = false
            SetVehicleEngineOn(vehicle, false, false, true)
            QBCore.Functions.Notify("Lockpick Canceled!", "error")
            IsHotwiring = false
            --exports['qb-dispatch']:VehicleTheft(vehicle)
        end)
    end
end

function LockpickIgnitionair(isAdvanced)
    if not HasKey then 
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
        IsHotwiring = true
        PoliceCall()
        local lockpickTime = math.random(3000, 4000)
        if isAdvanced then
            lockpickTime = math.ceil(lockpickTime*0.5)
        end
        
        QBCore.Functions.Progressbar("lockpick_ignition", "Lockicking with the uconnect kit..", lockpickTime, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            IsHotwiring = false
            local time = math.random(0,0)
            local circles = math.random(3,3)
            
            exports['ps-ui']:Scrambler(function(success)
                if success then 
                    QBCore.Functions.Notify("Lockpick successful!")
                    HasKey = true
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                else
                    QBCore.Functions.Notify("Lockpick failed!", "error")
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["uconnectair"], "remove", 1)
                    TriggerServerEvent("uconnectair:remove")
                    exports['qb-dispatch']:VehicleTheft(vehicle)
                end
            end, "greek", 10, 0)
            
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            HasKey = false
            SetVehicleEngineOn(veh, false, false, true)
            QBCore.Functions.Notify("Lockpick Canceled!", "error")
            IsHotwiring = false
            exports['qb-dispatch']:VehicleTheft(vehicle)
        end, "greek", 10, 0)
    end
end

function Hotwire()
    if not HasKey then 
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
        IsHotwiring = true
        local hotwireTime = math.random(20000, 40000)
        SetVehicleAlarm(vehicle, true)
        SetVehicleAlarmTimeLeft(vehicle, hotwireTime)
        PoliceCall()
        QBCore.Functions.Progressbar("hotwire_vehicle", "Engaging the ignition switch", hotwireTime, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            if (math.random(0, 100) < 80) then
                HasKey = true
                QBCore.Functions.Notify("Hotwire succeeded!")
            else
                HasKey = false
                SetVehicleEngineOn(veh, false, false, true)
                QBCore.Functions.Notify("Hotwire Canceled!", "error")
            end
            IsHotwiring = false
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            HasKey = false
            SetVehicleEngineOn(veh, false, false, true)
            QBCore.Functions.Notify("Hotwire Canceled!", "error")
            IsHotwiring = false
        end)
    end
end

function PoliceCall()
    local pos = GetEntityCoords(PlayerPedId())
    local chance = 25
    if GetClockHours() >= 1 and GetClockHours() <= 6 then
        chance = 3
    end
    if math.random(1, 100) <= chance then
        local closestPed = GetNearbyPed()
        if closestPed ~= nil then
            local msg = ""
            local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
            local streetLabel = GetStreetNameFromHashKey(s1)
            local street2 = GetStreetNameFromHashKey(s2)
            if street2 ~= nil and street2 ~= "" then 
                streetLabel = streetLabel .. " " .. street2
            end
            if IsPedInAnyVehicle(PlayerPedId()) then
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                local modelName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
                local modelPlate = GetVehicleNumberPlateText(vehicle)
                msg = "Vehicle theft attempt at " ..streetLabel.. ". Vehicle: " .. modelName .. ", Plate: " .. modelPlate
            else
                local vehicle = QBCore.Functions.GetClosestVehicle()
                local modelName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
                local modelPlate = GetVehicleNumberPlateText(vehicle)
                msg = "Vehicle theft attempt at " ..streetLabel.. ". Vehicle: " .. modelName .. ", Plate: " .. modelPlate
            end
            TriggerServerEvent("police:server:VehicleCall", pos, msg)
        end
    end
end

function GetClosestVehicleInDirection(coordFrom, coordTo)
	local offset = 0
	local rayHandle
	local vehicle

	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		
		offset = offset - 1

		if vehicle ~= 0 then break end
	end
	
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	
	if distance > 250 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

function GetNearbyPed()
	local retval = nil
	local PlayerPeds = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        table.insert(PlayerPeds, ped)
    end
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)
	local closestPed, closestDistance = QBCore.Functions.GetClosestPed(coords, PlayerPeds)
	if not IsEntityDead(closestPed) and closestDistance < 30.0 then
		retval = closestPed
	end
	return retval
end

function IsBlacklistedWeapon()
    local weapon = GetSelectedPedWeapon(PlayerPedId())
    if weapon ~= nil then
        for _, v in pairs(Config.NoRobWeapons) do
            if weapon == GetHashKey(v) then
                return true
            end
        end
    end
    return false
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 0 )
    end
end


local recentRobs = {}
local LastGive = {}
local LastGiveCash = {}

Citizen.CreateThread(function()
    while true do
        Wait(1)
        aiming, ent = GetEntityPlayerIsFreeAimingAt(PlayerId())
        if aiming then
            local pedCrds = GetEntityCoords(PlayerPedId())
            local entCrds = GetEntityCoords(ent)

            local pedType = GetPedType(ent)
            local animalped = false
            if pedType == 6 or pedType == 27 or pedType == 29 or pedType == 28 then
                animalped = true
            end

            if not animalped and #(pedCrds - entCrds) < 5.0 and not recentRobs["rob"..ent] and not IsPedAPlayer(ent) and not IsEntityDead(ent) and not IsPedDeadOrDying(ent, 1) and IsPedArmed(PlayerPedId(), 6) and not IsPedArmed(ent, 7) and not IsEntityPlayingAnim(ent, "missfbi5ig_22", "hands_up_anxious_scientist", 3) then
                local veh = 0
                if IsPedInAnyVehicle(ent, false) and GetEntitySpeed(veh) < 1.5 then
                    ClearPedTasks(ent)
                    Citizen.Wait(100)
                    veh = GetVehiclePedIsIn(ent,false)
                    TaskLeaveVehicle(ent, veh, 0)
                    Citizen.Wait(1500)
                    TriggerEvent("robEntity", ent, veh)
                    recentRobs["rob"..ent] = true
                    Citizen.Wait(10000)
                end

                if not IsPedInAnyVehicle(ent, false) then
                    TriggerEvent("robEntity",ent,veh)
                    recentRobs["rob"..ent] = true
                    Citizen.Wait(1000)
                end

            end

        else
            Wait(1000)
        end
    end
end)


-- 303280717 safe hash
local RobbedRegisters = {}
local LastGive = {}
local LastGiveCash = {}

RegisterNetEvent("robEntity")
AddEventHandler("robEntity", function(entityRobbed, veh)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    
    -- Check if player is in a vehicle and the entity is a vehicle
    if not IsPedInAnyVehicle(playerPed, false) or not IsEntityAVehicle(entityRobbed) then
        return
    end

    local robbingEntity = true
    local startCrds = GetEntityCoords(playerPed)
    local entCrds = GetEntityCoords(entityRobbed)
    local pedCrds = GetEntityCoords(playerPed)

    TaskLeaveVehicle(entityRobbed, veh, 0)
    SetPedFleeAttributes(entityRobbed, 0, 0)
    SetPedDropsWeaponsWhenDead(entityRobbed, false)
    ClearPedTasks(entityRobbed)
    ClearPedSecondaryTask(entityRobbed)
    TaskTurnPedToFaceEntity(entityRobbed, playerPed, 3.0)
    TaskSetBlockingOfNonTemporaryEvents(entityRobbed, true)
    SetPedCombatAttributes(entityRobbed, 17, 1)
    SetPedSeeingRange(entityRobbed, 0.0)
    SetPedHearingRange(entityRobbed, 0.0)
    SetPedAlertness(entityRobbed, 0)
    SetPedKeepTask(entityRobbed, true)
    SetVehicleCanBeUsedByFleeingPeds(veh, false)
    ResetPedLastVehicle(entityRobbed)
    Citizen.Wait(10)

    RequestAnimDict("missfbi5ig_22")
    while not HasAnimDictLoaded("missfbi5ig_22") do
        Citizen.Wait(0)
    end

    local storeRobbery = false
    local alerted = false
    local robberySuccessful = true

    while robbingEntity do
        Citizen.Wait(10)
        if not IsEntityPlayingAnim(entityRobbed, "missfbi5ig_22", "hands_up_anxious_scientist", 3) then
            TaskPlayAnim(entityRobbed, "missfbi5ig_22", "hands_up_anxious_scientist", 5.0, 1.0, -1, 1, 0, 0, 0, 0)
            Citizen.Wait(1000)
        end

        pedCrds = GetEntityCoords(playerPed)
        entCrds = GetEntityCoords(entityRobbed)

        if #(pedCrds - entCrds) > 15.0 then
            robbingEntity = false
            robberySuccessful = false
        end
        
        if math.random(1000) < 15 and #(pedCrds - entCrds) < 7.0 then
            if veh ~= 0 and LastGive[veh] ~= true then
                local plate = GetVehicleNumberPlateText(veh, false)
                local ped = playerPed
                local pos = GetEntityCoords(ped)
                Citizen.Wait(7000)
                QBCore.Functions.Notify("Person gave you his keys!", "success")
                HasKey = true
                TriggerEvent("vehiclekeys:client:SetOwner", plate)
                robbingEntity = false
                LastGive[veh] = true
            end

            if veh ~= 0 and LastGiveCash[veh] ~= true then
                if robberySuccessful then
                    local cashReward = math.random(100, 500) -- Adjust the range as needed
                    local player = QBCore.Functions.GetPlayer(playerPed)
                    player.Functions.AddMoney('cash', cashReward, "rob-entity")
                    QBCore.Functions.Notify("You robbed $" .. cashReward .. " from the target!", "success")
                    LastGiveCash[veh] = true
                end
            end

            robbingEntity = false
            RequestAnimDict("mp_common")
            while not HasAnimDictLoaded("mp_common") do
                Citizen.Wait(0)
            end			
            TaskPlayAnim(entityRobbed, "mp_common", "givetake1_a", 1.0, 1.0, -1, 1, 0, 0, 0, 0)
            Citizen.Wait(2200)
        end
    end

    ClearPedTasks(entityRobbed)
    Citizen.Wait(10)
    TaskReactAndFleePed(entityRobbed, playerPed)

    Citizen.Wait(math.random(1000, 30000))
    if veh ~= 0 then
        PoliceCall()
    else
        PoliceCall()
    end

    if #recentRobs > 20 then
        recentRobs = {}
    end
end)

RegisterCommand('togglelocks', function()
    LockVehicle()
end)

RegisterKeyMapping('togglelocks', 'Toggle Vehicle Locks', 'keyboard', 'L')