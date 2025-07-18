local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('rz:eat:craftmenu', function()
    exports['qb-menu']:openMenu({
        {
            header = Lang:t("qbmenu.header"),
            isMenuHeader = true,
        },
        {
            id = 1,
            header = Lang:t("qbmenu.smallcraft"),
            txt = Lang:t("qbmenu.smallcrafttxt"),
            params = {
                event = "rz-burgershot:smallpacket",
            }
        },
        {
            id = 2,
            header = Lang:t("qbmenu.bigcraft"),
            txt = Lang:t("qbmenu.bigcrafttxt"),
            params = {
                event = "rz-burgershot:bigpacket",
            }
        },
        {
            id = 3,
            header = Lang:t("qbmenu.goatcraft"),
            txt = Lang:t("qbmenu.goatcrafttxt"),
            params = {
                event = "rz-burgershot:goatpacket",
            }
        },
        {
            id = 4,
            header = Lang:t("qbmenu.coffecraft"),
            txt = Lang:t("qbmenu.coffecrafttxt"),
            params = {
                event = "rz-burgershot:coffeepacket",
            }
        },
        {
            header = Lang:t("qbmenu.closemenu"),
            params = { 
                event = "qb-menu:client:closeMenu"
            }
        },
    })
end)

RegisterNetEvent('rz-burgershot:ordermenu', function(data)
    exports['qb-menu']:openMenu({
        {
            header = Lang:t("qbmenu.Fridge"),
            isMenuHeader = true
        },
        {
            header = Lang:t("qbmenu.orderıtems"),
            txt = Lang:t("qbmenu.orderıtemstxt"),
            params = {
                event = "rz:burgershot:shop"
            }
        },
        {
            header = Lang:t("qbmenu.fridgeheader"),
            txt = Lang:t("qbmenu.fridgetxt"),
            params = {
                event = "rz-burgershot:storge2"
            }
        },
        { 
            header = Lang:t("qbmenu.macaroonheader"),
            txt = Lang:t("qbmenu.macaroontxt"),
            params = {
                event = "rz-burgershot:client:macaroon",
            }
        },
        { 
            header = Lang:t("qbmenu.icecream"),
            txt = Lang:t("label.IceCreamStation"),
            params = {
                event = "rz-burgershot:icecream",
            }
        },
        {
            header = Lang:t("qbmenu.closemenu"), 
            params = { 
                event = "qb-menu:client:closeMenu"
            }
        },
    })
end)

RegisterNetEvent('rz-burgershot:dutymenu', function(data)
    exports['qb-menu']:openMenu({
        {
            header = Lang:t("qbmenu.dutymenu"),
            isMenuHeader = true
        },
        { 
            header = Lang:t("qbmenu.dutyonoff"),
            params = {
                event = "rz-burgershot:duty",
            }
        },
        {
            header = Lang:t("qbmenu.closemenu"),
            params = { 
                event = "qb-menu:client:closeMenu"
            }
        },
    })
end)

RegisterNetEvent('rz-burgershot:friesmenu', function(data)
    exports['qb-menu']:openMenu({
        {
            header = Lang:t("qbmenu.friestmenu"),
            isMenuHeader = true
        },
        { 
            header = Lang:t("qbmenu.friestmenu"),
            txt = "",
            params = {
                event = "rz-burgershot:friestlist",
            }
        },
        {
            header = Lang:t("qbmenu.closemenu"),
            params = { 
                event = "qb-menu:client:closeMenu"
            }
        },
    })
end)

