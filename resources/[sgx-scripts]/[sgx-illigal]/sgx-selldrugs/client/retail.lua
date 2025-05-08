RegisterNetEvent("SellDrugs:Start", function()
    CreateThread(function()
        sellingDrugs = true
        local ped = PlayerPedId()

        while sellingDrugs do
            local player_coords = GetEntityCoords(ped)
            for _, v in ipairs(GetGamePool("CPed")) do
                if not Potential_Clients["ped"..v] and not Blocked_Clients["ped"..v] and not IsPedAPlayer(v) and GetPedType(v) ~= 28 and not IsPedInAnyVehicle(v, false) and not IsPedDeadOrDying(v) and not IsEntityPositionFrozen(v) and IsEntityAPed(v) and not IsEntityAVehicle(v) then
                    local Client_Coords = GetEntityCoords(v)
                    if Client_Coords.x ~= 0.0 and Client_Coords.y ~= 0.0 and Client_Coords.z ~= 0.0 then
                        local distance = #(player_coords - Client_Coords)
                        if distance < 15.0 then
                            options = { 
                                { 
                                    num = 1,
                                    icon = 'fa-solid fa-comments',
                                    label = translate("client", "target_retail_sell_drugs"),
                                    action = function()
                                        if not IsPedInAnyVehicle(ped, false) then
                                            Start_Interaction(v)
                                        else
                                            clientNotify(translate("client", "notify_exit_vehicle"), "error", 5000)
                                        end
                                    end,
                                }
                            }
                            AddTargetEntity(v, options, 5.0)

                            Potential_Clients["ped"..v] = v
                        end
                    end
                end
            end

            for k, v in pairs(Potential_Clients) do
                local Client_Coords = GetEntityCoords(v)
                local distance = #(player_coords - Client_Coords)
    
                if distance > 15.0 then
                    RemoveTargetEntity(v)
                    Potential_Clients[k] = nil
                end
            end
            Wait(1500)
        end
    end)
end)

