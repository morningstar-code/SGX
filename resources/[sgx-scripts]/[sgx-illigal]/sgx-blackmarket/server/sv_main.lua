QBCore = exports['qb-core']:GetCoreObject()

local ItemList = {
    ['markedbills'] = 1500,
    ['cash'] = 00,
    ['money'] = 1500,
    ['pogo'] = 500,
    ['necklace'] = 135,
    ['cryptostick'] = 250,
    ['tequila_bottle'] = 250,
    ['bottle'] = 50,
    ['iphone'] = 100,
    ['samsungphone'] = 100,
    ['goldchain'] = 225,
    ['10kgoldchain'] = 300,
    ['goldbar'] = 200,
    ['rolex'] = 200,
    ['ruby'] = 550,
    ['emerald'] = 390,
    ['diamond'] = 430,
    ['sapphire'] = 480,
    ['gallary_egg'] = 150,
    ['gallary_skull'] = 150,
    ['gallary_dragon'] = 150,
    ['copperore'] = 110,
    ['silverore'] = 100,
    ['ironore'] = 80,
    ['panther'] = 10000,
    ['carbon'] = 17,
    ['goldingot'] = 135,
    ['silveringot'] = 85,
    ['uncut_emerald'] = 90,
    ['uncut_ruby'] = 110,
    ['uncut_diamond'] = 130,
    ['uncut_sapphire'] = 150,
    ['emerald'] = 110,
    ['ruby'] = 145,
    ['diamond'] = 150,
    ['guitar'] = 80,
    ['gold_ring'] = 60,
    ['sapphire_ring'] = 75,
    ['emerald_ring'] = 80,
    ['ruby_necklace'] = 90,
    ['emerald_necklace'] = 120,
    ['sapphire_necklace'] = 127,
    ['diamond_necklace'] = 135,
    ['carbon'] = 127,
    ['goldore'] = 55,
    ['trophy'] =105,
    ['aquamarine_ring'] = 135,
    ['citrine_ring'] = 75,
    ['diamond_ring'] = 150,
    ['jade_ring'] = 135,
    ['onyx_ring'] = 90,
    ['ruby_ring'] = 105,
    ['tanzanite_ring'] = 120,
}

RegisterNetEvent('qb-blackmarket:sellitemsv', function()
    local src = source
    local price = 0
    local Player = QBCore.Functions.GetPlayer(src)
	local sold = {};
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then
        for k, v in pairs(Player.PlayerData.items) do
            if Player.PlayerData.items[k] ~= nil then
                if ItemList[Player.PlayerData.items[k].name] ~= nil then
                    price = price + (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    table.insert(sold, ('%dx %s - $%d'):format(Player.PlayerData.items[k].amount, Player.PlayerData.items[k].label, (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)))
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Player.PlayerData.items[k].name], "remove")
                end
            end
        end
        Player.Functions.AddMoney("cash", price, "blackmarket items sold")
		if(price > 0) then
			-- exports["ws-log"]:Log("blackmarket", src, "just sold `$%d` in total:\n%s", price, table.concat(sold, "\n"))
		end
		TriggerClientEvent('QBCore:Notify', src, " You recieved $" ..price.. " for your stuff.", 'success')
    end
end)


-- ItemList:
-- laptop2
-- vpn_blackmarket
-- vpn_boosting
-- electornickit
-- thermite
-- advancedlockpick
-- lockpick
-- decrypter
-- screwdriverset

RegisterNetEvent("blackmarket:darkweb", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local price = 2000
    if Player.PlayerData.money.cash >= price then
        Player.Functions.RemoveMoney("cash", price)
        local info = {}
        info.uses = 10
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['laptop2'], "add", 1) 
        Player.Functions.AddItem('laptop2', 1, false, info)
        -- exports["ws-log"]:Log("pawnshop", src, "Bought Laptop for - $2000")
    else
        TriggerClientEvent("QBCore:Notify", src, "You are missing some cash.", "error")
    end
end)

RegisterNetEvent("blackmarket:pacificusb", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local price = 2000
    if Player.PlayerData.money.cash >= price then
        Player.Functions.RemoveMoney("cash", price)
        Player.Functions.AddItem('vpn_blackmarket', 1)
        TriggerClientEvent("inventory:client:ItemBox",src, QBCore.Shared.Items["vpn_blackmarket"], "add")
        -- exports["ws-log"]:Log("pawnshop", src, "Bought BlackMarket VPN Item for - $2000")
    else
        TriggerClientEvent("QBCore:Notify", src, "You are missing some cash.", "error")
    end
end)

