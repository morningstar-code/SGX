wFramework = nil
wRsc = nil
wCui = nil

if Config.Framework.Framework == "esx" then
    if Config.Framework.NewCore then
        wFramework = exports[Config.Framework.ResourceName]:getSharedObject()
    else
        while wFramework == nil do
            TriggerEvent(Config.Framework.SharedEvent, function(obj) wFramework = obj end)
            Wait(10)
        end
    end
    
    wRsc = wFramework.RegisterServerCallback
    wCui = wFramework.RegisterUsableItem
elseif Config.Framework.Framework == "qbcore" then
    wFramework = exports[Config.Framework.ResourceName]:GetCoreObject()
    wRsc = wFramework.Functions.CreateCallback
    wCui = Config.Items.qs_inventory and exports['qs-inventory']:CreateUseableItem(...) or wFramework.Functions.CreateUseableItem
end

local stations = {}
local players = {}

-----------------------------------------------------------------------------------------
-- EVENT'S --
-----------------------------------------------------------------------------------------

RegisterNetEvent('esx:playerLoaded', function(joiner, data)
    local src = joiner
    Wait(3000)
    checkJob(src, data.job)
end)

RegisterNetEvent('QBCore:Server:PlayerLoaded', function(p)
    local src = p.PlayerData.source
    checkJob(src, p.PlayerData.job)
end)

RegisterNetEvent('wais:checkPlayer:job', function(firstTime)
    local src = source
    local Player = Config.Framework.Framework == "esx" and wFramework.GetPlayerFromId(src) or wFramework.Functions.GetPlayer(src)

    if Player == nil then
        return
    end

    local stillInTheJob = checkNewJob(src, Config.Framework.Framework == "esx" and Player.job or Player.PlayerData.job)

    if not stillInTheJob then
        if players[tostring(src)] ~= nil then
            removePlayers(src)
        end
    end
end)

RegisterNetEvent('wais:removeTable:bodycam:inventory', function()
    local src = source
    if players[tostring(src)] ~= nil then
        closeBodycam(src)
    end
end)

RegisterNetEvent('wais:removeTable:dashcam', function(playerId)
    local src = source
    if players[tostring(playerId)] ~= nil then
        closeDashcam(playerId)
    end
end)

RegisterNetEvent('wais:removeTable:bodycam', function(source)
    local src = source
    if players[tostring(src)] ~= nil then
        closeBodycam(src)
    end
end)

RegisterNetEvent('wais:add:tableDashcam', function(carid, plate, bone)
    local src = source
    addDashcam(src, carid, plate, bone)
end)

RegisterNetEvent('wais:unload', function()
    local src = source
    if players[tostring(src)] ~= nil then
        removePlayers(src)
    end
end)

RegisterNetEvent('esx_ambulancejob:setDeathStatus', function(state)
    local src = source
    changeDeadStatus(src, state)
end)

RegisterNetEvent('hospital:server:SetDeathStatus', function(state)
    local src = source
    changeDeadStatus(src, state)   
end)

RegisterNetEvent('hospital:server:SetLaststandStatus', function(state)
    local src = source
    changeDeadStatus(src, state)
end)

RegisterNetEvent('wasabi_ambulance:setDeathStatus', function(state)
    local src = source
    changeDeadStatus(src, state)
end)

RegisterNetEvent('wais:upload:record', function(data)
    local src = source
    local recordId = insertRecord(data, src)
    if recordId then
        stations[data.player.job].records[recordId] = {
            ["id"] = recordId,
            ["meta"] = data
        }
        sendRecords(data.player.job, recordId)
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for k, v in pairs(Config.Jobs) do
            if stations[k] == nil then
                stations[k] =  {
                    ["sources"] = {}, 
                    ["bodycams"] = {
                        ["online"] = 0,
                        ["cams"] = {}
                    },
                    ["dashcams"] = {
                        ["online"] = 0,
                        ["cams"] = {}
                    },
                    ["records"] = getRecords(k)
                }
            end
        end
    end
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    if players[tostring(src)] ~= nil then
        removePlayers(src)
    end
end)

-----------------------------------------------------------------------------------------
-- CALLBACK'S --
-----------------------------------------------------------------------------------------

