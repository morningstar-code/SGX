sgx = {}

sgx.debug = function(str)
    if cfg?.debug or not cfg then
        if IsDuplicityVersion() then
            print('[^1sgx^0] - [^1Debug^0]: ' .. str)
        else
            print('[sgx] - [Debug]: ' .. str)
        end
    end
end

if cfg?.locale and cfg?.locales then
    local locales = cfg.locales[cfg.locale]
    setmetatable(locales, {
        __index = function(self, key)
            return 'Error: Missing translation for \"' .. key .. '\"'
        end,
    })

    sgx._t = function(key)
        return locales[key]
    end
end

dt = function(table, nb)
    if nb == nil then
        nb = 0
    end

    if type(table) == 'table' then
        local s = ''
        for i = 1, nb + 1, 1 do
            s = s .. '    '
        end

        s = '{\n'
        for k, v in pairs(table) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            for i = 1, nb, 1 do
                s = s .. '    '
            end
            s = s .. '[' .. k .. '] = ' .. dt(v, nb + 1) .. ',\n'
        end

        for i = 1, nb, 1 do
            s = s .. '    '
        end

        return s .. '}'
    else
        return tostring(table)
    end
end

sgx.dt = function(table, w)
    if w then return dt(table) else print(dt(table)) end
end

local fwObj
if cfg?.framework then
    framework = cfg.framework:lower()
else
    local esx = GetResourceState('es_extended'):find('start')
    local qbcore = GetResourceState('qb-core'):find('start')
    if esx then
        framework = 'esx'
    elseif qbcore then
        framework = 'qb'
    end
end

CreateThread(function()
    local c = 0
    while not fwObj and c < 1000 do
        c = c + 1
        if framework == 'esx' then
            pcall(function() fwObj = exports['es_extended']:getSharedObject() end)
            if not fwObj then
                TriggerEvent('esx:getSharedObject', function(obj) fwObj = obj end)
            end
            if fwObj then
                ESX = fwObj
                break
            end
        elseif framework == 'qb' or framework == 'qbcore' then
            pcall(function() fwObj = exports['qb-core']:GetCoreObject() end)
            if not fwObj then
                pcall(function() fwObj = exports['qb-core']:GetSharedObject() end)
            end
            if not fwObj then
                TriggerEvent('QBCore:GetObject', function(obj) fwObj = obj end)
            end
            if fwObj then
                QBCore = fwObj
                break
            end
        end
        Wait(0)
    end
end)

