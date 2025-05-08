wFramework = nil
wTsc = nil

if Config.Framework.Framework == "esx" then
    if Config.Framework.NewCore then
        wFramework = exports[Config.Framework.ResourceName]:getSharedObject()
    else
        CreateThread(function()
            while wFramework == nil do
                TriggerEvent(Config.Framework.SharedEvent, function(obj) wFramework = obj end)
                Wait(10)
            end
        end)
    end
    wTsc = wFramework.TriggerServerCallback
elseif Config.Framework.Framework == "qbcore" then
    wFramework = exports[Config.Framework.ResourceName]:GetCoreObject()
    wTsc = wFramework.Functions.TriggerCallback
end

local PlayerData, stations, Variation, incamState, targetZones = {}, {}, {}, {bodycam = false, dashcam = false}, {}
local bodycamState, recordState, badgeHide, inanyjob, playerName, menustate, pauseMenu, nuiready = false, false, false, nil, nil, false, false, false
local watchedSource, targetPed, targetVehicle, cam = nil, nil, nil, nil
local nuiwait = 5 * 1000

-----------------------------------------------------------------------------------------
-- EVENT'S --
-----------------------------------------------------------------------------------------

RegisterNetEvent('wais:send:stationsData', function(data)
    stations = data
end)

RegisterNetEvent('esx:removeInventoryItem', function(item, count, showNotification)
    Wait(500)
    if bodycamState then
        PlayerData = Config.Framework.Framework == "esx" and wFramework.GetPlayerData() or wFramework.Functions.GetPlayerData()
        local bodycamFind = false
        for k, v in pairs(PlayerData.inventory) do
            if v.name == Config.Items.bodycam then
                bodycamFind = true
                break
            end
        end

        if not bodycamFind then
            bodycamState = false
            TriggerServerEvent('wais:removeTable:bodycam:inventory')
        end
    end
end)

RegisterNetEvent("QBCore:Player:SetPlayerData", function(val)
    PlayerData = val
    if bodycamState then
        local bodycamFind = false
        for k, v in pairs(PlayerData.items) do
            if v.name == Config.Items.bodycam then
                bodycamFind = true
                break
            end
        end

        if not bodycamFind then
            bodycamState = false
            TriggerServerEvent('wais:removeTable:bodycam:inventory')
        end
    end
end)

RegisterNetEvent('wais:change:bodycamState', function(boolean)
    bodycamState = boolean

    if Config.Props.attachBodycam then
        local ped = GetEntityModel(PlayerPedId())
        local gender = ped == GetHashKey("mp_m_freemode_01") and "male" or ped == GetHashKey("mp_f_freemode_01") and "female" or "male"
        if boolean then
            Variation = {
                ["drawableId"] = GetPedDrawableVariation(PlayerPedId(), Config.Props.componentSettings[gender].componentId),
                ["textureId"] = GetPedTextureVariation(PlayerPedId(), Config.Props.componentSettings[gender].componentId)
            }
            SetPedComponentVariation(PlayerPedId(), Config.Props.componentSettings[gender].componentId, Config.Props.componentSettings[gender].drawableId, Config.Props.componentSettings[gender].textureId, 0)
        else
            SetPedComponentVariation(PlayerPedId(), Config.Props.componentSettings[gender].componentId, Variation.drawableId, Variation.textureId, 0)
            Variation = {}
        end
    end

    SendNUIMessage({
        type = "BADGE_STATE",
        state = boolean
    })

    SendNUIMessage({
        type = "HIDE_BADGE",
        state = false
    })
    hidebadge = false

    Config.SendNotifications(boolean and 'bodycam_on' or 'bodycam_off')
end)

RegisterNetEvent('esx:setJob', function(job)
	Wait(500)
    TriggerServerEvent('wais:checkPlayer:job')
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
	Wait(500)
    TriggerServerEvent('wais:checkPlayer:job')
end)

