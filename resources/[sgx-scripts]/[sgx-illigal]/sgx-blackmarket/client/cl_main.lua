QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}

-- BEE

RegisterNetEvent('qb-beekeeping:hmenu')
AddEventHandler('qb-beekeeping:hmenu', function()
     exports['qb-menu']:openMenu({
        {
			id = 1,
            header = "BeeKeepingMarket",
            txt = "", 
        },
        {
			id = 3,
            header = "Sell BeeKeeping Items",
			txt = "Sell BeeKeeping Items",
			params = {
                event = "qb-beekeeping:sbuy",
            }
        },
        {
			id = 4,
            header = "Close", 
            txt = "",
            params = {
                event = "",
            }
        },
    })
-- else
--     QBCore.Functions.Notify("I'm not dealing with anyone at the moment, come back later", 'error')
--     end
end)



RegisterNetEvent('qb-blackmarket:hmenu')
AddEventHandler('qb-blackmarket:hmenu', function()
     exports['qb-menu']:openMenu({
        {
			id = 1,
            header = "Market",
            txt = "", 
        },
        {
			id = 3,
            header = "Sell Your Sh*t",
			txt = "Sell Items From Robberies",
			params = {
                event = "qb-blackmarket:sbuy",
            }
        },
        {
			id = 4,
            header = "Close", 
            txt = "",
            params = {
                event = "",
            }
        },
    })
-- else
--     QBCore.Functions.Notify("I'm not dealing with anyone at the moment, come back later", 'error')
--     end
end)


RegisterNetEvent('qb-cryptoselling:sbuy')
AddEventHandler('qb-cryptoselling:sbuy', function()
     exports['qb-menu']:openMenu({
        {
			id = 1,
            header = "Sell Crypto Papers",
            txt = "",        
        },
        {
			id = 2,
            header = "Sell Crypto Papers",
			txt = "Sell Crypto Papers",
			params = {
                event = 'qb-cryptoselling:sellitems'
            }
        },
        {
			id = 3,
            header = "Close",
			txt = "",
			params = {
                event = ''
            }
        },
    })
end)

RegisterNetEvent("qb-cryptoselling:sellitems")
AddEventHandler("qb-cryptoselling:sellitems", function()
    TriggerServerEvent('qb-cryptoselling:sellitemsv')
end)

RegisterNetEvent('qb-cryptoselling:hmenu')
AddEventHandler('qb-cryptoselling:hmenu', function()
     exports['qb-menu']:openMenu({
        {
			id = 1,
            header = "Sell Crypto Papers",
            txt = "", 
        },
        {
			id = 3,
            header = "Sell Your Crypto Papers",
			txt = "Sell Crypto Papers",
			params = {
                event = "qb-cryptoselling:sbuy",
            }
        },
        {
			id = 4,
            header = "Close", 
            txt = "",
            params = {
                event = "",
            }
        },
    })
-- else
--     QBCore.Functions.Notify("I'm not dealing with anyone at the moment, come back later", 'error')
--     end
end)

-- BEE

RegisterNetEvent('qb-beekeeping:sbuy')
AddEventHandler('qb-beekeeping:sbuy', function()
     exports['qb-menu']:openMenu({
        {
			id = 1,
            header = "BeeKeeping Market",
            txt = "",        
        },
        {
			id = 2,
            header = "Sell BeeKeeping stuff",
			txt = "Sell BeeKeeping stuff",
			params = {
                event = 'qb-beekeeping:sellitems'
            }
        },
        {
			id = 3,
            header = "Close",
			txt = "",
			params = {
                event = ''
            }
        },
    })
end)


RegisterNetEvent('qb-blackmarket:sbuy')
AddEventHandler('qb-blackmarket:sbuy', function()
     exports['qb-menu']:openMenu({
        {
			id = 1,
            header = "Market",
            txt = "",        
        },
        {
			id = 2,
            header = "Sell people stuff (Cash)",
			txt = "Sell Your Ass Items",
			params = {
                event = 'qb-blackmarket:sellitems'
            }
        },
        {
			id = 3,
            header = "Close",
			txt = "",
			params = {
                event = ''
            }
        },
    })
end)

RegisterNetEvent('qb-blackmarket:sbuy2')
AddEventHandler('qb-blackmarket:sbuy2', function()
     exports['qb-menu']:openMenu({
        {
			id = 1,
            header = "Cards Market",
            txt = "",        
        },
        {
			id = 2,
            header = "Sell people Cards (Cash)",
			txt = "Sell Your Cards Items",
			params = {
                event = 'qb-blackmarket:sellitems2'
            }
        },
        {
			id = 3,
            header = "Close",
			txt = "",
			params = {
                event = ''
            }
        },
    })
end)

RegisterNetEvent("qb-pawnshop:table")
AddEventHandler("qb-pawnshop:table", function()
    TriggerEvent("inventory:client:SetCurrentStash", "tray")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "tray", {
        maxweight = 350000,
        slots = 30,
    })
end)

RegisterNetEvent("qb-customcafe:table")
AddEventHandler("qb-customcafe:table", function()
    TriggerEvent("inventory:client:SetCurrentStash", "traycafe10")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "traycafe10", {
        maxweight = 350000,
        slots = 30,
    })
end)

RegisterNetEvent("qb-customcafe:tablegridge")
AddEventHandler("qb-customcafe:tablegridge", function()
    TriggerEvent("inventory:client:SetCurrentStash", "Fridgecafe101")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "Fridgecafe101", {
        maxweight = 350000,
        slots = 30,
    })
end)

RegisterNetEvent("qb-pawn:tray2")
AddEventHandler("qb-pawn:tray2", function()
    TriggerEvent("inventory:client:SetCurrentStash", "tray2")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "tray2", {
        maxweight = 350000,
        slots = 30,
    })