local StringCharset = {}
local NumberCharset = {}
for i = 48, 57 do NumberCharset[#NumberCharset + 1] = string.char(i) end
for i = 65, 90 do StringCharset[#StringCharset + 1] = string.char(i) end
for i = 97, 122 do StringCharset[#StringCharset + 1] = string.char(i) end


function randomStr(length)
    if length <= 0 then return '' end
    return randomStr(length - 1) .. StringCharset[math.random(1, #StringCharset)]
end

function randomInt(length)
    if length <= 0 then return '' end
    return randomInt(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
end

if not IsDuplicityVersion() then --client
    sgx.notification = function(type, str, length)
        if ESX then
            ESX.ShowNotification(str, type, length)
        elseif QBCore then
            QBCore.Functions.Notify(str, type, length)
        else
            SetNotificationTextEntry('STRING')
            AddTextComponentSubstringPlayerName(str)
            DrawNotification(0, 1)
        end
    end

    RegisterNetEvent(GetCurrentResourceName() .. ':client:notification', sgx.notification)

    sgx.clientCallbacks = {}
    sgx.serverCallbacks = {}

    sgx.triggerCallback = function(name, cb, ...)
        sgx.serverCallbacks[name] = cb
        TriggerServerEvent(GetCurrentResourceName() .. ':server:triggerCallback', name, ...)
    end

    RegisterNetEvent(GetCurrentResourceName() .. ':client:triggerCallback', function(name, ...)
        if sgx.serverCallbacks[name] then
            sgx.serverCallbacks[name](...)
            sgx.serverCallbacks[name] = nil
        end
    end)

    sgx.createClientCallback = function(name, cb)
        sgx.clientCallbacks[name] = cb
    end
    
    sgx.triggerClientCallback = function(name, cb, ...)
        if not QBCore.ClientCallbacks[name] then return end
        QBCore.ClientCallbacks[name](cb, ...)
    end

    sgx.registerKeyMap = function(data, cb, cb2)
        RegisterCommand('+sgx_' .. data.command, function()
            local response = true
            if not (data.useWhileFrontendMenu and data.useWhileFrontendMenu or false) and IsPauseMenuActive() then response = false end
            if not (data.useWhileNuiFocus and data.useWhileNuiFocus or false) and IsNuiFocused() then response = false end
            if cb and type(cb) == 'function' then cb(response) end
        end)
        RegisterCommand('-sgx_' .. data.command, function()
            if cb2 and type(cb2) == 'function' then cb2() end
        end)
        if data.key:match('mouse') or data.key:match('iom') then
            RegisterKeyMapping('+sgx_' .. data.command, data.description, 'mouse_button', data.key:lower())
        else
            RegisterKeyMapping('+sgx_' .. data.command, data.description, 'keyboard', data.key:lower())
        end

        Wait(500)
        TriggerEvent('chat:removeSuggestion', ('/+sgx_%s'):format(data.command))
        TriggerEvent('chat:removeSuggestion', ('/-sgx_%s'):format(data.command))
    end

    local specialChars = {
        ['116'] = 'WheelMouseMove.Up',
        ['115'] = 'WheelMouseMove.Up',
        ['100'] = 'MouseClick.LeftClick',
        ['101'] = 'MouseClick.RightClick',
        ['102'] = 'MouseClick.MiddleClick',
        ['103'] = 'MouseClick.ExtraBtn1',
        ['104'] = 'MouseClick.ExtraBtn2',
        ['105'] = 'MouseClick.ExtraBtn3',
        ['106'] = 'MouseClick.ExtraBtn4',
        ['107'] = 'MouseClick.ExtraBtn5',
        ['108'] = 'MouseClick.ExtraBtn6',
        ['109'] = 'MouseClick.ExtraBtn7',
        ['110'] = 'MouseClick.ExtraBtn8',
        ['1015'] = 'AltLeft',
        ['1000'] = 'ShiftLeft',
        ['2000'] = 'Space',
        ['1013'] = 'ControlLeft',
        ['1002'] = 'Tab',
        ['1014'] = 'ControlRight',
        ['140'] = 'Numpad4',
        ['142'] = 'Numpad6',
        ['144'] = 'Numpad8',
        ['141'] = 'Numpad5',
        ['143'] = 'Numpad7',
        ['145'] = 'Numpad9',
        ['200'] = 'Insert',
        ['1012'] = 'CapsLock',
        ['170'] = 'F1',
        ['171'] = 'F2',
        ['172'] = 'F3',
        ['173'] = 'F4',
        ['174'] = 'F5',
        ['175'] = 'F6',
        ['176'] = 'F7',
        ['177'] = 'F8',
        ['178'] = 'F9',
        ['179'] = 'F10',
        ['180'] = 'F11',
        ['181'] = 'F12',
        ['194'] = 'ArrowUp',
        ['195'] = 'Arrosgxown',
        ['196'] = 'ArrowLeft',
        ['197'] = 'ArrowRight',
        ['1003'] = 'Enter',
        ['1004'] = 'Backspace',
        ['198'] = 'Delete',
        ['199'] = 'Escape',
        ['1009'] = 'PageUp',
        ['1010'] = 'PageDown',
        ['1008'] = 'Home',
        ['131'] = 'NumpadAdd',
        ['130'] = 'NumpadSubstract',
        ['1002'] = 'CapsLock',
        ['211'] = 'Insert',
        ['210'] = 'Delete',
        ['212'] = 'End',
        ['1055'] = 'Home',
        ['1056'] = 'PageUp',
    }
    sgx.getPlayersKeyPreference = function(command, cb)
        local key = GetControlInstructionalButton(0, joaat('+sgx_' .. command) | 0x80000000, true):sub(3)
        if specialChars[key] then key = specialChars[key] end
        if cb then cb(key) else return key end
    end

    sgx.drawText3D = function(x, y, z, str, length, r, g, b, a)
        local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
        if onScreen then
            local factor = #str / 370
            if length then
                factor = #str / length
            end
            SetTextScale(0.30, 0.30)
            SetTextFont(4)
            SetTextProportional(1)
            SetTextColour(r or 255, g or 255, b or 255, a or 215)
            BeginTextCommandDisplayText('STRING')
            SetTextCentre(1)
            AddTextComponentSubstringPlayerName(str)
            EndTextCommandDisplayText(_x, _y)
            DrawRect(_x, _y + 0.0120, 0.006 + factor, 0.024, 0, 0, 0, 155)
        end
    end

    sgx.addBlip = function(coords, sprite, scale, color, str, cb)
        local blip = AddBlipForCoord(coords)
        SetBlipSprite(blip, sprite)
        SetBlipColour(blip, color)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, scale)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(str)
        EndTextCommandSetBlipName(blip)
        if cb then cb(blip) else return blip end
    end

    sgx.drawSubtitle = function(str, time)
        BeginTextCommandPrint('STRING')
        AddTextComponentSubstringPlayerName(str)
        EndTextCommandPrint(time or 4000, 1)
    end

    sgx.drawBusySpinner = function(str)
        BeginTextCommandBusyspinnerOn('STRING')
        AddTextComponentSubstringPlayerName(str)
        EndTextCommandBusyspinnerOn(3)
    end

    sgx.loadAnimDict = function(dict, cb)
        if not HasAnimDictLoaded(dict) then
            RequestAnimDict(dict)

            while not HasAnimDictLoaded(dict) do
                Wait(1)
            end
        end

        if cb then cb() end
        Wait(10)
        RemoveAnimDict(dict)
    end

    sgx.loadPtfxAsset = function(asset, cb)
        if not HasNamedPtfxAssetLoaded(asset) then
            RequestNamedPtfxAsset(asset)

            while not HasNamedPtfxAssetLoaded(asset) do
                Wait(1)
            end
        end

        if cb then cb() end
        Wait(10)
        RemovePtfxAsset(asset)
    end

    sgx.loadAnimSet = function(set, cb)
        if not HasAnimSetLoaded(set) then
            RequestAnimSet(set)

            while not HasAnimSetLoaded(asset) do
                Wait(1)
            end
        end

        if cb then cb() end
        Wait(10)
        RemoveAnimSet(asset)
    end

    sgx.requestModel = function(model, cb)
        model = type(model) == 'number' and model or joaat(model)
        if model and IsModelValid(model) then
            if not HasModelLoaded(model) then
                RequestModel(model)

                while not HasModelLoaded(model) do
                    Wait(0)
                end

                if cb then cb(true) end
                Wait(100)
                SetModelAsNoLongerNeeded(model)
            else
                if cb then cb(true) end
                Wait(100)
                SetModelAsNoLongerNeeded(model)
            end
        else
            print('Model(' .. model .. ') is not valid!')
            if cb then cb(false) end
        end
    end

    sgx.spawnObject = function(model, coords, isLocal, cb)
        model = type(model) == 'number' and model or joaat(model)

        sgx.requestModel(model, function()
            local obj = CreateObject(model, coords.xyz, not isLocal, true, false)
            SetEntityAsMissionEntity(obj, true, false)
            SetModelAsNoLongerNeeded(model)

            if DoesEntityExist(obj) then
                if cb then cb(obj) else return obj end
            end
        end)
    end

    sgx.spawnPed = function(model, coords, heading, isLocal, cb)
        model = type(model) == 'number' and model or joaat(model)

        sgx.requestModel(model, function()
            local ped = CreatePed(0, model, coords.xyz, heading, not isLocal, false)
            SetEntityAsMissionEntity(ped, true, false)

            if DoesEntityExist(ped) then
                if cb then cb(ped) else return ped end
            end
        end)
    end

    sgx.spawnVehicle = function(model, coords, heading, isLocal, cb)
        model = type(model) == 'number' and model or joaat(model)

        sgx.requestModel(model, function()
            local vehicle = CreateVehicle(model, coords.xyz, heading, not isLocal, true)
            local timeout = 0
            if not isLocal then
                local networkId = NetworkGetNetworkIdFromEntity(vehicle)
                SetNetworkIdCanMigrate(networkId, true)
                SetEntityAsMissionEntity(vehicle, true, false)
            end

            SetVehicleHasBeenOwnedByPlayer(vehicle, true)
            SetVehicleNeedsToBeHotwired(vehicle, false)
            SetVehicleDirtLevel(vehicle, 0.0)
            SetVehicleModKit(vehicle, 0)
            SetVehRadioStation(vehicle, 'OFF')
            SetModelAsNoLongerNeeded(model)
            RequestCollisionAtCoord(coords.xyz)

            repeat
                Wait(0)
                timeout = timeout + 1
            until (HasCollisionLoadedAroundEntity(vehicle) or timeout > 2000)

            if DoesEntityExist(vehicle) then
                if cb then cb(vehicle) else return vehicle end
            end
        end)
    end

    sgx.deleteObject = function(object, cb)
        SetEntityAsMissionEntity(object, false, true)
        DeleteObject(object)
        if cb then cb() else return end
    end

    sgx.deleteVehicle = function(vehicle, cb)
        SetEntityAsMissionEntity(vehicle, false, true)
        DeleteVehicle(vehicle)
        if cb then cb() else return end
    end

    sgx.deletePed = function(ped, cb)
        SetEntityAsMissionEntity(ped, false, true)
        DeletePed(ped)
        if cb then cb() else return end
    end

    sgx.getVehicles = function()
        return GetGamePool('CVehicle')
    end

    sgx.getObjects = function()
        return GetGamePool('CObject')
    end

    sgx.getPlayers = function()
        return GetActivePlayers()
    end

    sgx.getClosestPed = function(coords)
        local ped = PlayerPedId()
        coords = coords and (type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords) or GetEntityCoords(ped)
        local peds = GetGamePool('CPed')
        local closestDistance, closestPed = false
        for i = 1, #peds, 1 do
            local pedCoords = GetEntityCoords(peds[i])
            local distance = #(pedCoords - coords)
            if not closestDistance or closestDistance > distance then
                closestPed = peds[i]
                closestDistance = distance
            end
        end
        return closestPed, closestDistance
    end

    sgx.getClosestPeds = function(coords, maxDistance)
        local ped = PlayerPedId()
        local peds = GetGamePool('CPed')
        coords = coords and (type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords) or GetEntityCoords(ped)
        local maxDistance = maxDistance or 5
        local closestPeds = {}
        for i = 1, #peds, 1 do
            local pedCoords = GetEntityCoords(peds[i])
            if maxDistance >= #(pedCoords - coords) then
                closestPeds[#closestPeds + 1] = peds[i]
            end
        end
        return closestPeds
    end

    sgx.getClosestPlayer = function(coords)
        local ped = PlayerPedId()
        coords = coords and (type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords) or GetEntityCoords(ped)
        local closestPlayers = sgx.getPlayersFromCoords(coords)
        local closestDistance, closestPlayer = false
        for i = 1, #closestPlayers, 1 do
            if closestPlayers[i] ~= PlayerId() and closestPlayers[i] then
                local target = GetPlayerPed(closestPlayers[i])
                local targetCoords = GetEntityCoords(target)
                local distance = #(targetCoords - coords)
                if not closestDistance or closestDistance > distance then
                    closestPlayer = closestPlayers[i]
                    closestDistance = distance
                end
            end
        end
        return closestPlayer, closestDistance
    end

    sgx.getPlayersFromCoords = function(coords, maxDistance)
        local players = sgx.getPlayers()
        local ped = PlayerPedId()
        coords = coords and (type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords) or GetEntityCoords(ped)
        local maxDistance = maxDistance or 5
        local closePlayers = {}
        for _, player in pairs(players) do
            local target = GetPlayerPed(player)
            local targetCoords = GetEntityCoords(target)
            if maxDistance >= #(targetCoords - coords) then
                closePlayers[#closePlayers + 1] = player
            end
        end
        return closePlayers
    end

    sgx.getClosestVehicle = function(coords)
        local ped = PlayerPedId()
        local vehicles = GetGamePool('CVehicle')
        local closestDistance, closestVehicle = false
        coords = coords and (type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords) or GetEntityCoords(ped)
        for i = 1, #vehicles, 1 do
            local vehicleCoords = GetEntityCoords(vehicles[i])
            local distance = #(vehicleCoords - coords)
            if not closestDistance or closestDistance > distance then
                closestVehicle = vehicles[i]
                closestDistance = distance
            end
        end
        return closestVehicle, closestDistance
    end

    sgx.getClosestVehicles = function(coords, maxDistance)
        local ped = PlayerPedId()
        local vehicles = GetGamePool('CVehicle')
        coords = coords and (type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords) or GetEntityCoords(ped)
        local maxDistance = maxDistance or 5
        local closestVehicles = {}
        for i = 1, #vehicles, 1 do
            local vehicleCoords = GetEntityCoords(vehicles[i])
            if maxDistance >= #(vehicleCoords - coords) then
                closestVehicles[#closestVehicles + 1] = vehicles[i]
            end
        end
        return closestVehicles
    end

    sgx.getClosestObject = function(coords)
        local ped = PlayerPedId()
        local objects = GetGamePool('CObject')
        local closestDistance, closestObject = false
        coords = coords and (type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords) or GetEntityCoords(ped)
        for i = 1, #objects, 1 do
            local objectCoords = GetEntityCoords(objects[i])
            local distance = #(objectCoords - coords)
            if not closestDistance or closestDistance > distance then
                closestObject = objects[i]
                closestDistance = distance
            end
        end
        return closestObject, closestDistance
    end

    sgx.getClosestObjects = function(coords, maxDistance)
        local ped = PlayerPedId()
        local objects = GetGamePool('CObject')
        coords = coords and (type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords) or GetEntityCoords(ped)
        local maxDistance = maxDistance or 5
        local closestObjects = {}
        for i = 1, #objects, 1 do
            local objectCoords = GetEntityCoords(objects[i])
            if maxDistance >= #(objectCoords - coords) then
                closestObjects[#closestObjects + 1] = objects[i]
            end
        end
        return closestObjects
    end

    local duis = {}
    sgx.createDui = function(url, width, height, cb)
        width = width or 512
        height = height or 512
        local duiCounter = #duis + 1

        local duiSize = tostring(width) .. 'x' .. tostring(height)
        local generatedDictName = duiSize .. '-dict-' .. tostring(duiCounter)
        local generatedTxtName = duiSize .. '-tx-' .. tostring(duiCounter)
        local duiObject = CreateDui(url, width, height)
        local dictObject = CreateRuntimeTxd(generatedDictName)
        local duiHandle = GetDuiHandle(duiObject)
        local txdObject = CreateRuntimeTextureFromDuiHandle(dictObject, generatedTxtName, duiHandle)

        duis[duiCounter] = {
            -- duiSize = duiSize,
            duiObject = duiObject,
            -- duiHandle = duiHandle,
            -- dictionaryObject = dictObject,
            -- textureObject = txdObject,
            -- textureDictName = generatedDictName,
            -- textureName = generatedTxtName
        }

        local duiData = { id = duiCounter, dictionary = generatedDictName, texture = generatedTxtName }
        if cb then cb(duiData) else return duiData end
    end

    sgx.changeDuiUrl = function(id, url)
        if not duis[id] then
            print('dui not found. id: ' .. id)
            return
        end

        SetDuiUrl(duis[id].duiObject, url)
    end

    local mathpi, mathsin, mathabs, mathcos = math.pi, math.sin, math.abs, math.cos
    local GetForwardVector = function(rotation)
        local rot = (mathpi / 180.0) * rotation
        return vector3(-mathsin(rot.z) * mathabs(mathcos(rot.x)), mathcos(rot.z) * mathabs(mathcos(rot.x)), mathsin(rot.x))
    end

    sgx.raycast = function(origin, target, options, ignoreEntity, radius)
        local handle = StartShapeTestSweptSphere(origin.x, origin.y, origin.z, target.x, target.y, target.z, radius, options, ignoreEntity or PlayerPedId(), 0)
        return GetShapeTestResult(handle)
    end

    sgx.getEntityPlayerIsLookingAt = function(maxDistance, radius, flag, ignore)
        local maxDistance = maxDistance or 3.0
        local originCoords = GetPedBoneCoords(PlayerPedId(), 31086)
        local forwardVectors = GetForwardVector(GetGameplayCamRot(2))
        local forwardCoords = originCoords + (forwardVectors * maxDistance)

        if not forwardVectors then return end
        local _, hit, targetCoords, _, targetEntity = sgx.raycast(originCoords, forwardCoords, flag or 4294967295, ignore, radius or 0.2)
        if not hit and targetEntity == 0 then return end
        local entityType = GetEntityType(targetEntity)
        return targetEntity, entityType, targetCoords
    end

    sgx.getEntityInFrontOfEntity = function(entity, maxDistance, radius, flag)
        local maxDistance = maxDistance or 3.0
        local entity = (entity and DoesEntityExist(entity)) and entity or PlayerPedId()
        local forwardVector = GetEntityForwardVector(entity)
        local originCoords = GetEntityCoords(entity)
        local targetCoords = originCoords + (forwardVector * maxDistance)
        local _, hit, _, _, targetEntity = sgx.raycast(originCoords, targetCoords, flag or 4294967295, entity, radius or 0.2)
        return targetEntity
    end

    sgx.getVehicleProperties = function(vehicle)
        if DoesEntityExist(vehicle) then
            local function round(value, numDecimalPlaces)
                if not numDecimalPlaces then return math.floor(value + 0.5) end
                local power = 10 ^ numDecimalPlaces
                return math.floor((value * power) + 0.5) / (power)
            end
            local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
    
            local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
            if GetIsVehiclePrimaryColourCustom(vehicle) then
                local r, g, b = GetVehicleCustomPrimaryColour(vehicle)
                colorPrimary = { r, g, b }
            end
    
            if GetIsVehicleSecondaryColourCustom(vehicle) then
                local r, g, b = GetVehicleCustomSecondaryColour(vehicle)
                colorSecondary = { r, g, b }
            end
    
            local extras = {}
            for extraId = 0, 12 do
                if DoesExtraExist(vehicle, extraId) then
                    local state = IsVehicleExtraTurnedOn(vehicle, extraId) == 1
                    extras[tostring(extraId)] = state
                end
            end
    
            local modLivery = GetVehicleMod(vehicle, 48)
            if GetVehicleMod(vehicle, 48) == -1 and GetVehicleLivery(vehicle) ~= 0 then
                modLivery = GetVehicleLivery(vehicle)
            end
    
            local tireHealth = {}
            for i = 0, 3 do
                tireHealth[i] = GetVehicleWheelHealth(vehicle, i)
            end
    
            local tireBurstState = {}
            for i = 0, 5 do
                tireBurstState[i] = IsVehicleTyreBurst(vehicle, i, false)
            end
    
            local tireBurstCompletely = {}
            for i = 0, 5 do
                tireBurstCompletely[i] = IsVehicleTyreBurst(vehicle, i, true)
            end
    
            local windowStatus = {}
            for i = 0, 7 do
                windowStatus[i] = IsVehicleWindowIntact(vehicle, i) == 1
            end
    
            local doorStatus = {}
            for i = 0, 5 do
                doorStatus[i] = IsVehicleDoorDamaged(vehicle, i) == 1
            end
    
            local xenonColor
            local hasCustom, r, g, b = GetVehicleXenonLightsCustomColor(vehicle)
            if hasCustom then
                xenonColor = table.pack(r, g, b)
            else
                xenonColor = GetVehicleXenonLightsColor(vehicle)
            end
    
            return {
                model = GetEntityModel(vehicle),
                plate = GetVehicleNumberPlateText(vehicle),
                plateIndex = GetVehicleNumberPlateTextIndex(vehicle),
                bodyHealth = round(GetVehicleBodyHealth(vehicle), 0.1),
                engineHealth = round(GetVehicleEngineHealth(vehicle), 0.1),
                tankHealth = round(GetVehiclePetrolTankHealth(vehicle), 0.1),
                fuelLevel = round(GetVehicleFuelLevel(vehicle), 0.1),
                dirtLevel = round(GetVehicleDirtLevel(vehicle), 0.1),
                oilLevel = round(GetVehicleOilLevel(vehicle), 0.1),
                color1 = colorPrimary,
                color2 = colorSecondary,
                pearlescentColor = pearlescentColor,
                dashboardColor = GetVehicleDashboardColour(vehicle),
                wheelColor = wheelColor,
                wheels = GetVehicleWheelType(vehicle),
                wheelSize = GetVehicleWheelSize(vehicle),
                wheelWidth = GetVehicleWheelWidth(vehicle),
                tireHealth = tireHealth,
                tireBurstState = tireBurstState,
                tireBurstCompletely = tireBurstCompletely,
                windowTint = GetVehicleWindowTint(vehicle),
                windowStatus = windowStatus,
                doorStatus = doorStatus,
                neonEnabled = {
                    IsVehicleNeonLightEnabled(vehicle, 0),
                    IsVehicleNeonLightEnabled(vehicle, 1),
                    IsVehicleNeonLightEnabled(vehicle, 2),
                    IsVehicleNeonLightEnabled(vehicle, 3)
                },
                neonColor = table.pack(GetVehicleNeonLightsColour(vehicle)),
                interiorColor = GetVehicleInteriorColour(vehicle),
                extras = extras,
                tyreSmokeColor = table.pack(GetVehicleTyreSmokeColor(vehicle)),
                xenonColor = xenonColor,
                modSpoilers = GetVehicleMod(vehicle, 0),
                modFrontBumper = GetVehicleMod(vehicle, 1),
                modRearBumper = GetVehicleMod(vehicle, 2),
                modSideSkirt = GetVehicleMod(vehicle, 3),
                modExhaust = GetVehicleMod(vehicle, 4),
                modFrame = GetVehicleMod(vehicle, 5),
                modGrille = GetVehicleMod(vehicle, 6),
                modHood = GetVehicleMod(vehicle, 7),
                modFender = GetVehicleMod(vehicle, 8),
                modRightFender = GetVehicleMod(vehicle, 9),
                modRoof = GetVehicleMod(vehicle, 10),
                modEngine = GetVehicleMod(vehicle, 11),
                modBrakes = GetVehicleMod(vehicle, 12),
                modTransmission = GetVehicleMod(vehicle, 13),
                modHorns = GetVehicleMod(vehicle, 14),
                modSuspension = GetVehicleMod(vehicle, 15),
                modArmor = GetVehicleMod(vehicle, 16),
                modKit17 = GetVehicleMod(vehicle, 17),
                modTurbo = IsToggleModOn(vehicle, 18),
                modKit19 = GetVehicleMod(vehicle, 19),
                modSmokeEnabled = IsToggleModOn(vehicle, 20),
                modKit21 = GetVehicleMod(vehicle, 21),
                modXenon = IsToggleModOn(vehicle, 22),
                modFrontWheels = GetVehicleMod(vehicle, 23),
                modBackWheels = GetVehicleMod(vehicle, 24),
                modCustomTiresF = GetVehicleModVariation(vehicle, 23),
                modCustomTiresR = GetVehicleModVariation(vehicle, 24),
                modPlateHolder = GetVehicleMod(vehicle, 25),
                modVanityPlate = GetVehicleMod(vehicle, 26),
                modTrimA = GetVehicleMod(vehicle, 27),
                modOrnaments = GetVehicleMod(vehicle, 28),
                modDashboard = GetVehicleMod(vehicle, 29),
                modDial = GetVehicleMod(vehicle, 30),
                modDoorSpeaker = GetVehicleMod(vehicle, 31),
                modSeats = GetVehicleMod(vehicle, 32),
                modSteeringWheel = GetVehicleMod(vehicle, 33),
                modShifterLeavers = GetVehicleMod(vehicle, 34),
                modAPlate = GetVehicleMod(vehicle, 35),
                modSpeakers = GetVehicleMod(vehicle, 36),
                modTrunk = GetVehicleMod(vehicle, 37),
                modHydrolic = GetVehicleMod(vehicle, 38),
                modEngineBlock = GetVehicleMod(vehicle, 39),
                modAirFilter = GetVehicleMod(vehicle, 40),
                modStruts = GetVehicleMod(vehicle, 41),
                modArchCover = GetVehicleMod(vehicle, 42),
                modAerials = GetVehicleMod(vehicle, 43),
                modTrimB = GetVehicleMod(vehicle, 44),
                modTank = GetVehicleMod(vehicle, 45),
                modWindows = GetVehicleMod(vehicle, 46),
                modKit47 = GetVehicleMod(vehicle, 47),
                modLivery = modLivery,
                modKit49 = GetVehicleMod(vehicle, 49),
                liveryRoof = GetVehicleRoofLivery(vehicle),
            }
        else
            return
        end
    end

    sgx.setVehicleProperties = function(vehicle, props)
        if DoesEntityExist(vehicle) then
            if props.extras then
                for id, enabled in pairs(props.extras) do
                    if enabled then
                        SetVehicleExtra(vehicle, tonumber(id), 0)
                    else
                        SetVehicleExtra(vehicle, tonumber(id), 1)
                    end
                end
            end

            local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
            local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
            SetVehicleModKit(vehicle, 0)
            if props.plate then
                SetVehicleNumberPlateText(vehicle, props.plate)
            end
            if props.plateIndex then
                SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex)
            end
            if props.bodyHealth then
                SetVehicleBodyHealth(vehicle, props.bodyHealth + 0.0)
            end
            if props.engineHealth then
                SetVehicleEngineHealth(vehicle, props.engineHealth + 0.0)
            end
            if props.tankHealth then
                SetVehiclePetrolTankHealth(vehicle, props.tankHealth)
            end
            if props.fuelLevel then
                SetVehicleFuelLevel(vehicle, props.fuelLevel + 0.0)
            end
            if props.dirtLevel then
                SetVehicleDirtLevel(vehicle, props.dirtLevel + 0.0)
            end
            if props.oilLevel then
                SetVehicleOilLevel(vehicle, props.oilLevel)
            end
            if props.color1 then
                if type(props.color1) == 'number' then
                    ClearVehicleCustomPrimaryColour(vehicle)
                    SetVehicleColours(vehicle, props.color1, colorSecondary)
                else
                    SetVehicleCustomPrimaryColour(vehicle, props.color1[1], props.color1[2], props.color1[3])
                end
            end
            if props.color2 then
                if type(props.color2) == 'number' then
                    ClearVehicleCustomSecondaryColour(vehicle)
                    SetVehicleColours(vehicle, props.color1 or colorPrimary, props.color2)
                else
                    SetVehicleCustomSecondaryColour(vehicle, props.color2[1], props.color2[2], props.color2[3])
                end
            end
            if props.pearlescentColor then
                SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor)
            end
            if props.interiorColor then
                SetVehicleInteriorColor(vehicle, props.interiorColor)
            end
            if props.dashboardColor then
                SetVehicleDashboardColour(vehicle, props.dashboardColor)
            end
            if props.wheelColor then
                SetVehicleExtraColours(vehicle, props.pearlescentColor or pearlescentColor, props.wheelColor)
            end
            if props.wheels then
                SetVehicleWheelType(vehicle, props.wheels)
            end
            if props.tireHealth then
                for wheelIndex, health in pairs(props.tireHealth) do
                    SetVehicleWheelHealth(vehicle, wheelIndex, health)
                end
            end
            if props.tireBurstState then
                for wheelIndex, burstState in pairs(props.tireBurstState) do
                    if burstState then
                        SetVehicleTyreBurst(vehicle, tonumber(wheelIndex), false, 1000.0)
                    end
                end
            end
            if props.tireBurstCompletely then
                for wheelIndex, burstState in pairs(props.tireBurstCompletely) do
                    if burstState then
                        SetVehicleTyreBurst(vehicle, tonumber(wheelIndex), true, 1000.0)
                    end
                end
            end
            if props.windowTint then
                SetVehicleWindowTint(vehicle, props.windowTint)
            end
            if props.windowStatus then
                for windowIndex, smashWindow in pairs(props.windowStatus) do
                    if not smashWindow then SmashVehicleWindow(vehicle, windowIndex) end
                end
            end
            if props.doorStatus then
                for doorIndex, breakDoor in pairs(props.doorStatus) do
                    if breakDoor then
                        SetVehicleDoorBroken(vehicle, tonumber(doorIndex), true)
                    end
                end
            end
            if props.neonEnabled then
                SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
                SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
                SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
                SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
            end
            if props.neonColor then
                SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3])
            end
            if props.interiorColor then
                SetVehicleInteriorColour(vehicle, props.interiorColor)
            end
            if props.wheelSize then
                SetVehicleWheelSize(vehicle, props.wheelSize)
            end
            if props.wheelWidth then
                SetVehicleWheelWidth(vehicle, props.wheelWidth)
            end
            if props.tyreSmokeColor then
                SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3])
            end
            if props.modSpoilers then
                SetVehicleMod(vehicle, 0, props.modSpoilers, false)
            end
            if props.modFrontBumper then
                SetVehicleMod(vehicle, 1, props.modFrontBumper, false)
            end
            if props.modRearBumper then
                SetVehicleMod(vehicle, 2, props.modRearBumper, false)
            end
            if props.modSideSkirt then
                SetVehicleMod(vehicle, 3, props.modSideSkirt, false)
            end
            if props.modExhaust then
                SetVehicleMod(vehicle, 4, props.modExhaust, false)
            end
            if props.modFrame then
                SetVehicleMod(vehicle, 5, props.modFrame, false)
            end
            if props.modGrille then
                SetVehicleMod(vehicle, 6, props.modGrille, false)
            end
            if props.modHood then
                SetVehicleMod(vehicle, 7, props.modHood, false)
            end
            if props.modFender then
                SetVehicleMod(vehicle, 8, props.modFender, false)
            end
            if props.modRightFender then
                SetVehicleMod(vehicle, 9, props.modRightFender, false)
            end
            if props.modRoof then
                SetVehicleMod(vehicle, 10, props.modRoof, false)
            end
            if props.modEngine then
                SetVehicleMod(vehicle, 11, props.modEngine, false)
            end
            if props.modBrakes then
                SetVehicleMod(vehicle, 12, props.modBrakes, false)
            end
            if props.modTransmission then
                SetVehicleMod(vehicle, 13, props.modTransmission, false)
            end
            if props.modHorns then
                SetVehicleMod(vehicle, 14, props.modHorns, false)
            end
            if props.modSuspension then
                SetVehicleMod(vehicle, 15, props.modSuspension, false)
            end
            if props.modArmor then
                SetVehicleMod(vehicle, 16, props.modArmor, false)
            end
            if props.modKit17 then
                SetVehicleMod(vehicle, 17, props.modKit17, false)
            end
            if props.modTurbo then
                ToggleVehicleMod(vehicle, 18, props.modTurbo)
            end
            if props.modKit19 then
                SetVehicleMod(vehicle, 19, props.modKit19, false)
            end
            if props.modSmokeEnabled then
                ToggleVehicleMod(vehicle, 20, props.modSmokeEnabled)
            end
            if props.modKit21 then
                SetVehicleMod(vehicle, 21, props.modKit21, false)
            end
            if props.modXenon then
                ToggleVehicleMod(vehicle, 22, props.modXenon)
            end
            if props.xenonColor then
                if type(props.xenonColor) == 'table' then
                    SetVehicleXenonLightsCustomColor(vehicle, props.xenonColor[1], props.xenonColor[2], props.xenonColor[3])
                else
                    SetVehicleXenonLightsColor(vehicle, props.xenonColor)
                end
            end
            if props.modFrontWheels then
                SetVehicleMod(vehicle, 23, props.modFrontWheels, false)
            end
            if props.modBackWheels then
                SetVehicleMod(vehicle, 24, props.modBackWheels, false)
            end
            if props.modCustomTiresF then
                SetVehicleMod(vehicle, 23, props.modFrontWheels, props.modCustomTiresF)
            end
            if props.modCustomTiresR then
                SetVehicleMod(vehicle, 24, props.modBackWheels, props.modCustomTiresR)
            end
            if props.modPlateHolder then
                SetVehicleMod(vehicle, 25, props.modPlateHolder, false)
            end
            if props.modVanityPlate then
                SetVehicleMod(vehicle, 26, props.modVanityPlate, false)
            end
            if props.modTrimA then
                SetVehicleMod(vehicle, 27, props.modTrimA, false)
            end
            if props.modOrnaments then
                SetVehicleMod(vehicle, 28, props.modOrnaments, false)
            end
            if props.modDashboard then
                SetVehicleMod(vehicle, 29, props.modDashboard, false)
            end
            if props.modDial then
                SetVehicleMod(vehicle, 30, props.modDial, false)
            end
            if props.modDoorSpeaker then
                SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false)
            end
            if props.modSeats then
                SetVehicleMod(vehicle, 32, props.modSeats, false)
            end
            if props.modSteeringWheel then
                SetVehicleMod(vehicle, 33, props.modSteeringWheel, false)
            end
            if props.modShifterLeavers then
                SetVehicleMod(vehicle, 34, props.modShifterLeavers, false)
            end
            if props.modAPlate then
                SetVehicleMod(vehicle, 35, props.modAPlate, false)
            end
            if props.modSpeakers then
                SetVehicleMod(vehicle, 36, props.modSpeakers, false)
            end
            if props.modTrunk then
                SetVehicleMod(vehicle, 37, props.modTrunk, false)
            end
            if props.modHydrolic then
                SetVehicleMod(vehicle, 38, props.modHydrolic, false)
            end
            if props.modEngineBlock then
                SetVehicleMod(vehicle, 39, props.modEngineBlock, false)
            end
            if props.modAirFilter then
                SetVehicleMod(vehicle, 40, props.modAirFilter, false)
            end
            if props.modStruts then
                SetVehicleMod(vehicle, 41, props.modStruts, false)
            end
            if props.modArchCover then
                SetVehicleMod(vehicle, 42, props.modArchCover, false)
            end
            if props.modAerials then
                SetVehicleMod(vehicle, 43, props.modAerials, false)
            end
            if props.modTrimB then
                SetVehicleMod(vehicle, 44, props.modTrimB, false)
            end
            if props.modTank then
                SetVehicleMod(vehicle, 45, props.modTank, false)
            end
            if props.modWindows then
                SetVehicleMod(vehicle, 46, props.modWindows, false)
            end
            if props.modKit47 then
                SetVehicleMod(vehicle, 47, props.modKit47, false)
            end
            if props.modLivery then
                SetVehicleMod(vehicle, 48, props.modLivery, false)
                SetVehicleLivery(vehicle, props.modLivery)
            end
            if props.modKit49 then
                SetVehicleMod(vehicle, 49, props.modKit49, false)
            end
            if props.liveryRoof then
                SetVehicleRoofLivery(vehicle, props.liveryRoof)
            end
        end
    end

else --server
    sgx.serverCallbacks = {}

    sgx.registerCallback = function(name, cb)
        sgx.serverCallbacks[name] = cb
    end

    sgx.triggerCallback = function(name, src, cb, ...)
        if sgx.serverCallbacks[name] then
            sgx.serverCallbacks[name](src, cb, ...)
        else
            sgx.debug('This callback(^2' .. name .. '^0) is not registered!')
        end
    end

    RegisterNetEvent(GetCurrentResourceName() .. ':server:triggerCallback', function(name, ...)
        local src = source

        sgx.triggerCallback(name, src, function(...)
            TriggerClientEvent(GetCurrentResourceName() .. ':client:triggerCallback', src, name, ...)
        end, ...)
    end)

    local manifestFile = LoadResourceFile(GetCurrentResourceName(), 'fxmanifest.lua')
    local loadSqlFuncs = manifestFile:find('/lib/MySQL.lua') and true or false
    if loadSqlFuncs then
        sgx.sql = {}
        sgx.sql.async = {}
        sgx.sql.sync = {}
        if GetResourceState('oxmysql') == 'started' then
            CreateThread(function()
                while not MySQL do
                    Wait(1)
                end

                sgx.sql.sync.query = MySQL.query.await
                sgx.sql.sync.insert = MySQL.insert.await
                sgx.sql.sync.update = MySQL.update.await
                -- sgx.sql.sync.single = MySQL.single.await
                sgx.sql.sync.scalar = MySQL.scalar.await

                sgx.sql.async.query = MySQL.query
                sgx.sql.async.insert = MySQL.insert
                sgx.sql.async.update = MySQL.update
                -- sgx.sql.async.single = MySQL.single
                sgx.sql.async.scalar = MySQL.scalar
            end)
        elseif GetResourceState('mysql-async') == 'started' then
            CreateThread(function()
                while not MySQL do
                    Wait(1)
                end
                MySQL.ready(function()
                    sgx.sql.sync.query = MySQL.Sync.fetchAll
                    sgx.sql.sync.insert = MySQL.Sync.insert
                    sgx.sql.sync.update = MySQL.Sync.execute
                    -- sgx.sql.sync.single = MySQL.Sync.single
                    sgx.sql.sync.scalar = MySQL.Sync.fetchScalar

                    sgx.sql.async.query = MySQL.Async.fetchAll
                    sgx.sql.async.insert = MySQL.Async.insert
                    sgx.sql.async.update = MySQL.Async.execute
                    -- sgx.sql.async.single = MySQL.Async.single
                    sgx.sql.async.scalar = MySQL.Async.fetchScalar
                end)
            end)
        end
    end

    sgx.notification = function(src, type, str, length)
        TriggerClientEvent(GetCurrentResourceName() .. ':client:notification', src, type, str, length)
    end

    sgx.getIdentifiers = function(src, identifiertypes)
        local identifiers = GetPlayerIdentifiers(src)
        local response = {}
        if identifiertypes then
            if type(identifiertypes) == 'table' then
                for _, type in pairs(identifiertypes) do
                    for _, identifier in pairs(identifiers) do
                        if string.find(identifier, type) then
                            response[type] = identifier
                        end
                    end
                end
            else
                for _, identifier in pairs(identifiers) do
                    if string.find(identifier, identifiertypes) then
                        return identifier
                    end
                end
            end
        else
            for _, identifier in pairs(identifiers) do
                if string.find(identifier, 'steam') then
                    return identifier
                end
            end
        end
        return response
    end

    local sanitize = function(str)
        if str then
            local replacements = {
                ['&'] = '&amp;',
                ['<'] = '&lt;',
                ['>'] = '&gt;',
                ['\n'] = '<br/>',
            }

            return str:gsub('[&<>\n]', replacements):gsub(' +', function(s) return ' ' .. ('&nbsp;'):rep(#s - 1) end)
        else
            return nil
        end
    end

    local logColors = {
        ['default'] = 16711680,
        ['blue'] = 25087,
        ['green'] = 762640,
        ['white'] = 16777215,
        ['black'] = 0,
        ['orange'] = 16743168,
        ['lightgreen'] = 65309,
        ['yellow'] = 15335168,
        ['pink'] = 16711900,
        ['red'] = 16711680,
        ['cyan'] = 65535,
    }
    sgx.sendLog = function(webhookURL, color, str, imgUrl)
        if webhookURL and webhookURL ~= '' then
            local headers = {
                ['Content-Type'] = 'application/json',
            }
            local data = {
                ['username'] = 'sgx-logs',
                ['avatar_url'] = 'https://raw.githubusercontent.com/SH-Scripts/logo/main/logo.png',
                ['embeds'] = { {
                    ['title'] = 'sgx-store.tebex.io',
                    ['url'] = 'https://sgx-store.tebex.io/',
                    ['color'] = logColors[color] and logColors[color] or logColors['default'],
                    ['timestamp'] = os.date('!%Y-%m-%dT%H:%M:%SZ'),
                } },
                ['footer'] = {
                    ['text'] = 'sgx-store.tebex.io',
                    ['icon_url'] = 'https://raw.githubusercontent.com/SH-Scripts/logo/main/logo.png',
                },
            }
            data['embeds'][1]['description'] = str
            if imgUrl then
                data['embeds'][1]['image'] = {
                    ['url'] = imgUrl,
                }
            end
        else
            sgx.debug('Webhook URL is empty!')
        end
    end

    sgx.sendSelfLog = function(src, webhookURL, color, str, imgUrl)
        if webhookURL and webhookURL ~= '' then
            if src then
                local name = sanitize(GetPlayerName(src))
                local identifiers = sgx.getIdentifiers(src, { 'license', 'discord' })
                local text = ''
                if identifiers['license'] then
                    text = text .. '\n**License**: ' .. identifiers['license']
                end
                if identifiers['discord'] then
                    text = text .. '\n**Discord**: <@' .. identifiers['discord']:sub(9) .. '>'
                end
                local headers = {
                    ['Content-Type'] = 'application/json',
                }
                local data = {
                    ['username'] = 'sgx-logs',
                    ['avatar_url'] = 'https://raw.githubusercontent.com/SH-Scripts/logo/main/logo.png',
                    ['embeds'] = { {
                        ['title'] = 'sgx-store.tebex.io',
                        ['url'] = 'https://sgx-store.tebex.io/',
                        ['author'] = {
                            ['name'] = '#' .. src .. ' - ' .. name,
                            ['url'] = 'https://sgx-store.tebex.io/',
                        },
                        ['color'] = logColors[color] ~= nil and logColors[color] or logColors['default'],
                        ['timestamp'] = os.date('!%Y-%m-%dT%H:%M:%SZ'),
                        ['footer'] = {
                            ['text'] = 'sgx-store.tebex.io',
                            ['icon_url'] = 'https://raw.githubusercontent.com/SH-Scripts/logo/main/logo.png',
                        },
                    } },
                }
                data['embeds'][1]['description'] = text .. '\n' .. str
                if imgUrl then
                    data['embeds'][1]['image'] = {
                        ['url'] = imgUrl,
                    }
                end
            end
        else
            sgx.debug('Webhook URL is empty!')
        end
    end
end
