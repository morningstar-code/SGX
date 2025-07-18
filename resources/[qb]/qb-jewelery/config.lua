Config = Config or {}

-- Set to true or false or GetConvar('UseTarget', 'false') == 'true' to use global option or script specific
-- These have to be a string thanks to how Convars are returned.
Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'

Config.Timeout = 30 * (60 * 2000)
Config.RequiredCops = 1
Config.JewelleryLocation = {
    ['coords'] = vector3(-630.5, -237.13, 38.08),
}

Config.WhitelistedWeapons = {
    --assualtrifles
    [`weapon_assaultrifle`] = {
        ['timeOut'] = 10000
    },
    [`weapon_assaultrifle_mk2`] = {
        ['timeOut'] = 10000
    },
    [`weapon_carbinerifle`] = {
        ['timeOut'] = 10000
    },
    [`weapon_carbinerifle_mk2`] = {
        ['timeOut'] = 10000
    },
    [`weapon_advancedrifle`] = {
        ['timeOut'] = 10000
    },
    [`weapon_specialcarbine`] = {
        ['timeOut'] = 10000
    },
    [`weapon_bullpuprifle`] = {
        ['timeOut'] = 10000
    },
    [`weapon_compactrifle`] = {
        ['timeOut'] = 10000
    },
    [`weapon_specialcarbine_mk2`] = {
        ['timeOut'] = 10000
    },
    [`weapon_bullpuprifle_mk2`] = {
        ['timeOut'] = 10000
    },
    [`weapon_militaryrifle`] = {
        ['timeOut'] = 10000
    },
    --shotguns
    [`weapon_pumpshotgun`] = {
        ['timeOut'] = 10000
    },
    [`weapon_sawnoffshotgun`] = {
        ['timeOut'] = 10000
    },
    [`weapon_assaultshotgun`] = {
        ['timeOut'] = 10000
    },
    [`weapon_bullpupshotgun`] = {
        ['timeOut'] = 10000
    },
    [`weapon_musket`] = {
        ['timeOut'] = 10000
    },
    [`weapon_heavyshotgun`] = {
        ['timeOut'] = 10000
    },
    [`weapon_dbshotgun`] = {
        ['timeOut'] = 10000
    },
    [`weapon_autoshotgun`] = {
        ['timeOut'] = 10000
    },
    [`weapon_pumpshotgun_mk2`] = {
        ['timeOut'] = 10000
    },
    [`weapon_combatshotgun`] = {
        ['timeOut'] = 10000
    },
    --SMG
    [`weapon_smg`] = {
        ['timeOut'] = 10000
    },
    [`weapon_smg_mk2`] = {
        ['timeOut'] = 10000
    },
    [`weapon_assaultsmg`] = {
        ['timeOut'] = 10000
    },
    [`weapon_combatpdw`] = {
        ['timeOut'] = 10000
    },
    [`weapon_raycarbine`] = {
        ['timeOut'] = 10000
    },
    --LMG
    [`weapon_mg`] = {
        ['timeOut'] = 10000
    },
    [`weapon_combatmg`] = {
        ['timeOut'] = 10000
    },
    [`weapon_gusenberg`] = {
        ['timeOut'] = 10000
    },
    [`weapon_combatmg_mk2`] = {
        ['timeOut'] = 10000
    },
    --Sniper Rifles
    [`weapon_sniperrifle`] = {
        ['timeOut'] = 10000
    },
    [`weapon_heavysniper`] = {
        ['timeOut'] = 10000
    },
    [`weapon_marksmanrifle`] = {
        ['timeOut'] = 10000
    },
    [`weapon_remotesniper`] = {
        ['timeOut'] = 10000
    },
    [`weapon_heavysniper_mk2`] = {
        ['timeOut'] = 10000
    },
    [`weapon_marksmanrifle_mk2`] = {
        ['timeOut'] = 10000
    },
    --Heavy Weapons
    [`weapon_rpg`] = {
        ['timeOut'] = 10000
    },
    [`weapon_grenadelauncher`] = {
        ['timeOut'] = 10000
    },
    [`weapon_grenadelauncher_smoke`] = {
        ['timeOut'] = 10000
    },
    [`weapon_firework`] = {
        ['timeOut'] = 10000
    },
    [`weapon_railgunxm3`] = {
        ['timeOut'] = 10000
    },
    [`weapon_hominglauncher`] = {
        ['timeOut'] = 10000
    },
    [`weapon_compactlauncher`] = {
        ['timeOut'] = 10000
    },
    [`weapon_rayminigun`] = {
        ['timeOut'] = 10000
    },
    --Misc
    [`weapon_petrolcan`] = {
        ['timeOut'] = 10000
    },
    [`weapon_fireextinguisher`] = {
        ['timeOut'] = 10000
    },
    [`weapon_hazardcan`] = {
        ['timeOut'] = 10000
    },
}


