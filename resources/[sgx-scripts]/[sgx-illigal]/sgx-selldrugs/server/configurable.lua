cfg.Prefix.Functions.CreateUseableItem(cfg.Phone.Item_Name, function(source, item)
    local src = source
	local Player = cfg.Prefix.Functions.GetPlayer(src)

	if not Player.Functions.GetItemByName(item.name) then return end

    TriggerClientEvent("SellDrugs:OpenPhone", src)
end)

cfg.Prefix.Commands.Add('selldrugs-stats', translate("server", "command_selldrugs-stats_description"), {{name = translate("server", "command_selldrugs-stats_arg1_name"), help = translate("server", "command_selldrugs-stats_arg1_help")}, {name = translate("server", "command_selldrugs-stats_arg2_name"), help = translate("server", "command_selldrugs-stats_arg2_help")}, {name = translate("server", "command_selldrugs-stats_arg3_name"), help = translate("server", "command_selldrugs-stats_arg3_help")}, {name = translate("server", "command_selldrugs-stats_arg4_name"), help = translate("server", "command_selldrugs-stats_arg4_help")}}, false, function(source, args)

    if Player["id"..args[1]] then
        if args[2] == "add" then
            addStatistic("id"..args[1], args[3], args[4])
            serverNotify(source, translate("server", "notify_selldrugs-stats_add", reformatInt(args[4]), args[3], GetPlayerName(args[1])), "success", 5000)
            serverNotify(args[1], translate("server", "notify_selldrugs-stats_received", reformatInt(args[4]), args[3], GetPlayerName(source)), "success", 5000)
        elseif args[2] == "remove" then
            removeStatistic("id"..args[1], args[3], args[4])
            serverNotify(source, translate("server", "notify_selldrugs-stats_remove", reformatInt(args[4]), args[3], GetPlayerName(args[1])), "error", 5000)
            serverNotify(args[1], translate("server", "notify_selldrugs-stats_taken", GetPlayerName(source), reformatInt(args[4]), args[3]), "error", 5000)
        end
    end
end, 'admin')

cfg.Prefix.Commands.Add('selldrugs', translate("server", "command_selldrugs_description"), {}, false, function(source, args)
    TriggerEvent("SellDrugs:Status_Selling_Drugs", source)
    -- Client-Side: TriggerClientEvent("SellDrugs:Status_Selling_Drugs")
    -- Client-Side: TriggerServerEvent("SellDrugs:Status_Selling_Drugs")
    -- Server-Side: TriggerEvent("SellDrugs:Status_Selling_Drugs", source)
end, 'user')

function Check_Item(id, itemName)
    local xPlayer = cfg.Prefix.Functions.GetPlayer(id)

    if xPlayer then
        local item = xPlayer.Functions.GetItemByName(itemName)

        if item ~= nil then
            return {name = itemName, amount = item.amount, label = item.label}
        else
            return nil
        end
    end
end

function Check_Cash(id)
    local xPlayer = cfg.Prefix.Functions.GetPlayer(id)

    if xPlayer then
        return xPlayer.PlayerData.money.cash
    end
end

function Add_Cash(id, amount)
    local xPlayer = cfg.Prefix.Functions.GetPlayer(id)

    if xPlayer then
        xPlayer.Functions.AddMoney('cash', amount)
    end
end

function Remove_Cash(id, amount)
    local xPlayer = cfg.Prefix.Functions.GetPlayer(id)

    if xPlayer then
        xPlayer.Functions.RemoveMoney('cash', amount)
    end
end

function Add_Item(id, itemName, amount)
    local xPlayer = cfg.Prefix.Functions.GetPlayer(id)
    
    if xPlayer then
        xPlayer.Functions.AddItem(itemName, amount)
    end
end

function Remove_Item(id, itemName, amount)
    local xPlayer = cfg.Prefix.Functions.GetPlayer(id)
    
    if xPlayer then
        xPlayer.Functions.RemoveItem(itemName, amount)
    end
end
