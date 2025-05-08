RegisterNetEvent("SellDrugs:Wholesale_Offer", function(itemName)
    local npcID = generateRandomString(6)
    addPhoneConversation(npcID, itemName)
end)

RegisterNetEvent("SellDrugs:Wholesale", function(index)
    CreateThread(function()

        wholesale = cfg.Wholesale[index]
        peds = {}
        car = nil
        local check_weapon = 0
        local start_attack = false
        local inform = true
        local ped = PlayerPedId()

        while wholesale do
            local distance = #(GetEntityCoords(ped) - vector3(wholesale.Coords.x, wholesale.Coords.y, wholesale.Coords.z))
            local ped_weapon = GetWeapontypeModel(GetSelectedPedWeapon(ped))
            
            if distance < 50.0 then
                if inform then
                    TriggerServerEvent("SellDrugs:Wholesale_In_Range")
                    clientNotify(translate("client", "notify_wholesale_info"), "primary", 5000)
                    clientNotify(translate("client", "notify_wholesale_info2"), "error", 5000)
                    inform = false
                end

                if not start_attack and #peds == 3 and car then
                    for _, v in pairs(cfg.Wholesale_Settings.Guns_Whitelist) do
                        if ped_weapon ~= GetWeapontypeModel(v) then
                            check_weapon = check_weapon + 1
                        end
                    end

                    if check_weapon == #cfg.Wholesale_Settings.Guns_Whitelist then
                        for _,v in ipairs(peds) do
                            if v.isBuyer then
                                RemoveTargetEntity(v.entity)
                                break
                            end
                        end
                        start_attack = true
                        Wholesale_Attack()
                        clientNotify(translate("client", "notify_wholesale_fail_weapon", cfg.Wholesale_Settings.Remove_Respect), "error", 5000)
                    else
                        check_weapon = 0
                    end
                end

                if wholesale and #peds ~= 3 and car == nil then
                    cfg.Prefix.Functions.SpawnVehicle(wholesale.Vehicle, function(vehicle)
                        SetEntityHeading(vehicle, wholesale.Coords.w)
                        SetVehicleDirtLevel(vehicle, 0.0)
                        SetVehicleCustomPrimaryColour(vehicle, 255, 255, 255)
                        SetVehicleCustomSecondaryColour(vehicle, 255, 255, 255)
                        SetVehicleExtraColours(vehicle, 131, 131)
                        SetVehicleNumberPlateText(vehicle, "INS "..generateRandomString(3))
                        SetVehicleEngineOn(vehicle, false, false)
                        SetVehicleDoorsLocked(vehicle, 2)
                        SetVehicleDoorOpen(vehicle, 5, false, true)
                        FreezeEntityPosition(vehicle, true)
                        car = vehicle
                    end, vector3(wholesale.Coords.x, wholesale.Coords.y, wholesale.Coords.z))

                    for i, v in pairs(wholesale.Peds) do
                        if v.isBuyer then
                            local Coords = GetOffsetFromEntityInWorldCoords(car, 0.0, -5.0, 0.0)
                            local Buyer = Create_Ped(v.model, Coords, wholesale.Coords.w - 180, true)
                            SetPedDiesWhenInjured(Buyer, false)
                            SetEntityInvincible(Buyer, true)
                            table.insert(peds, {isBuyer = true, entity = Buyer})

                            TriggerServerEvent("SellDrugs:Send_Animation", NetworkGetNetworkIdFromEntity(Buyer), "amb@world_human_guard_patrol@male@idle_a", "idle_c", 8.0, -1, true)

                            options = { 
                                { 
                                    num = 1,
                                    icon = 'fa-solid fa-comments',
                                    label = translate("client", "target_wholesale_exchange"),
                                    action = function()
                                        RemoveTargetEntity(Buyer)
                                        cfg.Prefix.Functions.TriggerCallback('SellDrugs:Wholesale_Trade', function(result)
                                            if result then
                                                Wholesale_Trade(Buyer)
                                            else
                                                clientNotify(translate("client", "notify_wholesale_fail_drug", cfg.Wholesale_Settings.Remove_Respect), "error", 5000)
                                                Wholesale_Attack()
                                            end
                                        end)
                                    end,
                                }
                            }
                            AddTargetEntity(Buyer, options, 2.5)
                        else
                            local Offset = -2.0
                            if #peds == 2 then
                                Offset = math.abs(Offset)
                            end
                            local Coords = GetOffsetFromEntityInWorldCoords(car, Offset, -5.0, 0.0)
                            local Bodyguard = Create_Ped(v.model, Coords, wholesale.Coords.w - 180, true)
                            SetPedDiesWhenInjured(Bodyguard, false)
                            SetEntityInvincible(Bodyguard, true)
                            table.insert(peds, {entity = Bodyguard})

                            TaskStartScenarioInPlace(Bodyguard, 'WORLD_HUMAN_GUARD_STAND', -1, true)
                        end
                    end
                end
            elseif distance > 50.0 and not inform then
                if car and #peds > 0 then
                    cfg.Prefix.Functions.DeleteVehicle(car)
                    for _, v in ipairs(peds) do
                        DeletePed(v.entity)
                        if v.isBuyer then
                            RemoveTargetEntity(v.entity)
                        end
                    end
                end
                clientNotify(translate("client", "notify_wholesale_fail_distance", cfg.Wholesale_Settings.Respect), "error", 5000)
                TriggerServerEvent("SellDrugs:Wholesale_Clear_Place", true)
                wholesale = nil
                car = nil
                peds = {}
            end
            Wait(0)
        end
    end)
end)

