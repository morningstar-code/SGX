CreateThread(function()
	RequestIpl('banner_milo_')

    interiorID = GetInteriorAtCoords(-312.067627, -1042.79541, 66.87765)
        
    
    if IsValidInterior(interiorID) then      
        EnableInteriorProp(interiorID, "Main")
        EnableInteriorProp(interiorID, "Main_detail")
        EnableInteriorProp(interiorID, "doubleroom_hab_a")
        EnableInteriorProp(interiorID, "Bath")
        EnableInteriorProp(interiorID, "Bath2")
        EnableInteriorProp(interiorID, "Toilet")
        EnableInteriorProp(interiorID, "doubleroom_nohab")
        
        RefreshInterior(interiorID)

    end
end)