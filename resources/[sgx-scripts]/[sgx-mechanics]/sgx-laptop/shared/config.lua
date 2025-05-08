Config = {}

Config.Inventory = "qb-inventory"
Config.LaptopDevice = "laptop"

Config.RenewedPhone = true

Config.Linux = false

Config.PoliceJobs = {
    "police",
    "bcso",
    "sahp"
}

Config.Apps = {
    ['setting'] = {
        app = 'setting',
        name = 'Setting',
        icon = 'fa-solid fa-cog',
        useimage = false,
        color = '#fff',
        background = "#4B5D67",
        job = {},
        bannedJobs = {},
        gang = {},
        item = {},
        default = true
    },
    ['bennys'] = {
        app = 'bennys',
        name = "Bennys Shop",
        icon = "fa-solid fa-shopping-cart",
        useimage = false,
        color = '#fff',
        background = "#352968",
        job = {},
        bannedJobs = {},
        gang = {},
        item = {},
        default = true
    },
    ['darkweb'] = {
        app = 'darkweb',
        name = "Unknown",
        icon = "fa-solid fa-skull",
        useimage = false,
        color = '#fff',
        background = "black",
        job = {},
        bannedJobs = { "police" },
        gang = {},
        item = { "vpn" },
        default = false
    }
}
