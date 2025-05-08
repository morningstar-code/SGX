Config = {}
Config.Core = "qb" -- qb, esx
Config.UseTextUI = true --only qb target false
Config.Shops = {
    {
        name = "Acces Store",
        label = "24/7",
        type = "normal",
        blip = true,
        blipSprite = 59,
        blipColor = 2,
        blipScale = 0.5,
        categories = {
            [1] = {
                name = "General",
                description = "General",
                items = {
                    {name = "water_bottle", label = "Water", perPrice = 150, description = "Water"},
                    {name = "sandwich", label = "Sandwich", perPrice = 150, description = "Sandwich"},
                    {name = "cigar", label = "Cigar", perPrice = 150, description = "cigar"},
                    {name = "rolling_paper", label = "Rolling Paper", perPrice = 150, description = "Wanna roll something?"},
                    {name = "twerks_candy", label = "Twex", perPrice = 150, description = "twix"},
                    {name = "bandage", label = "Bandage", perPrice = 150, description = "bandage"},
                }
            },
        },
        pedHash = 'mp_m_shopkeep_01',
        scenario = 'WORLD_HUMAN_STAND_MOBILE',
        coords = {
            {ped = nil, coords = vector4(24.47, -1346.62, 29.5, 271.66)},
            {ped = nil, coords = vector4(-3039.54, 584.38, 7.91, 17.27)},
            {ped = nil, coords = vector4(-3242.97, 1000.01, 12.83, 357.57)},
            {ped = nil, coords = vector4(1728.07, 6415.63, 35.04, 242.95)},
            {ped = nil, coords = vector4(1959.82, 3740.48, 32.34, 301.57)},
            {ped = nil, coords = vector4(549.13, 2670.85, 42.16, 99.39)},
            {ped = nil, coords = vector4(2677.47, 3279.76, 55.24, 335.08)},
            {ped = nil, coords = vector4(2556.66, 380.84, 108.62, 356.67)},
            {ped = nil, coords = vector4(372.66, 326.98, 103.57, 253.73)},
        }
    },
    {
        name = "Acces Store",
        label = "Gasoline",
        type = "normal",
        blip = true,
        blipSprite = 59,
        blipColor = 2,
        blipScale = 0.5,
        categories = {
            [1] = {
                name = "General",
                description = "General",
                items = {
                    {name = "water_bottle", label = "Water", perPrice = 150, description = "Water"},
                    {name = "sandwich", label = "Sandwich", perPrice = 150, description = "Sandwich"},
                    {name = "cigar", label = "Cigar", perPrice = 150, description = "cigar"},
                    {name = "rolling_paper", label = "Rolling Paper", perPrice = 150, description = "Wanna roll something?"},
                    {name = "twerks_candy", label = "Twex", perPrice = 150, description = "twix"},
                    {name = "bandage", label = "Bandage", perPrice = 150, description = "bandage"},
                }
            },
        },
        pedHash = 'mp_m_shopkeep_01',
        scenario = 'WORLD_HUMAN_STAND_MOBILE',
        coords = {
            {ped = nil, coords = vector4(-47.02, -1758.23, 29.42, 45.05)},
            {ped = nil, coords = vector4(-706.06, -913.97, 19.22, 88.04)},
            {ped = nil, coords = vector4(-1820.02, 794.03, 138.09, 135.45)},
            {ped = nil, coords = vector4(1164.71, -322.94, 69.21, 101.72)},
            {ped = nil, coords = vector4(1697.87, 4922.96, 42.06, 324.71)},
            {ped = nil, coords = vector4(240.13, -897.61, 29.62, 163.17)},
        }
    },
    {
        name = "Liquor Store ",
        label = "Rob's Liqour",
        type = "normal",
        blip = true,
        blipSprite = 59,
        blipColor = 2,
        blipScale = 0.5,
        categories = {
            [1] = {
                name = "General",
                description = "General",
                items = {
                    {name = "water_bottle", label = "Water", perPrice = 150, description = "Water"},
                    {name = "grapejuice", label = "Sandwich", perPrice = 150, description = "Sandwich"},
                    {name = "wine", label = "Lighter", perPrice = 150, description = "lighter"},
                    {name = "vodka", label = "Rolling Paper", perPrice = 150, description = "Wanna roll something?"},
                    {name = "whiskey", label = "Twex", perPrice = 150, description = "twix"},
                    {name = "beer", label = "Bandage", perPrice = 150, description = "bandage"},
                }
            },
        },
        pedHash = 'ig_omega',
        scenario = 'WORLD_HUMAN_STAND_MOBILE',
        coords = {
            {ped = nil, coords = vector4(-1221.58, -908.15, 12.33, 35.49)},
            {ped = nil, coords = vector4(-1486.59, -377.68, 40.16, 139.51)},
            {ped = nil, coords = vector4(-2966.39, 391.42, 15.04, 87.48)},
            {ped = nil, coords = vector4(1165.17, 2710.88, 38.16, 179.43)},
            {ped = nil, coords = vector4(1134.2, -982.91, 46.42, 277.24)},
        }
    },
    {
        name = "Hardware Store ",
        label = "hardware shop",
        type = "normal",
        blip = true,
        blipSprite = 59,
        blipColor = 2,
        blipScale = 0.5,
        categories = {
            [1] = {
                name = "Hardware store",
                description = "",
                items = {
                    {name = "firework1", label = "Firework1", perPrice = 150, description = "firework1"},
                    {name = "firework2", label = "Firework2", perPrice = 150, description = "firework2"},
                    {name = "firework3", label = "Firework3", perPrice = 150, description = "firework3"},
                    {name = "firework4", label = "Firework4", perPrice = 150, description = "firework4"},
                    {name = "binoculars", label = "Binoculars", perPrice = 150, description = "binoculars"},
                    {name = "diving_gear", label = "Diving Gear", perPrice = 150, description = "Diving Gear"},
                    {name = "diving_fill", label = "Diving Tube", perPrice = 150, description = "Diving Tube"},
                    {name = "parachute", label = "Parachute", perPrice = 150, description = "parachute"},
                    {name = "repairkit", label = "Repairkit", perPrice = 150, description = "repairkit"},
                    {name = "advancedlockpick", label = "Advanced Lockpick", perPrice = 150, description = "advancedlockpick"},
                    {name = "lockpick", label = "Lockpick", perPrice = 150, description = "lockpick"},
                    {name = "screwdriverset", label = "Screwdriverset", perPrice = 150, description = "screwdriverset"},
                    {name = "drill", label = "Drill", perPrice = 150, description = "Wanna Screw Up Something?"},
                    {name = "bag", label = "Bag", perPrice = 150, description = "May I Put In?"},
                    {name = "empty_plastic_bag", label = "Plastic Bag", perPrice = 10, description = "Cheaper Than Condems"},
                }
            },
        },
        pedHash = 'ig_old_man2',
        scenario = 'WORLD_HUMAN_AA_SMOKE',
        coords = {
            {ped = nil, coords = vector4(2747.71, 3472.85, 55.67, 255.08)},
            {ped = nil, coords = vector4(45.68, -1749.04, 29.61, 53.13)},
        }
    },
    {
        name = "Pillbox",
        label = "Pharmacy",
        type = "normal",
        blip = false,
        blipSprite = 59,
        blipColor = 2,
        blipScale = 0.5,
        categories = {
            [1] = {
                name = "General",
                description = "General",
                items = {
                    {name = "water_bottle", label = "Water", perPrice = 150, description = "Water"},
                    {name = "sandwich", label = "Sandwich", perPrice = 150, description = "Sandwich"},
                    {name = "lighter", label = "Lighter", perPrice = 150, description = "lighter"},
                    {name = "cigar", label = "Cigar", perPrice = 150, description = "cigar"},
                    {name = "rolling_paper", label = "Rolling Paper", perPrice = 150, description = "Wanna roll something?"},
                    {name = "twerks_candy", label = "Twex", perPrice = 150, description = "twix"},
                    {name = "bandage", label = "Bandage", perPrice = 150, description = "Bandage"},
                    {name = "walkstick", label = "Walking Stick", perPrice = 150, description = "Walking Stick"},
                }
            },
        },
        pedHash = 's_f_y_scrubs_01',
        scenario = 'WORLD_HUMAN_SMOKING',
        coords = {
            {ped = nil, coords = vector4(324.74, -583.62, 43.27, 160.57)},
        }
    },
    {
        name = "Black",
        label = "Market",
        type = "normal",
        blip = false,
        blipSprite = 59,
        blipColor = 2,
        blipScale = 0.5,
        categories = {
            [1] = {
                name = "BlackMarket",
                description = "Lets Buy Something Illigal",
                items = {
                    {name = "plasmacutter", label = "Plasma Cutter", perPrice = 150, description = "Did U Just Cut My?"},
                    {name = "weapon_stickybomb", label = "C4 Bomb", perPrice = 150, description = "Come On Baby! Blow Me!"},
                    {name = "thermite", label = "Thermite", perPrice = 150, description = "Wanna Melt Something Hot?"},
                    {name = "trojan_usb", label = "Trojan USB", perPrice = 150, description = "USB Full of What?"},
                    {name = "encryptedtablet", label = "Encrypted Tablet", perPrice = 150, description = "lets Watch Something In 4k"},
                    {name = "vpn", label = "Vpn", perPrice = 150, description = "You Can't Trace Me MF!"},
                }
            },
        },
        pedHash = 'cs_chengsr',
        scenario = 'PROP_HUMAN_SEAT_BAR',
        coords = {
            {ped = nil, coords = vector4(-1694.40, 3181.29, -48.25, 23.26)},
        }
    },
    {
        name = "Digitel",
        label = "Den",
        type = "normal",
        blip = false,
        blipSprite = 59,
        blipColor = 2,
        blipScale = 0.5,
        categories = {
            [1] = {
                name = "DigitalDen",
                description = "Lets Get U Some Digital Accesories",
                items = {
                    {name = "laptop", label = "Laptop", perPrice = 150, description = "Incogonito Mode?"},
                    {name = "phone", label = "Phone", perPrice = 150, description = "Tool For Calling Someone"},
                    {name = "realestatetablet", label = "Real Estate Tablet", perPrice = 150, description = "Lets Look For Some Crib"},
                    {name = "radio", label = "Radio", perPrice = 150, description = "Need 77 On Your 20?"},
                    {name = "shitgpu", label = "Shit GPU", perPrice = 150, description = "Sam Ka Purana GPU"},
                    {name = "1050gpu", label = "SGX 1050 GPU", perPrice = 150, description = "Rufi Ka GPU"},
                    {name = "1060gpu", label = "SGX 1060 GPU", perPrice = 150, description = "Hunny Ka GPU"},
                    {name = "1080gpu", label = "SGX 1080 GPU", perPrice = 150, description = "SGX 1080"},
                    {name = "2080gpu", label = "SGX 2080 GPU", perPrice = 150, description = "SGX 2080"},
                    {name = "3060gpu", label = "SGX 3060 GPU", perPrice = 150, description = "Sam Ka New GPU"},
                    {name = "4090gpu", label = "SGX 4090 GPU", perPrice = 150, description = "Hunny Ka Upcoming"},
                    {name = "thermalpast", label = "Thermal Paste", perPrice = 150, description = "Wanna Make GPU Wet?"},
                }
            },
        },
        pedHash = 'a_m_m_soucent_04',
        scenario = 'WORLD_HUMAN_STAND_MOBILE_CLUBHOUSE',
        coords = {
            {ped = nil, coords = vector4(-1531.42, -403.43, 35.64, 223.12)},
        }
    },
    -- {
    --     name = "Job Market",
    --     label = "LSPD Ammunation",
    --     type = "job",
    --     jobName = "police",
    --     blip = false,
    --     categories = {
    --         [1] = {
    --             name = "General",
    --             description = "Choose Items",
    --             items = {
    --                 {name = "radio", label = "radio", perPrice = 150, description = "radio"},
    --                 {name = "signalradar", label = "signalradar", perPrice = 150, description = "signalradar"},
    --                 {name = "armor", label = "Armor", perPrice = 150, description = "Ekipman"},
    --                 {name = "repairkit", label = "repairkit", perPrice = 150, description = "repairkit"},
    --                 {name = "bandage", label = "bandage", perPrice = 150, description = "bandage"},
    --                 {name = "bodycam", label = "bodycam", perPrice = 150, description = "bodycam"},
    --                 {name = "handcuffs", label = "handcuffs", perPrice = 150, description = "handcuffs"},
    --                 {name = "badge", label = "badge", perPrice = 150, description = "badge"},
    --                 {name = "parachute", label = "parachute", perPrice = 150, description = "parachute"},
    --                 {name = "Dashcam", label = "Dashcam", perPrice = 150, description = "Dashcam"},
    --                 {name = "diving_gear", label = "Divinggear", perPrice = 150, description = "Divinggear"},
    --             }
    --         },
    --         [2] = {
    --             name = "Weapons",
    --             description = "You Need To Be Ready In The Field",
    --             items = {
    --                 {name = "weapon_heavypistol", label = "Weapon", perPrice = 150, description = "Weapon"},
    --                 {name = "weapon_stungun", label = "Weapon", perPrice = 150, description = "Weapon"},
    --             }
    --         },
    --         [3] = {
    --             name = "Ammo",
    --             description = "Very Important For Weapon",
    --             items = {
    --                 {name = "pistol_ammo", label = "Ammo", perPrice = 150, description = "Ammo"},
    --             }
    --         },
    --     },
    --     pedHash = 'ig_andreas',
    --     scenario = 'WORLD_HUMAN_STAND_MOBILE',
    --     coords = {
    --         {ped = nil, coords = vector4(482.45, -995.24, 30.69, 175.18)}
    --     }
    -- },

}