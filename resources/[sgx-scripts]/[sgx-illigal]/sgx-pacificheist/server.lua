
local lastrob = 0
local start = false
discord = {
    ['webhook'] = 'https://discord.com/api/webhooks/1117646032218640424/SKSLlcVYb-K66ZWXSQdvk_qjfJo-wotY6OdJTMA701BMeAZ___6lZfUJOHVFCEtpGk2z',
    ['name'] = 'rm_pacificheist',
    ['image'] = 'https://cdn.discordapp.com/avatars/869260464775921675/dea34d25f883049a798a241c8d94020c.png?size=1024'
}


QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

QBCore.Functions.CreateCallback('pacificheist:server:checkPoliceCount', function(source, cb)
    local src = source
    local players = QBCore.Functions.GetPlayers()
    local policeCount = 0

    for i = 1, #players do
        local player = QBCore.Functions.GetPlayer(players[i])
        -- if player['job']['name'] == 'police' then
        if (player.PlayerData.job.name == "police" and player.PlayerData.job.onduty) then
         policeCount = policeCount + 1
        end
    end

    if policeCount >= Config['PacificHeist']['requiredPoliceCount'] then
        cb(true)
    else
        cb(false)
        --TriggerClientEvent('fleecaheist:client:showNotification', src, Strings['need_police'])
        TriggerClientEvent('QBCore:Notify', src, Strings['need_police'] , 'error', 3000)
    end
end)

--[[
QBCore.Functions.CreateCallback('pacificheist:server:checkPoliceCount', function(source, cb)
    local src = source
    local players = ESX.GetPlayers()
    local policeCount = 0

    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            policeCount = policeCount + 1
        end
    end

    if policeCount >= Config['PacificHeist']['requiredPoliceCount'] then
        cb(true)
    else
        cb(false)
        TriggerClientEvent('pacificheist:client:showNotification', src, Strings['need_police'])
    end
end)
--]]