RegisterNetEvent('wais:set:job', function(job, name)    
    inanyjob = job
    playerName = name
    PlayerData = Config.Framework.Framework == "esx" and wFramework.GetPlayerData() or wFramework.Functions.GetPlayerData()

    while PlayerData.job == nil do
        PlayerData = Config.Framework.Framework == "esx" and wFramework.GetPlayerData() or wFramework.Functions.GetPlayerData()
        Wait(500)
    end

    while not nuiready do
        nuiwait = nuiwait - 1000
        if nuiwait <= 0 then
            print("NUI is not ready")
            return
        end
        Wait(1000)
    end

    if inanyjob ~= nil then
        SendNUIMessage({
            type = "SET_DATA",
            stations = stations
        })

        SendNUIMessage({
            type = "BADGE_SETTINGS",
            zoom = Config.BadgeSettings.scale,
            position = Config.BadgeSettings.position,
        })

        SendNUIMessage({
            type = "JOB_UI_SETTINGS",
            settings = Config.Jobs[inanyjob].uiSettings
        })

        SendNUIMessage({
            type = "SET_PLAYER_INFOS",
            infos = {
                name = playerName,
                rank = Config.Framework.Framework == "esx" and PlayerData.job.grade_label or PlayerData.job.grade.name
            }
        })

        local jobSettings = Config.Jobs[inanyjob]

        if jobSettings.useTarget then
            createBoxZones(inanyjob, jobSettings.watch, jobSettings.distance, jobSettings.text)
        end
    else
        changeUItoDef()
        deleteBoxZones()
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
    playerUnload()
end)

RegisterNetEvent('esx:onPlayerLogout', function()
    PlayerData = {}
    playerUnload()
end)

RegisterNetEvent('wais:check:nearVehicles', function()
    local coords = GetEntityCoords(PlayerPedId())
    local carId, carDistance = GetClosestVehicles(coords, 2)
    if carDistance <= 2 and carId ~= 0 then
        local bone = GetEntityBoneIndexByName(carId, 'windscreen')
        if bone == -1 then
            bone = GetEntityBoneIndexByName(carId, 'windscreen_f')
        end
        local plate = GetVehicleNumberPlateText(carId)
        TriggerServerEvent('wais:add:tableDashcam', NetworkGetNetworkIdFromEntity(carId), plate, bone)
        Config.SendNotifications('dashcam_added')
    else
        Config.SendNotifications('no_vehicle')
    end
end)

RegisterNetEvent('wais:add:bodycam', function(tableid, data)
    stations.bodycams.cams[tableid] = data
    stations.bodycams.online = stations.bodycams.online + 1

    SendNUIMessage({
        type = "ADD_BODYCAM",
        tableid = tableid,
        data = data
    })
end)

RegisterNetEvent('wais:remove:bodycam', function(tableid)
    stations.bodycams.cams[tableid] = nil
    stations.bodycams.online = stations.bodycams.online - 1

    if watchedSource ~= nil then
        if watchedSource == tonumber(tableid) then
            closeWatch()
            Config.SendNotifications('disconnected')
        end
    end

    SendNUIMessage({
        type = "REMOVE_BODYCAM",
        tableid = tableid
    })
end)

RegisterNetEvent('wais:add:dashcam', function(tableid, data)
    stations.dashcams.cams[tableid] = data
    stations.dashcams.online = stations.dashcams.online + 1

    SendNUIMessage({
        type = "ADD_DASHCAM",
        tableid = tableid,
        data = data
    })
end)

RegisterNetEvent('wais:remove:dashcam', function(tableid)
    stations.dashcams.cams[tableid] = nil
    stations.dashcams.online = stations.dashcams.online - 1

    if watchedSource ~= nil then
        if watchedSource == tonumber(tableid) then
            closeWatch()
            Config.SendNotifications('disconnected')
        end
    end

    SendNUIMessage({
        type = "REMOVE_DASHCAM",
        tableid = tableid
    })
end)

RegisterNetEvent('wais:add:records', function(tableid, data)
    stations.records[tableid] = data
    SendNUIMessage({
        type = "ADD_RECORD",
        tableid = tableid,
        data = data
    })
end)

RegisterNetEvent('wais:playerDead', function()
    if watchedSource ~= nil then
        closeWatch()
    end
end)

AddEventHandler('onClientResourceStart', function(resName)
    if (GetCurrentResourceName() == resName) then
        while true do
            if wFramework ~= nil then
                checkPlayerDataV2(true)
                break
            end
            Wait(1)
        end
    end
end)

-----------------------------------------------------------------------------------------
-- NUI CALLBACK'S --
-----------------------------------------------------------------------------------------

RegisterNUICallback('ready', function(_, cb)
    nuiready = true
    cb(true)
end)

RegisterNUICallback('closeMenu', function(_, cb)
    closeMenu()
    cb(true)
end)

RegisterNUICallback('watchbodycam', function(data, cb)
    local id = data.tableid
    watchcam(id)
    cb(true)
end)

RegisterNUICallback('watchdashcam', function(data, cb)
    local id = data.tableid
    watchdashcam(id)
    cb(true)
end)

RegisterNUICallback('recordState', function(data, cb)
    local uploaded = data.uploaded
    if uploaded then
        data.player.job = inanyjob
        TriggerServerEvent('wais:upload:record', data)
        Config.SendNotifications('record_uploaded')
    else
        Config.SendNotifications('record_failed_load')
    end
    cb(true)
end)

