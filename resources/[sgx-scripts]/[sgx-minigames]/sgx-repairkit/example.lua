RegisterCommand('testrepairkit', function() 
    local minigame = exports["sgx-repairkit"]:Minigame()
    if minigame then 
        print('User won the minigame')
    else
        print('User lost the minigame')
    end
end)

