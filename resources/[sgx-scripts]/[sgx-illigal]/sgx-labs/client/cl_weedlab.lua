CreateThread(function()
    exports["qb-target"]:AddBoxZone("weedentrance", Config.Labs.weedlab.entrance.xyz, 0.6, 1.2, {
        name = "weedentrance",
        heading = Config.Labs.weedlab.entrance.w,
        debugPoly = false,
        minZ = 274.01309,
        maxZ = 276.01309,
     }, {
        options = {
            {
                action = function()
                    enterKeyLab("weedlab")
                end,
                icon = "fas fa-user-secret",
                label = "Enter",
                canInteract = function()
                    if Config.Labs.weedlab.locked then return false end
                    return true
                end,
            },
            {
                action = function()
                    LockUnlock("weedlab")
                end,
                icon = "fas fa-key",
                label = "Lock/Unlock Door",
                item = "weedkey"
            }
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("weedexit", Config.Labs.weedlab.exit.xyz, 0.6, 1.2, {
        name = "weedexit",
        heading = Config.Labs.weedlab.exit.w,
        debugPoly = false,
        minZ = -40.20,
        maxZ = -38.20,
     }, {
        options = {
            {
                action = function()
                    Exitlab("weedlab")
                end,
                icon = "fas fa-user-secret",
                label = "Exit",
                canInteract = function()
                    if Config.Labs.weedlab.locked then return false end
                    return true
                end,
            },
            {
                action = function()
                    LockUnlock("weedlab")
                end,
                icon = "fas fa-key",
                label = "Lock/Unlock Door",
                item = "weedkey"
            }
        },
        distance = 1.5
    })

    exports['qb-target']:AddBoxZone("weedingredients", vector3(1041.85, -3208.35, -38.71), 0.5, 2.6, {
        name = "weedingredients",
        heading = 180.00,
        debugPoly = false,
        minZ = -39.16,
        maxZ = -38.60,
     }, {
        options = { 
            {
                action = function()
                    CheckIngredients("weedlab")
                end,
                icon = 'fas fa-flask',
                label = 'Check Ingredients'
            }
        },
        distance = 1.5,
    })

    exports["qb-target"]:AddBoxZone("weedtask1", vector3(1062.62, -3193.66, -39.11), 3.2, 3.2, {
            name = "weedtask1",
            heading = 270.00,
            debugPoly = false,
            minZ = -40.20,
            maxZ = -37.60,
     }, {
        options = {
            {
                action = function()
                    CheckTask("weedlab", 1)
                end,
                icon = "fas fa-glasses",
                label = 'Inspect Plants',
                canInteract = function()
                    if Config.Labs["weedlab"].tasks[1].busy then return false end
                    return true
                end,
            },
        },
        distance = 2.5
    })

    exports["qb-target"]:AddBoxZone("weedtask2", vector3(1057.47, -3199.65, -39.12), 3.2, 3.2, {
        name = "weedtask2",
        heading = 180.00,
        debugPoly = false,
        minZ = -40.20,
        maxZ = -37.60,
     }, {
        options = {
            {
                action = function()
                    CheckTask("weedlab", 2)
                end,
                icon = "fas fa-glasses",
                label = 'Inspect Plants',
                canInteract = function()
                    if Config.Labs["weedlab"].tasks[2].busy or not Config.Labs["weedlab"].tasks[1].completed then return false end
                    return true
                end,
            },
        },
        distance = 2.5
    })

    exports["qb-target"]:AddBoxZone("weedtask3", vector3(1051.25, -3193.75, -39.15) , 2.8, 4.6, {
        name = "weedtask3",
        heading = 90.00,
        debugPoly = false,
        minZ = -40.20,
        maxZ = -37.60,
     }, {
        options = {
            {
                action = function()
                    CheckTask("weedlab", 3)
                end,
                icon = "fas fa-glasses",
                label = 'Inspect Plants',
                canInteract = function()
                    if Config.Labs["weedlab"].tasks[3].busy or not Config.Labs["weedlab"].tasks[2].completed then return false end
                    return true
                end,
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("weedtaskend", vector3(1038.35, -3205.88, -38.28), 1.2, 1.8, {
        name = "weedtaskend",
        heading = 270.00,
        debugPoly = false,
        minZ = -38.50,
        maxZ = -38.10,
     }, {
        options = {
            {
                action = function()
                    TriggerServerEvent('qb-labs:server:FinishLab', "weedlab")
                end,
                icon = "fas fa-glasses",
                label = 'Inspect Plants',
                canInteract = function()
                    if not Config.Labs["weedlab"].tasks[3].completed then return false end
                    return true
                end,
            },
        },
        distance = 1.5
    })
end)

    --exports["qb-target"]:AddBoxZone("weedcuring", vector3(1033.85, -3203.07, -38.28), 5.0, 3.6, {
    --    name = "weedcuring",
    --    heading = 90.00,
    --    debugPoly = false,
    --    minZ = -37.00,
    --    maxZ = -35.00,
    -- }, {
    --    options = {
    --        {
    --            action = function()
    --                CheckCure("weedlab")
    --            end,
    --            icon = "fas fa-clock",
    --            label = 'Dry Weed'
    --        },
    --    },
    --    distance = 3.0
    --})
--end)