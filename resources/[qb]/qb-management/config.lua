-- Zones for Menus
Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.BossMenus = {
    police = {
        vector3(447.16, -974.31, 30.47),
    },
    ambulance = {
        vector3(351.86, -582.32, 48.34),
    },
    cardealer = {
        vector3(-32.94, -1114.64, 26.42),
    },
    mechanic = {
        vector3(-347.59, -133.35, 39.01),
    },
    pizzathis = {
        vector3(-594.78, -886.12, 30.2)
    },
    coolbeans = {
        vector3(-1183.77, -1138.13, 7.90)
    },
    burgershot = {
        vector3(-1200.99, -901.99, 14.70)
    },
    police = {
        vector3(461.45, -986.12, 30.66)
    },
    bcso = {
        vector3(-433.08, 6005.31, 36.94)
    },
    sahp = {
        vector3(1843.74, 3683.78, 38.93)
    },
    redlinemechanic = {
        vector3(-1603.20, -837.60, 10.15)
    },
    beeker = {
        vector3(101.16, 6620.20, 32.75)
    },
    mechanic = {
        vector3(-345.15, -127.68, 39.26)
    },
    mechanic2 = {
        vector3(1186.21, 2638.14, 38.73)
    },
    mechanic3 = {
        vector3(-1143.78, -2004.08, 13.25)
    },
    bennys = {
        vector3(-224.27, -1319.28, 31.20)
    },
    bennys2 = {
        vector3(937.05, -1052.16, 40.85)
    },
    autoexotic = {
        vector3(543.81, -199.83, 54.60)
    },
}

Config.GangMenus = {
    lostmc = {
        vector3(100.20, 3613.68, 40.87),
    },
    ballas = {
        vector3(-15.37, -1808.57, 20.40),
    },
    vagos = {
        vector3(340.66, -2020.57, 22.40),
    },
    infernalmc = {
        vector3(-445.37, 266.11, 86.38),
    },
    families = {
        vector3(-137.52, -1608.03, 35.22),
    },
    mafia = {
        vector3(1393.45, 1161.01, 114.48),
    },
}
