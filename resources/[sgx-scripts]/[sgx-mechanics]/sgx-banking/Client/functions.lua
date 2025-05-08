function IsPlayerNearAccessLocation() 
    local MenuAccessible = false

    for k,v in ipairs(Config.Locations) do 
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x,v.y,v.z) < 3 then 
            MenuAccessible = true
            break
        end
    end

    return MenuAccessible
end