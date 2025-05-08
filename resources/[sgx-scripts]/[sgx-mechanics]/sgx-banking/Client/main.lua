QBCore = exports["qb-core"]:GetCoreObject()
MenuAccessible = false

RegisterNetEvent("sgx-banking:Client:BankMenu:Show")
AddEventHandler("sgx-banking:Client:BankMenu:Show", function() 
    if IsPlayerNearAccessLocation() then 
        QBCore.Functions.TriggerCallback("sgx-banking:Server:GetUserAccounts", function(playerName, playerBank, playerAccount, transactions)
                SetNuiFocus(true, true)
                SendNUIMessage({
                    action = "showMenu",
                    playerName = playerName,
                    playerBank = playerBank,
                    playerAccount = playerAccount,
                    transactions = transactions
                })

        end)
    end
end)

RegisterNetEvent("sgx-banking:Client:BankMenu:Hide")
AddEventHandler("sgx-banking:Client:BankMenu:Hide", function() 
    SetNuiFocus(false, false)
                
    SendNUIMessage({
        action = "hideMenu"
    })
end)


RegisterNUICallback("action", function(data, cb)
	if data.action == "deposit-money-bank" then
        TriggerServerEvent("sgx-banking:Server:DepositMoney", tonumber(data.amount))
    elseif data.action == "withdraw-money-bank" then
        TriggerServerEvent("sgx-banking:Server:WithdrawMoney", tonumber(data.amount))
    end
end)


RegisterNetEvent('updateMoneyDeposited')
AddEventHandler('updateMoneyDeposited', function(amount)
    QBCore.Functions.TriggerCallback("sgx-banking:Server:GetUserAccounts", function(playerName, playerBank, playerAccount, transactions)
        SendNUIMessage({
            action = "updateMoneyDeposited",
            playerBank = playerBank,
            transactions = transactions
        })
    end)
end)