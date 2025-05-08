CreateThread(function()
    exports["qb-target"]:AddBoxZone("meth2entrance", Config.Labs.methlab2.entrance.xyz, 0.4, 1.2, {
        name = "meth2entrance",
        heading = Config.Labs.methlab2.entrance.w,
        debugPoly = false,
        minZ = 77.97,
        maxZ = 79.97,
     }, {
        options = {
            {
                action = function()
                    enterKeyLab("methlab2")
                end,
                icon = "fas fa-user-secret",
                label = "Enter",
                canInteract = function()
                    if Config.Labs.methlab2.locked then return false end
                    return true
                end,
            },
            {
                action = function()
                    LockUnlock("methlab2")
                end,
                icon = "fas fa-key",
                label = "Lock/Unlock Door",
                item = "methkey2"
            }
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("meth2exit", Config.Labs.methlab2.exit.xyz, 0.4, 1.2, {
        name = "meth2exit",
        heading = Config.Labs.methlab2.exit.w,
        debugPoly = false,
        minZ = -47.40,
        maxZ = -45.40,
     }, {
        options = {
            {
                action = function()
                    Exitlab("methlab2")
                end,
                icon = "fas fa-user-secret",
                label = "Exit",
                canInteract = function()
                    if Config.Labs.methlab2.locked then return false end
                    return true
                end,
            },
            {
                action = function()
                    LockUnlock("methlab2")
                end,
                icon = "fas fa-key",
                label = "Lock/Unlock Door",
                item = "methkey2"
            }
        },
        distance = 1.5
    })

    exports['qb-target']:AddBoxZone("meth2ingredients", vector3(969.56, -146.53, -49.0), 0.8, 2.6, {
        name = "meth2ingredients",
        heading = 90.00,
        debugPoly = false,
        minZ = -50.00,
        maxZ = -48.0,
     }, {
        options = { 
            {
                action = function()
                    CheckIngredients("methlab2")
                end,
                icon = 'fas fa-flask',
                label = 'Check Ingredients'
            }
        },
        distance = 1.5,
    })

    exports["qb-target"]:AddCircleZone("meth2task1", vector3(978.2, -147.34, -49.02), 1.0, {
        name = "meth2task1",
        useZ = true,
        debugPoly = false
     }, {
        options = {
            {
                action = function()
                    CheckTask("methlab2", 1)
                end,
                icon = "fas fa-glasses",
                label = 'Inspect Machine',
                canInteract = function()
                    if Config.Labs["methlab2"].tasks[1].busy then return false end
                    return true
                end,
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("meth2task2", vector3(983.75, -143.71, -49.0), 0.8, 2.6, {
        name = "meth2task2",
        heading = 180.00,
        debugPoly = false,
        minZ = -50.00,
        maxZ = -48.00,
     }, {
        options = {
            {
                action = function()
                    CheckTask("methlab2", 2)
                end,
                icon = "fas fa-glasses",
                label = 'Inspect Machine',
                canInteract = function()
                    if Config.Labs["methlab2"].tasks[2].busy or not Config.Labs["methlab2"].tasks[1].completed then return false end
                    return true
                end,
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("meth2task3", vector3(983.73, -145.96, -49.0), 0.8, 2.6, {
        name = "meth2task3",
        heading = 0.00,
        debugPoly = false,
        minZ = -50.00,
        maxZ = -48.0,
     }, {
        options = {
            {
                action = function()
                    CheckTask("methlab2", 3)
                end,
                icon = "fas fa-glasses",
                label = 'Inspect Machine',
                canInteract = function()
                    if Config.Labs["methlab2"].tasks[3].busy or not Config.Labs["methlab2"].tasks[2].completed then return false end
                    return true
                end,
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("meth2taskend", vector3(979.38, -144.08, -50.0), 0.4, 1.2, {
        name = "meth2taskend",
        heading = 270.00,
        debugPoly = false,
        minZ = -49.30,
        maxZ = -48.00,
     }, {
        options = {
            {
                action = function()
                    TriggerServerEvent('qb-labs:server:FinishLab', "methlab2")
                end,
                icon = "fas fa-glasses",
                label = 'Inspect Machine',
                canInteract = function()
                    if not Config.Labs["methlab2"].tasks[3].completed then return false end
                    return true
                end,
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("meth2curing", vector3(980.43, -140.79, -46.75), 0.7, 1.6, {
        name = "meth2curing",
        heading = 0.00,
        debugPoly = false,
        minZ = -49.75,
        maxZ = -47.80,
     }, {
        options = {
            {
                action = function()
                    CheckCure("methlab2")
                end,
                icon = "fas fa-clock",
                label = 'Cure Batch'
            },
        },
        distance = 1.5
    })
end)
