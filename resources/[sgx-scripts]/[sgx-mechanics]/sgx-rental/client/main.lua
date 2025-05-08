local QBCore = exports["qb-core"]:GetCoreObject()
local pedSpawned = false
local ShopPed = {}

local spawncarcoords

local function openRentMenu(data)
    SendNUIMessage({
        action = "OPEN",
        data = data
    })
    SetNuiFocus(true, true)
end

local function createBlips()
    if pedSpawned then return end

    for store in pairs(Config.Locations) do
        if Config.Locations[store]["showblip"] then
            local StoreBlip = AddBlipForCoord(Config.Locations[store]["coords"]["x"], Config.Locations[store]["coords"]["y"], Config.Locations[store]["coords"]["z"])
            SetBlipSprite(StoreBlip, Config.Locations[store]["blipsprite"])
            SetBlipScale(StoreBlip, Config.Locations[store]["blipscale"])
            SetBlipDisplay(StoreBlip, 4)
            SetBlipColour(StoreBlip, Config.Locations[store]["blipcolor"])
            SetBlipAsShortRange(StoreBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.Locations[store]["label"])
            EndTextCommandSetBlipName(StoreBlip)
        end
    end
end

local function createPeds()
    if pedSpawned then return end

    for k, v in pairs(Config.Locations) do
        local current = type(v["ped"]) == "number" and v["ped"] or joaat(v["ped"])

        RequestModel(current)
        while not HasModelLoaded(current) do
            Wait(0)
        end

        ShopPed[k] = CreatePed(0, current, v["coords"].x, v["coords"].y, v["coords"].z-1, v["coords"].w, false, false)
        TaskStartScenarioInPlace(ShopPed[k], v["scenario"], 0, true)
        FreezeEntityPosition(ShopPed[k], true)
        SetEntityInvincible(ShopPed[k], true)
        SetBlockingOfNonTemporaryEvents(ShopPed[k], true)

        exports['qb-target']:AddTargetEntity(ShopPed[k], {
            options = {
                {
                    label = v["targetLabel"],
                    icon = v["targetIcon"],
                    action = function()
                        spawncarcoords = v.carspawn,
                        openRentMenu(v.categorie)
                    end,
                }
            },
            distance = 5.0
        })
    end

    pedSpawned = true
end


local function deletePeds()
    if not pedSpawned then return end
    for _, v in pairs(ShopPed) do
        DeletePed(v)
    end
    pedSpawned = false
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    createBlips()
    createPeds()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    deletePeds()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    createBlips()
    createPeds()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    deletePeds()
end)


RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('rent', function(data)
    SetNuiFocus(false, false)
    if IsAnyVehicleNearPoint(spawncarcoords.x, spawncarcoords.y, spawncarcoords.z, 2.0) then
        QBCore.Functions.Notify("Vehicle Spot is occupied", "error", 4500)
        return
    end
    if tonumber(data.carDay) < 1 then QBCore.Functions.Notify("Do not push me to ban you please", "error", 4500) return end
    TriggerServerEvent("sgx-rental:sv:rentVehicle", data)
end)

RegisterNetEvent('sgx-rental:cl:spawnVehicle', function(model,time)
    QBCore.Functions.SpawnVehicle(model, function(vehicle)
        local plate = GetVehicleNumberPlateText(vehicle)
        SetEntityHeading(vehicle, spawncarcoords.w)
        TriggerEvent("vehiclekeys:client:SetOwner", plate)
        SetVehicleEngineOn(vehicle, true, true)
        SetVehicleDirtLevel(vehicle, 0.0)
        exports('SetFuel', SetFuel)
        TriggerServerEvent("sgx-rental:sv:updatesql", plate, model, time)
    end, spawncarcoords, true)
end)

CreateThread(function()
    while true do
        TriggerServerEvent("sgx-rental:sv:checktime")
        Wait(3600000)
    end
end)

RegisterNetEvent('qb-don:client:openloststashes', function(stash)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", stash)
    TriggerEvent("inventory:client:SetCurrentStash", stash)
end)