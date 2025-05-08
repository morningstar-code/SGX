Core = nil
Citizen.CreateThread(function()
    if Config.Core == "qb" then
        Core = exports['qb-core']:GetCoreObject()
        RegisterNetEvent('qb-shops:makePayment', function(type, price, basket)
            local src = source
            local xPlayer = Core.Functions.GetPlayer(src)
            if xPlayer.PlayerData.money[type] >= tonumber(price) then
                xPlayer.Functions.RemoveMoney(type, tonumber(price))
                for k, v in pairs(basket) do
                    xPlayer.Functions.AddItem(v.name, v.amount)
                end
                Core.Functions.Notify(src, "Purchase was successful, bon appetit.", 'success')
            else
            Core.Functions.Notify(src, "You do not have enough funds.", 'error')
            end
        end)
    elseif Config.Core == "esx" then
        Core = exports["es_extended"]:getSharedObject()
        RegisterNetEvent('qb-shops:makePayment', function(type, price, basket)
            local src = source
            local xPlayer = Core.GetPlayerFromId(src)
            local acType = "bank"
            if type == "cash" then
                acType = "money"
            end
            if xPlayer.getAccount(acType).money >= tonumber(price) then
                xPlayer.removeAccountMoney(acType, tonumber(price))
                for k, v in pairs(basket) do
                    xPlayer.addInventoryItem(v.name, v.amount)
                end
                --QBCore.Functions.Notify(src, "Satın alım başaralı, afiyet olsun.", 'success')
            else
                --QBCore.Functions.Notify(src, "Yeterli bakiyeniz yok.", 'error')
            end
        end)
    end
end)