function Wholesale_Trade(buyer)
    local ped = PlayerPedId()

    TriggerServerEvent("SellDrugs:Send_Speech", NetworkGetNetworkIdFromEntity(buyer), "GENERIC_HI", "SPEECH_PARAMS_STANDARD")
    local Random_Anim = Trade_Animation[math.random(1, #Trade_Animation)]
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, Face_To_Face(ped, buyer))
    SetEntityHeading(buyer, Face_To_Face(buyer, ped))
    TriggerServerEvent("SellDrugs:Send_Animation", NetworkGetNetworkIdFromEntity(ped), Random_Anim.dict, Random_Anim.anim, 8.0, Random_Anim.duration, true)
    TriggerServerEvent("SellDrugs:Send_Animation", NetworkGetNetworkIdFromEntity(buyer), Random_Anim.dict, Random_Anim.anim, 8.0, Random_Anim.duration, true)
    local DrugObj = CreateObject(GetHashKey('v_ret_ml_cigs3'), 0.0, 0.0, 0.0, true, true, false)
    local CashObj = CreateObject(GetHashKey('prop_anim_cash_pile_01'), 0.0, 0.0, 0.0, true, true, false)
    AttachEntityToEntity(CashObj, buyer, GetPedBoneIndex(buyer,  57005), 0.1, 0.01, -0.02, 0.0, 0.0, -90.0, false, true, false, false, 0, true)
    AttachEntityToEntity(DrugObj, ped, GetPedBoneIndex(ped,  57005), 0.1, 0.01, -0.02, -90.0, 0.0, -90.0, false, true, false, false, 0, true)
    Wait(Random_Anim.swap)
    DetachEntity(DrugObj, true, true)
    DetachEntity(CashObj, true, true)
    AttachEntityToEntity(CashObj, ped, GetPedBoneIndex(ped,  57005), 0.1, 0.01, -0.02, 0.0, 0.0, -90.0, false, true, false, false, 0, true)
    AttachEntityToEntity(DrugObj, buyer, GetPedBoneIndex(buyer,  57005), 0.1, 0.01, -0.02, -90.0, 0.0, -90.0, false, true, false, false, 0, true)
    Wait(Random_Anim.duration - Random_Anim.swap)
    DeleteObject(CashObj)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    for _, npc in pairs(peds) do
        FreezeEntityPosition(npc.entity, false)
    end

    local Trunk_Coords = GetWorldPositionOfEntityBone(car, GetEntityBoneIndexByName(car, 'boot'))
    TaskGoToCoordAnyMeans(buyer, Trunk_Coords.x, Trunk_Coords.y, Trunk_Coords.z, 1.0, 0, false, "move_m@gangster@generic", 0)

    while true do
        local distance = #(GetEntityCoords(buyer) - Trunk_Coords)

        if not IsPedWalking(buyer) and distance < 2.0 then
            break
        end
        Wait(0)
    end

    TriggerServerEvent("SellDrugs:Send_Animation", NetworkGetNetworkIdFromEntity(buyer), "mp_common", "givetake1_a", 8.0, 2000, true)
    Wait(2000)
    TriggerServerEvent("SellDrugs:Send_Speech", NetworkGetNetworkIdFromEntity(buyer), "GENERIC_THANKS", "SPEECH_PARAMS_STANDARD")
    DeleteObject(DrugObj)
    SetVehicleDoorsLocked(car, 0)
    SetVehicleDoorShut(car, 5, false)
    FreezeEntityPosition(car, false)

    local Seat_Index = {-1, 1, 2}

    for _, npc in ipairs(peds) do
        ClearPedTasksImmediately(npc.entity)
        for i, seat in ipairs(Seat_Index) do
            npc.seat = seat
            table.remove(Seat_Index, i)
            break
        end
    end

    local inVehicle = 0
    local timer = 7500

    while true do
        for _, npc in ipairs(peds) do
            if npc.seat then
                if GetVehiclePedIsTryingToEnter(npc.entity) ~= car then
                    TaskEnterVehicle(npc.entity, car, 1.0, npc.seat)
                end

                if IsPedInVehicle(npc.entity, car, false) then
                    npc.seat = nil
                    inVehicle = inVehicle + 1
                end

                if timer == 0 then
                    TaskWarpPedIntoVehicle(npc.entity, car, npc.seat)
                    npc.seat = nil
                    inVehicle = inVehicle + 1
                end
            end
        end

        if inVehicle == #peds then break end
        Wait(500)
        timer = timer - 500
    end

    SetVehicleEngineOn(car, true, false, false)
    SetPedAsNoLongerNeeded(buyer)
    SetBlockingOfNonTemporaryEvents(buyer, false)
    Wait(15000)
    for _, v in pairs(peds) do
        DeletePed(v.entity)
    end
    cfg.Prefix.Functions.DeleteVehicle(car)
    TriggerServerEvent("SellDrugs:Wholesale_Clear_Place", false)
    wholesale = nil
    car = nil
    peds = {}
end

function Wholesale_Attack(buyer)
    local ped = PlayerPedId()

    local Alive_Peds = {}

    for _, v in ipairs(peds) do
        table.insert(Alive_Peds, v)
        ClearPedTasksImmediately(v.entity)
        FreezeEntityPosition(v.entity, false)
        SetPedDiesWhenInjured(v.entity, true)
        SetEntityInvincible(v.entity, false)
        SetPedRelationshipGroupHash(v.entity, GetHashKey("AGGRESSIVE_INVESTIGATE"))
        GiveWeaponToPed(v.entity, wholesale.Gun, 100, false, true)
        TaskCombatPed(v.entity, ped, 0, 16)
    end

    local scenario = nil

    while true do
        for i, v in ipairs(Alive_Peds) do
            if IsPedDeadOrDying(v.entity) then
                table.remove(Alive_Peds, i)
            end
        end

        if IsPedDeadOrDying(ped) then
            scenario = "ped_dead"
            break
        end

        if #Alive_Peds == 0 then scenario = "enemy_dead" break end
        Wait(0)
    end

    if scenario == "ped_dead" then
        for _, v in ipairs(Alive_Peds) do
            SetPedDiesWhenInjured(v.entity, false)
            SetEntityInvincible(v.entity, true)
        end

        local Random_Ped = Alive_Peds[1]
        local Dead_Coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)

        SetVehicleDoorsLocked(car, 0)
        SetVehicleDoorShut(car, 5, false)
        FreezeEntityPosition(car, false)

        local Seat_Index = {-1, 1, 2}

        for _, v in ipairs(Alive_Peds) do
            ClearPedTasksImmediately(v.entity)
            for i, seat in ipairs(Seat_Index) do
                v.seat = seat
                table.remove(Seat_Index, i)
                break
            end
        end

        local inVehicle = 0
        local timer = 5000

        if #Alive_Peds > 1 then
            while true do
                for _, v in pairs(Alive_Peds) do
                    if v.seat and v.entity ~= Random_Ped.entity then
                        if GetVehiclePedIsTryingToEnter(v.entity) ~= car then
                            TaskEnterVehicle(v.entity, car, -1, v.seat, 2.0)
                        end

                        if IsPedInVehicle(v.entity, car, false) then
                            v.seat = nil
                            inVehicle = inVehicle + 1
                        end

                        if timer == 0 then
                            TaskWarpPedIntoVehicle(v.entity, car, v.seat)
                            v.seat = nil
                            inVehicle = inVehicle + 1
                        end
                    end
                end

                if inVehicle == (#Alive_Peds - 1) then break end
                Wait(500)
                timer = timer - 500
            end
        end

        TaskGoToCoordAnyMeans(Random_Ped.entity, Dead_Coords.x, Dead_Coords.y, Dead_Coords.z, 2.0)
        timer = 6000

        while true do
            local distance = #(GetEntityCoords(Random_Ped.entity) - Dead_Coords)

            if not IsPedWalking(Random_Ped.entity) and distance < 1.5 then
                TaskStandStill(Random_Ped.entity, -1)
                Wait(500)
                SetEntityHeading(Random_Ped.entity, Face_To_Face(Random_Ped.entity, ped))
                TriggerServerEvent("SellDrugs:Send_Animation", NetworkGetNetworkIdFromEntity(Random_Ped.entity), "mp_common", "givetake1_a", 8.0, 2000, true)
                Wait(1000)
                local CashObj = CreateObject(GetHashKey('prop_anim_cash_pile_01'), 0.0, 0.0, 0.0, true, true, false)
                AttachEntityToEntity(CashObj, Random_Ped.entity, GetPedBoneIndex(Random_Ped.entity,  57005), 0.1, 0.01, -0.02, 0.0, 0.0, -90.0, false, true, false, false, 0, true)
                Wait(1000)
                DeleteObject(CashObj)
                break
            end
            Wait(500)
            timer = timer - 500
            if timer <= 0 then SetEntityCoords(Random_Ped.entity, Dead_Coords) end
        end

        TriggerServerEvent("SellDrugs:Wholesale_Attack", scenario)
        TriggerServerEvent("SellDrugs:Send_Speech", NetworkGetNetworkIdFromEntity(Random_Ped.entity), "GENERIC_THANKS", "SPEECH_PARAMS_STANDARD")

        timer = 5000

        while true do
            if GetVehiclePedIsTryingToEnter(Random_Ped.entity) ~= car then
                TaskEnterVehicle(Random_Ped.entity, car, -1, Random_Ped.seat, 2.0)
            end

            if IsPedInVehicle(Random_Ped.entity, car, false) then
                Random_Ped.seat = nil
                inVehicle = inVehicle + 1
            end

            if timer == 0 then
                TaskWarpPedIntoVehicle(Random_Ped.entity, car, Random_Ped.seat)
                Random_Ped.seat = nil
                inVehicle = inVehicle + 1
            end

            if inVehicle == #Alive_Peds then break end
            Wait(500)
            timer = timer - 500
        end

        TriggerServerEvent("SellDrugs:Send_Speech", NetworkGetNetworkIdFromEntity(Random_Ped.entity), "GENERIC_BYE", "SPEECH_PARAMS_STANDARD")
        SetVehicleEngineOn(car, true, false, false)
        SetPedAsNoLongerNeeded(Random_Ped.entity)
        SetBlockingOfNonTemporaryEvents(Random_Ped.entity, false)
        Wait(15000)
        for _, v in pairs(peds) do
            DeletePed(v.entity)
        end
        cfg.Prefix.Functions.DeleteVehicle(car)
        TriggerServerEvent("SellDrugs:Wholesale_Clear_Place", false)
        wholesale = nil
        car = nil
        peds = {}
    elseif scenario == "enemy_dead" then
        clientNotify(translate("client", "notify_wholesale_enemy_dead"), "primary", 5000)
        local Buyer = peds[1].entity

        options = { 
            { 
                num = 1,
                icon = 'fa-solid fa-comments',
                label = translate("client", "target_wholesale_steal_money"),
                action = function()
                    RemoveTargetEntity(Buyer)
                    SetEntityHeading(ped, Face_To_Face(ped, Buyer))
                    TriggerServerEvent("SellDrugs:Send_Animation", NetworkGetNetworkIdFromEntity(ped), "mp_common", "givetake1_a", 8.0, 2000, true)
                    Wait(1000)
                    TriggerServerEvent("SellDrugs:Wholesale_Attack", scenario)
                    local CashObj = CreateObject(GetHashKey('prop_anim_cash_pile_01'), 0.0, 0.0, 0.0, true, true, false)
                    AttachEntityToEntity(CashObj, ped, GetPedBoneIndex(ped,  57005), 0.1, 0.01, -0.02, 0.0, 0.0, -90.0, false, true, false, false, 0, true)
                    Wait(1000)
                    DeleteObject(CashObj)
                    Wait(15000)
                    for _, v in pairs(peds) do
                        DeletePed(v.entity)
                    end
                    cfg.Prefix.Functions.DeleteVehicle(car)
                    TriggerServerEvent("SellDrugs:Wholesale_Clear_Place", false)
                    wholesale = nil
                    car = nil
                    peds = {}
                end,
            }
        }
        AddTargetEntity(Buyer, options, 2.5)
    end
end