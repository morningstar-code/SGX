local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-labs:weaponbunker:OpenStash', function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "weaponbunker_stash", {
        maxweight = 4000000,
        slots = 80,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "weaponbunker_stash")
end)

RegisterNetEvent('qb-labs:weaponbunker:CraftItem', function(data)
    QBCore.Functions.Progressbar("CraftWeapon", "Crafting...", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('qb-labs:server:CraftItem', data.craft, data.index)
    end, function() -- Cancel
        QBCore.Functions.Notify("Cancelled..", "error")
    end)
end)

RegisterNetEvent('qb-labs:weaponbunker:OpenCraft', function(data)
    local menu = {
        {
            header = "Crafting Menu",
            txt = "ESC or click to close",
            icon = 'fas fa-angle-left',
            params = {
                event = "qb-menu:closeMenu",
            }
        }
    }

    for k, v in pairs(Config.CraftingCost[data.craft]) do
        local text = ''
        for i=1, #v.items do
            text = text.. QBCore.Shared.Items[v.items[i].item]['label']..": "..v.items[i].amount.." <br>"
        end

        menu[#menu+1] = {
            header = v.label,
            txt = text,
            icon = 'fas fa-screwdriver-wrench',
            params = {
                event = "qb-labs:weaponbunker:CraftItem",
                args = {
                    craft = data.craft,
                    index = k
                }
            }
        }
    end
    exports['qb-menu']:openMenu(menu)
end)

CreateThread(function()
    exports["qb-target"]:AddBoxZone("gunentrance", Config.Labs.gunbunker.entrance.xyz, 0.8, 1.4, {
        name = "gunentrance",
        heading = Config.Labs.gunbunker.entrance.w,
        debugPoly = false,
        minZ = 143.20,
        maxZ = 145.20,
     }, {
        options = {
            {
                action = function()
                    enterKeyLab("gunbunker")
                end,
                icon = "fas fa-user-secret",
                label = "Enter",
                canInteract = function()
                    if Config.Labs.gunbunker.locked then return false end
                    return true
                end,
            },
            {
                action = function()
                    LockUnlock("gunbunker")
                end,
                icon = "fas fa-key",
                label = "Lock/Unlock Door",
                item = "gunkey"
            }
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("gunexit", Config.Labs.gunbunker.exit.xyz, 0.7, 1.6, {
        name = "gunexit",
        heading = Config.Labs.gunbunker.exit.w,
        debugPoly = false,
        minZ = -98.00,
        maxZ = -95.00,
     }, {
        options = {
            {
                action = function()
                    Exitlab("gunbunker")
                end,
                icon = "fas fa-user-secret",
                label = "Exit",
                canInteract = function()
                    if Config.Labs.gunbunker.locked then return false end
                    return true
                end,
            },
            {
                action = function()
                    LockUnlock("gunbunker")
                end,
                icon = "fas fa-key",
                label = "Lock/Unlock Door",
                item = "gunkey"
            }
        },
        distance = 1.5
    })

    exports["qb-target"]:AddCircleZone("gunstash", Config.Labs.gunbunker.locations.weaponstash, 1.5, {
        name = "gunstash",
        useZ = true,
        debugPoly = false
     }, {
        options = {
            {
                type = "client",
                event = "qb-labs:weaponbunker:OpenStash",
                icon = "fas fa-archive",
                label = "Open Stash"
            }
        },
        distance = 1.5
    })

    exports["qb-target"]:AddCircleZone("gunammo", Config.Labs.gunbunker.locations.ammo, 1.5, {
        name = "gunammo",
        useZ = true,
        debugPoly = false
     }, {
        options = {
            {
                type = "client",
                event = "qb-labs:weaponbunker:OpenCraft",
                icon = "fas fa-user-secret",
                label = "Craft Ammo",
                craft = "ammo"
            }
        },
        distance = 1.5
    })

    exports["qb-target"]:AddCircleZone("gunpistol", Config.Labs.gunbunker.locations.pistol, 1.5, {
        name = "gunpistol",
        useZ = true,
        debugPoly = false
     }, {
        options = {
            {
                type = "client",
                event = "qb-labs:weaponbunker:OpenCraft",
                icon = "fas fa-user-secret",
                label = "Craft Pistol",
                craft = "pistol"
            }
        },
        distance = 1.5
    })

    exports["qb-target"]:AddCircleZone("gunsmg", Config.Labs.gunbunker.locations.smg, 1.5, {
        name = "gunsmg",
        useZ = true,
        debugPoly = false
     }, {
        options = {
            {
                type = "client",
                event = "qb-labs:weaponbunker:OpenCraft",
                icon = "fas fa-user-secret",
                label = "Craft SMG",
                craft = "smg"
            }
        },
        distance = 1.5
    })

    exports["qb-target"]:AddCircleZone("gunrifle", Config.Labs.gunbunker.locations.rifle, 1.5, {
        name = "gunrifle",
        useZ = true,
        debugPoly = false
     }, {
        options = {
            {
                type = "client",
                event = "qb-labs:weaponbunker:OpenCraft",
                icon = "fas fa-user-secret",
                label = "Craft Rifle",
                craft = "rifles"
            }
        },
        distance = 1.5
    })
end)
