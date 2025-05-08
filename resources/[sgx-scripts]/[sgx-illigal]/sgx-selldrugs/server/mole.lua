RegisterNetEvent("SellDrugs:Buy_Subscription", function(mole_type, mole_name)
    local src = source
    local xPlayer = cfg.Prefix.Functions.GetPlayer(src)

    if not Player["id"..src].mole[mole_type][mole_name] then
        if Player["id"..src].respect >= cfg.Threshold_Respect.Mole[mole_type] then
            local CurrentMoney = Check_Cash(src)
            if CurrentMoney >= cfg.Mole[mole_type][mole_name].price then
                Player["id"..src].mole[mole_type][mole_name] = Get_Time(os.time(), "days", cfg.Mole_Settings.Subscription)
                Player["id"..src].save = true
                Remove_Cash(src, cfg.Mole[mole_type][mole_name].price)
                serverNotify(src, translate("server", "notify_buy_subscription_success", mole_name, reformatInt(cfg.Mole[mole_type][mole_name].price)), "success", 5000)
                serverNotify(src, translate("server", "notify_buy_subscription_success2"), "primary", 5000)
                TriggerClientEvent("SellDrugs:Activate_Mole", src, mole_type, mole_name)
                TriggerClientEvent("SellDrugs:Mole_Subscription_Information", src, mole_name)
                local full_name = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname
                Send_Discord_Log(3447003, translate("server", "discord_buy_subscription_title", GetPlayerName(src), src, xPlayer.PlayerData.citizenid), "sgx-scripts (Advanced Drug Sales 💊)", translate("server", "discord_buy_subscription_message", full_name, mole_name, Player["id"..src].mole[mole_type][mole_name].date, reformatInt(cfg.Mole[mole_type][mole_name].price)), "Support - discord.gg/sgx")
            else
                serverNotify(src, translate("server", "notify_buy_subscription_fail_money", reformatInt(math.floor(cfg.Mole[mole_type][mole_name].price - CurrentMoney))), "error", 5000)
            end
        else
            serverNotify(src, translate("server", "notify_buy_subscription_fail_respect", reformatInt(math.floor(cfg.Threshold_Respect.Mole[mole_type] - Player["id"..src].respect)), mole_name), "error", 5000)
        end
    else
        serverNotify(src, translate("server", "notify_buy_subscription_fail_active", mole_name), "primary", 5000)
    end
end)

RegisterNetEvent("SellDrugs:Buy_Trap_Phone", function()
    local src = source
    local item = Check_Item(src, cfg.Phone.Item_Name)

    if not item then
        local CurrentMoney = Check_Cash(src)
        if CurrentMoney >= cfg.Phone.Price then
            Remove_Cash(src, cfg.Phone.Price)
            Add_Item(src, cfg.Phone.Item_Name, 1)
            serverNotify(src, translate("server", "notify_buy_phone_success", reformatInt(cfg.Phone.Price)), "success", 5000)
        else
            serverNotify(src, translate("server", "notify_buy_phone_fail_money", reformatInt(math.floor(cfg.Phone.Price - CurrentMoney))), "error", 5000)
        end
    else
        serverNotify(src, translate("server", "notify_buy_phone_fail_have"), "error", 5000)
    end
end)