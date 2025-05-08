Config = {}

Config.Resupply = {
    enable = true,
    amount = 10, -- Amount of ingredients that get added every x minutes in the druglabs.
    time = 60 -- In minutes
}

Config.Labs = {
    ["darkroom"] = {
        entrance = vector4(-575.0474, -939.968, 23.861368, 186.95602),
        exit = vector4(-581.3051, -937.2222, 14.240921, 96.255409),
        locked = true,
        tasks = {
            [1] = {
                busy = false,
                completed = false,
                started = false,
                ingredients = {
                    current = 0,
                    needed = 8
                },
                temperature = 30,
                timeremaining = 180,
                duration = 180
            },
            [2] = {
                busy = false,
                completed = false,
                started = false,
                ingredients = {
                    current = 0,
                    needed = 4,
                },
                temperature = 80,
                timeremaining = 120,
                duration = 120
            },
            [3] = {
                busy = false,
                completed = false,
                started = false,
                ingredients = {
                    current = 0,
                    needed = 6
                },
                temperature = 20,
                timeremaining = 60,
                duration = 60
            }, 
        },
        ingredients = {
            stock = 0,
            taken = false,
            busy = false
        },
        curing = {
            busy = false,
            started = false,
            completed = false,
            timeremaining = 480,
            duration = 480,
            purity = nil,
            batchItem = 'meth_batch',
            curedItem = 'meth_cured'
        }
    },
    ["methlab"] = {
        entrance = vector4(3309.9833, 5189.9536, 19.428356, 227.8337),
        exit = vector4(996.61, -3200.65, -36.4, 90.0),
        locked = true,
        tasks = {
            [1] = {
                busy = false,
                completed = false,
                started = false,
                ingredients = {
                    current = 0,
                    needed = 8
                },
                temperature = 30,
                timeremaining = 180,
                duration = 180
            },
            [2] = {
                busy = false,
                completed = false,
                started = false,
                ingredients = {
                    current = 0,
                    needed = 4,
                },
                temperature = 80,
                timeremaining = 120,
                duration = 120
            },
            [3] = {
                busy = false,
                completed = false,
                started = false,
                ingredients = {
                    current = 0,
                    needed = 6
                },
                temperature = 20,
                timeremaining = 60,
                duration = 60
            }, 
        },
        ingredients = {
            stock = 0,
            taken = false,
            busy = false
        },
        curing = {
            busy = false,
            started = false,
            completed = false,
            timeremaining = 480,
            duration = 480,
            purity = nil,
            batchItem = 'meth_batch',
            curedItem = 'meth_cured'
        }
    },
    ["methlab2"] = {
        entrance = vector4(1233.82, 1876.07, 78.97, 220.6),
        exit = vector4(969.08, -147.09, -46.4, 269.95),
        locked = true,
        tasks = {
            [1] = {
                busy = false,
                completed = false,
                started = false,
                ingredients = {
                    current = 0,
                    needed = 8
                },
                temperature = 30,
                timeremaining = 180,
                duration = 180
            },
            [2] = {
                busy = false,
                completed = false,
                started = false,
                ingredients = {
                    current = 0,
                    needed = 4,
                },
                temperature = 80,
                timeremaining = 120,
                duration = 120
            },
            [3] = {
                busy = false,
                completed = false,
                started = false,
                ingredients = {
                    current = 0,
                    needed = 6
                },
                temperature = 20,
                timeremaining = 60,
                duration = 60
            }, 
        },
        ingredients = {
            stock = 0,
            taken = false,
            busy = false
        },
        curing = {
            busy = false,
            started = false,
            completed = false,
            timeremaining = 480,
            duration = 480,
            purity = nil,
            batchItem = 'meth_batch',
            curedItem = 'meth_cured'
        }
    },
    ["cokelab"] = {
        entrance = vector4(-443.4014, 5602.0903, 68.088783, 359.96429),
        exit = vector4(1088.7, -3187.5, -38.99, 180.00),
        locked = true,
        tasks = {
            [1] = {
                busy = false,
                completed = false,
                started = false,
                ingredients = {
                    current = 0,
                    needed = 8
                },
                temperature = 30,
                timeremaining = 180,
                duration = 180
            },
            [2] = {
                busy = false,
                completed = false,
                started = false,
                ingredients = {
                    current = 0,
                    needed = 4,
                },
                temperature = 80,
                timeremaining = 120,
                duration = 120
            },
            [3] = {
                busy = false,
                completed = false,
                started = false,
                ingredients = {
                    current = 0,
                    needed = 6
                },
                temperature = 20,
                timeremaining = 60,
                duration = 60
            }, 
        },
        ingredients = {
            stock = 0,
            taken = false,
            busy = false
        },
        curing = {
            busy = false,
            started = false,
            completed = false,
            timeremaining = 480,
            duration = 480,
            purity = nil,
            batchItem = 'coke_batch',
            curedItem = 'coke_cured'
        }
    },
    ["weedlab"] = {
        entrance = vector4(-1001.36, 4847.2548, 275.01309, 175.50195),
        exit = vector4(1066.39, -3183.5, -39.16, 90.00),
        locked = true,
        tasks = {
            [1] = {
                busy = false,
                completed = false,
                started = false,
                ingredients = {
                    current = 0,
                    needed = 8
                },
                temperature = 30,
                timeremaining = 180,
                duration = 180
            },
            [2] = {
                busy = false,
                completed = false,
                started = false,
                ingredients = {
                    current = 0,
                    needed = 4,
                },
                temperature = 80,
                timeremaining = 120,
                duration = 120
            },
            [3] = {
                busy = false,
                completed = false,
                started = false,
                ingredients = {
                    current = 0,
                    needed = 6
                },
                temperature = 20,
                timeremaining = 60,
                duration = 60
            }, 
        },
        ingredients = {
            stock = 0,
            taken = false,
            busy = false
        },
        curing = {
            busy = false,
            started = false,
            completed = false,
            timeremaining = 480,
            duration = 480,
            purity = nil,
            batchItem = 'weed_cured',
            curedItem = 'weed_cured'
        }
    },
    ["moneywash"] = {
        entrance = vector4(206.65, -1851.5, 27.48, 320.00),
        exit = vector4(1138.04, -3199.44, -39.67, 180.00),
        locked = true,
        maxBags = 5,
        washers = {
            [1] = {
                coords = vector3(1122.373291, -3193.474365, -40.403080),
                busy = false,
                started = false,
                completed = false,
                duration = 180,
                moneybags = 0,
                worth = 0
            },
            [2] = {
                coords = vector3(1123.7697, -3193.351318, -40.403080),
                busy = false,
                started = false,
                completed = false,
                duration = 180,
                moneybags = 0,
                worth = 0
            },
            [3] = {
                coords = vector3(1125.5155, -3193.314209, -40.403080),
                busy = false,
                started = false,
                completed = false,
                duration = 180,
                moneybags = 0,
                worth = 0
            },
            [4] = {
                coords = vector3(1126.9450, -3193.314, -40.403080),
                busy = false,
                started = false,
                completed = false,
                duration = 180,
                moneybags = 0,
                worth = 0
            }
        }
    },
    ["gunbunker"] = {
        entrance = vector4(-354.16, 4825.45, 144.29, 320.00),
        exit = vector4(903.19659, -3182.285, -97.05294, 90.00),
        locked = true,
        key = "gunkey",
        locations = {
            ammo = vector3(905.89, -3231.37, -98.42),
            pistol = vector3(908.6, -3210.18, -98.45),
            smg = vector3(896.08, -3217.17, -98.07),
            rifle = vector3(835.04, -3245.6, -98.9),
            weaponstash = vector3(892.16, -3228.9, -98.14)
        }
    }
}