wRsc('wais:get:targetCoords', function(source, cb, id)
    local ped = GetPlayerPed(id)
    local playerCoords = GetEntityCoords(ped)
    cb(playerCoords)
end)

wRsc('wais:get:carCoords', function(source, cb, playerId)
    local car = NetworkGetEntityFromNetworkId(stations[players[tostring(playerId)].job].dashcams.cams[tostring(playerId)].carId)
    local exists = DoesEntityExist(car)
    if exists then
        local carCoords = GetEntityCoords(car)
        cb(carCoords)
    else
        closeDashcam(playerId)
        cb(false)
    end
end)

wCui(Config.Items.bodycam, function(source, item)
    local src = source

    if players[tostring(src)] ~= nil then
        local table = players[tostring(src)]
        if not table.bodycam then
            stations[table.job].bodycams.online = stations[table.job].bodycams.online + 1
            stations[table.job].bodycams.cams[tostring(src)] = {
                ["id"] = src,
                ["name"] = table.name,
                ["grade"] = table.grade,
            }
            table.bodycam = true
            TriggerClientEvent('wais:change:bodycamState', src, true)
            TriggerJobEvent(tostring(src), table.job, true, false, true)
        else
            closeBodycam(src)
        end
    end
end)    

wCui(Config.Items.dashcam, function(source, item)
    local src = source
    if players[tostring(src)] ~= nil then
        local table = players[tostring(src)]
        if not table.dashcam then
            TriggerClientEvent('wais:check:nearVehicles', src)
        else
            closeDashcam(src)
        end
    end
end)

-----------------------------------------------------------------------------------------
-- FUNCTION'S --
-----------------------------------------------------------------------------------------

