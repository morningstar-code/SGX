local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-labs:server:GetConfig', function(source, cb)
    cb(Config)
end)

--- Method to fetch stock from database
--- @return nil
local function FetchStock()
    local result = MySQL.scalar.await('SELECT config FROM configs WHERE name = ?', {"keylabs"})
    local stockTable = json.decode(result)
    Config.Labs["methlab"].ingredients.stock = stockTable.methlab
    Config.Labs["methlab2"].ingredients.stock = stockTable.methlab2
    Config.Labs["cokelab"].ingredients.stock = stockTable.cokelab
    Config.Labs["weedlab"].ingredients.stock = stockTable.weedlab
    Config.Labs["moneywash"].washers[1].moneybags = stockTable.washer1
    Config.Labs["moneywash"].washers[2].moneybags = stockTable.washer2
    Config.Labs["moneywash"].washers[3].moneybags = stockTable.washer3
    Config.Labs["moneywash"].washers[4].moneybags = stockTable.washer4
    Config.Labs["moneywash"].washers[1].worth = stockTable.worth1
    Config.Labs["moneywash"].washers[2].worth = stockTable.worth2
    Config.Labs["moneywash"].washers[3].worth = stockTable.worth3
    Config.Labs["moneywash"].washers[4].worth = stockTable.worth4
    print("^3[sgx-labs] ^5Data Fetched^7")
end

--- Method to store stock to database
--- @return nil
local function StoreStock()
    local stock = {
        methlab = Config.Labs["methlab"].ingredients.stock,
        methlab2 = Config.Labs["methlab2"].ingredients.stock,
        cokelab = Config.Labs["cokelab"].ingredients.stock,
        weedlab = Config.Labs["weedlab"].ingredients.stock,
        washer1 = Config.Labs["moneywash"].washers[1].moneybags,
        washer2 = Config.Labs["moneywash"].washers[2].moneybags,
        washer3 = Config.Labs["moneywash"].washers[3].moneybags,
        washer4 = Config.Labs["moneywash"].washers[4].moneybags,
        worth1 = Config.Labs["moneywash"].washers[1].worth,
        worth2 = Config.Labs["moneywash"].washers[2].worth,
        worth3 = Config.Labs["moneywash"].washers[3].worth,
        worth4 = Config.Labs["moneywash"].washers[4].worth
    }
    MySQL.update('UPDATE configs SET config = ? WHERE name = ?', {json.encode(stock), "keylabs"})
    print("^3[sgx-labs] ^5Data Stored^7")
end

--- Method to add Config.Resupply.amount amount of stock every Config.Resupply.time minutes to every drug lab
--- @return nil
local function AddStock()
    Config.Labs["methlab"].ingredients.stock = Config.Labs["methlab"].ingredients.stock + Config.Resupply.amount
    TriggerClientEvent("qb-labs:client:UpdateStock", -1, 'methlab', Config.Labs["methlab"].ingredients.stock)
    Config.Labs["methlab2"].ingredients.stock = Config.Labs["methlab2"].ingredients.stock + Config.Resupply.amount
    TriggerClientEvent("qb-labs:client:UpdateStock", -1, 'methlab2', Config.Labs["methlab2"].ingredients.stock)
    Config.Labs["cokelab"].ingredients.stock = Config.Labs["cokelab"].ingredients.stock + Config.Resupply.amount
    TriggerClientEvent("qb-labs:client:UpdateStock", -1, 'cokelab', Config.Labs["cokelab"].ingredients.stock)
    Config.Labs["weedlab"].ingredients.stock = Config.Labs["weedlab"].ingredients.stock + Config.Resupply.amount
    TriggerClientEvent("qb-labs:client:UpdateStock", -1, 'weedlab', Config.Labs["weedlab"].ingredients.stock)
    print("^3[sgx-labs] ^5Adding "..Config.Resupply.amount.." stock to labs^7")
    SetTimeout(Config.Resupply.time * (60 * 1000), AddStock)
end

AddEventHandler('txAdmin:events:serverShuttingDown', function()
    StoreStock()
end)

AddEventHandler("onResourceStop", function(resource)
    if resource ~= GetCurrentResourceName() then return end
    StoreStock()
end)

RegisterNetEvent('qb-labs:server:lock', function(data)
    Config.Labs[data.lab].locked = true
    TriggerClientEvent('qb-labs:client:lock', -1, data.lab)
    TriggerClientEvent('qb-labs:client:DoorAnimation', source)
end)

RegisterNetEvent('dark3', function(data)
    Config.Labs[data.darkroom].locked = true
    TriggerClientEvent('dark4', -1, data.darkroom)
    TriggerClientEvent('qb-labs:client:DoorAnimation', source)
end)

RegisterNetEvent('qb-labs:server:unlock', function(data)
    Config.Labs[data.lab].locked = false
    TriggerClientEvent('qb-labs:client:unlock', -1, data.lab)
    TriggerClientEvent('qb-labs:client:DoorAnimation', source)
end)