function Start_Interaction(buyer)
    CreateThread(function()
        local ped = PlayerPedId()

        TriggerServerEvent("SellDrugs:Add_Blocked_Client", NetworkGetNetworkIdFromEntity(buyer))
        cfg.Prefix.Functions.TriggerCallback('SellDrugs:Start_Interaction', function(result)
            if result.drugs ~= nil then
                local playerDrugs = {}
                for k, v in pairs(result.drugs) do
                    table.insert(playerDrugs, {name = k, amount = v.amount, label = v.label, img = "img/inventory/"..k..".png"})
                end
                ClearPedTasks(buyer)
                SetPedCanBeTargetted(buyer, false)
                TaskSetBlockingOfNonTemporaryEvents(buyer, true)
                SetPedDiesWhenInjured(buyer, false)
                SetEntityInvincible(buyer, true)
                TaskLookAtEntity(ped, buyer, -1)
                TaskLookAtEntity(buyer, ped, -1)
                local FaceToFace = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
                TaskGoToCoordAnyMeans(buyer, FaceToFace.x, FaceToFace.y, FaceToFace.z, 1.0)

                local timer = 7500

                while true do
                    local distance = #(GetEntityCoords(buyer) - FaceToFace)
                    DisableAllControlActions()

                    if distance < 1.0 and not IsPedWalking(buyer) then
                        TaskStandStill(buyer, -1)
                        break
                    end

                    if timer <= 0 then
                        SetEntityCoords(buyer, FaceToFace.x, FaceToFace.y, FaceToFace.z)
                        TaskStandStill(buyer, -1)
                        break
                    end
                    Wait(0)
                    timer = timer - 10
                end

                TaskTurnPedToFaceEntity(buyer, ped, -1)
                TaskTurnPedToFaceEntity(ped, buyer, -1)

                Wait(1500)

                FreezeEntityPosition(buyer, true)
                TriggerServerEvent("SellDrugs:Send_Speech", NetworkGetNetworkIdFromEntity(buyer), "GENERIC_HI", "SPEECH_PARAMS_STANDARD")
                local gender = nil
                if IsPedMale(buyer) then gender = "Male" else gender = "Female" end
                local Random_Anim = Start_Animation[gender][math.random(1, #Start_Animation[gender])]
                TriggerServerEvent("SellDrugs:Send_Animation", NetworkGetNetworkIdFromEntity(buyer), Random_Anim.dict, Random_Anim.anim, 8.0, -1, true)
                cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
                AttachCamToEntity(cam, buyer, 0.0, 0.45, 0.55, true)
                SetCamRot(cam, 0.0, 0.0, (GetEntityHeading(buyer) - 180))
                SetCamFov(cam, 100.0)
                RenderScriptCams(true, true, 1500, 1, 0)
                SetNuiFocus(true, true)

                toggleNPCSellNUI(true, playerDrugs, result.stats)

                UsingPed = buyer

                while UsingPed do
                    if IsPedWalking(UsingPed) or IsPedRunning(UsingPed) then
                        ClearPedTasksImmediately(buyer)
                        TriggerServerEvent("SellDrugs:Send_Animation", NetworkGetNetworkIdFromEntity(buyer), Random_Anim.dict, Random_Anim.anim, 8.0, -1, true)
                        break
                    end
                    Wait(0)
                end

                local Call_Police = math.random(1, 100)
                if Call_Police <= 50 then
                    CreateThread(function()
                        local Close_Peds = {}

                        for k, v in pairs(Potential_Clients) do
                            table.insert(Close_Peds, v)
                        end

                        if #Close_Peds > 0 then
                            local Random_Ped = Close_Peds[math.random(1, #Close_Peds)]
                            TriggerServerEvent("SellDrugs:Add_Blocked_Client", NetworkGetNetworkIdFromEntity(Random_Ped))
                            ClearPedTasksImmediately(Random_Ped)
                            SetEntityHeading(Random_Ped, Face_To_Face(Random_Ped, ped))
                            TriggerServerEvent("SellDrugs:Send_Speech", NetworkGetNetworkIdFromEntity(Random_Ped), "GENERIC_SHOCKED_MED", "SPEECH_PARAMS_STANDARD")
                            Wait(1000)
                            TriggerServerEvent("SellDrugs:Send_Animation", NetworkGetNetworkIdFromEntity(Random_Ped), "cellphone@", "cellphone_call_listen_base", 8.0, -1, false)
                            local PhoneObj = CreateObject(GetHashKey('prop_phone_taymckenzienz'), 0.0, 0.0, 0.0, true, true, false)
                            AttachEntityToEntity(PhoneObj, Random_Ped, GetPedBoneIndex(Random_Ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, true, false, false, 0, true)
                            TriggerServerEvent("SellDrugs:Send_Speech", NetworkGetNetworkIdFromEntity(Random_Ped), "GENERIC_HOWS_IT_GOING", "SPEECH_PARAMS_STANDARD")
                            Wait(5000)
                            DeleteObject(PhoneObj)
                            ClearPedTasks(Random_Ped)
                            SetPedAsNoLongerNeeded(Random_Ped)
                            Dispatch(GetEntityCoords(Random_Ped), Random_Ped)
                        end
                    end)
                end
            end
        end)
    end)
end

RegisterNetEvent("SellDrugs:Stop", function()
    sellingDrugs = false
    for _, v in pairs(Potential_Clients) do
        RemoveTargetEntity(v)
    end
    Potential_Clients = {}
end)


RegisterNetEvent("SellDrugs:Get_Blocked_Client", function(network)
    if NetworkDoesNetworkIdExist(network) then
        local entity = NetworkGetEntityFromNetworkId(network)

        if entity ~= 0 then
            if Potential_Clients["ped"..entity] then
                RemoveTargetEntity(entity)
                Potential_Clients["ped"..entity] = nil
                Blocked_Clients["ped"..entity] = entity
            end
            CreateThread(function()
                Wait(180000)
                Blocked_Clients["ped"..entity] = nil
            end)
        end
    end
end)