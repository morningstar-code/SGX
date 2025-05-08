Config = {
    ServerCallbacks = {}, -- Don't edit or change
    AutoDatabaseCreator = true, -- If you are starting the script for the first time, make this true and restart the script, after restarting, make this false otherwise you will get an error.
    TestDriveTime = 600000, -- Seconds 600000
    TeleportBackWhenTestFinishes = false, -- If false destroys the test vehicle's engine and sets it unusable again
    WarpPedToTestVehicle = false, -- If you activate it, a player will be automatically teleported to the driver's seat of a test vehicle when they pick it up.
    SalesShare = 10, -- The player making the sale receives a share of the entered amount from the sale.
    EnableSocietyAccount = false, -- Activate/deactivate management bank accounts
    Permissions = {"admin", "staff", "god"},
    VehicleShops = {
        {   
            ClearAreaOfNPCVehicles = true, -- If true script deletes default spawned NPC cars around the vehicle shop
			Management = {
			Enable = true,
			Job = nil -- or Job = "any"
			},
            EnableStocks = true,
            AllowedCategories = {"sedans", "sportsclassics", "offroad", "cycles", "motorcycles", "vans", "super", "sports", "coupes", "compacts", "suvs", "muscle"},
            Coords = {
                ShowroomVehicles = vector4(557.29, -241.64, 49.34, 169.01),
                BoughtVehicles = vector4(535.25, -256.47, 49.98, 282.33),
                TestVehicles = vector4(538.91, -255.82, 49.34, 288.68),
                SellingPoint = vector3(562.05, -240.98, 49.75)
            },
            Ped = {
                Enable = true,
                Coords = vector4(559.5, -251.96, 49.50, 65.50),
                Model = "a_m_y_smartcaspat_01",
                animDict = "amb@prop_human_seat_chair@female@arms_folded@idle_a",
                animName = "idle_a"
            },
            ShowroomVehicles = {
                {coords = vector4(551.63, -264.08, 49.98, 26.31)},
                {coords = vector4(549.3, -268.2, 49.98, 16.18)},
                {coords = vector4(547.28, -272.67, 49.98, 12.61)},
                {coords = vector4(545.5, -276.48, 49.98, 23.36)},
                {coords = vector4(561.3, -245.63, 49.33, 1.91)}
            },
            Blip = { -- https://docs.fivem.net/docs/game-references/blips/
                Enable = true,
                coords = vector3(556.14, -244.64, 49.98),
                sprite = 820,
                color = 0,
                scale = 0.5,
                text = "Dealership"
            },
            Interaction = {
                Target = {
                    Enable = true,
                    Distance = 2.0,
                    Label = "Open Showroom",
                    Icon = "fa-solid fa-car",
                    Label2 = "Open Management",
                    Icon2 = "fa-solid fa-car"
                },
                Text = {
                    Enable = false,
                    Distance = 3.0,
                    Label = "[E] Open Showroom | [G] Open Management"
                },
                DrawText = {
                    Enable = false,
                    Distance = 3.0,
                    Show = function()
                        exports["qb-core"]:DrawText("Contact", "left")
                    end,
                    Hide = function()
                        exports["qb-core"]:HideText()
                    end
                }
            }
        }
    }
}

-- Fuel Function
function Config.SetFuel(vehicle, fuel)
    exports["sgx-fuel"]:SetFuel(vehicle, fuel)
end

-- Key Function
function Config.GiveKey(plate)
    TriggerEvent('vehiclekeys:client:SetOwner', plate)
end

-- HUD Function
function Config.HUD(state)
    TriggerEvent('sgx-hud:display', state)
    --TriggerEvent('ps-hud:display', state)
end

-- Management Function
function Config.AddManagementMoney(job, amount)
    exports['qb-management']:AddMoney(job, amount)
end