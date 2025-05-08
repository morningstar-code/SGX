cfg.Prefix.Functions.CreateCallback('SellDrugs:Create_Wholesale', function(source, cb, price, amount)
    local src = source
    local Zone = Get_Time(os.time(), "minute", 0)

    if Player["id"..src].wholesale and Player["id"..src].wholesale.Drug and Player["id"..src].wholesale.Waiting and (Player["id"..src].wholesale.Waiting.time - Zone.time) then
        local Block_Wholesale = {}

        for _, v in pairs(Player) do
            if v.wholesale and v.wholesale.Index then
                table.insert(Block_Wholesale, v.wholesale.Index)
            end
        end

        if #Block_Wholesale == #cfg.Wholesale then
            cb(false)
            return
        end

        local Index = nil

        while true do
            Index = math.random(1, #cfg.Wholesale)
            local Blocked_Index = false

            for _, v in ipairs(Block_Wholesale) do
                if v == Index then
                    Blocked_Index = true
                end
            end

            if not Blocked_Index then break end
            Wait(0)
        end
        Player["id"..src].wholesale.Price = price
        Player["id"..src].wholesale.Amount = amount
        Player["id"..src].wholesale.Index = Index
        cb(Player["id"..src].wholesale.Index)
    end
end)

RegisterNetEvent("SellDrugs:Wholesale_In_Range", function()
    local src = source

    Player["id"..src].wholesale.Waiting = nil
end)

RegisterNetEvent("SellDrugs:Wholesale_Clear_Place", function(tooFar)
    local src = source

    Player["id"..src].wholesale = nil
    if tooFar then
        removeStatistic("id"..src, "respect", cfg.Wholesale_Settings.Respect)
    end
end)

cfg.Prefix.Functions.CreateCallback('SellDrugs:Wholesale_Trade', function(source, cb)
    local src = source
    local xPlayer = cfg.Prefix.Functions.GetPlayer(src)

    local item = Check_Item(src, Player["id"..src].wholesale.Drug)

    if not item then
        removeStatistic("id"..src, "respect", cfg.Wholesale_Settings.Remove_Respect)
        cb(false)
        return
    end

    if item and item.amount >= Player["id"..src].wholesale.Amount then
        local Price = math.floor(Player["id"..src].wholesale.Amount * Player["id"..src].wholesale.Price)
        serverNotify(src, translate("server", "notify_wholesale_sell", Player["id"..src].wholesale.Amount, item.label, reformatInt(Price)), "success", 5000)
        Remove_Item(src, Player["id"..src].wholesale.Drug, Player["id"..src].wholesale.Amount)
        Add_Cash(src, Price)
        addStatistic("id"..src, "respect", cfg.Wholesale_Settings.Respect)
        local full_name = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname
        Send_Discord_Log(3447003, translate("server", "discord_wholesale_sell_title", GetPlayerName(src), src, xPlayer.PlayerData.citizenid), "sgx-scripts (Advanced Drug Sales 💊)", translate("server", "discord_wholesale_sell_message", full_name, reformatInt(Player["id"..src].wholesale.Amount), item.label, reformatInt(Price)), "Support - discord.gg/sgx")
        cb(true)
    elseif item and item.amount < Player["id"..src].wholesale.Amount then
        removeStatistic("id"..src, "respect", cfg.Wholesale_Settings.Remove_Respect)
        cb(false)
    end
end)

RegisterNetEvent("SellDrugs:Wholesale_Attack", function(scenario)
    local src = source
    local xPlayer = cfg.Prefix.Functions.GetPlayer(src)
    removeStatistic("id"..src, "respect", cfg.Wholesale_Settings.Remove_Respect)

    if scenario == "ped_dead" then
        serverNotify(src, translate("server", "notify_wholesale_attack_fail"), "error", 5000)
        local CurrentMoney = Check_Cash(src)
        Remove_Cash(src, CurrentMoney)
        local full_name = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname
        Send_Discord_Log(3447003, translate("server", "discrod_wholesale_attack_title", GetPlayerName(src), src, xPlayer.PlayerData.citizenid), "sgx-scripts (Advanced Drug Sales 💊)", translate("server", "discrod_wholesale_attack_message_player_dead", full_name, reformatInt(CurrentMoney)), "Support - discord.gg/sgx")
    elseif scenario == "enemy_dead" then
        local Price = Player["id"..src].wholesale.Amount * Player["id"..src].wholesale.Price
        local configPrice = math.floor((cfg.Wholesale_Settings.Money_Robbery / 100) * Price)
        serverNotify(src, translate("server", "notify_wholesale_attack_success", reformatInt(configPrice)), "success", 5000)
        Add_Cash(src, configPrice)
        local full_name = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname
        Send_Discord_Log(3447003, translate("server", "discrod_wholesale_attack_title", GetPlayerName(src), src, xPlayer.PlayerData.citizenid), "sgx-scripts (Advanced Drug Sales 💊)", translate("server", "discrod_wholesale_attack_message_enemy_dead", full_name, reformatInt(configPrice)), "Support - discord.gg/sgx")
    end
end)