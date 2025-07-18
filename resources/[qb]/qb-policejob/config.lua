Config = {}

Config.Objects = {
    ["cone"] = {model = `prop_roadcone01a`, freeze = false},
    ["barrier"] = {model = `prop_barrier_work05`, freeze = true},
    ["roadsign"] = {model = `prop_snow_sign_road_01a`, freeze = true},
    ["tent"] = {model = `prop_skid_tent_01`, freeze = true},
    ["light"] = {model = `prop_worklight_02a`, freeze = true},
}

Config.MaxSpikes = 5

Config.HandCuffItem = 'handcuffs'
Config.CuffKeyItem = "cuffkeys"
Config.TieItem = 'ziptie'
Config.CutTieItem = 'flush_cutter'
Config.CutCuffItem = 'bolt_cutter'
Config.BrokenCuffItem = 'broken_handcuffs'
Config.BreakOutCuffing = {active = true, duration = math.random(2500,5000), pos = math.random(10, 30), width = math.random(10, 20)}
Config.BreakoutMinigame = 'sgx-repairkit' -- Choose the cuff breakout minigame : qb-skillbar / ps-ui (circle) / sgx-repairkit
Config.PSUIConfig = {numcircle = 2, ms = 20} -- If minigame is ps-ui then choose number of circles and ms 
Config.OXLibConfig = {difficulty = 'medium', inputs = {'w', 'a', 's', 'd'}} -- If minigame is ox_lib then choose difficulty and input characters
Config.TargetSystem = 'qb-target' -- Target system you want to use : qb-target / qtarget / ox_target
Config.ContextSystem = 'qb-menu' -- Menu system you want to use : qb-menu / ox_lib
Config.DrawText = {sys = 'qb-core', position = 'left'} -- Drawtext system you want to use : qb-core / ox_lib  and position of the drawtext
Config.ProgressBar = 'progressbar' -- Progressbar system : progressbar / ox_lib
Config.Inventory = 'qb-inventory' -- Inventory system : qb-inventory / new-qb-inventory / ps-inventory / ox_inventory 
Config.StashSettings = {maxweight = 4000000, slots = 30,} -- Stash settings for qb / ps inventory
Config.Debug = false -- Enable / Disable debugpoly 
Config.CuffCooldown = 5 -- Sets a cooldown for cuffing, prevents cuff spamming
Config.DisableSprintJump = true -- Disables jumping and running while escorting a player
Config.AlcoholTesterName = "alcoholtester" -- Name of the alcohol tester item
Config.AlcoholReleaseInterval = {min = 5, promille = 0.02} -- Interval time in minutes to release alcohol per given promille
Config.EnableVersionCheck = false -- Enable or disable the version checking from github
Config.OwnedPoliceCars = true -- Do you want the spawned police cars to be owned ?

-- itemname = name of the item
-- propname = the prop used for cuffing
-- needkey = does the cuff needs a key to uncuff ? It will give a key when true
-- keyitem = what is the item used to uncuff
-- cufftype = the animation type. 19 - ped is freezed / 49 - ped can move with cuffs
Config.CuffItems = {
    ['handcuffs'] = {itemname = "handcuffs", propname = "p_cs_cuffs_02_s", needkey = true, keyitem = "cuffkeys", cufftype = 19 },
    ['ziptie'] = {itemname = "ziptie", propname = "ba_prop_battle_cuffs", needkey = false, keyitem = "flush_cutter", cufftype = 49}
}

Config.BlipColors = {
    ['police'] = 29, -- Dark Blue
    ['bcso'] = 47, -- Orange
    ['sahp'] = 2, -- Green
    ['ambulance'] = 1 -- Red
}

