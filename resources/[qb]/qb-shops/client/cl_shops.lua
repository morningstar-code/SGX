local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-shops:client:hunting')
AddEventHandler('qb-shops:client:hunting', function()
    local ShopItems = {}
    ShopItems.label = "hunting"
    ShopItems.items = {
        [1] = { name = "weapon_sniperrifle", price = 1200, amount = 1, info = {}, type = "weapons", slot = 1 },
        [2] = { name = "huntingbait", price = 75, amount = 50, info = {}, type = "item", slot = 2 },
        [3] = { name = "weapon_knife", price = 155, amount = 5, info = {}, type = "item", slot = 3 },
    }
    ShopItems.slots = #ShopItems.items
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Hunting_", ShopItems)
end)


