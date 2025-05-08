Config = Config or {}

-- ███████╗██████╗░░█████╗░███╗░░░███╗███████╗░██╗░░░░░░░██╗░█████╗░██████╗░██╗░░██╗
-- ██╔════╝██╔══██╗██╔══██╗████╗░████║██╔════╝░██║░░██╗░░██║██╔══██╗██╔══██╗██║░██╔╝
-- █████╗░░██████╔╝███████║██╔████╔██║█████╗░░░╚██╗████╗██╔╝██║░░██║██████╔╝█████═╝░
-- ██╔══╝░░██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝░░░░████╔═████║░██║░░██║██╔══██╗██╔═██╗░
-- ██║░░░░░██║░░██║██║░░██║██║░╚═╝░██║███████╗░░╚██╔╝░╚██╔╝░╚█████╔╝██║░░██║██║░╚██╗
-- ╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░░░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝

Config.Framework = 'qb' -- You can choose between 'esx', 'qb', 'standalone', 'autodetect'

-- ░██████╗░███████╗███╗░░██╗███████╗██████╗░░█████╗░██╗░░░░░
-- ██╔════╝░██╔════╝████╗░██║██╔════╝██╔══██╗██╔══██╗██║░░░░░
-- ██║░░██╗░█████╗░░██╔██╗██║█████╗░░██████╔╝███████║██║░░░░░
-- ██║░░╚██╗██╔══╝░░██║╚████║██╔══╝░░██╔══██╗██╔══██║██║░░░░░
-- ██████╔╝███████╗ ██║░╚███║███████╗██║░░██║██║░░██║███████╗
-- ░╚═════╝░╚══════╝╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝

Config.InteractionHandler = 'drawtext' -- 'drawtext', 'ox-target', 'qb-target' editable in client/interactionHandler.lua
Config.CodemTextUI        = false      -- true, false

Config.defaultVehicleImage = 'vehicleImages/togg.png' -- Default image for vehicles that don't have image.
Config.defaultVehicleName = 'Unkown' -- Default name for vehicles that don't have name.

Config.Prices = {
    ['DIESEL'] = 10,
    ['ECONOMIC'] = 20,
    ['SUPER'] = 30,
    ['SUPER_PLUS'] = 40,
}

-- ██████╗░██╗░░░░░██╗██████╗░░██████╗
-- ██╔══██╗██║░░░░░██║██╔══██╗██╔════╝
-- ██████╦╝██║░░░░░██║██████╔╝╚█████╗░
-- ██╔══██╗██║░░░░░██║██╔═══╝░░╚═══██╗
-- ██████╦╝███████╗██║██║░░░░░██████╔╝
-- ╚═════╝░╚══════╝╚═╝╚═╝░░░░░╚═════╝░

Config.showNearestBlips = false
Config.showAllBlips = true
Config.blipSettings = {
    sprite = 361,
    scale = 0.7,
    color = 4,
    display = 4,
    shortRange = true,
    name = 'Gas Station'
}

Config.Locations = {
    vector3(49.4187, 2778.793, 58.043),
    vector3(263.894, 2606.463, 44.983),
    vector3(1039.958, 2671.134, 39.550),
    vector3(1207.260, 2660.175, 37.899),
    vector3(2539.685, 2594.192, 37.944),
    vector3(2679.858, 3263.946, 55.240),
    vector3(2005.055, 3773.887, 32.403),
    vector3(1687.156, 4929.392, 42.078),
    vector3(1701.314, 6416.028, 32.763),
    vector3(179.857, 6602.839, 31.868),
    vector3(-94.4619, 6419.594, 31.489),
    vector3(-2554.996, 2334.40, 33.078),
    vector3(-1800.375, 803.661, 138.651),
    vector3(-1437.622, -276.747, 46.207),
    vector3(-2096.243, -320.286, 13.168),
    vector3(-724.619, -935.1631, 19.213),
    vector3(-526.019, -1211.003, 18.184),
    vector3(-70.2148, -1761.792, 29.534),
    vector3(265.648, -1261.309, 29.292),
    vector3(819.653, -1028.846, 26.403),
    vector3(1208.951, -1402.567,35.224),
    vector3(1181.381, -330.847, 69.316),
    vector3(620.843, 269.100, 103.089),
    vector3(2581.321, 362.039, 108.468),
    vector3(176.631, -1562.025, 29.263),
    vector3(176.631, -1562.025, 29.263),
    vector3(-319.292, -1471.715, 30.549),
    vector3(1784.324, 3330.55, 41.253)
}