function getRecords(job)
    local p = promise:new()
    MySQL.Async.fetchAll('SELECT * FROM wais_records WHERE job = @job ORDER BY date DESC', {
        ['@job'] = job
    }, function(records)
        p:resolve(#records > 0 and records or {})
    end)
    return Citizen.Await(p)
end

function checkJob(src, job)
    local state = false
    for k, v in pairs(Config.Jobs) do
        if job.name == k then
            if players[tostring(src)] == nil then
                local player = Config.Framework.Framework == "esx" and wFramework.GetPlayerFromId(src) or wFramework.Functions.GetPlayer(src)
                local playerName = Config.Framework.Framework == "esx" and ('%s - %s'):format(player.get('firstName'), player.get('lastName')) or ('%s - %s'):format(player.PlayerData.charinfo.firstname, player.PlayerData.charinfo.lastname)

                players[tostring(src)] = {
                    ["job"] = k,
                    ["bodycam"] = false,
                    ["dashcam"] = false,
                    ["grade"] = Config.Framework.Framework == "esx" and job.grade_label or job.grade.name,
                    ["name"] = playerName
                }
                stations[k].sources[tostring(src)] = true
                TriggerClientEvent('wais:send:stationsData', src, stations[job.name])
                TriggerClientEvent('wais:set:job', src, job.name, playerName)
                state = true
                break
            end
        end
    end
    return state
end

function checkNewJob(src, job)
    local p = promise:new()
    if players[tostring(src)] ~= nil then
        if players[tostring(src)].job == job.name then
            players[tostring(src)].grade = Config.Framework.Framework == "esx" and job.grade_label or job.grade.name
            p:resolve(true)
        else
            if removePlayers(src) then
                p:resolve(checkJob(src, job))
            end
        end
    else
        p:resolve(checkJob(src, job))
    end
    return Citizen.Await(p)
end

function removePlayers(src)
    local table = players[tostring(src)]
    local bodycam = table.bodycam
    local dashcam = table.dashcam
    local job = table.job

    if bodycam then
        stations[job].bodycams.online = stations[job].bodycams.online - 1
        stations[job].bodycams.cams[tostring(src)] = nil
        TriggerClientEvent('wais:change:bodycamState', src, false)
    end

    if dashcam then
        stations[job].dashcams.online = stations[job].dashcams.online - 1
        stations[job].dashcams.cams[tostring(src)] = nil
    end

    players[tostring(src)] = nil
    stations[job].sources[tostring(src)] = nil
    TriggerClientEvent('wais:set:job', src, nil, nil)
    return TriggerJobEvent(tostring(src), job, bodycam, dashcam, false)
end

function closeDashcam(src)
    if players[tostring(src)] ~= nil then
        local table = players[tostring(src)]
        if table.dashcam then
            stations[table.job].dashcams.online = stations[table.job].dashcams.online - 1
            stations[table.job].dashcams.cams[tostring(src)] = nil
            table.dashcam = false
            TriggerJobEvent(tostring(src), table.job, false, true, false)
        end
    end
end

function closeBodycam(src)
    if players[tostring(src)] ~= nil then
        local table = players[tostring(src)]
        if table.bodycam then
            stations[table.job].bodycams.online = stations[table.job].bodycams.online - 1
            stations[table.job].bodycams.cams[tostring(src)] = nil
            table.bodycam = false
            TriggerClientEvent('wais:change:bodycamState', src, false)
            TriggerJobEvent(tostring(src), table.job, true, false, false)
        end
    end
end

function addDashcam(src, carid, plate, bone)
    if players[tostring(src)] ~= nil then
        local table = players[tostring(src)]
        if not table.dashcam then
            stations[table.job].dashcams.online = stations[table.job].dashcams.online + 1
            stations[table.job].dashcams.cams[tostring(src)] = {
                ["id"] = src,
                ["name"] = table.name,
                ["grade"] = table.grade,
                ["carId"] = carid,
                ["plate"] = plate,
                ["bone"] = bone
            }
            table.dashcam = true
            TriggerJobEvent(tostring(src), table.job, false, true, true)
        else
            closeDashcam(src)
        end
    end
end

function TriggerJobEvent(tableid, job, bodycam, dashcam, add)
    local bodyEvent = bodycam and ('wais:%s:bodycam'):format(add and 'add' or 'remove') or false
    local dashEvent = dashcam and ('wais:%s:dashcam'):format(add and 'add' or 'remove') or false
    for k, v in pairs(stations[job].sources) do
        if bodyEvent then
            TriggerClientEvent(bodyEvent, tonumber(k), tableid, not add and nil or stations[job].bodycams.cams[tableid])
        end
        if dashEvent then
            TriggerClientEvent(dashEvent, tonumber(k), tableid, not add and nil or stations[job].dashcams.cams[tableid])
        end
    end
    return true
end

function sendRecords(job, tableid)
    for k, v in pairs(stations[job].sources) do
        TriggerClientEvent('wais:add:records', tonumber(k), tableid, stations[job].records[tableid])
    end
end

function changeDeadStatus(src, state)
    if state then
        if players[tostring(src)] ~= nil then
            local table = players[tostring(src)]
            if table.bodycam then
                closeBodycam(src)
            end

            TriggerClientEvent('wais:playerDead', src)
        end
    end
end

function insertRecord(data, source)
    local p = promise:new()
    MySQL.Async.insert('INSERT INTO `wais_records` (`job`, `meta`) VALUES (@job, @meta)', {
        ['@job'] = data.player.job,
        ['@meta'] = json.encode(data)
    }, function(res)
        if res ~= nil then
            p:resolve(res)
        else
            p:resolve(false)
            print('Error inserting record')
        end
    end)
    return Citizen.Await(p)
end

-----------------------------------------------------------------------------------------
-- COMMAND'S --
-----------------------------------------------------------------------------------------

RegisterCommand('jobcams', function(s)
    if s > 0 then
        return
    end
    print(json.encode(stations))
end)

-----------------------------------------------------------------------------------------
-- THREAD'S --
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- VERSION CHECK --
-----------------------------------------------------------------------------------------

local resource  = GetInvokingResource() or GetCurrentResourceName()
local script    = GetResourceMetadata(resource, 'scriptname', 0)
local version   = GetResourceMetadata(resource, 'version', 0)

SetTimeout(1000, function()
    checkversion()
end)

function checkversion()
    PerformHttpRequest('https://ayazwai.dev/version', function(errorCode, resultData, resultHeaders)
        if resultData ~= nil then
            local data = json.decode(resultData)
            if errorCode == 202 then
                print(data.message)
                if data.havelog then
                    for k, v in pairs(data.changelogs) do
                        print(v)
                    end
                end
            else
                print(data.message)
            end
        else
            print('Could not check the script version...')
        end
    end, 'GET', '', {
        ["x-script"] = script, 
        ["x-version"] = version
    })
end