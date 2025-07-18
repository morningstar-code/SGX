-- Open Inventory
RegisterNetEvent('sgx-adminmenu:client:openInventory', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local player = selectedData["Player"].value

    if Config.Inventory == 'ox_inventory' then
        TriggerServerEvent("sgx-adminmenu:server:OpenInv", player)
    else
        TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", player)
    end
end)

-- Open Stash
RegisterNetEvent('sgx-adminmenu:client:openStash', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local stash = selectedData["Stash"].value

    if Config.Inventory == 'ox_inventory' then
        TriggerServerEvent("sgx-adminmenu:server:OpenStash", stash)
    else
        TriggerServerEvent("inventory:server:OpenInventory", "stash", tostring(stash))
        TriggerEvent("inventory:client:SetCurrentStash", tostring(stash))
    end
end)

-- Open Trunk
RegisterNetEvent('sgx-adminmenu:client:openTrunk', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local vehiclePlate = selectedData["Plate"].value

    if Config.Inventory == 'ox_inventory' then
        TriggerServerEvent("sgx-adminmenu:server:OpenTrunk", vehiclePlate)
    else
        TriggerServerEvent("inventory:server:OpenInventory", "trunk", tostring(vehiclePlate))
        TriggerEvent("inventory:client:SetCurrentStash", tostring(vehiclePlate))
    end
end)
