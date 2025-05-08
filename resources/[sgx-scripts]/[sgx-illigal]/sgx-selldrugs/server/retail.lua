RegisterNetEvent("SellDrugs:Status_Selling_Drugs", function(src)
    if src then source = src end
    if not src and not source then
        print("This trigger must be used from the client side or you need to specify the player as an argument. If you're unable to do this, please contact Support - discord.gg/sgx")
        return 
    end

    if Police.Count < cfg.Police.Required then
        serverNotify(source, translate("server", "notify_retail_fail_police", (cfg.Police.Required - Police.Count)), "error", 5000)
        return
    end

    local citizenID = cfg.Prefix.Functions.GetPlayer(source).PlayerData.citizenid

    if Player["id"..source].sellingDrugs then
        TriggerClientEvent("SellDrugs:Stop", source)
        Player["id"..source].sellingDrugs = false
        serverNotify(source, translate("server", "notify_retail_stop"), "primary", 5000)
    else
        local Drugs = {}
        local Drugs_Amount = 0

        for k, _ in pairs(cfg.Drug_List) do
            local item = Check_Item(source, k)

            if item then
                Drugs[item.name] = {amount = item.amount}
                Drugs_Amount = Drugs_Amount + 1
            end
        end

        if Drugs_Amount > 0 then
            TriggerClientEvent("SellDrugs:Start", source)
            Player["id"..source].sellingDrugs = true
            serverNotify(source, translate("server", "notify_retail_start"), "primary", 5000)
        else
            serverNotify(source, translate("server", "notify_retail_fail_drugs"), "error", 5000)
        end
    end
end)

cfg.Prefix.Functions.CreateCallback('SellDrugs:Start_Interaction', function(source, cb)
    local src = source
    local Drugs = {}
    local Drugs_Amount = 0

    for k, _ in pairs(cfg.Drug_List) do
        local item = Check_Item(src, k)

        if item then
            Drugs[item.name] = {amount = item.amount, label = item.label}
            Drugs_Amount = Drugs_Amount + 1
        end
    end

    if Drugs_Amount > 0 then
        local data = {
            drugs = Drugs,
            stats = {
                respectLimit = cfg.Threshold_Respect.Limit,
                respect = Player["id"..src].respect,
                salesLimit = cfg.Sales_Skill.Limit,
                sales = Player["id"..src].sale_skill
            }
        }
        cb(data)
    else
        TriggerClientEvent("SellDrugs:Stop", src)
        Player["id"..src].sellingDrugs = false
        serverNotify(src, translate("server", "notify_retail_stop_drugs"), "error", 5000)
    end
end)

RegisterNetEvent("SellDrugs:Clear_Prices", function()
    local src = source

    Player["id"..src].Prices = {}
end)

RegisterNetEvent("SellDrugs:Make_Trade", function(Drug, Amount)
    local src = source
    local xPlayer = cfg.Prefix.Functions.GetPlayer(src)
    local item = Check_Item(src, Drug)

    if #Player["id"..src].Prices == 0 or not item then
        print(translate("server", "print_hacker", GetPlayerName(src), src))
        local full_name = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname
        Send_Discord_Log(3447003, translate("server", "discord_hacker_title", GetPlayerName(src), src, xPlayer.PlayerData.citizenid), "sgx-scripts (Advanced Drug Sales 💊)", translate("server", "discord_hacker_make_trade_message", full_name), "Support - discord.gg/sgx")
        return
    end

    if item and item.amount >= Amount then
        local Price = math.floor(Player["id"..src].Prices[#Player["id"..src].Prices] * Amount)
        serverNotify(src, translate("server", "notify_retail_sell", Amount, item.label, reformatInt(Price)), "success", 5000)
        Remove_Item(src, Drug, Amount)
        Add_Cash(src, Price)
        addStatistic("id"..src, "respect", 1)
        Player["id"..src].Prices = {}
        local full_name = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname
        Send_Discord_Log(3447003, translate("server", "discord_retail_sell_title", GetPlayerName(src), src, xPlayer.PlayerData.citizenid), "sgx-scripts (Advanced Drug Sales 💊)", translate("server", "discord_retail_sell_message", full_name, reformatInt(Amount), item.label, reformatInt(Price)), "Support - discord.gg/sgx")
    end
end)

RegisterNetEvent("SellDrugs:Add_Blocked_Client", function(netId)
    TriggerClientEvent("SellDrugs:Get_Blocked_Client", -1, netId)
end)