end)

RegisterNetEvent("qb-taco:tray6")
AddEventHandler("qb-taco:tray6", function()
    TriggerEvent("inventory:client:SetCurrentStash", "tray6")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "tray6", {
        maxweight = 350000,
        slots = 30,
    })
end)

RegisterNetEvent("qb-taconew:tray2")
AddEventHandler("qb-taconew:tray2", function()
    TriggerEvent("inventory:client:SetCurrentStash", "tray11")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "tray111", {
        maxweight = 350000,
        slots = 30,
    })
end)

-- exports['qb-target']:AddCircleZone('tray', vector3(-320.7291, -95.26486, 47.505573), 1.0,{
--     name = 'tray', debugPoly = false, useZ=true}, {
--     options = {{label = "Put On The Table" ,icon = 'fa-solid fa-hand-holding', action = function() TriggerEvent('qb-pawnshop:table') end}},
--     distance = 2.0
-- })

RegisterNetEvent('qb-blackmarket:robitems')
AddEventHandler('qb-blackmarket:robitems', function()
     exports['qb-menu']:openMenu({
        {
			id = 1,
            header = "Available Items",
            txt = "",        
        },
        {
			id = 2,
            header = "Pawn Store",
			txt = "Open you fucking shit store and learn English!",
			params = {
                event = 'qb-shops:marketshop'
            }
        },
        -- {
		-- 	id = 3,
        --     header = "BlackMarket VPN",
		-- 	txt = "Illegal Item, Get One - (2,000$)",
		-- 	params = {
        --         event = 'qb-blackmarket:pacificusb'
        --     }
        -- },
        -- {
		-- 	id = 4,
        --     header = "Boosting VPN",
		-- 	txt = "Illegal Item, Get One - (2,000$)",
		-- 	params = {
        --         event = 'blackmarket:boostingvpn'
        --     }
        -- },
        -- {
		-- 	id = 5,
        --     header = "Electronic Kit",
		-- 	txt = "Illegal Item, Get One (2,000$)",
		-- 	params = {
        --         event = 'blackmarket:electronickit'
        --     }
        -- },
        -- {
		-- 	id = 6,
        --     header = "Thermite",
		-- 	txt = "Illegal Item, Get One (2,000$)",
		-- 	params = {
        --         event = 'blackmarket:thermite'
        --     }
        -- },
        -- {
		-- 	id = 7,
        --     header = "Advanced Lockpick",
		-- 	txt = "Illegal Item, Get One (2,000$)",
		-- 	params = {
        --         event = 'blackmarket:advancedlockpick'
        --     }
        -- },
        -- {
		-- 	id = 8,
        --     header = "Lockpick",
		-- 	txt = "Illegal Item, Get One (2,000$)",
		-- 	params = {
        --         event = 'blackmarket:lockpick'
        --     }
        -- },
        -- {
		-- 	id = 9,
        --     header = "Decrypter",
		-- 	txt = "Illegal Item, Get One (2,000$)",
		-- 	params = {
        --         event = 'blackmarket:decrypter'
        --     }
        -- },
        -- {
		-- 	id = 10,
        --     header = "ToolBox (/RemoveGPS)",
		-- 	txt = "Illegal Item, Get One (2,000$)",
		-- 	params = {
        --         event = 'blackmarket:screwdriverset'
        --     }
        -- },
        {
			id = 3,
            header = "Close",
			txt = "",
			params = {
                event = ''
            }
        },
    })
end)

-- Bee

RegisterNetEvent("qb-beekeeping:sellitems")
AddEventHandler("qb-beekeeping:sellitems", function()
    TriggerServerEvent('qb-beekeeping:sellitemsv')
end)

RegisterNetEvent("qb-blackmarket:sellitems")
AddEventHandler("qb-blackmarket:sellitems", function()
    TriggerServerEvent('qb-blackmarket:sellitemsv')
end)

RegisterNetEvent("qb-blackmarket:sellitems2")
AddEventHandler("qb-blackmarket:sellitems2", function()
    TriggerServerEvent('qb-blackmarket:sellitemsv2')
end)

RegisterNetEvent("qb-blackmarket:pacificusb")
AddEventHandler("qb-blackmarket:pacificusb", function()
    TriggerServerEvent('blackmarket:pacificusb')
end)

RegisterNetEvent("qb-blackmarket:darkweb")
AddEventHandler("qb-blackmarket:darkweb", function()
    TriggerServerEvent('blackmarket:darkweb')
end)

RegisterNetEvent("blackmarket:boostingvpn")
AddEventHandler("blackmarket:boostingvpn", function()
    TriggerServerEvent('blackmarket:boostingvpn')
end)

RegisterNetEvent("blackmarket:electronickit")
AddEventHandler("blackmarket:electronickit", function()
    TriggerServerEvent('blackmarket:electronickit')
end)

RegisterNetEvent("blackmarket:thermite")
AddEventHandler("blackmarket:thermite", function()
    TriggerServerEvent('blackmarket:thermite')
end)

RegisterNetEvent("blackmarket:advancedlockpick")
AddEventHandler("blackmarket:advancedlockpick", function()
    TriggerServerEvent('blackmarket:advancedlockpick')
end)

RegisterNetEvent("blackmarket:lockpick")
AddEventHandler("blackmarket:lockpick", function()
    TriggerServerEvent('blackmarket:lockpick')
end)

RegisterNetEvent("blackmarket:decrypter")
AddEventHandler("blackmarket:decrypter", function()
    TriggerServerEvent('blackmarket:decrypter')
end)

RegisterNetEvent("blackmarket:screwdriverset")
AddEventHandler("blackmarket:screwdriverset", function()
    TriggerServerEvent('blackmarket:screwdriverset')
end)