Config.CraftingCost = {
    ['pistol'] = {
        [1] = {
            label = 'SNS Pistol',
            item = 'weapon_snspistol',
            items = {
                [1] = {
                    item = 'plastic',
                    amount = 30
                },
                [2] = {
                    item = 'steel',
                    amount = 40
                },
                [3] = {
                    item = 'aluminum',
                    amount = 55
                }
            }
        },
        [2] = {
            label = 'Vintage Pistol',
            item = 'weapon_vintagepistol',
            items = {
                [1] = {
                    item = 'plastic',
                    amount = 50
                },
                [2] = {
                    item = 'iron',
                    amount = 50
                },
                [3] = {
                    item = 'aluminum',
                    amount = 50
                }
            }
        },
        [3] = {
            label = 'Pistol',
            item = 'weapon_pistol',
            items = {
                [1] = {
                    item = 'plastic',
                    amount = 55
                },
                [2] = {
                    item = 'iron',
                    amount = 65
                },
                [3] = {
                    item = 'aluminum',
                    amount = 60
                }
            }
        },
        [4] = {
            label = 'Heavy Pistol',
            item = 'weapon_heavypistol',
            items = {
                [1] = {
                    item = 'plastic',
                    amount = 65
                },
                [2] = {
                    item = 'steel',
                    amount = 80
                },
                [3] = {
                    item = 'aluminum',
                    amount = 60
                }
            }
        },
        [5] = {
            label = 'Pistol .50',
            item = 'weapon_pistol50',
            items = {
                [1] = {
                    item = 'plastic',
                    amount = 75
                },
                [2] = {
                    item = 'steel',
                    amount = 95
                },
                [3] = {
                    item = 'iron',
                    amount = 70
                }
            }
        },
    },
    ['smg'] = {
        [1] = {
            label = 'Micro SMG',
            item = 'weapon_microsmg',
            items = {
                [1] = {
                    item = 'aluminum',
                    amount = 85
                },
                [2] = {
                    item = 'glass',
                    amount = 200
                },
                [3] = {
                    item = 'rubber',
                    amount = 155
                }
            }
        },
        [2] = {
            label = 'Assault SMG',
            item = 'weapon_assaultsmg',
            items = {
                [1] = {
                    item = 'aluminum',
                    amount = 195
                },
                [2] = {
                    item = 'glass',
                    amount = 235
                },
                [3] = {
                    item = 'rubber',
                    amount = 110
                }
            }
        },
        [3] = {
            label = 'Mini SMG',
            item = 'weapon_minismg',
            items = {
                [1] = {
                    item = 'aluminum',
                    amount = 155
                },
                [2] = {
                    item = 'glass',
                    amount = 200
                },
                [3] = {
                    item = 'rubber',
                    amount = 85
                }
            }
        },
        [4] = {
            label = 'Machine Pistol',
            item = 'weapon_machinepistol',
            items = {
                [1] = {
                    item = 'aluminum',
                    amount = 70
                },
                [2] = {
                    item = 'glass',
                    amount = 170
                },
                [3] = {
                    item = 'rubber',
                    amount = 115
                }
            }
        },
    },
    ['rifles'] = {
        [1] = {
            label = 'Assault Rifle',
            item = 'weapon_assaultrifle',
            items = {
                [1] = {
                    item = 'metalscrap',
                    amount = 380
                },
                [2] = {
                    item = 'steel',
                    amount = 500
                },
                [3] = {
                    item = 'rubber',
                    amount = 400
                }
            }
        },
        [2] = {
            label = 'Special Carbine',
            item = 'weapon_specialcarbine',
            items = {
                [1] = {
                    item = 'metalscrap',
                    amount = 395
                },
                [2] = {
                    item = 'steel',
                    amount = 520
                },
                [3] = {
                    item = 'rubber',
                    amount = 495
                }
            }
        },
        [3] = {
            label = 'Advanced Rifle',
            item = 'weapon_advancedrifle',
            items = {
                [1] = {
                    item = 'metalscrap',
                    amount = 390
                },
                [2] = {
                    item = 'steel',
                    amount = 510
                },
                [3] = {
                    item = 'rubber',
                    amount = 455
                }
            }
        },
    },
    ['ammo'] = {
        [1] = {
            label = 'Pistol Ammo',
            item = 'pistol_ammo',
            items = {
                [1] = {
                    item = 'metalscrap',
                    amount = 25
                },
                [2] = {
                    item = 'aluminum',
                    amount = 18
                },
                [3] = {
                    item = 'copper',
                    amount = 30
                }
            }
        },
        [2] = {
            label = 'SMG Ammo',
            item = 'smg_ammo',
            items = {
                [1] = {
                    item = 'metalscrap',
                    amount = 28
                },
                [2] = {
                    item = 'aluminum',
                    amount = 25
                },
                [3] = {
                    item = 'copper',
                    amount = 35
                }
            }
        },
        [3] = {
            label = 'Rifle Ammo',
            item = 'rifle_ammo',
            items = {
                [1] = {
                    item = 'metalscrap',
                    amount = 295
                },
                [2] = {
                    item = 'aluminum',
                    amount = 240
                },
                [3] = {
                    item = 'copper',
                    amount = 340
                }
            }
        },
        [4] = {
            label = 'MG Ammo',
            item = 'mg_ammo',
            items = {
                [1] = {
                    item = 'metalscrap',
                    amount = 410
                },
                [2] = {
                    item = 'aluminum',
                    amount = 265
                },
                [3] = {
                    item = 'copper',
                    amount = 400
                }
            }
        },
    }
}
