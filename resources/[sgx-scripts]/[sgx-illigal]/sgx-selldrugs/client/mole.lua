CreateThread(function()
    while true do
        for mole, _ in pairs(cfg.Mole) do
            for k, v in pairs(cfg.Mole[mole]) do

                local distance = #(GetEntityCoords(PlayerPedId()) - vector3(v.coords.x, v.coords.y, v.coords.z))

                if distance < 150.0 then
                    if v.ped == nil then
                        v.ped = Create_Ped(v.ped_model, v.coords, v.coords.w, false)
                        SetPedDiesWhenInjured(v.ped, false)
                        SetEntityInvincible(v.ped, true)
            
                        Play_Anim(v.ped, "amb@world_human_guard_patrol@male@idle_a", "idle_c", 8.0, -1)
            
                        options = { 
                            { 
                                num = 1,
                                icon = 'fa-solid fa-comments',
                                label = translate('client', 'target_buy_subscription'),
                                action = function()
                                    local boolean = showModal(k.." ("..translate("client", "modal_mole_name")..")", translate("client", "modal_buy_subscription", reformatInt(v.price), cfg.Mole_Settings.Subscription))

                                    if boolean then
                                        TriggerServerEvent("SellDrugs:Buy_Subscription", mole, k)
                                    end
                                end,
                            },
                            { 
                                num = 2,
                                icon = 'fa-solid fa-money-bill-wave',
                                label = translate("client", "target_buy_phone"),
                                action = function()
                                    local boolean = showModal(k.." ("..translate("client", "modal_mole_name")..")", translate("client", "modal_buy_phone", reformatInt(cfg.Phone.Price) ))

                                    if boolean then
                                        TriggerServerEvent("SellDrugs:Buy_Trap_Phone")
                                    end
                                end,
                            }
                        }
                        AddTargetEntity(v.ped, options, 2.5)
                    end
                else
                    if v.ped ~= nil then
                        RemoveTargetEntity(v.ped)
                        DeletePed(v.ped)
                    end
                end
            end
        end
        Wait(3000)
    end
end)

RegisterNetEvent("SellDrugs:Mole_Subscription_Information", function(mole_name)
    sendMolePhoneMessage(mole_name, translate("client", "phone_mole_buy_message"))
end)

RegisterNetEvent("SellDrugs:Activate_Mole", function(mole_type, mole_name)
    CreateThread(function()
        local v = cfg.Mole[mole_type][mole_name]

        v.Nearby_Police = {}
        v.blip = Create_Blip("blip", {Coords = vector3(v.coords.x, v.coords.y, v.coords.z), Sprite = cfg.Mole_Settings.Blip["Mole"].Sprite, Scale = cfg.Mole_Settings.Blip["Mole"].Scale, Color = cfg.Mole_Settings.Blip["Mole"].Color, Text = cfg.Mole_Settings.Blip["Mole"].Text})
        v.radius = Create_Blip("radius", {Coords = vector3(v.coords.x, v.coords.y, v.coords.z), Distance = cfg.Mole_Settings.Distance[mole_type], Color = cfg.Mole_Settings.Blip["Mole"].Color})

        while v.blip and v.radius do
            for k, value in pairs(Police) do
                if value.entity ~= 0 and not v.Nearby_Police[k] then
                    local Officer_Coords = GetEntityCoords(value.entity)
                    local distance = #(vector3(v.coords.x, v.coords.y, v.coords.z) - Officer_Coords)

                    if distance < cfg.Mole_Settings.Distance[mole_type] then
                        v.Nearby_Police[k] = {timer = 0}
                        v.Nearby_Police[k].blip = Create_Blip("blip", {Coords = Officer_Coords, Sprite = cfg.Mole_Settings.Blip["Police"].Sprite, Scale = cfg.Mole_Settings.Blip["Police"].Scale, Color = cfg.Mole_Settings.Blip["Police"].Color, Text = cfg.Mole_Settings.Blip["Police"].Text})
                        sendMolePhoneMessage(mole_name, randomTranslate("client", "phone_mole_message"))
                    end
                end
            end
            Wait(1000)
            for k, value in pairs(v.Nearby_Police) do
                if value.timer >= (cfg.Mole_Settings.Blip["Police"].Duration * 1000) then
                    RemoveBlip(value.blip)
                    v.Nearby_Police[k] = nil
                end
                value.timer = value.timer + 1000
            end
        end
    end)
end)

RegisterNetEvent("SellDrugs:Deactivate_Mole", function(mole_type, mole_name)
    local mole = cfg.Mole[mole_type][mole_name]

    RemoveBlip(mole.blip)
    RemoveBlip(mole.radius)
    mole.blip = nil
    mole.radius = nil
    for _, v in pairs(mole.Nearby_Police) do
        RemoveBlip(v.blip)
    end
    mole.Nearby_Police = {}
end)