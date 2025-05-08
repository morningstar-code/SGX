CreateThread(function()
    if Config.InteractionHandler == 'qb-target' then
        for k,v in pairs(Config.pumpModels) do
            exports['qb-target']:AddTargetModel(k, {
                options = {
                    {
                        type = "client",
                        icon = 'fa-solid fa-gas-pump',
                        label = Config.Locales['GRAB_NOZZLE'] .. ' / ' .. Config.Locales['PUT_NOZZLE'],
                        action = function()
                            if pumpGrabbed then
                                deleteNozzle()
                            else
                                local pumpObject, pumpDistance = FindNearestFuelPump()
                                grabNozzle(GetEntityCoords(pumpObject),pumpObject)
                            end
                        end
                    },
                },
                distance = 4.0
            })
        end
    elseif Config.InteractionHandler == 'ox-target' then
        for k, v in pairs(Config.pumpModels) do
            options = { 
                icon = 'fa-solid fa-gas-pump',
                label = Config.Locales['GRAB_NOZZLE'] .. ' / ' .. Config.Locales['PUT_NOZZLE'],
                onSelect = function(data)
                    if pumpGrabbed then
                        deleteNozzle()
                    else
                        local pumpObject, pumpDistance = FindNearestFuelPump()
                        grabNozzle(GetEntityCoords(pumpObject),pumpObject)
                    end
                end
            }
            distance = 1.5
            exports['ox_target']:addModel(k, options)
        end
    elseif Config.InteractionHandler == 'drawtext' then
        local isTextUiOpen = false
        CreateThread(function()
            while true do
                local wait = 1500
                local playerPed = PlayerPedId()
                local coords = GetEntityCoords(playerPed)
                local isInZone = false
                local obj = isNearPump
                local distance = #(coords - GetEntityCoords(obj))
                if distance < 1.2 then
                    wait = 5
                    isInZone = true
                    label = pumpGrabbed == false and '[E] ' .. Config.Locales['GRAB_NOZZLE'] or '[E] ' .. Config.Locales['PUT_NOZZLE']
                    if not isTextUiOpen and Config.CodemTextUI then
                        exports["codem-textui"]:OpenTextUI(label, 'E', 'thema-6')
                        isTextUiOpen = true
                    elseif not Config.CodemTextUI then
                        DrawText3D(GetEntityCoords(obj).x, GetEntityCoords(obj).y, GetEntityCoords(obj).z + 1.0, label)
                    end

                    if IsControlJustReleased(0, 38) then
                        if pumpGrabbed then
                            deleteNozzle()
                        else
                            grabNozzle(GetEntityCoords(obj),obj)
                        end
                    end
                end

                if isTextUiOpen and not isInZone and Config.CodemTextUI then
                    exports["codem-textui"]:CloseTextUI()
                    isTextUiOpen = false
                end

                Wait(wait)
            end
        end)
    end
end)