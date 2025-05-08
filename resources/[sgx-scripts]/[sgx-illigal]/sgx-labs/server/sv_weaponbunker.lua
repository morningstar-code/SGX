local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-labs:server:CraftItem', function(craft, index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if not craft then return end
    if not index then return end

    -- Check for items
    local hasItems = true
    for _, v in pairs(Config.CraftingCost[craft][index].items) do
        local item = Player.Functions.GetItemByName(v.item)
        if not item or item.amount < v.amount then
            hasItems = false
            break
        end
    end

    -- Craft item
    if hasItems then
        -- Remove Items
        for _, v in pairs(Config.CraftingCost[craft][index].items) do
            Player.Functions.RemoveItem(v.item, v.amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v.item], "remove", v.amount)
            Wait(250)
        end

        -- Ammo in sets of 10
        local amount = 1
        if craft == 'ammo' then amount = 10 end

        -- Add Items
        Player.Functions.AddItem(Config.CraftingCost[craft][index].item, amount, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.CraftingCost[craft][index].item], "add", amount)

        TriggerClientEvent('QBCore:Notify', src, 'You crafted 1 '..Config.CraftingCost[craft][index].label)
        TriggerEvent("qb-log:server:CreateLog", 'keylabs', "Guncrafting", "black", "**"..Player.PlayerData.name .. "** (citizenid: *" .. Player.PlayerData.citizenid .. "* | id: *(" .. Player.PlayerData.source .. "))*: has crafted "..amount.."x "..Config.CraftingCost[craft][index].label)
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have all the items..", "error", 2500)
    end
end)
