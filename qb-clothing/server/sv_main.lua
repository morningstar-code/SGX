local QBCore = exports['qb-core']:GetCoreObject()

-- [ Commands ] --

QBCore.Commands.Add('addoutfit', 'Put your current outfit in your closet.', {{name = 'name', help = 'Outfit Name'}}, false, function(source, args)
    local OutfitName = args[1] ~= nil and args[1] or 'outfit-'..math.random(111111, 999999)
    if OutfitName then   
        TriggerClientEvent('qb-clothing/client/saveCurrentOutfit', source, OutfitName)
    else
        TriggerClientEvent('QBCore:Notify', source, 'You have not given a name for your outfit.', 'error')
    end
end)

QBCore.Commands.Add('skin', 'Clothing Menu', {}, false, function(source, args)
    TriggerClientEvent('qb-clothing:client:openMenu', source)
end, "admin")

-- [ Events ] --

RegisterNetEvent("qb-clothing/saveSkin", function(Model, Skin)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Model ~= nil and Skin ~= nil then
        MySQL.query('DELETE FROM playerskins WHERE cid = ?', { tostring(Player.PlayerData.cid) }, function()
            MySQL.insert('INSERT INTO playerskins (cid, model, skin, active) VALUES (?, ?, ?, ?)', {
                tostring(Player.PlayerData.cid),
                Model,
                Skin,
                1
            })
        end)
        TriggerClientEvent('QBCore:Notify', src, "Outfit Saved", "success")
    end
end)

RegisterNetEvent("qb-clothes/loadPlayerSkin", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = MySQL.query.await('SELECT * FROM playerskins WHERE cid = ? AND active = ?', { tostring(Player.PlayerData.cid), 1 })
    if result[1] ~= nil then
        TriggerClientEvent("qb-clothes:loadSkin", src, false, result[1].model, result[1].skin)
    else
        TriggerClientEvent("qb-clothes:loadSkin", src, true)
    end
end)

RegisterNetEvent("qb-clothes/saveOutfit", function(outfitName, model, skinData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if model ~= nil and skinData ~= nil then
        local outfitId = "outfit-"..math.random(1, 10).."-"..math.random(1111, 9999)
        MySQL.insert('INSERT INTO player_outfits (cid, outfitname, model, skin, outfitId) VALUES (?, ?, ?, ?, ?)', {
            tostring(Player.PlayerData.cid),
            outfitName,
            model,
            json.encode(skinData),
            outfitId
        }, function()
        end)
    end
end)

RegisterNetEvent("qb-clothing/server/removeOutfit", function(outfitName, outfitId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Outfit = nil
    local OutfitIdentifier = nil

    if type(outfitName) == 'table' then
        Outfit = outfitName.name
        OutfitIdentifier = outfitName.id
    else
        Outfit = outfitName
        OutfitIdentifier = outfitId
    end

    print('Nu deleten', outfitName, outfitId)
    MySQL.query('DELETE FROM player_outfits WHERE cid = ? AND outfitname = ? AND outfitId = ?', {
        tostring(Player.PlayerData.cid),
        Outfit,
        OutfitIdentifier
    }, function()
    end)
end)

-- [ Callbacks ] --

QBCore.Functions.CreateCallback('qb-clothing/server/pay-for-clothes', function(source, cb, IsAdmin)
    local Player = QBCore.Functions.GetPlayer(source)
    if not IsAdmin then
        if Player.Functions.RemoveMoney('cash', Config.ClothingPrice) then
            cb(true)
        else
            cb(false)
            TriggerClientEvent('QBCore:Notify', source, "Not enough money", "error")
            TriggerClientEvent("qb-clothes/client/loadPlayerSkin", source)
        end
    else
        cb(true)
    end
end)

QBCore.Functions.CreateCallback('qb-clothing/server/getOutfits', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local Outfits = {}
    local result = MySQL.query.await('SELECT * FROM player_outfits WHERE cid = ?', { tostring(Player.PlayerData.cid) })
    if result[1] ~= nil then
        for k, v in pairs(result) do
            result[k].skin = json.decode(result[k].skin)
            Outfits[k] = v
        end
        cb(Outfits)
    end
    cb(Outfits)
end)