RegisterNetEvent('dark1', function(data)
    Config.Labs[data.darkroom].locked = false
    TriggerClientEvent('dark2', -1, data.darkroom)
    TriggerClientEvent('qb-labs:client:DoorAnimation', source)
end)

-- Meth Baggies
QBCore.Functions.CreateUseableItem("meth_cured", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
	if Player.Functions.GetItemByName('meth_cured') then
        TriggerClientEvent('qb-labs:client:MakeMethBags', src)
    end
end)

RegisterNetEvent('qb-labs:server:MakeMethBags', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local item = Player.Functions.GetItemByName('meth_cured')
    local baggies = Player.Functions.GetItemByName('empty_plastic_bag')
    if item and baggies then
        if baggies.amount >= 150 then
            local info = {purity = item.info.purity}
            Player.Functions.RemoveItem(item.name, 1, item.slot)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove", 1)
            Player.Functions.RemoveItem("empty_plastic_bag", 150)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["empty_plastic_bag"], "remove", 150)
            Player.Functions.AddItem("meth_baggy", 150, false, info)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["meth_baggy"], "add", 150)
        else
            TriggerClientEvent('QBCore:Notify', src, "You need more plastic baggies (150)...", "error", 2500)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have any smaller plastic bags...", "error", 2500)
    end
end)

-- Coke baggies
QBCore.Functions.CreateUseableItem("coke_cured", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
	if Player.Functions.GetItemByName('coke_cured') then
        TriggerClientEvent('qb-labs:client:MakeCokeBags', src)
    end
end)

RegisterNetEvent('qb-labs:server:MakeCokeBags', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local item = Player.Functions.GetItemByName('coke_cured')
    local baggies = Player.Functions.GetItemByName('empty_plastic_bag')
    if item and baggies then
        if baggies.amount >= 150 then
            local info = {purity = item.info.purity}
            Player.Functions.RemoveItem(item.name, 1, item.slot)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove", 1)
            Player.Functions.RemoveItem("empty_plastic_bag", 150)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["empty_plastic_bag"], "remove", 150)
            Player.Functions.AddItem("coke_baggy", 150, false, info)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["coke_baggy"], "add", 150)
        else
            TriggerClientEvent('QBCore:Notify', src, "You need more plastic baggies (150)...", "error", 2500)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have any smaller plastic bags...", "error", 2500)
    end
end)

-- Weed baggies
QBCore.Functions.CreateUseableItem("weed_cured", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
	if Player.Functions.GetItemByName('weed_cured') then
        TriggerClientEvent('qb-labs:client:MakeWeedBags', src)
    end
end)

RegisterNetEvent('qb-labs:server:MakeWeedBags', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local item = Player.Functions.GetItemByName('weed_cured')
    local baggies = Player.Functions.GetItemByName('empty_plastic_bag')
    if item and baggies then
        if baggies.amount >= 150 then
            local info = {purity = item.info.purity}
            Player.Functions.RemoveItem(item.name, 1, item.slot)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove", 1)
            Player.Functions.RemoveItem("empty_plastic_bag", 150)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["empty_plastic_bag"], "remove", 150)
            Player.Functions.AddItem("weed_baggy", 150, false, info)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_baggy"], "add", 150)
        else
            TriggerClientEvent('QBCore:Notify', src, "You need more plastic baggies (150)...", "error", 2500)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have any smaller plastic bags...", "error", 2500)
    end
end)

-- Use Baggies
QBCore.Functions.CreateUseableItem("coke_baggy", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.RemoveItem(item.name, 1, item.slot)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove", 1)
    if item.info.purity then
        TriggerClientEvent('consumables:client:Cokebaggy', src, item.info.purity)
    else
        TriggerClientEvent('consumables:client:Cokebaggy', src, 0)
    end
end)

QBCore.Functions.CreateUseableItem("weed_baggy", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.RemoveItem(item.name, 1, item.slot)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove", 1)
    if item.info.purity then
        TriggerClientEvent('consumables:client:weedbaggy', src, item.info.purity)
    else
        TriggerClientEvent('consumables:client:weedbaggy', src, 0)
    end
end)

QBCore.Functions.CreateUseableItem("meth_baggy", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.RemoveItem(item.name, 1, item.slot)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove", 1)
    if item.info.purity then
        TriggerClientEvent('qb-labs:client:UseMethBag', src, item.info.purity)
    else
        TriggerClientEvent('qb-labs:client:UseMethBag', src, 0)
    end
end)

CreateThread(function()
    FetchStock()
    if Config.Resupply.enable then
        print("^3[sgx-labs] ^5Adding "..Config.Resupply.amount.." stock every "..Config.Resupply.time.." minutes^7")
        Wait(Config.Resupply.time*60*1000)
        AddStock()
    end
end)

-- Server Console Commands to force storing and fetching from the database (think about sudden server restarts)
RegisterCommand('keylabs_fetch', function(source, args)
    FetchStock()
end, true)

RegisterCommand('keylabs_store', function(source, args)
    StoreStock()
end, true)
