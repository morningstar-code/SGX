cfg.Prefix = exports[cfg.ExportPrefix]:GetCoreObject()

sellingDrugs = false
Potential_Clients = {}
Blocked_Clients = {}
Police = {}
isOfficer = false

Start_Animation = {
    ["Male"] = {{dict = "anim@heists@heist_corona@team_idles@male_a", anim = "idle"}, {dict = "anim@mp_corona_idles@male_c@idle_a", anim = "idle_a"}, {dict = "anim@mp_corona_idles@male_d@idle_a", anim = "idle_a"}},
    ["Female"] = {{dict = "anim@mp_corona_idles@female_b@idle_a", anim = "idle_a"}, {dict = "mp_move@prostitute@m@french", anim = "idle"}, {dict = "anim@heists@heist_corona@team_idles@female_a", anim = "idle"}}
}

Trade_Animation = {{dict = "mp_common", anim = "givetake1_a", duration = 2000, swap = 1000}, {dict = "mp_ped_interaction", anim = "handshake_guy_a", duration = 3000, swap = 1500}}

RegisterNetEvent(cfg.TriggerPrefix..':Client:OnPlayerLoaded', function()
    PlayerData = cfg.Prefix.Functions.GetPlayerData()
end)

RegisterNetEvent(cfg.TriggerPrefix..':Client:OnJobUpdate', function(job)
    local Check = 0

    for _, v in pairs(cfg.Police.Job) do
        if v == job.name and not isOfficer then
            TriggerServerEvent("SellDrugs:Get_Police", "add", NetworkGetNetworkIdFromEntity(PlayerPedId()))
            isOfficer = true
            break
        elseif v ~= job.name and isOfficer then
            Check = Check + 1
        end
    end

    if Check == #cfg.Police.Job then
        TriggerServerEvent("SellDrugs:Get_Police", "remove")
        isOfficer = false
    end
end)

CreateThread(function()
    PlayerData = cfg.Prefix.Functions.GetPlayerData()

    while not PlayerData.job do
        Wait(0)
    end

    TriggerServerEvent("SellDrugs:Player_Joined")

    for _, v in pairs(cfg.Police.Job) do
        if v == PlayerData.job.name then
            TriggerServerEvent("SellDrugs:Get_Police", "add", NetworkGetNetworkIdFromEntity(PlayerPedId()))
            isOfficer = true
            break
        end
    end

    while true do
        for k, v in pairs(Police) do
            if NetworkDoesNetworkIdExist(v.network) then
                v.entity = NetworkGetEntityFromNetworkId(v.network)
            end
        end
        Wait(3000)
    end
end)

RegisterNetEvent("SellDrugs:Update_Police", function(result)
    Police = result
end)

RegisterNetEvent("SellDrugs:Use_Animation", function(network, dict, anim, blendSpeed, duration, move)
    if NetworkDoesNetworkIdExist(network) then
        local entity = NetworkGetEntityFromNetworkId(network)

        if entity ~= 0 then
            Play_Anim(entity, dict, anim, blendSpeed, duration, move)
        end
    end
end)

RegisterNetEvent("SellDrugs:Use_Speech", function(network, speechName, speechArg)
    if NetworkDoesNetworkIdExist(network) then
        local entity = NetworkGetEntityFromNetworkId(network)

        if entity ~= 0 then
            PlayPedAmbientSpeechNative(entity, speechName, speechArg)
        end
    end
end)

function Play_Anim(entity, dict, anim, BlendSpeed, Duration, Move)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
    TaskPlayAnim(entity, dict, anim, BlendSpeed, BlendSpeed, Duration, 1, 0, Move, Move, Move)
end

function Create_Ped(model, coords, heading, isNetwork)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
    local ped = CreatePed(1, model, coords.x, coords.y, coords.z, heading, isNetwork, true)
    SetModelAsNoLongerNeeded(model)
    SetPedDefaultComponentVariation(ped)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    local Height = coords.z - GetEntityHeightAboveGround(ped)
    SetEntityCoords(ped, coords.x, coords.y, Height + 1.0)

    return ped
end

function Create_Blip(task, args)
    local blip = nil

    if task == "blip" then
        blip = AddBlipForCoord(args.Coords)
        SetBlipSprite(blip, args.Sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, args.Scale)
        SetBlipAsShortRange(blip, false)
        SetBlipColour(blip, args.Color)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(args.Text)
        EndTextCommandSetBlipName(blip)
    elseif task == "radius" then
        blip = AddBlipForRadius(args.Coords, args.Distance)
        SetBlipColour(blip, args.Color)
        SetBlipAlpha(blip, 50)
    end

    return blip
end

function Face_To_Face(entity1, entity2)
    local p1 = GetEntityCoords(entity1, true)
    local p2 = GetEntityCoords(entity2, true)

    local dx = p2.x - p1.x
    local dy = p2.y - p1.y

    local heading = GetHeadingFromVector_2d(dx, dy)
    
    return heading
end

RegisterNetEvent("SellDrugs:Status_Selling_Drugs", function()
    TriggerServerEvent("SellDrugs:Status_Selling_Drugs")
end)

AddEventHandler('onResourceStop', function(name)
    if name == GetCurrentResourceName() then
        for mole, _ in pairs(cfg.Mole) do
            for __, v in pairs(cfg.Mole[mole]) do
                if v.ped then
                    RemoveTargetEntity(v.ped)
                    DeletePed(v.ped)
                end
            end
        end

        for _, v in pairs(Potential_Clients) do
            FreezeEntityPosition(v, false)
            SetPedCanBeTargetted(v, true)
            SetPedDiesWhenInjured(v, true)
            SetEntityInvincible(v, false)
            SetPedAsNoLongerNeeded(v)
            TaskSetBlockingOfNonTemporaryEvents(v, false)
            RemoveTargetEntity(v)
        end

        if UsingPed then
            FreezeEntityPosition(UsingPed, false)
            SetPedCanBeTargetted(UsingPed, true)
            SetPedDiesWhenInjured(UsingPed, true)
            SetEntityInvincible(UsingPed, false)
            SetPedAsNoLongerNeeded(UsingPed)
            TaskSetBlockingOfNonTemporaryEvents(UsingPed, false)
        end

        if car and #peds > 0 then
            cfg.Prefix.Functions.DeleteVehicle(car)
            for _, v in ipairs(peds) do
                DeletePed(v.entity)
                if v.isBuyer then
                    RemoveTargetEntity(v.entity)
                end
            end
        end
    end
end)