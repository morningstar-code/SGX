local Translations = {
    categories = {
        openwheel = "Open Wheels",
        sedans = "Sedans",
        sportsclassics = "Sports Classics",
        commercial = "Commercial",
        offroad = "Off-Road",
        cycles = "Cycles",
        boats = "Boats",
        military = "Military",
        motorcycles = "Motorcycles",
        industrial = "Industrial",
        helicopters = "Helicopters",
        vans = "Vans",
        super = "Super Sports",
        sports = "Sports",
        coupes = "Coupes",
        emergency = "Emergency",
        muscle = "Muscles",
        compacts = "Compacts",
        utility = "Utility",
        suvs = "SUVs",
        service = "Services",
        planes = "Planes"
    },
    commands = {
        add_vehicle_stock = "Add Stock To Vehicle"
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})