-----------------------------------------------------------------------------------------
-- FUNCTION'S --
-----------------------------------------------------------------------------------------

function checkPlayerDataV2(check)
    PlayerData = Config.Framework.Framework == "esx" and wFramework.GetPlayerData() or wFramework.Functions.GetPlayerData()

    while PlayerData.job == nil do
        PlayerData = Config.Framework.Framework == "esx" and wFramework.GetPlayerData() or wFramework.Functions.GetPlayerData()
        Wait(500)
    end

    if check then
        TriggerServerEvent('wais:checkPlayer:job')
    end
end

function closeWatch()    
    local ped = PlayerPedId()
    incamState = {bodycam = false, dashcam = false}
    cam = nil
    targetPed = nil
    targetVehicle = nil
    watchedSource = nil

    DetachEntity(ped, 1, 1)
    SetEntityVisible(ped, true)
    SetEntityCollision(ped, true, true)
    SetEntityCompletelyDisableCollision(ped, true, true)
	SetEntityInvincible(ped, false)
    NetworkFadeInEntity(ped, 0, false)
    FreezeEntityPosition(ped, false)

    RenderScriptCams(false, false, 0, 1, 0)
    SetTimecycleModifier("default")
    SetTimecycleModifierStrength(0.3)
    CloseCamFrame()

    local stationWatchCoords = Config.Jobs[inanyjob].watch
    SetEntityCoords(ped, stationWatchCoords.x, stationWatchCoords.y, stationWatchCoords.z)
end

function watchcam(id)
    local myPed = PlayerPedId()
    local myCoords = GetEntityCoords(myPed)
    local myServerId = GetPlayerServerId(PlayerId())

    if myServerId == id then
        Config.SendNotifications('cant_watch_self')
        return
    end

    Out()
    wTsc('wais:get:targetCoords', function(coords)
        if coords then
            SetEntityVisible(myPed, false)
            FreezeEntityPosition(myPed, true)
            SetEntityCollision(myPed, false, true)
            SetEntityCompletelyDisableCollision(myPed, false, true)
            if Config.Audible then
                SetEntityCoords(myPed, coords.x, coords.y, coords.z + 3.0)
            else
                SetEntityCoords(myPed, coords.x, coords.y, coords.z - 100.0)
            end
        else
            In()
            return
        end
    end, id)

    closeMenu()
    Wait(500)

    local targetplayer = GetPlayerFromServerId(id)
    targetPed = GetPlayerPed(targetplayer)
    SetTimecycleModifier("scanline_cam_cheap")
    SetTimecycleModifierStrength(2.0)
    CreateHeliCam()
    cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)

    AttachCamToPedBone(cam, targetPed, 31086, Config.CamSettings.bodycamPositions.x, Config.CamSettings.bodycamPositions.y, Config.CamSettings.bodycamPositions.z, true)
    SetCamFov(cam, Config.CamSettings.bodycamFov)
    RenderScriptCams(true, false, 0, 1, 0)

    incamState.bodycam = true
    watchedSource = id
    OpenCameraFrame(id, "bodycams")
    In()
end

function watchdashcam(playerId)
    local ped = PlayerPedId()
    local myCoords = GetEntityCoords(ped)
    local carId = 0

    Out()

    wTsc('wais:get:carCoords', function(coords)
        if coords then
            carId = stations.dashcams.cams[tostring(playerId)].carId
            SetEntityVisible(ped, false)
            FreezeEntityPosition(ped, true)
            SetEntityCollision(ped, false, true)
            SetEntityCompletelyDisableCollision(ped, false, true)
            if Config.Audible then
                SetEntityCoords(ped, coords.x, coords.y, coords.z + 3.0)
            else
                SetEntityCoords(ped, coords.x, coords.y, coords.z - 100.0)
            end
        else
            In()
            Config.SendNotifications('not_found')
            return
        end
    end, tonumber(playerId))

    closeMenu()
    Wait(1000)

    targetVehicle = NetworkGetEntityFromNetworkId(carId)

    if DoesEntityExist(targetVehicle) then
        SetEntityVisible(ped, false)
        AttachEntityToEntity(ped, targetVehicle, stations.dashcams.cams[tostring(playerId)].bone, 0.0, 0.0, Config.Audible and 3.0 or -100.0, 0.0, 0.0, 0.0, true, false, false, true, 0, false)
        SetTimecycleModifier("scanline_cam_cheap")
        SetTimecycleModifierStrength(2.0)
        CreateHeliCam()
        cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)

        AttachCamToVehicleBone(cam, targetVehicle, stations.dashcams.cams[tostring(playerId)].bone, true, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true)
        SetCamFov(cam, Config.CamSettings.dashcamFov)
        RenderScriptCams(true, false, 0, 1, 0)

        incamState.dashcam = true
        watchedSource = playerId
        OpenCameraFrame(playerId, "dashcams")
        In()
    else
        In()
        Config.SendNotifications('not_found')
        TriggerServerEvent('wais:removeTable:dashcam', playerId)
    end