RegisterNetEvent('rz-burgershot:friestlist', function(data)
    exports['qb-menu']:openMenu({
        {
            header = Lang:t("qbmenu.frieslistmenu"),
            isMenuHeader = true
        },
        { 
            header = Lang:t("qbmenu.bigpotatoheader"),
            txt = Lang:t("qbmenu.bigpotatotxt"),
            params = {
                event = "rz-burgershot:client:bigpotato",
            }
        },
        { 
            header = Lang:t("qbmenu.smallpotatoheader"),
            txt = Lang:t("qbmenu.smallpotatotxt"),
            params = {
                event = "rz-burgershot:client:smallpotato",
            }
        },
        { 
            header = Lang:t("qbmenu.ringsheader"),
            txt = Lang:t("qbmenu.ringstxt"),
            params = {
                event = "rz-burgershot:client:rings",
            }
        },
        { 
            header = Lang:t("qbmenu.nuggetsheader"),
            txt = Lang:t("qbmenu.nuggetstxt"),
            params = {
                event = "rz-burgershot:client:nuggets",
            }
        },
        { 
            header = Lang:t("qbmenu.backmenu"),
            params = {
                event = "rz-burgershot:friesmenu",
            }
        },
    })
end)

RegisterNetEvent('rz-burgershot:meatmenu', function(data)
    exports['qb-menu']:openMenu({
        {
            header =  Lang:t("qbmenu.friesmeatmenu"),
            isMenuHeader = true
        },
        { 
            header = Lang:t("qbmenu.friesmeatheader"),
            txt = Lang:t("qbmenu.friesmeatxt"),
            params = {
                event = "rz-burgershot:client:meat",
            }
        },
    })
end)

RegisterNetEvent('rz-burgershot:drinkmenu', function(data)
    exports['qb-menu']:openMenu({
        {
            header = "Drink List Menu",
            isMenuHeader = true
        },
        { 
            header = Lang:t("qbmenu.bigsizecola"),
            txt = Lang:t("qbmenu.bigsizecolatxt"),
            params = {
                event = "rz-burgershot:client:bigcola",
            }
        },
        { 
            header = Lang:t("qbmenu.smallsizecola"),
            txt = Lang:t("qbmenu.smallsizecolatxt"),
            params = {
                event = "rz-burgershot:client:smallcola",
            }
        },
        { 
            header = Lang:t("qbmenu.coffee"),
            txt = Lang:t("qbmenu.coffeetxt"),
            params = {
                event = "rz-burgershot:client:coffee",
            }
        },
    })
end)

RegisterNetEvent('rz-burgershot:burgermenu', function(data)
    exports['qb-menu']:openMenu({
        {
            header = Lang:t("qbmenu.burgermenu"),
            isMenuHeader = true
        },
        { 
            header = Lang:t("qbmenu.bleederburgerheader"),
            txt = Lang:t("qbmenu.bleederburgertxt"),
            params = {
                event = "rz-burgershot:client:bleederburger",
            }
        },
        { 
            header = Lang:t("qbmenu.bigkingburgerheader"),
            txt = Lang:t("qbmenu.bigkingburgertxt"),
            params = {
                event = "rz-burgershot:client:bigkingburger",
            }
        },
        { 
            header = Lang:t("qbmenu.wrapheader"),
            txt = Lang:t("qbmenu.wraptxt"),
            params = {
                event = "rz-burgershot:client:wrap",
            }
        },
    })
end)

RegisterNetEvent('rz-burgershot:icecream', function(data)
    exports['qb-menu']:openMenu({
        {
            header = Lang:t("qbmenu.icecream"),
            isMenuHeader = true
        },
        { 
            header = Lang:t("qbmenu.chocolateicecream"),
            params = {
                event = "rz-burgershot:client:chocolateicecream",
            }
        },
        { 
            header = Lang:t("qbmenu.vanillaicecream"),
            params = {
                event = "rz-burgershot:client:vanillaicecream",
            }
        },
        { 
            header = Lang:t("qbmenu.thesmurfsicecream"),
            params = {
                event = "rz-burgershot:client:thesmurfsicecream",
            }
        },
        ----
        { 
            header = Lang:t("qbmenu.strawberryicecream"),
            params = {
                event = "rz-burgershot:client:strawberryicecream",
            }
        },
        { 
            header = Lang:t("qbmenu.matchaicecream"),
            params = {
                event = "rz-burgershot:client:matchaicecream",
            }
        },
        { 
            header = Lang:t("qbmenu.ubeicecream"),
            params = {
                event = "rz-burgershot:client:ubeicecream",
            }
        },
        { 
            header = Lang:t("qbmenu.smurfetteicecream"),
            params = {
                event = "rz-burgershot:client:smurfetteicecream",
            }
        },
        { 
            header = Lang:t("qbmenu.unicornicecream"),
            params = {
                event = "rz-burgershot:client:unicornicecream",
            }
        },
        { 
            header = Lang:t("qbmenu.backmenu"),
            params = {
                event = "rz-burgershot:ordermenu",
            }
        },
    })
end)