Config.FuelScript = 'sgx-fuel'
Config.LicenseRank = 2
Config.BlockWallThermals = true -- true/false; lowers thermal cam intensity to stop penetration through walls or tunnels
Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'
Config.GaragePedModel = "s_m_y_hwaycop_01"
Config.Locations = {
    ["duty"] = {
        [1] = vector3(441.60, -982.00, 30.75), -- LSPD
        [2] = vector3(-448.20, 6013.40, 32.19), -- BCSO
        [3] = vector3(1829.81, 3682.59, 34.12), -- Sandy
    },
    ["vehicle"] = {
        [1] = vector4(460.59, -975.75, 25.7, 89.19), -- LSPD
        [2] = vector4(-461.25, 6027.38, 31.49, 137.44), --BCSO
        [3] = vector4(1850.61, 3698.35, 34.17, 299.32), -- Sandy
    },
    ["vehspawn"] = { -- The numbers [1] must match the numbers in [vehicle]
        [1] = vector4(450.42, -976.09, 25.06, 89.25), -- LSPD
        [2] = vector4(-454.63, 6041.09, 30.7, 136.02), -- BCSO
        [3] = vector4(1859.93, 3704.46, 33.09, 118.33), -- Sandy
    },
    ["stash"] = {
        [1] = vector3(461.81, -995.50, 30.69), -- LSPD
        [2] = vector3(-438.50, 6010.5, 37.0), -- BCSO
        [3] = vector3(1838.01, 3679.51, 38.33), -- Sandy
    },
    ["impound"] = {
        [1] = vector3(463.65, -1018.12, 28.09),-- LSPD
        [2] = vector3(-483.5, 6025.51, 31.34),-- BCSO
        [3] = vector3(1866.86, 3694.28, 33.73),-- Sandy
    },
    ["helicopter"] = {
        [1] = vector4(456.48, -976.54, 43.69, 95.0), -- LSPD
        [2] = vector4(-462.15, 5994.77, 31.25, 134.84), -- BCSO
        [3] = vector4(1835.82, 3676.54, 38.93, 110.6), -- Sandy
    },
    ["helispawn"] = { -- The numbers [1] must match the numbers in [helicopter]
        [1] = vector4(449.22, -981.12, 43.69, 89.12), -- LSPD
        [2] = vector4(-475.18, 5988.43, 31.72, 317.27), -- BCSO
        [3] = vector4(1833.57, 3669.0, 38.93, 32.35), -- Sandy
    },
    ["armory"] = {
        [1] = vector3(482.51, -995.62, 30.69), -- LSPD
        [2] = vector3(-447.45, 6016.9, 36.8), -- BCSO
        [3] = vector3(1836.60, 3682.00, 38.93), -- Sandy
    },
    ["trash"] = {
        [1] = vector3(440.15, -978.25, 30.00), -- LSPD
        [2] = vector3(-447.99, 6012.25, 31.3), -- BCSO
        [3] = vector3(1849.93, 3675.4, 38.93), -- Sandy
    },
    ["fingerprint"] = {
        [1] = vector3(474.63, -1013.99, 26.18), -- LSPD
    },
    ["evidence"] = {
        [1] = vector3(480.82, -990.34, 30.69), -- LSPD
        [2] = vector3(-446.91, 6018.66, 32.29), -- BCSO
        [3] = vector3(1846.5, 3690.56, 34.33), -- Sandy
    },
    ["labs"] = {
        [1] = vector3(483.57, -988.59, 30.69), -- LSPD
    },
    ["stations"] = {
        [1] = {label = "Los Santos Police Department", coords = vector4(428.23, -984.28, 29.76, 3.5), sprite= 137, scale= 0.7, colour= 29},
        [2] = {label = "Sandy Shores Sheriffs Office", coords = vector4(1836.1, 3683.0, 34.37, 115.97), sprite= 137, scale= 0.7, colour= 1},
        [3] = {label = "Blaine County Sheriffs Office", coords = vector4(-448.26, 6007.83, 44.01, 225.93), sprite= 137, scale= 0.7, colour= 47},
    },
}

Config.RepairStations = {
    enabled = false,
    withanim = false,
    locations = {
        [1] = {
            jobtype = 'leo', -- jobtype that can use this station or public to be used by everyone 
            pedhash = 's_m_m_fibsec_01', -- ped hash to be used as repair guy
            pedloc = vector4(480.39, -996.65, 30.69, 87.97), -- location where the ped will be spawned
            walkto = vector4(487.31, -996.93, 30.69, 274.41), -- location where the ped will walk to repair
        },
        [2] = {
            jobtype = 'public', -- jobtype that can use this station or public to be used by everyone 
            pedhash = 'u_m_y_gunvend_01', -- ped hash to be used as repair guy
            pedloc = vector4(16.37, -1111.51, 29.8, 254.8), -- location where the ped will be spawned
            walkto = vector4(15.32, -1105.86, 29.8, 215.82), -- location where the ped will walk to repair
        }
    }
}

