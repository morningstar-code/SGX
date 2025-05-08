RegisterNetEvent("sgx-healthsystem:server:sendPlayerData", function(target)
    if not target then return end
    TriggerClientEvent("sgx-healthsystem:client:getPlayerData", tonumber(target), source)
end)

RegisterNetEvent("sgx-healthsystem:server:setPlayerData", function(doctor, current)
    TriggerClientEvent("sgx-healthsystem:client:setPlayerData", tonumber(doctor), current)
end)

RegisterNetEvent("sgx-healthsystem:server:removeItem", function(item, amount)
    removeItem(source, item, amount)
end)

RegisterNetEvent("sgx-healthsystem:server:revivePlayer", function(target)
    if not target then return end
    target = tonumber(target)
    TriggerClientEvent("sgx-healthsystem:client:revive", target)
    TriggerClientEvent("hospital:client:Revive", target)
    TriggerClientEvent("esx_ambulancejob:revive", target)
end)

RegisterNetEvent("sgx-healthsystem:server:savePlayer", function(target, data)
    if not target then return end
    TriggerClientEvent("sgx-healthsystem:client:savePlayer", tonumber(target), data)
end)

sgx.registerCallback("sgx-healthsystem:getInventoryItems", function(_, cb, target)
    local items = getInventoryItems(tonumber(target))
    if not items then cb({}) return end
    local formattedItems = {}
    for k, v in pairs(items) do
        if cfg.items[v.name] then
            formattedItems[v.name] = v.amount or v.count
        end
    end

    cb(formattedItems)
end)