RegisterNetEvent('rz-burgershot:sellpacket', function(data)
    exports['qb-menu']:openMenu({
        {
            header = Lang:t("qbmenu.packetmenuheader"),
            isMenuHeader = true
        },
        { 
            header = Lang:t("qbmenu.smallpacketsellheader"),
            params = {
                event = "rz-burgershot:client:startdeliverysmall",
            }
        },
        { 
            header = Lang:t("qbmenu.bigpacketsellheader"),
            params = {
                event = "rz-burgershot:client:startdeliverybig",
            }
        },
    })
end)


exports['qb-target']:AddBoxZone('duty', vector3(Config.Duty.x, Config.Duty.y, Config.Duty.z), 2, 0.4, {
    name = 'duty', debugPoly = false, heading = 35, useZ=true}, {
    options = {{label = Lang:t("label.duty") ,icon = 'fa-solid fa-hand-holding', job = Config.Job, action = function() TriggerEvent('rz-burgershot:dutymenu') end}},
    distance = 1.0
})

exports['qb-target']:AddBoxZone('tray', vector3(Config.Tray.x, Config.Tray.y, Config.Tray.z), 0.5, 0.4, {
    name = 'tray', debugPoly = false, heading = 340, useZ=true}, {
    options = {{label = Lang:t("label.tray") ,icon = 'fa-solid fa-hand-holding', action = function() TriggerEvent('rz-burgershot:tray') end}},
    distance = 2.0
})

exports['qb-target']:AddBoxZone('tray2', vector3(Config.Tray2.x, Config.Tray2.y, Config.Tray2.z), 0.5, 0.4, {
    name = 'tray2', debugPoly = false, heading=330, useZ=true}, {
    options = {{label = Lang:t("label.tray") ,icon = 'fa-solid fa-hand-holding',  action = function() TriggerEvent('rz-burgershot:tray2') end}},
    distance = 2.0
})

exports['qb-target']:AddBoxZone('tray3', vector3(Config.Tray3.x, Config.Tray3.y, Config.Tray3.z), 0.5, 0.4, {
    name = 'tray3', debugPoly = false, heading=355, useZ=true}, {
    options = {{label = Lang:t("label.tray") ,icon = 'fa-solid fa-hand-holding',  action = function() TriggerEvent('rz-burgershot:tray3') end}},
    distance = 2.0
})

exports['qb-target']:AddBoxZone('tray4', vector3(Config.Tray4.x, Config.Tray4.y, Config.Tray4.z), 0.5, 0.4, {
    name = 'tray4', debugPoly = false, heading=350, useZ=true}, {
    options = {{label = Lang:t("label.tray") ,icon = 'fa-solid fa-hand-holding',  action = function() TriggerEvent('rz-burgershot:tray4') end}},
    distance = 2.0
})

exports['qb-target']:AddBoxZone('Storge', vector3(Config.Storge.x, Config.Storge.y, Config.Storge.z), 2.0, 0.5, {
    name = 'Storage', debugPoly = false, heading=255, useZ=true}, {
    options = {{label = Lang:t("label.storge") ,icon = 'fa-solid fa-hand-holding', job = Config.Job, action = function() TriggerEvent('rz-burgershot:storge') end}},
    distance = 1.0
})

exports['qb-target']:AddBoxZone('Fridge', vector3(Config.Fridge.x, Config.Fridge.y, Config.Fridge.z), 1.5, 0.4, {
    name = 'Fridge', debugPoly = false, heading=35, useZ=true}, {
    options = {{label = Lang:t("label.Fridge") ,icon = 'fa-solid fa-hand-holding', job = Config.Job, action = function() TriggerEvent('rz-burgershot:ordermenu') end}},
    distance = 1.0
})

