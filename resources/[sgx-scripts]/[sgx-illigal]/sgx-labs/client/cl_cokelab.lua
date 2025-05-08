CreateThread(function()
    exports["qb-target"]:AddBoxZone("cokeentrance", vector3(-443.4014, 5602.0903, 68.088783), 0.4, 1.2, {
        name = "cokeentrance",
        heading = Config.Labs.cokelab.entrance.w,
        debugPoly = false,
        minZ = 67.088783,
        maxZ = 69.088783,
     }, {
        options = {
            {
                action = function()
                    enterKeyLab("cokelab")
                end,
                icon = "fas fa-user-secret",
                label = "Enter",
                canInteract = function()
                    if Config.Labs.cokelab.locked then return false end
                    return true
                end,
            },
            {
                action = function()
                    LockUnlock("cokelab")
                end,
                icon = "fas fa-key",
                label = "Lock/Unlock Door",
                item = "cokekey"
            }
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("cokeexit", vector3(1088.66, -3187.06, -38.79), 0.4, 1.2, {
        name = "cokeexit",
        heading = Config.Labs.cokelab.exit.w,
        debugPoly = false,
        minZ = -39.80,
        maxZ = -37.80,
     }, {
        options = {
            {
                action = function()
                    Exitlab("cokelab")
                end,
                icon = "fas fa-user-secret",
                label = "Exit",
                canInteract = function()
                    if Config.Labs.cokelab.locked then return false end
                    return true
                end,
            },
            {
                action = function()
                    LockUnlock("cokelab")
                end,
                icon = "fas fa-key",
                label = "Lock/Unlock Door",
                item = "cokekey"
            }
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("darkexit", vector3(-581.1341, -937.4114, 14.713626), 0.4, 1.2, {
        name = "darkexit",
        heading = Config.Labs.darkroom.exit.w,
        debugPoly = false,
        minZ = 13.713626,
        maxZ = 15.713626,
     }, {
        options = {
            {
                action = function()
                    Exitlab("darkroom")
                end,
                icon = "fas fa-user-secret",
                label = "Exit",
                canInteract = function()
                    if Config.Labs.darkroom.locked then return false end
                    return true
                end,
            },
            {
                action = function()
                    LockDark("darkroom")
                end,
                icon = "fas fa-key",
                label = "Lock/Unlock Door",
                item = "darkkey"
            }
        },
        distance = 1.5
    })

exports["qb-target"]:AddBoxZone("darkenter", vector3(-575.0803, -939.6504, 24.350456), 0.4, 1.2, {
    name = "darkenter",
    heading = Config.Labs.darkroom.entrance.w,
    debugPoly = false,
    minZ = 23.350456,
    maxZ = 25.350456,
 }, {
    options = {
        {
            action = function()
                enterKeyLab("darkroom")
            end,
            icon = "fas fa-user-secret",
            label = "Enter",
            canInteract = function()
                if Config.Labs.darkroom.locked then return false end
                return true
            end,
        },
        {
            action = function()
                LockDark("darkroom")
            end,
            icon = "fas fa-key",
            label = "Lock/Unlock Door",
            item = "darkkey"
        },
        {
            action = function()
                LockDark("darkroom")
            end,
            icon = "fas fa-key", 
            label = "Lock/Unlock Door",
            item = "izcohen_card" 
        }
    },
    distance = 1.5
})

    exports['qb-target']:AddBoxZone("cokeingredients", vector3(1090.04, -3199.62, -38.95), 0.8, 2.6, {
        name = "cokeingredients",
        heading = 180.00,
        debugPoly = false,
        minZ = -39.50,
        maxZ = -38.0,
     }, {
        options = { 
            {
                action = function()
                    CheckIngredients("cokelab")
                end,
                icon = 'fas fa-flask',
                label = 'Check Ingredients'
            }
        },
        distance = 1.5,
    })

    exports["qb-target"]:AddBoxZone("coketask1", vector3(1092.92, -3195.74, -38.13), 1.1, 2.6, {
        name = "coketask1",
        heading = 180.00,
        debugPoly = false,
        minZ = -39.50,
        maxZ = -39.0,
     }, {
        options = {
            {
                action = function()
                    CheckTask("cokelab", 1)
                end,
                icon = "fas fa-glasses",
                label = 'Interact',
                canInteract = function()
                    if Config.Labs["cokelab"].tasks[1].busy then return false end
                    return true
                end,
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("coketask2", vector3(1098.88, -3194.24, -38.2), 0.8, 2.6, {
        name = "coketask2",
        heading = 90.00,
        debugPoly = false,
        minZ = -39.50,
        maxZ = -39.0,
     }, {
        options = {
            {
                action = function()
                    CheckTask("cokelab", 2)
                end,
                icon = "fas fa-glasses",
                label = 'Interact',
                canInteract = function()
                    if Config.Labs["cokelab"].tasks[2].busy or not Config.Labs["cokelab"].tasks[1].completed then return false end
                    return true
                end,
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("coketask3", vector3(1101.87, -3192.81, -38.2), 1.2, 2.6, {
        name = "coketask3",
        heading = 0.00,
        debugPoly = false,
        minZ = -39.50,
        maxZ = -39.0,
     }, {
        options = {
            {
                action = function()
                    CheckTask("cokelab", 3)
                end,
                icon = "fas fa-glasses",
                label = 'Interact',
                canInteract = function()
                    if Config.Labs["cokelab"].tasks[3].busy or not Config.Labs["cokelab"].tasks[2].completed then return false end
                    return true
                end,
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("coketaskend", vector3(1098.89, -3196.12, -39.26), 0.8, 1.3, {
        name = "coketaskend",
        heading = 20.00,
        debugPoly = false,
        minZ = -39.70,
        maxZ = -38.90,
     }, {
        options = {
            {
                action = function()
                    TriggerServerEvent('qb-labs:server:FinishLab', "cokelab")
                end,
                icon = "fas fa-glasses",
                label = 'Interact',
                canInteract = function()
                    if not Config.Labs["cokelab"].tasks[3].completed then return false end
                    return true
                end,
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("cokecuring", vector3(1100.38, -3199.56, -38.18), 1.0, 1.5, {
        name = "cokecuring",
        heading = 180.00,
        debugPoly = false,
        minZ = -39.50,
        maxZ = -39.00,
     }, {
        options = {
            {
                action = function()
                    CheckCure("cokelab")
                end,
                icon = "fas fa-clock",
                label = 'Interact'
            },
        },
        distance = 1.5
    })
end)