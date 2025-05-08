Core = nil

CreateThread(function()
    Core, Config.Framework = GetCore()
end)

CreateThread(function()
    RegisterCallback(Config.eventPrefix ..'getESXCash', function(source, cb)
        local Player = GetPlayer(source)
        cb(Player.getMoney())
    end)

    RegisterCallback(Config.eventPrefix ..'getESXBank', function(source, cb)
        local Player = GetPlayer(source)
        cb(Player.getAccount("bank").money)
    end)

    RegisterCallback(Config.eventPrefix .. 'removeCashMoney', function(source, cb, amount)
        local removed = payMoney(source, 'cash', amount)
        if removed then
            cb(true)
        else
            cb(false)
        end
    end)

    RegisterCallback(Config.eventPrefix .. 'removeBankMoney', function(source, cb, amount)
        local removed = payMoney(source, 'bank', amount)
        if removed then
            cb(true)
        else
            cb(false)
        end
    end)
end)

function payMoney(source, method, price)
    local success = false
    local Player = GetPlayer(source)
    if Config.Framework == 'esx' then
        if method == 'cash' then
            if Player.getMoney() >= price then
                success = true
                Player.removeMoney(price)
            end
        elseif method == 'bank' then
            if Player.getAccount("bank").money >= price then
                success = true
                Player.removeAccountMoney("bank", price)
            end
        end
    else
        if Player.Functions.RemoveMoney(method, price) then
            success = true
        end
    end
    return success
end

function GetPlayer(source)
    local Player = false
    while Core == nil do
        Citizen.Wait(0)
    end
    if Config.Framework == 'esx' then
        Player = Core.GetPlayerFromId(source)
    elseif Config.Framework == 'qb' then
        Player = Core.Functions.GetPlayer(source)
    end
    return Player
end

function RegisterCallback(name, cbFunc)
    while not Core do
        Citizen.Wait(0)
    end
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        Core.RegisterServerCallback(name, function(source, cb, data)
            cbFunc(source, cb, data)
        end)
    else
        Core.Functions.CreateCallback(name, function(source, cb, data)
            cbFunc(source, cb, data)
        end)
    end
end