Config.PoliceHelicopters = {
    -- Garage 1 helis (LSPD)
    [1] = {
        ['polmav'] =  {label = "Police Maverick", ranks = {1,2,3,4,5,6,7,8,9,10,11}, livery = 0, price = 00},
        ['buzzard2'] = {label = "Buzzard", ranks = {1,2,3,4,5,6,7,8,9,10,11}, livery = 1, price = 0},
    },
     -- Garage 2 helis (BCSO)
    [2] = {
        ['polmav'] =  {label = "Police Maverick", ranks = {1,2,3,4,5,6,7,8,9,10,11}, livery = 0, price = 00},
        ['buzzard2'] = {label = "Buzzard", ranks = {1,2,3,4,5,6,7,8,9,10,11}, livery = 1, price = 0},
    },
    -- Garage 2 helis (SAHP)
    [3] = {
        ['polmav'] =  {label = "Police Maverick", ranks = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}, livery = 0, price = 0},
        ['buzzard2'] = {label = "Buzzard", ranks = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}, livery = 1, price = 0},
    }
}

Config.SecurityCameras = {
    hideradar = false,
    cameras = {
        [1] = {label = "Pacific Bank CAM#1", coords = vector3(257.45, 210.07, 109.08), r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = false, isOnline = true},
        [2] = {label = "Pacific Bank CAM#2", coords = vector3(232.86, 221.46, 107.83), r = {x = -25.0, y = 0.0, z = -140.91}, canRotate = false, isOnline = true},
        [3] = {label = "Pacific Bank CAM#3", coords = vector3(252.27, 225.52, 103.99), r = {x = -35.0, y = 0.0, z = -74.87}, canRotate = false, isOnline = true},
        [4] = {label = "Limited Ltd Grove St. CAM#1", coords = vector3(-53.1433, -1746.714, 31.546), r = {x = -35.0, y = 0.0, z = -168.9182}, canRotate = false, isOnline = true},
        [5] = {label = "Rob's Liqour Prosperity St. CAM#1", coords = vector3(-1482.9, -380.463, 42.363), r = {x = -35.0, y = 0.0, z = 79.53281}, canRotate = false, isOnline = true},
        [6] = {label = "Rob's Liqour San Andreas Ave. CAM#1", coords = vector3(-1224.874, -911.094, 14.401), r = {x = -35.0, y = 0.0, z = -6.778894}, canRotate = false, isOnline = true},
        [7] = {label = "Limited Ltd Ginger St. CAM#1", coords = vector3(-718.153, -909.211, 21.49), r = {x = -35.0, y = 0.0, z = -137.1431}, canRotate = false, isOnline = true},
        [8] = {label = "24/7 Supermarkt Innocence Blvd. CAM#1", coords = vector3(23.885, -1342.441, 31.672), r = {x = -35.0, y = 0.0, z = -142.9191}, canRotate = false, isOnline = true},
        [9] = {label = "Rob's Liqour El Rancho Blvd. CAM#1", coords = vector3(1133.024, -978.712, 48.515), r = {x = -35.0, y = 0.0, z = -137.302}, canRotate = false, isOnline = true},
        [10] = {label = "Limited Ltd West Mirror Drive CAM#1", coords = vector3(1151.93, -320.389, 71.33), r = {x = -35.0, y = 0.0, z = -119.4468}, canRotate = false, isOnline = true},
        [11] = {label = "24/7 Supermarkt Clinton Ave CAM#1", coords = vector3(383.402, 328.915, 105.541), r = {x = -35.0, y = 0.0, z = 118.585}, canRotate = false, isOnline = true},
        [12] = {label = "Limited Ltd Banham Canyon Dr CAM#1", coords = vector3(-1832.057, 789.389, 140.436), r = {x = -35.0, y = 0.0, z = -91.481}, canRotate = false, isOnline = true},
        [13] = {label = "Rob's Liqour Great Ocean Hwy CAM#1", coords = vector3(-2966.15, 387.067, 17.393), r = {x = -35.0, y = 0.0, z = 32.92229}, canRotate = false, isOnline = true},
        [14] = {label = "24/7 Supermarkt Ineseno Road CAM#1", coords = vector3(-3046.749, 592.491, 9.808), r = {x = -35.0, y = 0.0, z = -116.673}, canRotate = false, isOnline = true},
        [15] = {label = "24/7 Supermarkt Barbareno Rd. CAM#1", coords = vector3(-3246.489, 1010.408, 14.705), r = {x = -35.0, y = 0.0, z = -135.2151}, canRotate = false, isOnline = true},
        [16] = {label = "24/7 Supermarkt Route 68 CAM#1", coords = vector3(539.773, 2664.904, 44.056), r = {x = -35.0, y = 0.0, z = -42.947}, canRotate = false, isOnline = true},
        [17] = {label = "Rob's Liqour Route 68 CAM#1", coords = vector3(1169.855, 2711.493, 40.432), r = {x = -35.0, y = 0.0, z = 127.17}, canRotate = false, isOnline = true},
        [18] = {label = "24/7 Supermarkt Senora Fwy CAM#1", coords = vector3(2673.579, 3281.265, 57.541), r = {x = -35.0, y = 0.0, z = -80.242}, canRotate = false, isOnline = true},
        [19] = {label = "24/7 Supermarkt Alhambra Dr. CAM#1", coords = vector3(1966.24, 3749.545, 34.143), r = {x = -35.0, y = 0.0, z = 163.065}, canRotate = false, isOnline = true},
        [20] = {label = "24/7 Supermarkt Senora Fwy CAM#2", coords = vector3(1729.522, 6419.87, 37.262), r = {x = -35.0, y = 0.0, z = -160.089}, canRotate = false, isOnline = true},
        [21] = {label = "Fleeca Bank Hawick Ave CAM#1", coords = vector3(309.341, -281.439, 55.88), r = {x = -35.0, y = 0.0, z = -146.1595}, canRotate = false, isOnline = true},
        [22] = {label = "Fleeca Bank Legion Square CAM#1", coords = vector3(144.871, -1043.044, 31.017), r = {x = -35.0, y = 0.0, z = -143.9796}, canRotate = false, isOnline = true},
        [23] = {label = "Fleeca Bank Hawick Ave CAM#2", coords = vector3(-355.7643, -52.506, 50.746), r = {x = -35.0, y = 0.0, z = -143.8711}, canRotate = false, isOnline = true},
        [24] = {label = "Fleeca Bank Del Perro Blvd CAM#1", coords = vector3(-1214.226, -335.86, 39.515), r = {x = -35.0, y = 0.0, z = -97.862}, canRotate = false, isOnline = true},
        [25] = {label = "Fleeca Bank Great Ocean Hwy CAM#1", coords = vector3(-2958.885, 478.983, 17.406), r = {x = -35.0, y = 0.0, z = -34.69595}, canRotate = false, isOnline = true},
        [26] = {label = "Paleto Bank CAM#1", coords = vector3(-102.939, 6467.668, 33.424), r = {x = -35.0, y = 0.0, z = 24.66}, canRotate = false, isOnline = true},
        [27] = {label = "Del Vecchio Liquor Paleto Bay", coords = vector3(-163.75, 6323.45, 33.424), r = {x = -35.0, y = 0.0, z = 260.00}, canRotate = false, isOnline = true},
        [28] = {label = "Don's Country Store Paleto Bay CAM#1", coords = vector3(166.42, 6634.4, 33.69), r = {x = -35.0, y = 0.0, z = 32.00}, canRotate = false, isOnline = true},
        [29] = {label = "Don's Country Store Paleto Bay CAM#2", coords = vector3(163.74, 6644.34, 33.69), r = {x = -35.0, y = 0.0, z = 168.00}, canRotate = false, isOnline = true},
        [30] = {label = "Don's Country Store Paleto Bay CAM#3", coords = vector3(169.54, 6640.89, 33.69), r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = false, isOnline = true},
        [31] = {label = "Vangelico Jewelery CAM#1", coords = vector3(-627.54, -239.74, 40.33), r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true},
        [32] = {label = "Vangelico Jewelery CAM#2", coords = vector3(-627.51, -229.51, 40.24), r = {x = -35.0, y = 0.0, z = -95.78}, canRotate = true, isOnline = true},
        [33] = {label = "Vangelico Jewelery CAM#3", coords = vector3(-620.3, -224.31, 40.23), r = {x = -35.0, y = 0.0, z = 165.78}, canRotate = true, isOnline = true},
        [34] = {label = "Vangelico Jewelery CAM#4", coords = vector3(-622.57, -236.3, 40.31), r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true},
    },
}
Config.EnableMods = true -- Enable the mods below to be applied
Config.CarMods = { -- Mods to be enabled / disabled for vehicles
    engine = true,
    brakes = true,
    gearbox = true,
    armour = false,
    turbo = true,
}
Config.EnableExtras = true
Config.CarExtras = { -- Extra options to be enabled / disabled
    ["extras"] = {
        ["1"] = true, -- on/off
        ["2"] = true,
        ["3"] = true,
        ["4"] = true,
        ["5"] = true,
        ["6"] = true,
        ["7"] = true,
        ["8"] = true,
        ["9"] = true,
        ["10"] = true,
        ["11"] = true,
        ["12"] = true,
        ["13"] = true,
    }
}
Config.AuthorizedVehicles = {
    -- Garage 1 vehicles (LSPD)
    [1] = {
        ["police"] = {label = "Police Car 1", ranks = {1,2,3,4,5,6,7,8,9,10,11}, livery = 2, price = 10},
        ["police2"] = {label = "Police Car 2", ranks = {1,2,3,4,5,6,7,8,9,10,11}, livery = 2, price = 10},
        ["police3"] = {label = "Police Car 3", ranks = {1,2,3,4,5,6,7,8,9,10,11}, livery = 2, price = 10},
        ["police4"] = {label = "Police Car 4", ranks = {1,2,3,4,5,6,7,8,9,10,11}, livery = 2, price = 10},
        ["policeb"] = {label = "Police Car 5", ranks = {1,2,3,4,5,6,7,8,9,10,11}, livery = 2, price = 10},
        ["policet"] = {label = "Police Car 6", ranks = {1,2,3,4,5,6,7,8,9,10,11}, livery = 2, price = 10},
        ["fbi"] = {label = "Unmarked FBI", ranks = {1,2,3,4,5,6,7,8,9,10,11}, livery = 2, price = 15},
        ["fbi2"] = {label = "Unmarked FBI2", ranks = {1,2,3,4,5,6,7,8,9,10,11}, livery = 2, price = 10},
    },
    -- Garage 2 vehicles (BCSO)
    [2] = {
        ["sheriff"] = {label = "Sheriff Car 1", ranks = {1,2}, livery = 1, price = 10},
        ["sheriff2"] = {label = "Sheriff Car 2", ranks = {2,3,4}, livery = 1, price = 10},
        ["fbi"] = {label = "Unmarked FBI", ranks = {3,4}, livery = 1, price = 10},
        ["fbi2"] = {label = "Unmarked FBI2", ranks = {3,4}, livery = 1, price = 10},
    },
    -- Garage 1 vehicles (Sandy)
    [3] = {
        ["sheriff"] = {label = "Sheriff Car 1", ranks = {1,2}, livery = 1, price = 10},
        ["sheriff2"] = {label = "Sheriff Car 2", ranks = {2,3,4}, livery = 1, price = 10},
        ["fbi"] = {label = "Unmarked FBI", ranks = {3,4}, livery = 1, price = 10},
        ["fbi2"] = {label = "Unmarked FBI2", ranks = {3,4}, livery = 1, price = 10},
    },
}