-- ███████╗██╗░░░██╗███████╗██╗░░░░░░██████╗
-- ██╔════╝██║░░░██║██╔════╝██║░░░░░██╔════╝
-- █████╗░░██║░░░██║█████╗░░██║░░░░░╚█████╗░
-- ██╔══╝░░██║░░░██║██╔══╝░░██║░░░░░░╚═══██╗
-- ██║░░░░░╚██████╔╝███████╗███████╗██████╔╝
-- ╚═╝░░░░░░╚═════╝░╚══════╝╚══════╝╚═════╝░

-- Class multipliers. If you want SUVs to use less fuel, you can change it to anything under 1.0, and vise versa.
Config.Classes = {
	[0] = 1.0, -- Compacts
	[1] = 1.0, -- Sedans
	[2] = 1.0, -- SUVs
	[3] = 1.0, -- Coupes
	[4] = 1.0, -- Muscle
	[5] = 1.0, -- Sports Classics
	[6] = 1.0, -- Sports
	[7] = 1.0, -- Super
	[8] = 1.0, -- Motorcycles
	[9] = 1.0, -- Off-road
	[10] = 1.0, -- Industrial
	[11] = 1.0, -- Utility
	[12] = 1.0, -- Vans
	[13] = 0.0, -- Cycles
	[14] = 1.0, -- Boats
	[15] = 1.0, -- Helicopters
	[16] = 1.0, -- Planes
	[17] = 1.0, -- Service
	[18] = 1.0, -- Emergency
	[19] = 1.0, -- Military
	[20] = 1.0, -- Commercial
	[21] = 1.0, -- Trains
}

-- The left part is at percentage RPM, and the right is how much fuel (divided by 10) you want to remove from the tank every second
Config.fuelUsage = {
	[1.0] = 1.4,
	[0.9] = 1.2,
	[0.8] = 1.0,
	[0.7] = 0.9,
	[0.6] = 0.8,
	[0.5] = 0.7,
	[0.4] = 0.5,
	[0.3] = 0.4,
	[0.2] = 0.2,
	[0.1] = 0.1,
	[0.0] = 0.0,
}

Config.pumpModels = {
    [-2007231801] = true,
    [1339433404] = true,
    [1694452750] = true,
    [1933174915] = true,
    [-462817101] = true,
    [-469694731] = true,
    [-164877493] = true,
  --  ['HASH'] = true,
}

-- Black list of vehicles that can't be refueled. Use names or hashes (https://wiki.gtanet.work/index.php?title=Vehicle_Models)
Config.blacklistedVehicles = {
    ['Imorgon'] = true,
    ['Neon'] = true,
    ['Raiden'] = true,
    ['Cyclone'] = true,
    ['Voltic'] = true,
    ['Voltic2'] = true,
    ['Tezeract'] = true,
    ['Dilettante'] = true,
    ['Dilettante2'] = true,
    ['Airtug'] = true,
    ['Caddy'] = true,
    ['Caddy2'] = true,
    ['Caddy3'] = true,
    ['Surge'] = true,
    ['Khamelion'] = true,
    ['RCBandito'] = true
}

-- ██╗░░░░░░█████╗░░█████╗░░█████╗░██╗░░░░░███████╗░██████╗
-- ██║░░░░░██╔══██╗██╔══██╗██╔══██╗██║░░░░░██╔════╝██╔════╝
-- ██║░░░░░██║░░██║██║░░╚═╝███████║██║░░░░░█████╗░░╚█████╗░
-- ██║░░░░░██║░░██║██║░░██╗██╔══██║██║░░░░░██╔══╝░░░╚═══██╗
-- ███████╗╚█████╔╝╚█████╔╝██║░░██║███████╗███████╗██████╔╝
-- ╚══════╝░╚════╝░░╚════╝░╚═╝░░╚═╝╚══════╝╚══════╝╚═════╝░