exports['qb-target']:AddBoxZone('Fries', vector3(Config.Fries.x, Config.Fries.y, Config.Fries.z), 1.0, 0.6, {
    name = 'Fries', debugPoly = false, heading=345, useZ=true}, {
    options = {{label = Lang:t("label.Fries") ,icon = 'fa-solid fa-hand-holding', job = Config.Job, action = function() TriggerEvent('rz-burgershot:friesmenu') end}},
    distance = 1.0
})

exports['qb-target']:AddBoxZone('Drink', vector3(Config.Drink.x, Config.Drink.y, Config.Drink.z), 0.8, 0.6, {
    name = 'Drink', debugPoly = false,  heading=345, useZ=true}, {
    options = {{label = Lang:t("label.Drink") ,icon = 'fa-solid fa-hand-holding', job = Config.Job, action = function() TriggerEvent('rz-burgershot:drinkmenu') end}},
    distance = 1.0
})

exports['qb-target']:AddBoxZone('Meat', vector3(Config.MeatStation.x, Config.MeatStation.y, Config.MeatStation.z), 1.0, 0.6, {
    name = 'Meat', debugPoly = false, heading=345, useZ=true}, {
    options = {{label = Lang:t("label.Meat") ,icon = 'fa-solid fa-hand-holding', job = Config.Job, action = function() TriggerEvent('rz-burgershot:meatmenu') end}},
    distance = 1.0
})

exports['qb-target']:AddBoxZone('BurgerStation', vector3(Config.BurgerStation.x, Config.BurgerStation.y, Config.BurgerStation.z), 1, 0.5, {
    name = 'BurgerStation', debugPoly = false, heading=255, useZ=true}, {
    options = {{label = Lang:t("label.BurgerStation") ,icon = 'fa-solid fa-hand-holding', job = Config.Job, action = function() TriggerEvent('rz-burgershot:burgermenu') end}},
    distance = 1.0
})

exports['qb-target']:AddBoxZone('PackageStation', vector3(Config.PackageStation.x, Config.PackageStation.y, Config.PackageStation.z), 1.4, 0.7, {
    name = 'PackageStation', debugPoly = false, heading=75, useZ=true}, {
    options = {{label = Lang:t("label.PackageStation") ,icon = 'fa-solid fa-hand-holding', job = Config.Job, action = function() TriggerEvent('rz:eat:craftmenu') end}},
    distance = 1.0
})


exports['qb-target']:AddBoxZone('Clean', vector3(Config.Clean.x, Config.Clean.y, Config.Clean.z), 1.4, 0.5,{
    name = 'Clean', debugPoly = false, heading=75, useZ=true}, {
    options = {{label = Lang:t("label.Clean") ,icon = 'fa-solid fa-hand-holding', job = Config.Job, action = function() TriggerEvent('rz-burgershot:client:clean') end}},
    distance = 1.0
})

-- exports['qb-target']:AddBoxZone('SellItem', vector3(Config.SellItem.x, Config.SellItem.y, Config.SellItem.z), 0.9, 0.2, {
--     name = 'SellItem', debugPoly = false, heading=305, useZ=true}, {
--     options = {{label = Lang:t("label.SellItem") ,icon = 'fa-solid fa-hand-holding', job = Config.Job, action = function() TriggerEvent('rz-burgershot:sellpacket') end}},
--     distance = 1.0
-- })

-- exports['qb-target']:AddBoxZone('Finish', vector3(Config.Finish.x, Config.Finish.y, Config.Finish.z), 0.9, 0.2, {
--     name = 'Finish', debugPoly = false, heading=305, useZ=true}, {
--     options = {{label = "Finish" ,icon = 'fa-solid fa-hand-holding', job = Config.Job, action = function() TriggerEvent('rz-burgershot:client:sellingfinish') end}},
--     distance = 2.0
-- })