Config.AmmoLabels = {
    ["AMMO_PISTOL"] = "9x19mm parabellum bullet",
    ["AMMO_SMG"] = "9x19mm parabellum bullet",
    ["AMMO_RIFLE"] = "7.62x39mm bullet",
    ["AMMO_MG"] = "7.92x57mm mauser bullet",
    ["AMMO_SHOTGUN"] = "12-gauge bullet",
    ["AMMO_SNIPER"] = "Large caliber bullet",
}

Config.Radars = {
    vector4(-623.44421386719, -823.08361816406, 25.25704574585, 145.0),
    vector4(-652.44421386719, -854.08361816406, 24.55704574585, 325.0),
    vector4(1623.0114746094, 1068.9924316406, 80.903594970703, 84.0),
    vector4(-2604.8994140625, 2996.3391113281, 27.528566360474, 175.0),
    vector4(2136.65234375, -591.81469726563, 94.272926330566, 318.0),
    vector4(2117.5764160156, -558.51013183594, 95.683128356934, 158.0),
    vector4(406.89505004883, -969.06286621094, 29.436267852783, 33.0),
    vector4(657.315, -218.819, 44.06, 320.0),
    vector4(2118.287, 6040.027, 50.928, 172.0),
    vector4(-106.304, -1127.5530, 30.778, 230.0),
    vector4(-823.3688, -1146.980, 8.0, 300.0),
}

