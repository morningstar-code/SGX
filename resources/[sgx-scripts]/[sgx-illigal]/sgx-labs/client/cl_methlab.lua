CreateThread(function()
    exports["qb-target"]:AddBoxZone("methentrance", Config.Labs.methlab.entrance.xyz, 0.6, 1.2, {
        name = "methentrance",
        heading = Config.Labs.methlab.entrance.w,
        debugPoly = false,
        minZ = 18.428356,
        maxZ = 20.428356,
     }, {
        options = {
            {
                action = function()
                    enterKeyLab("methlab")
                end,
                icon = "fas fa-user-secret",
                label = "Enter",
                canInteract = function()
                    if Config.Labs.methlab.locked then return false end
                    return true
                end,
            },
            {
                action = function()
                    LockUnlock("methlab")
                end,
                icon = "fas fa-key",
                label = "Lock/Unlock Door",
                item = "methkey"
            }
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("methexit", Config.Labs.methlab.exit.xyz, 0.6, 1.2, {
        name = "methexit",
        heading = Config.Labs.methlab.exit.w,
        debugPoly = false,
        minZ = -37.30,
        maxZ = -35.30,
     }, {
        options = {
            {
                action = function()
                    Exitlab("methlab")
                end,
                icon = "fas fa-user-secret",
                label = "Exit",
                canInteract = function()
                    if Config.Labs.methlab.locked then return false end
                    return true
                end,
            },
            {
                action = function()
                    LockUnlock("methlab")
                end,
                icon = "fas fa-key",
                label = "Lock/Unlock Door",
                item = "methkey"
            }
        },
        distance = 2.5
    })

    exports['qb-target']:AddBoxZone("methingredients", vector3(996.79, -3200.01, -39.0), 0.8, 2.6, {
        name = "methingredients",
        heading = 90.00,
        debugPoly = false,
        minZ = -39.50,
        maxZ = -38.0,
     }, {
        options = { 
            {
                action = function()
                    CheckIngredients("methlab")
                end,
                icon = 'fas fa-flask',
                label = 'Check Ingredients'
            }
        },
        distance = 1.5,
    })

    exports["qb-target"]:AddCircleZone("methtask1", vector3(1005.71, -3200.79, -38.31), 1.0, {
        name = "methtask1",
        useZ = true,
        debugPoly = false
     }, {
        options = {
            {
                action = function()
                    CheckTask("methlab", 1)
                end,
                icon = "fas fa-glasses",
                label = 'Inspect Machine',
                canInteract = function()
                    if Config.Labs["methlab"].tasks[1].busy then return false end
                    return true
                end,
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("methtask2", vector3(1010.89, -3197.73, -38.88), 0.8, 2.6, {
        name = "methtask2",
        heading = 180.00,
        debugPoly = false,
        minZ = -39.50,
        maxZ = -38.0,
     }, {
        options = {
            {
                action = function()
                    CheckTask("methlab", 2)
                end,
                icon = "fas fa-glasses",
                label = 'Inspect Machine',
                canInteract = function()
                    if Config.Labs["methlab"].tasks[2].busy or not Config.Labs["methlab"].tasks[1].completed then return false end
                    return true
                end,
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("methtask3", vector3(1010.77, -3199.19, -38.77), 0.8, 2.6, {
        name = "methtask3",
        heading = 0.00,
        debugPoly = false,
        minZ = -39.50,
        maxZ = -38.0,
     }, {
        options = {
            {
                action = function()
                    CheckTask("methlab", 3)
                end,
                icon = "fas fa-glasses",
                label = 'Inspect Machine',
                canInteract = function()
                    if Config.Labs["methlab"].tasks[3].busy or not Config.Labs["methlab"].tasks[2].completed then return false end
                    return true
                end,
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("methtaskend", vector3(1006.9, -3197.71, -38.82), 0.4, 1.2, {
        name = "methtaskend",
        heading = 270.00,
        debugPoly = false,
        minZ = -39.50,
        maxZ = -37.80,
     }, {
        options = {
            {
                action = function()
                    TriggerServerEvent('qb-labs:server:FinishLab', "methlab")
                end,
                icon = "fas fa-glasses",
                label = 'Inspect Machine',
                canInteract = function()
                    if not Config.Labs["methlab"].tasks[3].completed then return false end
                    return true
                end,
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("methcuring", vector3(1007.83, -3194.38, -39.07), 0.7, 1.6, {
        name = "methcuring",
        heading = 0.00,
        debugPoly = false,
        minZ = -40.00,
        maxZ = -37.80,
     }, {
        options = {
            {
                action = function()
                    CheckCure("methlab")
                end,
                icon = "fas fa-clock",
                label = 'Cure Batch'
            },
        },
        distance = 1.5
    })
end)
