Config = {}

Config.useItem = "encryptedtablet"
Config.paymentType = "crypto" -- cash, bank or crypto
Config.cryptoAcronym = "Crypto"
Config.cryptoIcon = "fa-solid fa-bitcoin-sign"
Config.inventory = "qb-inventory" -- needed for fetching images

Config.randomItems = false -- number of items chosen at random for blackmarket, set to false to have all items in stock
Config.reset = 360 -- mins for blackmarket to restock
Config.maxOrderQueue = 3 -- max number of orders at one time, should not be higher than # of delivery locations
Config.lootTimeout = 3 -- mins after looting container, clear props and delete stash
Config.orderTimeout = 30 -- mins after delivery, if no one loots it clears
Config.deliveryTime = {
    min = 1,
    max = 1,
}

Config.policeNotifChance = 0.0 -- chance to alert polcie, set to 0 if you dont want police alerts

function Config.policeNotify(coords) -- client sided function
    -- Add your police notify event here, default qb-core police notify won't work unless changed to accept custom coords
    -- Alert sent when order is ready, not when player is opening the container
end

Config.tabletColour = "dark" -- light or dark

Config.notifs = {
    success = {
        colour = "#009e73",
        icon = "fa-solid fa-circle-check",
    },
    error = {
        colour = "#ee3737",
        icon = "fa-solid fa-triangle-exclamation",
    }
}

Config.notifText = {
    maxOrder = "Order denied, too many pending orders, try again later",
    insufficientStock = "Order denied, insufficient stock",
    cantAfford = "Order denied, insufficient funds",
    orderSuccess = "Order successful, delivery pending",
    stockUpdate = "Item stock updated and cart adjusted",
    orderReady = "Your order is ready for pickup",
    gpsSet = "Location marked on GPS",
}

Config.props = {
    container = "tr_prop_tr_container_01a",
    containerCollison = "tr_prop_tr_cont_coll_01a",
    lock = "tr_prop_tr_lock_01a",
    grinder = "tr_prop_tr_grinder_01a",
    crate = "tr_prop_tr_crates_sam_01a",
    bag = "hei_p_m_bag_var22_arm_s",
}

Config.containerAnim = {
    dict = "anim@scripted@player@mission@tunf_train_ig1_container_p1@male@",
    bag = "action_bag",
    container = "action_container",
    lock = "action_lock",
    grinder = "action_angle_grinder",
    player = "action",
    audioBank = "dlc_tuner/dlc_tuner_generic",
    ptfx = "scr_tn_tr",
}

Config.lootAnim = {
    dict = "mini@repair",
    anim = "fixing_a_ped",
}

Config.lootTime = 6000 -- ms to open order stash

Config.tabletAnim = {
    dict = "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a",
    anim = "idle_a",
    prop = "prop_cs_tablet",
}

Config.items = {
    -- Weapons
    {item = "weapon_switchblade", label = "Switchblade", minStock = 15, maxStock = 15, price = 15, image = "weapon_switchblade.png"},
    {item = "weapon_knuckle", label = "Brass Knuckles", minStock = 3, maxStock = 3, price = 150, image = "weapon_knuckle.png"},
    {item = "weapon_dagger", label = "Karambit", minStock = 2, maxStock = 2, price = 100, image = "weapon_dagger.png"},
    {item = "weapon_snspistol", label = "SNS Pistol", minStock = 10, maxStock = 10, price = 150, image = "weapon_snspistol.png"},
    {item = "weapon_heavypistol", label = "Entreprise Wide", minStock = 8, maxStock = 8, price = 550, image = "weapon_heavypistol.png"},
    {item = "weapon_microsmg", label = "Micro SMG", minStock = 3, maxStock = 5, price = 3000, image = "weapon_microsmg.png"},
    {item = "weapon_sawnoffshotgun", label = "Sawn-off Shotgun", minStock = 3, maxStock = 5, price = 4000, image = "weapon_sawnoffshotgun.png"}, 
    {item = "weapon_pistol50", label = "Desert Eagle", minStock = 3, maxStock = 5, price = 700, image = "weapon_pistol50.png"},
    {item = "weapon_machinepistol", label = "Tec-9", minStock = 3, maxStock = 5, price = 900, image = "weapon_machinepistol.png"},
    {item = "weapon_smg_mk2", label = "SMG MK2", minStock = 3, maxStock = 5, price = 4500, image = "weapon_smg_mk2.png"},
    {item = "weapon_compactrifle", label = "Draco NAK9", minStock = 3, maxStock = 5, price = 4000, image = "weapon_compactrifle.png"},
    {item = "weapon_assaultsmg", label = "Assault SMG", minStock = 3, maxStock = 5, price = 4000, image = "weapon_assaultsmg.png"},
    {item = "weapon_advancedrifle", label = "OTs-14 Groza", minStock = 3, maxStock = 5, price = 6000, image = "weapon_advancedrifle.png"},
    {item = "weapon_assaultrifle_mk2", label = "AK MK2", minStock = 3, maxStock = 5, price = 6000, image = "weapon_assaultrifle_mk2.png"},
    {item = "weapon_assaultrifle", label = "AK-47", minStock = 3, maxStock = 5, price = 6000, image = "weapon_assaultrifle.png"},
    {item = "weapon_bullpuprifle", label = "Bullpuprifle MK2", minStock = 3, maxStock = 5, stock = 1, price = 6500, image = "weapon_bullpuprifle.png"},
    -- Attachments
    {item = "smg_suppressor", label = "SMG Suppressor", minStock = 10, maxStock = 10, price = 350, image = "pistol_suppressor.png"},
    {item = "heavypistol_extendedclip", label = "Heavy Extendedclip", minStock = 10, maxStock = 10, price = 250, image = "pistol_extendedclip.png"},
    {item = "pistol_suppressor", label = "Pistol Suppressor", minStock = 10, maxStock = 10, price = 250, image = "pistol_suppressor.png"},
    {item = "snspistol_extendedclip", label = "SNS Pistol Extendedclip", minStock = 10, maxStock = 10, price = 250, image = "pistol_extendedclip.png"},
    {item = "pistol_extendedclip", label = "Pistol Extendedclip", minStock = 10, maxStock = 10, price = 250, image = "pistol_extendedclip.png"},
    {item = "bullpuprifle_extendedclip", label = "Bullpuprifle Extendedclip", minStock = 10, maxStock = 10, price = 450, image = "pistol_extendedclip.png"},
    {item = "assaultsmg_extendedclip", label = "AssaultSMG Extendedclip", minStock = 10, maxStock = 10, price = 450, image = "pistol_extendedclip.png"},
}

Config.deliveryLocations = {
    vector4(905.73, -3086.67, 5.9, 90.0),
    vector4(844.46, -2869.94, 13.82, 90.0),
    vector4(1082.78, -2317.47, 30.23, 265.0),
    vector4(1014.27, -1928.1, 30.96, 90.0),
    vector4(-111.62, -2363.87, 13.79, 180.0),
    vector4(-441.31, -2280.42, 7.61, 268.57),
    vector4(170.1, 2740.44, 43.42, 280.64),
}