Config.CarItems = {
    [1] = {name = "heavyarmor", amount = 2, info = {}, type = "item", slot = 1,},
    [2] = {name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 2,},
    [3] = {name = "police_stormram", amount = 1, info = {}, type = "item", slot = 3,},
}

Config.QuickEquip = false -- Set this to true if you want to give certain items automatically and configure the quick = {} part on each item
Config.Items = {
    label = "Police Armory",
    slots = 30,
    items = {
        [1] = {
            name = "weapon_pistol",
            price = 0,
            amount = 1,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_PI_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 1,
            authorizedJobGrades = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15},
            quick = {equip = true, amount = 1}
        },
        [2] = {
            name = "weapon_stungun",
            price = 0,
            amount = 1,
            info = {
                serie = "",
            },
            type = "weapon",
            slot = 2,
            authorizedJobGrades = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15},
            quick = {equip = true, amount = 1}
        },
        [3] = {
            name = "weapon_pumpshotgun",
            price = 0,
            amount = 1,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 3,
            authorizedJobGrades = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15},
            quick = {equip = false, amount = 1}
        },
        [4] = {
            name = "weapon_smg",
            price = 0,
            amount = 1,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_SCOPE_MACRO_02", label = "1x Scope"},
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 4,
            authorizedJobGrades = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15},
            quick = {equip = false, amount = 1}
        },
        [5] = {
            name = "weapon_carbinerifle",
            price = 0,
            amount = 1,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                    {component = "COMPONENT_AT_SCOPE_MEDIUM", label = "3x Scope"},
                }
            },
            type = "weapon",
            slot = 5,
            authorizedJobGrades = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15},
            quick = {equip = false, amount = 1}
        },
        [6] = {
            name = "weapon_nightstick",
            price = 0,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 6,
            authorizedJobGrades = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15},
            quick = {equip = true, amount = 1}
        },
        [7] = {
            name = "pistol_ammo",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 7,
            authorizedJobGrades = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15},
            quick = {equip = true, amount = 5}
        },
        [8] = {
            name = "smg_ammo",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 8,
            authorizedJobGrades = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15},
            quick = {equip = false, amount = 1}
        },
        [9] = {
            name = "shotgun_ammo",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 9,
            authorizedJobGrades = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15},
            quick = {equip = false, amount = 1}
        },
        [10] = {
            name = "rifle_ammo",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 10,
            authorizedJobGrades = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15},
            quick = {equip = false, amount = 1}
        },
        [11] = {
            name = "handcuffs",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 11,
            authorizedJobGrades = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15},
            quick = {equip = true, amount = 1}
        },
        [12] = {
            name = "weapon_flashlight",
            price = 0,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 12,
            authorizedJobGrades = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15},
            quick = {equip = true, amount = 1}
        },
        [13] = {
            name = "empty_evidence_bag",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 13,
            authorizedJobGrades = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15},
            quick = {equip = false, amount = 1}
        },
        [14] = {
            name = "police_stormram",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 14,
            authorizedJobGrades = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15},
            quick = {equip = false, amount = 1}
        },
        [15] = {
            name = "armor",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 15,
            authorizedJobGrades = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15},
            quick = {equip = true, amount = 1}
        },
        [16] = {
            name = "radio",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 16,
            authorizedJobGrades = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15},
            quick = {equip = true, amount = 1}
        },
        [17] = {
            name = "heavyarmor",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 17,
            authorizedJobGrades = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15},
            quick = {equip = false, amount = 1}
        },
        [18] = {
            name = "alcoholtester",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 18,
            authorizedJobGrades = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15},
            quick = {equip = true, amount = 1}
        }
    }
}