RegisterNetEvent("blackmarket:boostingvpn", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local price = 2000
    if Player.PlayerData.money.cash >= price then
        Player.Functions.RemoveMoney("cash", price)
        Player.Functions.AddItem('vpn_boosting', 1)
        TriggerClientEvent("inventory:client:ItemBox",src, QBCore.Shared.Items["vpn_boosting"], "add")
        -- exports["ws-log"]:Log("pawnshop", src, "Bought Boosting VPN Item for - $2000")
    else
        TriggerClientEvent("QBCore:Notify", src, "You are missing some cash.", "error")
    end
end)

RegisterNetEvent("blackmarket:electronickit", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local price = 2000
    if Player.PlayerData.money.cash >= price then
        Player.Functions.RemoveMoney("cash", price)
        Player.Functions.AddItem('electronickit', 1)
        TriggerClientEvent("inventory:client:ItemBox",src, QBCore.Shared.Items["electronickit"], "add")
        -- exports["ws-log"]:Log("pawnshop", src, "Bought Electronic Kit Item for - $2000")
    else
        TriggerClientEvent("QBCore:Notify", src, "You are missing some cash.", "error")
    end
end)

RegisterNetEvent("blackmarket:thermite", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local price = 2000
    if Player.PlayerData.money.cash >= price then
        Player.Functions.RemoveMoney("cash", price)
        Player.Functions.AddItem('thermite', 1)
        TriggerClientEvent("inventory:client:ItemBox",src, QBCore.Shared.Items["thermite"], "add")
       -- exports["ws-log"]:Log("pawnshop", src, "Bought Thermite Item for - $2000")
    else
        TriggerClientEvent("QBCore:Notify", src, "You are missing some cash.", "error")
    end
end)

RegisterNetEvent("blackmarket:advancedlockpick", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local price = 2000
    if Player.PlayerData.money.cash >= price then
        Player.Functions.RemoveMoney("cash", price)
        Player.Functions.AddItem('advancedlockpick', 1)
        TriggerClientEvent("inventory:client:ItemBox",src, QBCore.Shared.Items["advancedlockpick"], "add")
      --  exports["ws-log"]:Log("pawnshop", src, "Bought Advanced Lockpick Item for - $2000")
    else
        TriggerClientEvent("QBCore:Notify", src, "You are missing some cash.", "error")
    end
end)

RegisterNetEvent("blackmarket:lockpick", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local price = 2000
    if Player.PlayerData.money.cash >= price then
        Player.Functions.RemoveMoney("cash", price)
        Player.Functions.AddItem('lockpick', 1)
        TriggerClientEvent("inventory:client:ItemBox",src, QBCore.Shared.Items["lockpick"], "add")
      --  exports["ws-log"]:Log("pawnshop", src, "Bought Lockpick Item for - $2000")
    else
        TriggerClientEvent("QBCore:Notify", src, "You are missing some cash.", "error")
    end
end)

RegisterNetEvent("blackmarket:decrypter", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local price = 2000
    if Player.PlayerData.money.cash >= price then
        Player.Functions.RemoveMoney("cash", price)
        Player.Functions.AddItem('decrypter', 1)
        TriggerClientEvent("inventory:client:ItemBox",src, QBCore.Shared.Items["decrypter"], "add")
      --  exports["ws-log"]:Log("pawnshop", src, "Bought Decrypter Item for - $2000")
    else
        TriggerClientEvent("QBCore:Notify", src, "You are missing some cash.", "error")
    end
end)

RegisterNetEvent("blackmarket:screwdriverset", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local price = 2000
    if Player.PlayerData.money.cash >= price then
        Player.Functions.RemoveMoney("cash", price)
        Player.Functions.AddItem('screwdriverset', 1)
        TriggerClientEvent("inventory:client:ItemBox",src, QBCore.Shared.Items["screwdriverset"], "add")
      --  exports["ws-log"]:Log("pawnshop", src, "Bought Screwdriverset Item for - $2000")
    else
        TriggerClientEvent("QBCore:Notify", src, "You are missing some cash.", "error")
    end
end)



