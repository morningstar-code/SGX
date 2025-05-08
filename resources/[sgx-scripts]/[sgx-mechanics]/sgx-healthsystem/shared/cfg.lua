cfg = {
    debug = false,
    serverName = "SGXCore",
    serverNameDesc = "HEALTH-SYSTEM",
    minStumbleHealth = 20,
    accessableJobs = {
        -- ["all"] = true,
        ['ambulance'] = true
    },
    damages = {
        [`weapon_unarmed`] = function() return math.random(5, 10) end,
        [`weapon_pistol`] = function() return math.random(10, 20) end,
        [`weapon_assaultrifle`] = function() return math.random(15, 40) end
    },
    items = {
        ["bandage"] = {
            label = 'Bandage',
            description = 'Lorem ipsum dolor sit amet consectetur.',
            icon = 'bandage.png', -- you can add new image from web/dist
            giveHealth = 50
        },
        ["bullet"] = {
            label = 'Bullet',
            description = 'Lorem ipsum dolor sit amet consectetur.',
            icon = 'bullet.png' -- you can add new image from web/dist
        },
        ["knife"] = {
            label = 'Melee',
            description = 'Lorem ipsum dolor sit amet consectetur.',
            icon = 'knife.png' -- you can add new image from web/dist
        }
    },

    locale = "en",
    locales = {
        ["en"] = {
            inventoryItemsHeader = "Healing items you have",
            inventoryItemsDesc = "Lorem ipsum dolor sit amet consectetur. Massa enim lobortis risus arcu. Sed enim sollicitudin ac convallis.",
            injuryListHeader = "Combined Injury List",
            injuryListDesc = "Lorem ipsum dolor sit amet consectetur. Massa enim lobortis risus arcu. Sed enim sollicitudin ac convallis.",
            healthStatusHeader = "Status of Health",
            healthStatusDesc = "Lorem ipsum dolor sit amet consectetur. Massa enim lobortis risus arcu. Sed enim sollicitudin ac convallis.",
            youCantAccess = "You cannot access!",
            successfulAction = "You did successful action!",
            healthyBone = "This bone already healthy!",
            lArm = 'Left Arm',
            rArm = 'Right Arm',
            head = 'Head',
            body = 'Body',
            lLeg = 'Left Leg',
            rLeg = 'Right Leg',
            lFoot = 'Left Foot',
            rFoot = 'Right Foot',
            health = 'Health'
        }
    }
}
