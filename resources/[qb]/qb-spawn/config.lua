Config = {
    Core = "qb", -- qb - QBCore | newesx - New ES Extended
    WeatherEvent = "qb-weathersync:client:SyncWeather",
    SpawnCoords = {
        -- Example (UI X means left, UI Y means top): {label = "Label here", icon = "Icon here (Font Awesome Pro Icons - https://fontawesome.com/v5/search)", coords = vector3(-2041.12, -368.13, 48.1), heading = 0.0, ui = {x = 40, y = 40}},
        {label = "Sandy Shores", icon = "fas fa-bacon", coords = vector3(1792.0, 3643.49, 34.49), heading = 120.85, ui = {x = 65, y = 70}},
        {label = "Maze Bank", icon = "fad fa-building", coords = vector3(-1380.98, -505.05, 33.16), heading = 3.16, ui = {x = 31, y = 24.0}},
        {label = "Paleto Bay", icon = "fas fa-warehouse", coords = vector3(-420.28, 5982.39, 31.52), heading = 319.27, ui = {x = 85, y = 42.0}},
        {label = "Train Station", icon = "fa fa-train", coords = vector3(-207.69, -1018.57, 30.14), heading = 70.87, ui = {x = 26.5, y = 42}},
        {label = "LS Airport", icon = "fas fa-plane-alt", coords = vector3(-1042.42, -2746.16, 21.36), heading = 333.73, ui = {x = 10, y = 27.0}},
        {label = "Del Perro Pier", icon = "far fa-swimming-pool", coords = vector3(-1594.45, -963.16, 13.02), heading = 129.94, ui = {x = 23, y = 17}},
    },
    Infos = {
        ["date"] = true,
        ["weather"] = true,
        ["windSpeed"] = true,
        ["temperature"] = true,
        ["playerCount"] = true,
    },
    TemperatureType = "c", -- f - Fahrenheit° | c - Celsius
    WeatherIcons = {
        ["EXTRASUNNY"] = "fas fa-sun",
        ["CLEAR"] = "fas fa-sun-haze",
        ["NEUTRAL"] = "fas fa-sun-dust",
        ["SMOG"] = "fas fa-smog",
        ["FOGGY"] = "fas fa-fog",
        ["OVERCAST"] = "fas fa-clouds",
        ["CLOUDS"] = "fas fa-clouds",
        ["CLEARING"] = "fad fa-sun-cloud",
        ["HALLOWEEN"] = "fas fa-cloud-rainbow",
        ["RAIN"] = "fas fa-cloud-showers",
        ["THUNDER"] = "fad fa-thunderstorm",
        ["BLIZZARD"] = "fad fa-cloud-snow",
        ["SNOWLIGHT"] = "fad fa-cloud-hail",
        ["XMAS"] = "fad fa-snow-blowing",
        ["SNOW"] = "fad fa-snowflake",
    },
    EnableLastLocation = true
}