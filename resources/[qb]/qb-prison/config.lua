Config = {}
Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.Jobs = {
    ['electrician'] = 'Electrician'
}

Config.Uniforms = {
    ['male'] = {
        outfitData = {
            ['t-shirt'] = { item = 15, texture = 0 },
            ['torso2'] = { item = 345, texture = 0 },
            ['arms'] = { item = 19, texture = 0 },
            ['pants'] = { item = 3, texture = 7 },
            ['shoes'] = { item = 1, texture = 0 },
        }
    },
    ['female'] = {
        outfitData = {
            ['t-shirt'] = { item = 14, texture = 0 },
            ['torso2'] = { item = 370, texture = 0 },
            ['arms'] = { item = 0, texture = 0 },
            ['pants'] = { item = 0, texture = 12 },
            ['shoes'] = { item = 1, texture = 0 },
        }
    },
}

Config.Locations = {
    freedom = vector4(1790.39, 2552.92, 44.67, 88.67),
    outside = vector4(1832.25, 2594.30, 46.01, 265.06),
    yard = vector4(1754.29, 2502.01, 45.63, 24.67),
    middle = vector4(1693.23, 2575.73, 52.41, 39.38),
    spawns = {
        { coords = vector4(1742.49, 2488.02, 49.42, 205.14) },
        { coords = vector4(1752.43, 2470.36, 49.42, 35.89) },
        { coords = vector4(1745.56, 2489.56, 49.42, 193.42) },
        { coords = vector4(1755.90, 2471.39, 49.42, 34.25) },
        { coords = vector4(1749.23, 2491.02, 49.42, 203.97) },
        { coords = vector4(1758.09, 2474.61, 49.42, 29.57) },
        { coords = vector4(1751.58, 2492.46, 49.42, 206.37) },
        { coords = vector4(1760.97, 2475.34, 49.42, 29.68) },
        { coords = vector4(1754.36, 2494.45, 49.42, 210.47) },
        { coords = vector4(1764.47, 2477.00, 49.42, 29.90) },
        { coords = vector4(1757.64, 2496.60, 49.43, 202.93) }
    },
    jobs = {
        electrician = {
            { coords = vector4(1694.64, 2469.16, 46.05, 176.48) },
            { coords = vector4(1719.48, 2488.15, 46.05, 179.92) },
            { coords = vector4(1723.40, 2505.34, 46.10, 208.50) },
            { coords = vector4(1767.24, 2530.69, 46.21, 209.33) },
            { coords = vector4(1652.51, 2564.94, 45.86, 353.27) },
            { coords = vector4(1629.94, 2564.89, 46.02, 326.97) },
            { coords = vector4(1618.64, 2521.05, 46.06, 126.65) }
        }
    }
}
