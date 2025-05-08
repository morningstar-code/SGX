RegisterNetEvent("sgx_hack:playSound")
AddEventHandler("sgx_hack:playSound", function(name)
    local t = {transactionType = name}

    SendNuiMessage(json.encode(t))
end)