local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-labs:server:BusyMoneyWash', function(index, bool)
    Config.Labs.moneywash.washers[index].busy = bool
    TriggerClientEvent('qb-labs:client:BusyMoneyWash', -1, index, bool)
end)

RegisterNetEvent('qb-labs:server:LoadMoneyWash', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if not index then return end
    if Config.Labs.moneywash.washers[index].started then return end

    local item = Player.Functions.GetItemByName("markedbills")
    if item then
        -- Grab item data
        local bagAmount = item.amount
        local removeAmount = bagAmount
        local newAmount = Config.Labs.moneywash.washers[index].moneybags + bagAmount
        local addedWorth = item.info.worth

        -- Max amount check
        if newAmount > Config.Labs.moneywash.maxBags then
            removeAmount = Config.Labs.moneywash.maxBags - Config.Labs.moneywash.washers[index].moneybags
            newAmount = Config.Labs.moneywash.maxBags
        end

        -- Remove Items
        Player.Functions.RemoveItem('markedbills', removeAmount, item.slot)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["markedbills"], "remove", removeAmount)
        
        -- Load washer
        Config.Labs.moneywash.washers[index].moneybags = newAmount
        Config.Labs.moneywash.washers[index].worth = Config.Labs.moneywash.washers[index].worth + (removeAmount*addedWorth)
        TriggerClientEvent('qb-labs:client:LoadMoneyWash', -1, index, newAmount, Config.Labs.moneywash.washers[index].worth)
        print("^3[sgx-labs] ^5Loaded Washer "..index.." with "..removeAmount.." bags worth: "..(removeAmount*addedWorth).."^7")
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have any inked bills!", "error", 2500)
    end
end)

RegisterNetEvent('qb-labs:server:StartMoneyWash', function(data)
    local src = source
    if not data.washer then return end
    if Config.Labs.moneywash.washers[data.washer].started then return end

    -- Set Started
    Config.Labs.moneywash.washers[data.washer].started = true
    TriggerClientEvent('qb-labs:client:StartMoneyWash', -1, data.washer)
    print("^3[sgx-labs] ^5Started Washer "..data.washer.." with "..Config.Labs.moneywash.washers[data.washer].moneybags.." bags worth: "..Config.Labs.moneywash.washers[data.washer].worth.."^7")
    
    CreateThread(function()
        -- Wait until completed
        Wait(1000*Config.Labs.moneywash.washers[data.washer].duration)

        -- Set completed
        Config.Labs.moneywash.washers[data.washer].started = false
        Config.Labs.moneywash.washers[data.washer].completed = true
        TriggerClientEvent('qb-labs:client:CompletedMoneyWash', -1, data.washer)
        TriggerClientEvent('qb-phone:client:CustomNotification', src, "LAUNDRY", "Your laundry is done..", 'fas fa-socks', '#00FF00', 4000)
        print("^3[sgx-labs] ^5Completed Washer "..data.washer.." with "..Config.Labs.moneywash.washers[data.washer].moneybags.." bags worth: "..Config.Labs.moneywash.washers[data.washer].worth.."^7")
    end)
end)

RegisterNetEvent('qb-labs:server:GrabMoney', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if not index then return end

    -- Pay out
    local bags = Config.Labs.moneywash.washers[index].moneybags
    local payout = Config.Labs.moneywash.washers[index].worth
    Player.Functions.AddMoney('cash', payout)
    TriggerClientEvent('QBCore:Notify', src, "You received "..payout, "success", 2500)
    TriggerEvent("qb-log:server:CreateLog", 'keylabs', "Moneywash", "red", "**"..Player.PlayerData.name .. "** (citizenid: *" .. Player.PlayerData.citizenid .. "* | id: *(" .. Player.PlayerData.source .. "))*: has received " .. payout .. "$")  

    -- Reset washer
    Config.Labs.moneywash.washers[index].busy = false
    Config.Labs.moneywash.washers[index].started = false
    Config.Labs.moneywash.washers[index].completed = false
    Config.Labs.moneywash.washers[index].moneybags = 0
    Config.Labs.moneywash.washers[index].worth = 0
    TriggerClientEvent('qb-labs:client:ResetWasher', -1, index)
    print("^3[sgx-labs] ^5"..Player.PlayerData.name.." took "..payout.." from washer "..index.."^7")   
end)
