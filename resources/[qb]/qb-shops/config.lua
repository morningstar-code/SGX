Config = {}
Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'

-- Deliveries
Config.ShopsInvJsonFile = './json/shops-inventory.json'
Config.TruckDeposit = 125
Config.MaxDeliveries = 20
Config.DeliveryPrice = 500
Config.RewardItem = 'cryptostick'
Config.Fuel = 'sgx-fuel'

Config.DeliveryLocations = {
    ['main'] = { label = 'GO Postal', coords = vector4(69.0862, 127.6753, 79.2123, 156.7736) },
    ['vehicleWithdraw'] = vector4(71.9318, 120.8389, 79.0823, 160.5110),
    ['vehicleDeposit'] = vector3(62.7282, 124.9846, 79.0926),
    ['stores'] = {} -- auto generated
}

Config.Vehicles = {
    ['boxville2'] = { ['label'] = 'Boxville StepVan', ['cargodoors'] = { [0] = 2, [1] = 3 }, ['trunkpos'] = 1.5 },
}

Config.Products = {
    ['normal'] = {
        { name = 'tosti',         price = 2,   amount = 50 },
        { name = 'water_bottle',  price = 2,   amount = 50 },
        { name = 'kurkakola',     price = 2,   amount = 50 },
        { name = 'twerks_candy',  price = 2,   amount = 50 },
        { name = 'snikkel_candy', price = 2,   amount = 50 },
        { name = 'sandwich',      price = 2,   amount = 50 },
        { name = 'beer',          price = 7,   amount = 50 },
        { name = 'whiskey',       price = 10,  amount = 50 },
        { name = 'vodka',         price = 12,  amount = 50 },
        { name = 'bandage',       price = 100, amount = 50 },
        { name = 'lighter',       price = 2,   amount = 50 },
        { name = 'rolling_paper', price = 2,   amount = 5000 },
    },
    ['liquor'] = {
        { name = 'beer',    price = 7,  amount = 50 },
        { name = 'whiskey', price = 10, amount = 50 },
        { name = 'vodka',   price = 12, amount = 50 },
    },
    ['hardware'] = {
        { name = 'lockpick',          price = 200, amount = 50 },
        { name = 'weapon_wrench',     price = 250, amount = 250 },
        { name = 'weapon_hammer',     price = 250, amount = 250 },
        { name = 'repairkit',         price = 250, amount = 50, requiredJob = { 'mechanic', 'police' } },
        { name = 'screwdriverset',    price = 350, amount = 50 },
        { name = 'phone',             price = 850, amount = 50 },
        { name = 'radio',             price = 250, amount = 50 },
        { name = 'binoculars',        price = 50,  amount = 50 },
        { name = 'firework1',         price = 50,  amount = 50 },
        { name = 'firework2',         price = 50,  amount = 50 },
        { name = 'firework3',         price = 50,  amount = 50 },
        { name = 'firework4',         price = 50,  amount = 50 },
        { name = 'fitbit',            price = 400, amount = 150 },
        { name = 'cleaningkit',       price = 150, amount = 150 },
        { name = 'advancedrepairkit', price = 500, amount = 50, requiredJob = 'mechanic' },
    },
    ['weedshop'] = {
        { name = 'joint',          price = 10,  amount = 50 },
        { name = 'weapon_poolcue', price = 100, amount = 50 },
        { name = 'weed_nutrition', price = 20,  amount = 50 },
        { name = 'empty_weed_bag', price = 2,   amount = 1000 },
        { name = 'rolling_paper',  price = 2,   amount = 1000 },
    },
    ['gearshop'] = {
        { name = 'diving_gear', price = 2500, amount = 10 },
        { name = 'jerry_can',   price = 200,  amount = 50 },
    },
    ['leisureshop'] = {
        { name = 'parachute',   price = 2500, amount = 10 },
        { name = 'binoculars',  price = 50,   amount = 50 },
        { name = 'diving_gear', price = 2500, amount = 10 },
        { name = 'diving_fill', price = 500,  amount = 10 },
    },
    ['weapons'] = {
        { name = 'weapon_knife',         price = 250,  amount = 250 },
        { name = 'weapon_bat',           price = 250,  amount = 250 },
        { name = 'weapon_hatchet',       price = 250,  amount = 250 },
        { name = 'pistol_ammo',          price = 250,  amount = 250, requiredLicense = 'weapon' },
        { name = 'weapon_pistol',        price = 2500, amount = 5,   requiredLicense = 'weapon' },
        { name = 'weapon_snspistol',     price = 1500, amount = 5,   requiredLicense = 'weapon' },
        { name = 'weapon_vintagepistol', price = 4000, amount = 5,   requiredLicense = 'weapon' },
    },
    ['blackmarket'] = {
        { name = 'security_card_01',  price = 5000, amount = 50 },
        { name = 'security_card_02',  price = 5000, amount = 50 },
        { name = 'advanced_lockpick', price = 5000, amount = 50 },
        { name = 'electronickit',     price = 5000, amount = 50 },
        { name = 'gatecrack',         price = 5000, amount = 50 },
        { name = 'thermite',          price = 5000, amount = 50 },
        { name = 'trojan_usb',        price = 5000, amount = 50 },
        { name = 'drill',             price = 5000, amount = 50 },
        { name = 'radioscanner',      price = 5000, amount = 50 },
        { name = 'cryptostick',       price = 5000, amount = 50 },
        { name = 'joint',             price = 5000, amount = 50 },
        { name = 'cokebaggy',         price = 5000, amount = 50 },
        { name = 'crack_baggy',       price = 5000, amount = 50 },
        { name = 'xtcbaggy',          price = 5000, amount = 50 },
        { name = 'coke_brick',        price = 5000, amount = 50 },
        { name = 'weed_brick',        price = 5000, amount = 50 },
        { name = 'coke_small_brick',  price = 5000, amount = 50 },
        { name = 'oxy',               price = 5000, amount = 50 },
        { name = 'meth',              price = 5000, amount = 50 },
        { name = 'weed_whitewidow',   price = 5000, amount = 50 },
        { name = 'weed_skunk',        price = 5000, amount = 50 },
        { name = 'weed_purplehaze',   price = 5000, amount = 50 },
        { name = 'weed_ogkush',       price = 5000, amount = 50 },
        { name = 'weed_amnesia',      price = 5000, amount = 50 },
        { name = 'weed_ak47',         price = 5000, amount = 50 },
        { name = 'markedbills',       price = 5000, amount = 50, info = { worth = 5000 } },
    },
    ['prison'] = {
        { name = 'sandwich',     price = 4, amount = 50 },
        { name = 'water_bottle', price = 4, amount = 50 },
    },
    ['police'] = {
        { name = 'weapon_pistol',       price = 0, amount = 50, info = { attachments = { { component = 'COMPONENT_AT_PI_FLSH', label = 'Flashlight' } } } },
        { name = 'weapon_stungun',      price = 0, amount = 50, info = { attachments = { { component = 'COMPONENT_AT_AR_FLSH', label = 'Flashlight' } } } },
        { name = 'weapon_pumpshotgun',  price = 0, amount = 50, info = { attachments = { { component = 'COMPONENT_AT_AR_FLSH', label = 'Flashlight' } } } },
        { name = 'weapon_smg',          price = 0, amount = 50, info = { attachments = { { component = 'COMPONENT_AT_SCOPE_MACRO_02', label = '1x Scope' }, { component = 'COMPONENT_AT_AR_FLSH', label = 'Flashlight' } } } },
        { name = 'weapon_carbinerifle', price = 0, amount = 50, info = { attachments = { { component = 'COMPONENT_AT_AR_FLSH', label = 'Flashlight' }, { component = 'COMPONENT_AT_SCOPE_MEDIUM', label = '3x Scope' } } } },
        { name = 'weapon_nightstick',   price = 0, amount = 50 },
        { name = 'weapon_flashlight',   price = 0, amount = 50 },
        { name = 'pistol_ammo',         price = 0, amount = 50 },
        { name = 'smg_ammo',            price = 0, amount = 50 },
        { name = 'shotgun_ammo',        price = 0, amount = 50 },
        { name = 'rifle_ammo',          price = 0, amount = 50 },
        { name = 'handcuffs',           price = 0, amount = 50 },
        { name = 'empty_evidence_bag',  price = 0, amount = 50 },
        { name = 'police_stormram',     price = 0, amount = 50 },
        { name = 'armor',               price = 0, amount = 50 },
        { name = 'radio',               price = 0, amount = 50 },
        { name = 'heavyarmor',          price = 0, amount = 50 },
    },
    ['ambulance'] = {
        { name = 'radio',                   price = 0, amount = 50 },
        { name = 'bandage',                 price = 0, amount = 50 },
        { name = 'painkillers',             price = 0, amount = 50 },
        { name = 'firstaid',                price = 0, amount = 50 },
        { name = 'weapon_flashlight',       price = 0, amount = 50 },
        { name = 'weapon_fireextinguisher', price = 0, amount = 50 },
    },
    ['mechanic'] = {
        { name = 'veh_toolbox',       price = 5000, amount = 50 },
        { name = 'veh_armor',         price = 5000, amount = 50 },
        { name = 'veh_brakes',        price = 5000, amount = 50 },
        { name = 'veh_engine',        price = 5000, amount = 50 },
        { name = 'veh_suspension',    price = 5000, amount = 50 },
        { name = 'veh_transmission',  price = 5000, amount = 50 },
        { name = 'veh_turbo',         price = 5000, amount = 50 },
        { name = 'veh_interior',      price = 5000, amount = 50 },
        { name = 'veh_exterior',      price = 5000, amount = 50 },
        { name = 'veh_wheels',        price = 5000, amount = 50 },
        { name = 'veh_neons',         price = 5000, amount = 50 },
        { name = 'veh_xenons',        price = 5000, amount = 50 },
        { name = 'veh_tint',          price = 5000, amount = 50 },
        { name = 'veh_plates',        price = 5000, amount = 50 },
        { name = 'nitrous',           price = 5000, amount = 50 },
        { name = 'tunerlaptop',       price = 5000, amount = 50 },
        { name = 'repairkit',         price = 5000, amount = 50 },
        { name = 'advancedrepairkit', price = 5000, amount = 50 },
        { name = 'tirerepairkit',     price = 5000, amount = 50 },
    }
}

Config.Locations = {
    -- 24/7 Locations
}