Config.VitrineRewards = {
    [1] = {
        ['item'] = 'rolex',
        ['amount'] = {
            ['min'] = 1,
            ['max'] = 4
        },
        ['probability'] = 0.4
    },
    [2] = {
        ['item'] = 'diamond_ring',
        ['amount'] = {
            ['min'] = 1,
            ['max'] = 4
        },
        ['probability'] = 0.3
    },
    [3] = {
        ['item'] = 'goldchain',
        ['amount'] = {
            ['min'] = 1,
            ['max'] = 4
        },
        ['probability'] = 0.2
    },
    [4] = {
        ['item'] = 'tenkgoldchain',
        ['amount'] = {
            ['min'] = 1,
            ['max'] = 4
        },
        ['probability'] = 0.1
    },
}

Config.Locations = {
    [1] = {
        ['coords'] = vector3(-626.83, -235.35, 38.05),
        ['isOpened'] = false,
        ['isBusy'] = false,
    },
    [2] = {
        ['coords'] = vector3(-625.81, -234.7, 38.05),
        ['isOpened'] = false,
        ['isBusy'] = false,
    },
    [3] = {
        ['coords'] = vector3(-626.95, -233.14, 38.05),
        ['isOpened'] = false,
        ['isBusy'] = false,
    },
    [4] = {
        ['coords'] = vector3(-628.0, -233.86, 38.05),
        ['isOpened'] = false,
        ['isBusy'] = false,
    },
    [5] = {
        ['coords'] = vector3(-625.7, -237.8, 38.05),
        ['isOpened'] = false,
        ['isBusy'] = false,
    },
    [6] = {
        ['coords'] = vector3(-626.7, -238.58, 38.05),
        ['isOpened'] = false,
        ['isBusy'] = false,
    },
    [7] = {
        ['coords'] = vector3(-624.55, -231.06, 38.05),
        ['isOpened'] = false,
        ['isBusy'] = false,
    },
    [8] = {
        ['coords'] = vector3(-623.13, -232.94, 38.05),
        ['isOpened'] = false,
        ['isBusy'] = false,
    },
    [9] = {
        ['coords'] = vector3(-620.29, -234.44, 38.05),
        ['isOpened'] = false,
        ['isBusy'] = false,
    },
    [10] = {
        ['coords'] = vector3(-619.15, -233.66, 38.05),
        ['isOpened'] = false,
        ['isBusy'] = false,
    },
    [11] = {
        ['coords'] = vector3(-620.19, -233.44, 38.05),
        ['isOpened'] = false,
        ['isBusy'] = false,
    },
    [12] = {
        ['coords'] = vector3(-617.63, -230.58, 38.05),
        ['isOpened'] = false,
        ['isBusy'] = false,
    },
    [13] = {
        ['coords'] = vector3(-618.33, -229.55, 38.05),
        ['isOpened'] = false,
        ['isBusy'] = false,
    },
    [14] = {
        ['coords'] = vector3(-619.7, -230.33, 38.05),
        ['isOpened'] = false,
        ['isBusy'] = false,
    },
    [15] = {
        ['coords'] = vector3(-620.95, -228.6, 38.05),
        ['isOpened'] = false,
        ['isBusy'] = false,
    },
    [16] = {
        ['coords'] = vector3(-619.79, -227.6, 38.05),
        ['isOpened'] = false,
        ['isBusy'] = false,
    },
    [17] = {
        ['coords'] = vector3(-620.42, -226.6, 38.05),
        ['isOpened'] = false,
        ['isBusy'] = false,
    },
    [18] = {
        ['coords'] = vector3(-623.94, -227.18, 38.05),
        ['isOpened'] = false,
        ['isBusy'] = false,
    },
    [19] = {
        ['coords'] = vector3(-624.91, -227.87, 38.05),
        ['isOpened'] = false,
        ['isBusy'] = false,
    },
    [20] = {
        ['coords'] = vector3(-623.94, -228.05, 38.05),
        ['isOpened'] = false,
        ['isBusy'] = false,
    }
}