Config.Locales = {
    ['CURRENCY'] = "$",
    ['MENU_NAME'] = "Fuel System",
    ['MODEL'] = "MODEL",
    ['CAR_PLATE'] = "YOUR CAR PLATE",
    ['TEMP'] = "Temp",
    ['SPEED'] = "Speed",
    ['FUEL_TYPE'] = "Fuel Type",
    ['LITER'] = "LITER",
    ['DIESEL'] = "DIESEL",
    ['ECONOMIC'] = "ECONOMIC",
    ['SUPER'] = "SUPER",
    ['SUPER_P'] = "SUPER +",
    ['TOTAL_PRICE'] = "TOTAL PRICE FOR:",
    ['PAYMENT_METHOD'] = "PAYMENT METHOD",
    ['PAYMENT_BUTTON'] = "PAYMENT BUTTON",
    ['PURCHASE'] = 'PURCHASE',
    ['GRAB_NOZZLE'] = 'Grab Nozzle',
    ['PUT_NOZZLE'] = 'Put Nozzle Back',
    ['ATTACH_NOZZLE'] = '[E] Attach Nozzle',
}

-- ███╗░░██╗░█████╗░████████╗██╗███████╗██╗░█████╗░░█████╗░████████╗██╗░█████╗░███╗░░██╗░██████╗
-- ████╗░██║██╔══██╗╚══██╔══╝██║██╔════╝██║██╔══██╗██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║██╔════╝
-- ██╔██╗██║██║░░██║░░░██║░░░██║█████╗░░██║██║░░╚═╝███████║░░░██║░░░██║██║░░██║██╔██╗██║╚█████╗░
-- ██║╚████║██║░░██║░░░██║░░░██║██╔══╝░░██║██║░░██╗██╔══██║░░░██║░░░██║██║░░██║██║╚████║░╚═══██╗
-- ██║░╚███║╚█████╔╝░░░██║░░░██║██║░░░░░██║╚█████╔╝██║░░██║░░░██║░░░██║╚█████╔╝██║░╚███║██████╔╝
-- ╚═╝░░╚══╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝╚═════╝░

Config.NotificationText = {
    ['enoughmnoney'] = {
        text = "Not enough money for the purchase",
        type = "error"
    }
}

Config.Notification = function(message, type, isServer, src) -- You can change here events for notifications
    if isServer then
        if Config.Framework == "esx" then
            TriggerClientEvent("esx:showNotification", src, message)
        else
            TriggerClientEvent('esx:showNotification', src, message, type, 1500)
        end
    else
        if Config.Framework == "esx" then
            TriggerEvent("QBCore:Notify'", message)
        else
            TriggerEvent('QBCore:Notify', message, type, 1500)
        end
    end
end


-- ░█████╗░████████╗██╗░░██╗███████╗██████╗░░██████╗
-- ██╔══██╗╚══██╔══╝██║░░██║██╔════╝██╔══██╗██╔════╝
-- ██║░░██║░░░██║░░░███████║█████╗░░██████╔╝╚█████╗░
-- ██║░░██║░░░██║░░░██╔══██║██╔══╝░░██╔══██╗░╚═══██╗
-- ╚█████╔╝░░░██║░░░██║░░██║███████╗██║░░██║██████╔╝
-- ░╚════╝░░░░╚═╝░░░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚═════╝░

Config.FuelDecor = "_FUEL_LEVEL" -- (Default: "_FUEL_LEVEL") Decor used to store the fuel level in vehicles.
Config.SpeedUnit = "KMH" -- ['KMH', 'MPH']

-- ██████╗░███████╗██████╗░██╗░░░██╗░██████╗░
-- ██╔══██╗██╔════╝██╔══██╗██║░░░██║██╔════╝░
-- ██║░░██║█████╗░░██████╦╝██║░░░██║██║░░██╗░
-- ██║░░██║██╔══╝░░██╔══██╗██║░░░██║██║░░╚██╗
-- ██████╔╝███████╗██████╦╝╚██████╔╝╚██████╔╝
-- ╚═════╝░╚══════╝╚═════╝░░╚═════╝░░╚═════╝░

Config.Debug = false -- If you want to see more about what happens internally in the script use true.
Config.eventPrefix = 'sgx-fuel'