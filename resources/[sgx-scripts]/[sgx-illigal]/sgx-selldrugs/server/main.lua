cfg.Prefix = exports[cfg.ExportPrefix]:GetCoreObject()

cfg.Prefix.Functions.CreateCallback('SellDrugs:Get_Player_Info', function(source, cb)
    local src = source

    local data = {
        mole = Player["id"..src].mole,
        stats = {
            respectLimit = cfg.Threshold_Respect.Limit,
            respect = Player["id"..src].respect,
            salesLimit = cfg.Sales_Skill.Limit,
            sales = Player["id"..src].sale_skill
        },
        settings = Player["id"..src].Phone
    }
    cb(data)
end)

RegisterNetEvent("SellDrugs:Change_Phone_Settings", function(settings)
    local src = source

    Player["id"..src].Phone = settings
    Player["id"..src].save = true
end)

cfg.Prefix.Functions.CreateCallback('SellDrugs:Calculate_Percentage', function(source, cb, itemName, price, isWholesale)
    local src = source
    local xPlayer = cfg.Prefix.Functions.GetPlayer(src)

    local itemConfig = cfg.Drug_List[itemName]
    if not itemConfig then
        local mode = nil
        if isWholesale then mode = "Wholesale" else mode = "Retail" end
        local full_name = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname
        print(translate("server", "print_hacker", GetPlayerName(src), src))
        Send_Discord_Log(3447003, translate("server", "discord_hacker_title", GetPlayerName(src), src, xPlayer.PlayerData.citizenid), "sgx-scripts (Advanced Drug Sales 💊)", translate("server", "discord_hacker_calculate_percentage_message", full_name, itemName, price, mode), "Support - discord.gg/sgx")
        return
    end

    if not isWholesale then
        local HigherPrice = false

        if Player["id"..src].Prices == nil or #Player["id"..src].Prices == 4 then
            Player["id"..src].Prices = {}
        end
    
        for _, v in ipairs(Player["id"..src].Prices) do
            if price >= v then
                HigherPrice = true
                break
            end
        end
    
        if HigherPrice then serverNotify(src, translate("server", "notify_retail_negotiating"), "primary", 5000) return end
    end

    local averagePrice = itemConfig.average_price
    if isWholesale then averagePrice = averagePrice / 2 end

    local skillBonus = 0
    if Player["id"..src].sale_skill >= cfg.Sales_Skill.Threshold then
        skillBonus = cfg.Sales_Skill.Increase_Chance
    end

    local successChance = 0

    if price <= averagePrice then
        successChance = 100
    else
        local maxPrice = 2 * averagePrice
        if price < maxPrice then
            successChance = ((maxPrice - price) / (maxPrice - averagePrice)) * 100 + skillBonus
        end
    end

    successChance = math.min(100, successChance)
    local randomRoll = math.random(0, 100)

    if not isWholesale then table.insert(Player["id"..src].Prices, price) end

    if successChance >= randomRoll then
        cb(true, #Player["id"..src].Prices)
        addStatistic("id"..src, "sale_skill", Calculate_Skill_Bonus(price, averagePrice, cfg.Sales_Skill.Skill))
    elseif successChance <= randomRoll then
        cb(false, #Player["id"..src].Prices)
        removeStatistic("id"..src, "sale_skill", cfg.Sales_Skill.Skill)
    end
end)

RegisterNetEvent("SellDrugs:Get_Police", function(task, netId)
    local src = source

    if task == "add" then
        Police.Count = Police.Count + 1
        Police.Player["id"..src] = {network = netId}
    elseif task == "remove" then
        Police.Count = Police.Count - 1
        Police.Player["id"..src] = nil
    end

    TriggerClientEvent("SellDrugs:Update_Police", -1, Police.Player)
end)

RegisterNetEvent("SellDrugs:Send_Animation", function(ped, dict, anim, blendSpeed, duration, move)
    TriggerClientEvent("SellDrugs:Use_Animation", -1, ped, dict, anim, blendSpeed, duration, move)
end)

RegisterNetEvent("SellDrugs:Send_Speech", function(ped, speechName, speechArg)
    TriggerClientEvent("SellDrugs:Use_Speech", -1, ped, speechName, speechArg)
end)

RegisterNetEvent("SellDrugs:Player_Joined", function()
    local src = source
    local citizenID = cfg.Prefix.Functions.GetPlayer(src).PlayerData.citizenid    

    local Player_Result = exports.oxmysql:executeSync('SELECT * FROM selldrugs_players WHERE player = @player', {["@player"] = citizenID})
    local Phone_Result = exports.oxmysql:executeSync('SELECT * FROM selldrugs_phone WHERE player = @player', {["@player"] = citizenID})

    if not Player_Result[1] then
        exports.oxmysql:execute('INSERT INTO selldrugs_players (player, respect, sale_skill, mole) VALUES (@player, @respect, @sale_skill, @mole)',
        {
            ['@player'] = citizenID,
            ['@respect'] = 0,
            ['@sale_skill'] = 0,
            ['@mole'] = json.encode({["junkie"] = {}, ["criminal"] = {}, ["professional"] = {}})
        })

        exports.oxmysql:execute('INSERT INTO selldrugs_phone (player, settings) VALUES (@player, @settings)',
        {
            ['@player'] = citizenID,
            ['@settings'] = json.encode({statusAlerts = true, statusAlertsSound = true})
        })
        Player["id"..src] = {respect = 0, sale_skill = 0, mole = {["junkie"] = {}, ["criminal"] = {}, ["professional"] = {}}, Prices = {}, Phone = {statusAlerts = true, statusAlertsSound = true}, citizen = citizenID}
    end

    if Player_Result[1] then
        Player["id"..src] = {respect = Player_Result[1].respect, sale_skill = Player_Result[1].sale_skill, mole = json.decode(Player_Result[1].mole), Prices = {}, Phone = json.decode(Phone_Result[1].settings), citizen = citizenID}
    end

    for mole_type, mole_table in pairs(Player["id"..src].mole) do
        for mole_name, mole_info in pairs(mole_table) do
            if mole_info.date and mole_info.time then
                TriggerClientEvent("SellDrugs:Activate_Mole", src, mole_type, mole_name)
            end
        end
    end

    TriggerClientEvent("SellDrugs:Update_Police", src, Police.Player)
end)

AddEventHandler('playerDropped', function()
    local src = source
    
    if not Player["id"..src] then return end

    if Player["id"..src].save then
        Save_Database("id"..src)
    end

    Player["id"..src] = nil

    if Police.Player["id"..src] then
        Police.Count = Police.Count - 1
        Police.Player["id"..src] = nil
        TriggerClientEvent("SellDrugs:Update_Police", -1, Police.Player)
    end
end)

AddEventHandler('onResourceStop', function(name)
    if name == GetCurrentResourceName() then
        for k, v in pairs(Player) do
            if v.save then
                Save_Database(k)
            end
        end
    end
end)

AddEventHandler('onResourceStart', function(name)
    if name == GetCurrentResourceName() then
        Blocked_Clients = {}
        Player = {}
        Police = {Count = 0, Player = {}}
        Loop()
    end
end)

function Loop()
    Wait(1000)
    while true do
        local Zone = Get_Time(os.time(), "minute", 0)

        for k, v in pairs(Player) do
            local playerId = tonumber(string.sub(k, 3))

            for mole_type, mole_table in pairs(v.mole) do
                for mole_name, mole_info in pairs(mole_table) do
                    if mole_info.date and mole_info.time then
                        if (mole_info.time - Zone.time) <= 0 then
                            TriggerClientEvent("SellDrugs:Deactivate_Mole", playerId, mole_type, mole_name)
                            mole_table[mole_name] = nil
                            v.save = true
                        end
                    end
                end
            end

            if Police.Count >= cfg.Police.Required then
                if v.respect >= cfg.Threshold_Respect.Wholesale then
                    local item = Check_Item(playerId, cfg.Phone.Item_Name)
                    if item ~= nil then
                        if not v.wholesale then
                            v.wholesale = {Cooldown = Get_Time(os.time(), "minute", cfg.Wholesale_Settings.Repeat)}
                        end

                        if v.wholesale then
                            if v.wholesale.Cooldown and not v.wholesale.Waiting and (v.wholesale.Cooldown.time - Zone.time) <= 0 then
                                v.wholesale.Cooldown = nil
                                local items = {}
                                for k, _ in pairs(cfg.Drug_List) do
                                    table.insert(items, k)
                                end
                                v.wholesale.Drug = items[math.random(1, #items)]
                                TriggerClientEvent("SellDrugs:Wholesale_Offer", playerId, v.wholesale.Drug)
                                v.wholesale.Waiting = Get_Time(os.time(), "minute", cfg.Wholesale_Settings.Waiting)
                            elseif v.wholesale.Waiting and (v.wholesale.Waiting.time - Zone.time) <= 0 then
                                v.wholesale = nil
                            end
                        end
                    end
                end
            end

            if v.save then
                Save_Database(k)
            end
        end
        Wait(90000) -- 1:30 minutes
    end
end

function Save_Database(id)
    Player[id].save = false
    exports.oxmysql:execute('UPDATE selldrugs_phone SET settings = @settings WHERE player = @player',
    {
        ['@player'] = Player[id].citizen,
        ['@settings'] = json.encode(Player[id].Phone)
    })

    exports.oxmysql:execute('UPDATE selldrugs_players SET respect = @respect, sale_skill = @sale_skill, mole = @mole WHERE player = @player',
    {
        ['@player'] = Player[id].citizen,
        ['@respect'] = Player[id].respect,
        ['@sale_skill'] = Player[id].sale_skill,
        ['@mole'] = json.encode(Player[id].mole)
    })
end

function Get_Time(time, unit, count)
    local Add_Time = 0
    local Current_Time = nil
    local Current_Date = nil

    if unit == "minute" then
        Add_Time = 60 * count
    elseif unit == "days" then
        Add_Time = 86400 * count
    end

    if cfg.Time["Zone"] == "plus" then
        Current_Time = (cfg.Time["Zone_Count"] * 3600) + time + Add_Time
    elseif cfg.Time["Zone"] == "minus" then
        Current_Time = (cfg.Time["Zone_Count"] * 3600) - time + Add_Time
    end

    if cfg.Time["Format"] == 24 then
        Current_Date = os.date("%Y/%m/%d %H:%M", Current_Time)
    elseif cfg.Time["Format"] == 12 then
        Current_Date = os.date("%m/%d/%Y %I:%M %p", Current_Time)
    end

    return {date = Current_Date, time = Current_Time}
end

function addStatistic(player, statistic, amount)
    if Player[player] ~= nil then
        if statistic == "respect" then
            if Player[player].respect < cfg.Threshold_Respect.Limit then
                Player[player].respect = Player[player].respect + amount

                if Player[player].respect >= cfg.Threshold_Respect.Limit then
                    Player[player].respect = cfg.Threshold_Respect.Limit
                end
            end
        elseif statistic == "sale_skill" then
            if Player[player].sale_skill < cfg.Sales_Skill.Limit then
                Player[player].sale_skill = Player[player].sale_skill + amount

                if Player[player].sale_skill >= cfg.Sales_Skill.Limit then
                    Player[player].sale_skill = cfg.Sales_Skill.Limit
                end
            end
        end
        Player[player].save = true
    end
end

function removeStatistic(player, statistic, amount)
    if Player[player] ~= nil then
        if statistic == "respect" then
            if Player[player].respect > 0 then
                Player[player].respect = Player[player].respect - amount

                if Player[player].respect <= 0 then
                    Player[player].respect = 0
                end
            end
        elseif statistic == "sale_skill" then
            if Player[player].sale_skill > 0 then
                Player[player].sale_skill = Player[player].sale_skill - amount

                if Player[player].sale_skill <= 0 then
                    Player[player].sale_skill = 0
                end
            end
        end
        Player[player].save = true
    end
end

function Calculate_Skill_Bonus(negotiatedPrice, averagePrice, baseBonus)
    local priceRatio = negotiatedPrice / averagePrice
    local bonus = math.floor(baseBonus * priceRatio)

    return bonus
end

function Send_Discord_Log(color, title, webhookName, message, footer)
    if cfg.Discord_Webhook and cfg.Discord_Webhook ~= "URL" then
        local embed = {
            {
                ["color"] = color,
                ["title"] = "**".. title .."**",
                ["description"] = message,
                ["footer"] = {
                    ["text"] = footer,
                },
            }
        }
    
        PerformHttpRequest(cfg.Discord_Webhook, function(err, text, headers) end, 'POST', json.encode({username = webhookName, embeds = embed}), { ['Content-Type'] = 'application/json' })
    end
end