end

function GetClosestVehicles(coords, neededDistance)
    local vehicles = GetVehiclsePool()
    local carId, carDistance = 0, 0

    for i = 1, #vehicles do
        local vehicleCoords = GetEntityCoords(vehicles[i])
        local distance = #(coords - vehicleCoords)
        if distance <= neededDistance then
            carId = vehicles[i]
            carDistance = distance
            break
        end
    end

    return carId, carDistance
end

function GetVehiclsePool()
    local vehiclePool = GetGamePool('CVehicle')
    local vehicles = {}
    for i = 1, #vehiclePool do
        vehicles[#vehicles + 1] = vehiclePool[i]
    end
    return vehicles
end

function CreateHeliCam()
    local scaleform = RequestScaleformMovie("HELI_CAM")
	while not HasScaleformMovieLoaded(scaleform) do
		Wait(0)
	end
end

function playerUnload()
    if menustate then
        closeMenu()
    end

    if watchedSource ~= nil then
        closeWatch()
    end

    if bodycamState then
        changeUItoDef()
        SendNUIMessage({
            type = "BADGE_STATE",
            state = false
        })
        TriggerServerEvent('wais:unload')
    end

    incamState = {bodycam = false, dashcam = false}
    stations = {}
    inanyjob = nil
    hidebadge = false
    playerName = nil
    recordState = false
    bodycamState = false
end

function closeMenu()
    menustate = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "CLOSE_MENU",
    })
end

function OpenCameraFrame(playerId, types)
    Config.CloseUIs()
    SendNUIMessage({
        type = "OPEN_CAM_FRAME",
        name = stations[types].cams[tostring(playerId)].name,
        rank = stations[types].cams[tostring(playerId)].grade,
        types = types
    })
end

function CloseCamFrame()
    Config.OpenUIs()
    SendNUIMessage({
        type = "CLOSE_CAM_FRAME",
    })
end

function startRecord()
    recordState = true
    SendNUIMessage({
        type = "RECORD_STATE",
        state = recordState
    })
    Config.SendNotifications('record_start')
end

function stopRecord()
    recordState = false
    SendNUIMessage({
        type = "RECORD_STATE",
        state = recordState
    })
    Config.SendNotifications('record_stop')
end

function Out()
    DoScreenFadeOut(1000)
    while not IsScreenFadedOut() do
        Wait(0)
    end
end

function In()
    DoScreenFadeIn(1000)
    while not IsScreenFadedIn() do
        Wait(0)
    end
end

function changeUItoDef()
    SendNUIMessage({
        type = "JOB_UI_SETTINGS",
        settings = {
            ["color"] = "", 
            ["title"] = "", 
            ["subtitle"] = "",
            ["videoUpload"] = {
                ["webhook"] = "",
                ["fivemanage"] = false,
                ["fivemanage_token"] = "",
            },
            ["backgroundColor"] = "", 
            ["badgeSettings"] = {
                ["image"] = "",
                ["darkerColor"] = "",
                ["lighterColor"] = "",
                ["departmentName"] = ""
            }
        }
    })

    SendNUIMessage({
        type = "SET_PLAYER_INFOS",
        infos = {
            name = playerName,
            rank = "Unemployed"
        }
    })

    SendNUIMessage({
        type = "HIDE_BADGE",
        state = false
    })
    hidebadge = false
end

