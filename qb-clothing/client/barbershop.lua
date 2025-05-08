barberShops = {
	{1932.0756835938, 3729.6706542969, 32.844413757324},
	{-278.19036865234, 6228.361328125, 31.695510864258},
	{1211.9903564453, -472.77117919922, 66.207984924316},
	{-33.224239349365, -152.62608337402, 57.076496124268},
	{136.7181854248, -1708.2673339844, 29.291622161865},
	{-815.18896484375, -184.53868103027, 37.568943023682},
	{-1283.2886962891, -1117.3210449219, 6.9901118278503}
}

Barbers = {
	[1] = {shopType = 'barber', coords = vector3(-814.3, -183.8, 36.6), width = 2, length = 2},
    [2] = {shopType = 'barber', coords = vector3(136.8, -1708.4, 28.3), width = 2, length = 2},
    [3] = {shopType = 'barber', coords = vector3(-1282.6, -1116.8, 6.0), width = 2, length = 2},
    [4] = {shopType = 'barber', coords = vector3(1931.5, 3729.7, 31.8), width = 2, length = 2},
    [5] = {shopType = 'barber', coords = vector3(1212.8, -472.9, 65.2), width = 2, length = 2},
    [6] = {shopType = 'barber', coords = vector3(-32.9, -152.3, 56.1), width = 2, length = 2},
    [7] = {shopType = 'barber', coords = vector3(-278.1, 6228.5, 30.7), width = 2, length = 2}
}

Citizen.CreateThread(function()
    for k, v in pairs (Barbers) do
        if Barbers[k].shopType == "barber" then
            local barberShop = AddBlipForCoord(Barbers[k].coords)
            SetBlipSprite(barberShop, 71)
            SetBlipColour(barberShop, 0)
            SetBlipScale  (barberShop, 0.7)
            SetBlipAsShortRange(barberShop, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Barber")
            EndTextCommandSetBlipName(barberShop)
        end
	end
end)