QBCore.Functions.CreateCallback('pacificheist:server:checkTime', function(source, cb)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if (os.time() - lastrob) < Config['PacificHeist']['nextRob'] and lastrob ~= 0 then
        local seconds = Config['PacificHeist']['nextRob'] - (os.time() - lastrob)
        --TriggerClientEvent('pacificheist:client:showNotification', src, Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'])
        TriggerClientEvent('QBCore:Notify', src, Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'] , 'error', 3000)
        cb(false)
    else
        lastrob = os.time()
        start = true
        discordLog(GetPlayerName(src) ..  ' - ' .. player.PlayerData.license, ' started the Pacific Heist!')
        cb(true)
    end
end)

--[[
QBCore.Functions.CreateCallback('pacificheist:server:hasItem', function(source, cb, item)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    local playerItem = player.getInventoryItem(item)

    if player and playerItem ~= nil then
        if playerItem.count >= 1 then
            cb(true, playerItem.label)
        else
            cb(false, playerItem.label)
        end
    else
        print('[rm_pacificheist] you need add required items to server database')
    end
end)
--]]

QBCore.Functions.CreateCallback('pacificheist:server:hasItem', function(source, cb, item)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local playerItem = player.Functions.GetItemByName(item)

    if player and playerItem ~= nil then
        if playerItem.amount >= 1 then
            cb(true, playerItem.label)
        else
            cb(false, playerItem.label)
        end
    else
       -- print('[rm_fleecaheist] you need add required items to server database')
        TriggerClientEvent('QBCore:Notify', src, 'You missing items - Bag/Drill/Cutter/C4-Bomb/Themite/Laptop/USB' , 'error', 5000)

    end
end)
--[[
RegisterServerEvent('pacificheist:server:policeAlert')
AddEventHandler('pacificheist:server:policeAlert', function(coords)
    local players = ESX.GetPlayers()
    
    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            TriggerClientEvent('pacificheist:client:policeAlert', players[i], coords)
        end
    end
end)
--]]

RegisterServerEvent('pacificheist:server:rewardItem')
AddEventHandler('pacificheist:server:rewardItem', function(item, count, type)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local whitelistItems = {}

    if player then
        if type == 'money' then
            local sourcePed = GetPlayerPed(src)
            local sourceCoords = GetEntityCoords(sourcePed)
            local dist = #(sourceCoords - vector3(256.764, 241.272, 101.693))
            if dist > 200.0 then
                print('[rm_pacificheist] add money exploit playerID: '.. src .. ' name: ' .. GetPlayerName(src))
            else
                if Config['PacificHeist']['black_money'] then
                    player.Functions.AddItem('markedbills', count)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")
                  --  player.addAccountMoney('black_money', count)
                else
                    player.Functions.AddMoney("cash", count)
                   -- player.addMoney(count)
                end
            end
        else
            for k, v in pairs(Config['PacificHeist']['rewardItems']) do
                whitelistItems[v['itemName']] = true
            end

            for k, v in pairs(Config['PacificSetup']['glassCutting']['rewards']) do
                whitelistItems[v['item']] = true
            end

            for k, v in pairs(Config['PacificSetup']['painting']) do
                whitelistItems[v['rewardItem']] = true
            end

            if whitelistItems[item] then
                if count then 
                  --  player.addInventoryItem(item, count)
                    player.Functions.AddItem(item, count)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
                else
                   -- player.addInventoryItem(item, 1)
                    player.Functions.AddItem(item, 1)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
                end
            else
                print('[rm_pacificheist] add item exploit playerID: '.. src .. ' name: ' .. GetPlayerName(src))
            end
        end
    end
end)

RegisterServerEvent('pacificheist:server:removeItem')
AddEventHandler('pacificheist:server:removeItem', function(item)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        --player.removeInventoryItem(item, 1)
        player.Functions.RemoveItem(item, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
    end
end)

RegisterServerEvent('pacificheist:server:sellRewardItems')
AddEventHandler('pacificheist:server:sellRewardItems', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local totalMoney = 0

    if player then

        for k, v in pairs(Config['PacificHeist']['rewardItems']) do

            if player.Functions.GetItemByName(v['itemName']) ~= nil then

            local playerItem = player.Functions.GetItemByName(v['itemName'])

            if playerItem.amount >= 1 then

                player.Functions.RemoveItem(v['itemName'], playerItem.amount)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v['itemName']], "remove")
                player.Functions.AddMoney("cash", playerItem.amount * v['sellPrice'])
                totalMoney = totalMoney + (playerItem.amount * v['sellPrice'])

               -- player.removeInventoryItem(v['itemName'], playerItem.count)
               -- player.addMoney(playerItem.count * v['sellPrice'])

            end
          end
        end
        
        for k, v in pairs(Config['PacificSetup']['glassCutting']['rewards']) do

            if player.Functions.GetItemByName(v['item']) ~= nil then

            local playerItem = player.Functions.GetItemByName(v['item'])

            if playerItem.amount >= 1 then

                player.Functions.RemoveItem(v['item'], playerItem.amount)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v['item']], "remove")
                player.Functions.AddMoney("cash", playerItem.amount * v['price'])
                totalMoney = totalMoney + (playerItem.amount * v['price'])

              --  player.removeInventoryItem(v['item'], playerItem.count)
              --  player.addMoney(playerItem.count * v['price'])
              --  totalMoney = totalMoney + (playerItem.count * v['price'])
            end
          end
        end

        for k, v in pairs(Config['PacificSetup']['painting']) do

            if player.Functions.GetItemByName(v['rewardItem']) ~= nil then

            local playerItem = player.Functions.GetItemByName(v['rewardItem'])

            if playerItem.amount >= 1 then

                player.Functions.RemoveItem(v['rewardItem'], playerItem.amount)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v['rewardItem']], "remove")
                player.Functions.AddMoney("cash", playerItem.amount * v['paintingPrice'])
                totalMoney = totalMoney + (playerItem.amount * v['paintingPrice'])


                --player.removeInventoryItem(v['rewardItem'], playerItem.count)
               -- player.addMoney(playerItem.count * v['paintingPrice'])
               -- totalMoney = totalMoney + (playerItem.count * v['paintingPrice'])
            end
          end
        end

        local chance = math.random(1, 100)
        if chance < 15 then
            Player.Functions.AddItem("cryptostick", 1, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cryptostick"], "add")
        end

        discordLog(GetPlayerName(src) ..  ' - ' .. player.PlayerData.license, ' Gain $' .. math.floor(totalMoney) .. ' on the Pacific Heist Buyer!')
        --TriggerClientEvent('pacificheist:client:showNotification', src, Strings['total_money'] .. ' $' .. math.floor(totalMoney))
        TriggerClientEvent('QBCore:Notify', src, Strings['total_money'] .. ' $' .. math.floor(totalMoney), 'success', 3000)
    end
end)

RegisterServerEvent('pacificheist:server:startHeist')
AddEventHandler('pacificheist:server:startHeist', function()
    TriggerClientEvent('pacificheist:client:startHeist', -1)
end)

RegisterServerEvent('pacificheist:server:resetHeist')
AddEventHandler('pacificheist:server:resetHeist', function()
    TriggerClientEvent('pacificheist:client:resetHeist', -1)
end)

RegisterServerEvent('pacificheist:server:sceneSync')
AddEventHandler('pacificheist:server:sceneSync', function(model, animDict, animName, pos, rotation)
    TriggerClientEvent('pacificheist:client:sceneSync', -1, model, animDict, animName, pos, rotation)
end)