function createBoxZones(job, coords, distance, text)
    if GetResourceState('ox_target') == 'started' then
        local boxId = exports.ox_target:addBoxZone({
            coords = coords,
            size = vec3(distance, distance, distance),
            debug = false,
            drawSprite = false,
            options = {
                {
                    name = 'wais-bodycamv2-menu',
                    icon = 'fa-solid fa-table-cells',
                    label = text,
                    onSelect = function()
                        menustate = true
                        SetNuiFocus(true, true)
                        SendNUIMessage({
                            type = "OPEN_MENU",
                        })
                    end
                }
            }
        })
        targetZones[#targetZones + 1] = boxId
    elseif GetResourceState('qb-target') == 'started' then
        local boxName = exports['qb-target']:AddBoxZone('wais-bodycamv2-menu', coords, 0.5, 0.5, {
            name = "wais-bodycamv2-menu",
            debugPoly = false,
            minZ = coords.z,
            maxZ = coords.z + 1.0,
        }, {
            options = {
                {
                    type = "client",
                    icon = 'table-cells',
                    label = text,
                    action = function ()
                        menustate = true
                        SetNuiFocus(true, true)
                        SendNUIMessage({
                            type = "OPEN_MENU",
                        })
                    end,
                },
            },
            distance = distance
        })
        targetZones[#targetZones + 1] = boxName
    end
end

function deleteBoxZones()
    for i = 1, #targetZones do
        if GetResourceState('ox_target') == 'started' then
            exports.ox_target:removeZone(targetZones[i])
        elseif GetResourceState('qb-target') == 'started' then
            exports['qb-target']:RemoveZone(targetZones[i])
        end
    end
    targetZones = {}
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextDropshadow(0)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 250
    DrawRect(_x,_y +0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
end

-----------------------------------------------------------------------------------------
-- COMMAND'S --
-----------------------------------------------------------------------------------------

RegisterKeyMapping('_.closecam', 'Open the menu', 'keyboard', 'BACK')
RegisterCommand('_.closecam', function()
    if watchedSource ~= nil then
        closeWatch()
    end
end)

RegisterKeyMapping('_.record', 'Start / Stop bodycam record', 'keyboard', Config.Records.recordKey)
if Config.Records.enableRecord then
    RegisterCommand('_.record', function()
        if bodycamState then
            if recordState then
                stopRecord()
            else
                startRecord()
            end
        end
    end)
end

RegisterKeyMapping('_.hidebadge', 'Hide or Apper the badge', 'keyboard', Config.BadgeSettings.hideableKey)
RegisterCommand('_.hidebadge', function()
    if bodycamState then
        badgeHide = not badgeHide
        SendNUIMessage({
            type = "HIDE_BADGE",
            state = badgeHide
        })
    end
end)

-----------------------------------------------------------------------------------------
-- THREAD'S --
-----------------------------------------------------------------------------------------

-- CreateThread(function()
--     while true do
--         local sleep = 1000
--         if Config.Jobs[inanyjob] ~= nil then
--             local playerPed = PlayerPedId()
--             local coords = GetEntityCoords(playerPed)
--             local job = Config.Jobs[inanyjob]
--             local distance = #(coords - job.watch)

--             if distance <= job.distance and not menustate and not job.useTarget then
--                 sleep = 5
--                 DrawText3D(job.watch.x, job.watch.y, job.watch.z, job.text, job.color)
--                 if IsControlJustReleased(0, 38) then
--                     menustate = true
--                     SetNuiFocus(true, true)
--                     SendNUIMessage({
--                         type = "OPEN_MENU",
--                     })
--                 end
--             end
--         end
--         Wait(sleep)
--     end
-- end)

CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)

        if watchedSource ~= nil then
            sleep = 250
            local coords = incamState.bodycam and GetEntityCoords(targetPed) or incamState.dashcam and GetEntityCoords(targetVehicle)
            local distance = #(pedCoords - coords)

            local street1, street2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
            SendNUIMessage({
                type = "SET_CAM_STREET",
                street = ('%s - %s'):format(GetStreetNameFromHashKey(street1), GetStreetNameFromHashKey(street2))
            })

            if incamState.dashcam then
                if not DoesEntityExist(targetVehicle) then  
                    In()
                    closeWatch()
                    Config.SendNotifications('not_found')
                    TriggerServerEvent('wais:removeTable:dashcam', playerId)
                end
            end

            if distance >= 290 then
                SetEntityCoords(ped, coords.x, coords.y, coords.z + 3.0)
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local sleep = 1000
        if watchedSource ~= nil then
            if IsPauseMenuActive() then
                if not pauseMenu then
                    pauseMenu = true
                    SendNUIMessage({
                        type = "PAUSE_MENU",
                        state = true
                    })

                end
            else
                if pauseMenu then
                    pauseMenu = false
                    SendNUIMessage({
                        type = "PAUSE_MENU",
                        state = false
                    })
                end
            end

            if incamState.bodycam then
                sleep = 1                
                local pedHeading = GetEntityHeading(targetPed)
                SetCamRot(cam, 0.0, 0.0, pedHeading, 2)
            end
            DisablePlayerFiring(ped, true)
        end
        Wait(sleep)
    end
end)

-----------------------------------------------------------------------------------------
-- EXPORT'S --
-----------------------------------------------------------------------------------------