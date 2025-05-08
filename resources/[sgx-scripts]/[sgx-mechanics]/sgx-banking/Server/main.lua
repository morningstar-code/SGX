QBCore = exports['qb-core']:GetCoreObject()
local Accounts = {}
local Statements = {}

QBCore.Functions.CreateCallback("sgx-banking:Server:GetUserAccounts", function(source, cb) 
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local xPlayerBank = xPlayer.PlayerData.money.bank
    local playerName = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
    local playerAccount = xPlayer.PlayerData.charinfo.account

    MySQL.query("SELECT * FROM transactions WHERE citizenid = ?", { xPlayer.PlayerData.citizenid }, function(transactions)
        cb(playerName, xPlayerBank, playerAccount, transactions)
    end)

end)

RegisterNetEvent("sgx-banking:Server:DepositMoney")
AddEventHandler("sgx-banking:Server:DepositMoney", function(amount)
    local source = source
    local identifier = QBCore.Functions.GetPlayer(source).PlayerData.citizenid
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local Player = QBCore.Functions.GetPlayer(source)
    local PlayerMoney = Player.PlayerData.money.cash
    local PlayerBank = Player.PlayerData.money.bank

    if PlayerMoney >= amount then
        Player.Functions.RemoveMoney("cash", amount)
        Player.Functions.AddMoney("bank", amount)
        TriggerClientEvent('QBCore:Notify', source, 'You have deposited $'..amount, 'success', 7500)
        TriggerClientEvent('updateMoneyDeposited', source, PlayerBank + amount)
        MySQL.Async.execute('INSERT INTO transactions (citizenid, amount, type, description) VALUES (@citizenid, @amount, @type, @description)', {['@citizenid'] = identifier, ['@amount'] = amount, ['@type'] = 'deposit', ['@description'] = 'Deposited $'..amount..' into bank'}, function(rowsChanged) end)
    else
        TriggerClientEvent('QBCore:Notify', source, 'You do not have enough money to deposit', 'error', 7500)
    end

end)

RegisterNetEvent("sgx-banking:Server:WithdrawMoney")
AddEventHandler("sgx-banking:Server:WithdrawMoney", function(amount)
    local source = source
    local identifier = QBCore.Functions.GetPlayer(source).PlayerData.citizenid
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local Player = QBCore.Functions.GetPlayer(source)
    local PlayerMoney = Player.PlayerData.money.cash
    local PlayerBank = Player.PlayerData.money.bank

    if PlayerBank >= amount then
        Player.Functions.AddMoney("cash", amount)
        Player.Functions.RemoveMoney("bank", amount)
        TriggerClientEvent('QBCore:Notify', source, 'You have withdrawn $'..amount, 'success', 7500)
        TriggerClientEvent('updateMoneyDeposited', source, PlayerBank - amount)
        MySQL.Async.execute('INSERT INTO transactions (citizenid, amount, type, description) VALUES (@citizenid, @amount, @type, @description)', {['@citizenid'] = identifier, ['@amount'] = amount, ['@type'] = 'withdraw', ['@description'] = 'Withdrawn $'..amount..' from bank'}, function(rowsChanged) end)
    else
        TriggerClientEvent('QBCore:Notify', source, 'You do not have enough money to withdraw', 'error', 7500)
    end

end)

QBCore.Functions.CreateCallback("sgx-banking:Server:TransferMoney", function(source, data, cb) 
    local identifier = QBCore.Functions.GetPlayer(source).PlayerData.citizenid

    local accountFetch = MySQL.query("SELECT * FROM accounts WHERE identifier = ? and id = ?", { identifier, data.accountId })

    if accountFetch[1] then 
        local senderAccount = accountFetch[1]

        if senderAccount.balance >= tonumber(data.amount) then 

            local targetAccountFetch = MySQL.query("SELECT * FROM accounts WHERE id = ?", { data.targetId })

            if targetAccountFetch[1] then
                local targetAccount =targetAccountFetch[1]

                senderAccount.balance = senderAccount.balance - data.amount

                senderAccount.transactions = json.decode(senderAccount.transactions)
                table.insert(senderAccount.transactions, { type = "transfer_sent", amount = data.amount, description = data.description, targetId = data.targetId })

                targetAccount.balance = targetAccount.balance + data.amount

                targetAccount.transactions = json.decode(targetAccount.transactions)
                table.insert(targetAccount.transactions, { type = "transfer_recieved", amount = data.amount, description = data.description, targetId = senderAccount.id })

                MySQL.query("UPDATE accounts SET balance = ?, transactions = ? WHERE id = ?", { senderAccount.balance, json.encode(senderAccount.transactions), senderAccount.id })
                MySQL.query("UPDATE accounts SET balance = ?, transactions = ? WHERE id = ?", { targetAccount.balance, json.encode(targetAccount.transactions), targetAccount.id })

                if targetAccount.identifier == senderAccount.identifier then 
                    cb({ senderAccount, targetAccount })
                else
                    cb({ senderAccount })
                end
            else 
                cb(nil)
            end
                    
        else 
            cb(nil)
        end
    end
end)

local function AddMoney(accountName, amount, reason)
    if not reason then reason = 'External Deposit' end
    local newStatement = {
        amount = amount,
        reason = reason,
        date = os.time() * 1000,
        statement_type = 'deposit'
    }
    if Accounts[accountName] then
        local accountToUpdate = Accounts[accountName]
        accountToUpdate.account_balance = accountToUpdate.account_balance + amount
        if not Statements[accountName] then Statements[accountName] = {} end
        Statements[accountName][#Statements[accountName] + 1] = newStatement
        MySQL.insert.await('INSERT INTO bank_statements (account_name, amount, reason, statement_type) VALUES (?, ?, ?, ?)', { accountName, amount, reason, 'deposit' })
        local updateSuccess = MySQL.update.await('UPDATE bank_accounts SET account_balance = account_balance + ? WHERE account_name = ?', { amount, accountName })
        return updateSuccess
    end
    return false
end
exports('AddMoney', AddMoney)
exports('AddGangMoney', AddMoney)

local function RemoveMoney(accountName, amount, reason)
    if not reason then reason = 'External Withdrawal' end
    local newStatement = {
        amount = amount,
        reason = reason,
        date = os.time() * 1000,
        statement_type = 'withdraw'
    }
    if Accounts[accountName] then
        local accountToUpdate = Accounts[accountName]
        accountToUpdate.account_balance = accountToUpdate.account_balance - amount
        if not Statements[accountName] then Statements[accountName] = {} end
        Statements[accountName][#Statements[accountName] + 1] = newStatement
        MySQL.insert.await('INSERT INTO bank_statements (account_name, amount, reason, statement_type) VALUES (?, ?, ?, ?)', { accountName, amount, reason, 'withdraw' })
        local updateSuccess = MySQL.update.await('UPDATE bank_accounts SET account_balance = account_balance - ? WHERE account_name = ?', { amount, accountName })
        return updateSuccess
    end
    return false
end
exports('RemoveMoney', RemoveMoney)
exports('RemoveGangMoney', RemoveMoney)