RegisterServerEvent('pacificheist:server:particleFx')
AddEventHandler('pacificheist:server:particleFx', function(pos)
    TriggerClientEvent('pacificheist:client:particleFx', -1, pos)
end)

RegisterServerEvent('pacificheist:server:modelSwap')
AddEventHandler('pacificheist:server:modelSwap', function(pos, radius, model, newModel)
    TriggerClientEvent('pacificheist:client:modelSwap', -1, pos, radius, model, newModel)
end)

RegisterServerEvent('pacificheist:server:globalObject')
AddEventHandler('pacificheist:server:globalObject', function(object, item)
    TriggerClientEvent('pacificheist:client:globalObject', -1, object, item)
end)

RegisterServerEvent('pacificheist:server:someoneVault')
AddEventHandler('pacificheist:server:someoneVault', function(action)
    TriggerClientEvent('pacificheist:client:someoneVault', -1, action)
end)

RegisterServerEvent('pacificheist:server:openVault')
AddEventHandler('pacificheist:server:openVault', function(index)
    TriggerClientEvent('pacificheist:client:openVault', -1, index)
end)

RegisterServerEvent('pacificheist:server:vaultLoop')
AddEventHandler('pacificheist:server:vaultLoop', function()
    TriggerClientEvent('pacificheist:client:vaultLoop', -1)
end)

RegisterServerEvent('pacificheist:server:extendedLoop')
AddEventHandler('pacificheist:server:extendedLoop', function()
    TriggerClientEvent('pacificheist:client:extendedLoop', -1)
end)

RegisterServerEvent('pacificheist:server:vaultSync')
AddEventHandler('pacificheist:server:vaultSync', function(action, index)
    TriggerClientEvent('pacificheist:client:vaultSync', -1, action, index)
end)

RegisterServerEvent('pacificheist:server:extendedSync')
AddEventHandler('pacificheist:server:extendedSync', function(action, index)
    TriggerClientEvent('pacificheist:client:extendedSync', -1, action, index)
end)

RegisterServerEvent('pacificheist:server:doorSync')
AddEventHandler('pacificheist:server:doorSync', function(index)
    TriggerClientEvent('pacificheist:client:doorSync', -1, index)
end)

RegisterServerEvent('pacificheist:server:objectSync')
AddEventHandler('pacificheist:server:objectSync', function(e)
    TriggerClientEvent('pacificheist:client:objectSync', -1, e)
end)

RegisterServerEvent('pacificheist:server:doorFix')
AddEventHandler('pacificheist:server:doorFix', function(hash, heading, pos)
    TriggerClientEvent('pacificheist:client:doorFix', -1, hash, heading, pos)
end)

RegisterServerEvent('radialmenu:resetPacific')
AddEventHandler('radialmenu:resetPacific', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local isGod = QBCore.Functions.HasPermission(src, 'god')
    
    if player then
      --  if player['job']['name'] == 'police' then
      if (player.PlayerData.job.name == "police" and player.PlayerData.job.onduty) or isGod then
            if start then
                TriggerClientEvent('pacificheist:client:resetHeist', -1)
                TriggerClientEvent('QBCore:Notify', src, 'Cleared the robbery scene!', 'success', 3000)
                start = false
                TriggerEvent("qb-log:server:CreateLog", "heistreset", "Pacific Reset", "red", "**"..GetPlayerName(source) .. "** used the reset on **Pacific Bank Heist**")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, 'You are not cop / not on duty', 'error', 3000)
        end
    end
end)

RegisterCommand('pdpacific', function(source, args)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local isGod = QBCore.Functions.HasPermission(src, 'god')
    
    if player then
      --  if player['job']['name'] == 'police' then
      if (player.PlayerData.job.name == "police" and player.PlayerData.job.onduty) or isGod then
            if start then
                TriggerClientEvent('pacificheist:client:resetHeist', -1)
                TriggerClientEvent('QBCore:Notify', src, 'Cleared the robbery scene!', 'success', 3000)
                start = false
                TriggerEvent("qb-log:server:CreateLog", "heistreset", "Pacific Reset", "red", "**"..GetPlayerName(source) .. "** used the reset on **Pacific Bank Heist**")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, 'You are not cop / not on duty', 'error', 3000)
        end
    end
end)

function discordLog(name, message)
    local data = {
        {
            ["color"] = '3553600',
            ["title"] = "**".. name .."**",
            ["description"] = message,
        }
    }
    PerformHttpRequest(discord['webhook'], function(err, text, headers) end, 'POST', json.encode({username = discord['name'], embeds = data, avatar_url = discord['image']}), { ['Content-Type'] = 'application/json' })
end
