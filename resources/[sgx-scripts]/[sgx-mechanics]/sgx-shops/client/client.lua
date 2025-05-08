local QBCore = exports["qb-core"]:GetCoreObject()
-- Citizen.CreateThread(function()
--     while true do
--         sleep = 1000
--         for i, pos in ipairs(Pos) do
--             local playerPed = GetPlayerPed(-1)
--             local playerCoords = GetEntityCoords(playerPed)
--             local distance = GetDistanceBetweenCoords(playerCoords, pos.x, pos.y, pos.z, true)
--             if distance < 3.0 then
--                 sleep = 5
--                 if AC[i].job == "" or AC[i].job == " " then 
--                     DrawText3D(pos.x, pos.y, pos.z, "" .. AC[i].name .. " Press [E]")
--                         if IsControlJustReleased(0, 38) then
--                             SendNUIMessage({
--                                 action = "OPEN",
--                                 data = {
--                                     marketName = AC[i].name,
--                                     marketCategory = AC[i].category,
--                                     marketItemList = AC[i].itemList,
--                                     marketCategoryList = AC[i].categoryList,
--                                     marketJob = AC[i].job,
--                                 }
--                             })
--                             SetNuiFocus(true, true)
--                             sleep = 1000
--                         end
--                     else
--                         if AC[i].job ~= nil then
--                             local playerJob = QBCore.Functions.GetPlayerData().job.name
--                             if playerJob == AC[i].job then
--                                 DrawText3D(pos.x, pos.y, pos.z, "" .. AC[i].name .. " Press [E]")
--                                 if IsControlJustReleased(0, 38) then
--                                     SendNUIMessage({
--                                         action = "OPEN",
--                                         data = {
--                                             marketName = AC[i].name,
--                                             marketCategory = AC[i].category,
--                                             marketItemList = AC[i].itemList,
--                                             marketCategoryList = AC[i].categoryList,
--                                             marketJob = AC[i].job,
--                                         }
--                                     })
--                                     SetNuiFocus(true, true)
--                                     sleep = 1000
--                                 end
--                             end
--                         end
--                     end
--                 end      
--             end
--         Citizen.Wait(sleep)
--     end
-- end)

if Config.UseTextUI then
    Citizen.CreateThread(function()
        while true do
            local sleep = 1000
            local playerCoords = GetEntityCoords(PlayerPedId())
            for k, v in pairs(Config.Shops) do
                for a, b in pairs(v.coords) do
                    local dist = #(playerCoords - vector3(b.coords.x, b.coords.y, b.coords.z))
                    if dist <= 2 then
                        sleep = 0
                        item = {["item"] = {[1] = {name = "Open"}}}
                        --exports["sgx-textui-2"]:openTextUi(item,b.coords,3)
                        if IsControlJustPressed(0, 38) then
                            openShop(v.name, v.label, v.categories, v.type)
                        end
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end)
end

local pedSpawned = false
function createPeds()
    if pedSpawned then return end
    for k, v in pairs(Config.Shops) do
        local pedHash2 = type(v.pedHash) == "number" and v.pedHash or joaat(v.pedHash)
        RequestModel(pedHash2)
        while not HasModelLoaded(pedHash2) do
            Citizen.Wait(0)
        end
        for a, b in pairs(v.coords) do
            b.ped = CreatePed(0, pedHash2, b.coords.x, b.coords.y, b.coords.z - 1, b.coords.w, false, true)
            TaskStartScenarioInPlace(b.ped, v.scenario, 0, true)
            FreezeEntityPosition(b.ped, false)
            SetEntityInvincible(b.ped, false)
            SetBlockingOfNonTemporaryEvents(b.ped, true)
            SetModelAsNoLongerNeeded(pedHash2)
            pedSpawned = true
            if Config.UseTextUI == false then
                if v.type == "job" then
                    exports['qb-target']:AddTargetEntity(b.ped, {
                        options = {
                            {
                                label = v.name .. ' | ' .. v.label,
                                icon = 'fa-solid fa-basket-shopping',
                                job = v.jobName,
                                action = function()
                                    openShop(v.name, v.label, v.categories, v.type)
                                end
                            }
                        },
                        distance = 3.0
                    })
                else
                    
                    exports['qb-target']:AddTargetEntity(b.ped, {
                        options = {
                            {
                                label = v.name .. ' | ' .. v.label,
                                icon = 'fa-solid fa-basket-shopping',
                                action = function()
                                    openShop(v.name, v.label, v.categories, v.type)
                                end
                            }
                        },
                        distance = 3.0
                    })
                end
            else
                -- exports['qb-textui']:AddTextUIPed(ObjToNet(b.ped), vector3(b.coords.x, b.coords.y, b.coords.z), 'E', 'Open Shop', 2.5)
            end
        end
    end
end

function deletePeds()
    if not pedSpawned then return end
    for k, v in pairs(Config.Shops) do
        for a, b in pairs(v.coords) do
            DeletePed(b.ped)
            pedSpawned = false
        end
    end
end

function createBlips()
    for k, v in pairs(Config.Shops) do
        if v.blip == true then
            for a, b in pairs(v.coords) do
                local StoreBlip = AddBlipForCoord(b.coords.x, b.coords.y, b.coords.z)
                SetBlipSprite(StoreBlip, v.blipSprite)
                SetBlipScale(StoreBlip, v.blipScale)
                SetBlipDisplay(StoreBlip, 4)
                SetBlipColour(StoreBlip, v.blipColor)
                SetBlipAsShortRange(StoreBlip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentSubstringPlayerName(v.name)
                EndTextCommandSetBlipName(StoreBlip)
            end
        end
    end
end

Citizen.CreateThread(function()
    createBlips()
    createPeds()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    deletePeds()
end)

RegisterNUICallback("close",function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback("pay",function(data)
    TriggerServerEvent("qb-shops:pay", data)
end)

basket = {}
basketJob = {}
function openShop(name, label, category, type)
    basket = {}
    basketJob = {}
    local categories = {}
    for k, v in pairs(category) do
        table.insert(categories, {
            id = k,
            name = v.name,
            items = v.items,
            description = v.description
        })
    end
    SetNuiFocus(true, true)
    SendNUIMessage({action = "openShop", name = name, label = label, categories = categories, type = type, resourceName = GetCurrentResourceName()})
end

RegisterNetEvent("openShopEvent")
AddEventHandler("openShopEvent", function(eventData)
    basket = {}
    basketJob = {}
    function openShop(name, label, category, type)
        basket = {}
        basketJob = {}
        local categories = {}
        for k, v in pairs(category) do
            table.insert(categories, {
                id = k,
                name = v.name,
                items = v.items,
                description = v.description
            })
        end
        SetNuiFocus(true, true)
        SendNUIMessage({action = "openShop", name = name, label = label, categories = categories, type = type, resourceName = GetCurrentResourceName()})
    end
end)

RegisterNUICallback('addToBasket', function(data)
    if type(data.license) == 'table' then
        for k, v in ipairs(data.license) do
            if not QBCore.Functions.GetPlayerData().metadata["licences"][license] then
                QBCore.Functions.Notify("Missing a " ..  license .. " license for certain products", "error")
                return
            end
        end
    elseif data.license ~= nil and data.license ~= "undefined" then
        if not QBCore.Functions.GetPlayerData().metadata["licences"][data.license] then
            QBCore.Functions.Notify("Missing a " ..  data.license .. " license for certain products", "error")
            return
        end
    end
    if json.encode(basket) == "{}" or json.encode(basket) == "[]" then
        table.insert(basket, {
            name = data.name,
            perPrice = tonumber(data.price),
            totalPrice = tonumber(data.price),
            amount = 1,
            label = data.label
        })
        SendNUIMessage({action = "updateBasket", basket = basket})
    else
        local napacaz = napacaz(data.name)
        if napacaz == "insert" then
            table.insert(basket, {
                name = data.name,
                perPrice = tonumber(data.price),
                totalPrice = tonumber(data.price),
                amount = 1,
                label = data.label
            })
            SendNUIMessage({action = "updateBasket", basket = basket})
        end
    end
end)

RegisterNUICallback('addBasketJob', function(data)
    if json.encode(basketJob) == "{}" or json.encode(basketJob) == "[]" then
        table.insert(basketJob, {
            name = data.name,
            perPrice = tonumber(data.price),
            totalPrice = tonumber(data.price),
            amount = 1,
            label = data.label
        })
        SendNUIMessage({action = "updateBasketJob", basket = basketJob})
    else
        local napacazJob = napacazJob(data.name)
        if napacazJob == "insert" then
            table.insert(basketJob, {
                name = data.name,
                perPrice = tonumber(data.price),
                totalPrice = tonumber(data.price),
                amount = 1,
                label = data.label
            })
            SendNUIMessage({action = "updateBasketJob", basket = basketJob})
        end
    end
end)

function napacaz(name)
    for k, v in pairs(basket) do
        if v.name == name then
            basket[k].amount = basket[k].amount + 1
            basket[k].totalPrice = basket[k].perPrice * basket[k].amount
            SendNUIMessage({action = "updateBasket", basket = basket})
            return "update"
        end
    end
    return "insert"
end

function napacazJob(name)
    for k, v in pairs(basketJob) do
        if v.name == name then
            basketJob[k].amount = basketJob[k].amount + 1
            basketJob[k].totalPrice = basketJob[k].perPrice * basketJob[k].amount
            SendNUIMessage({action = "updateBasketJob", basket = basketJob})
            return "update"
        end
    end
    return "insert"
end

RegisterNUICallback('addBasketMore', function(data)
    for k, v in pairs(basket) do
        if v.name == data.name then
            basket[k].amount = basket[k].amount + 1
            basket[k].totalPrice = basket[k].perPrice * basket[k].amount
            SendNUIMessage({action = "updateBasket", basket = basket})
        end
    end
end)

RegisterNUICallback('addBasketMoreJob', function(data)
    for k, v in pairs(basketJob) do
        if v.name == data.name then
            basketJob[k].amount = basketJob[k].amount + 1
            basketJob[k].totalPrice = basketJob[k].perPrice * basketJob[k].amount
            SendNUIMessage({action = "updateBasketJob", basket = basketJob})
        end
    end
end)

RegisterNUICallback('removeOneBasket', function(data)
    for k, v in pairs(basket) do
        if v.name == data.name then
            if basket[k].amount > 1 then
                basket[k].amount = basket[k].amount - 1
                basket[k].totalPrice = basket[k].perPrice * basket[k].amount
                SendNUIMessage({action = "updateBasket", basket = basket})
            else
                basket[k] = nil
                SendNUIMessage({action = "updateBasket", basket = basket})
            end
        end
    end
end)

RegisterNUICallback('removeOneBasketJob', function(data)
    for k, v in pairs(basketJob) do
        if v.name == data.name then
            if basketJob[k].amount > 1 then
                basketJob[k].amount = basketJob[k].amount - 1
                basketJob[k].totalPrice = basketJob[k].perPrice * basketJob[k].amount
                SendNUIMessage({action = "updateBasketJob", basket = basketJob})
            else
                basketJob[k] = nil
                SendNUIMessage({action = "updateBasketJob", basket = basketJob})
            end
        end
    end
end)

RegisterNUICallback('deleteItemFromBasket', function(data)
    for k, v in pairs(basket) do
        if v.name == data.name then
            basket[k] = nil
            SendNUIMessage({action = "updateBasket", basket = basket})
        end
    end
end)

RegisterNUICallback('deleteItemFromBasketJob', function(data)
    for k, v in pairs(basketJob) do
        if v.name == data.name then
            basketJob[k] = nil
            SendNUIMessage({action = "updateBasketJob", basket = basketJob})
        end
    end
end)

RegisterNUICallback('makePayment', function(data)
    TriggerServerEvent('qb-shops:makePayment', data.type, data.price, basket)
end)

RegisterNUICallback('makePaymentJob', function(data)
    TriggerServerEvent('qb-shops:makePayment', data.type, data.price, basketJob)
end)

function hasLicense(licenses, playerLicenses)
    for _, license in ipairs(licenses) do
        if playerLicenses[license] then return true end
    end
    return false
end

    -- Text UI Interact
    exports['sgx-textui-2']:create3DTextUI("hospital-canteen", {
        coords = vector3(324.50, -584.36, 43.31),
        displayDist = 6.0,
        interactDist = 1.0,
        enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
        keyNum = 38,
        key = "E",
        text = "              Talk With Store Owner",
        theme = "green", -- or red
        job = "all", -- or the job you want to show this for
        canInteract = function()
            return true
        end,
        triggerData = {
        triggerName = "openShopEvent",
        args = {}
    }
})

    -- Text UI Interact
    exports['sgx-textui-2']:create3DTextUI("store-247-groserry", {
        coords = vector3(239.60, -898.40, 29.80),
        displayDist = 6.0,
        interactDist = 1.0,
        enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
        keyNum = 38,
        key = "E",
        text = "              Talk With Store Owner",
        theme = "green", -- or red
        job = "all", -- or the job you want to show this for
        canInteract = function()
            return true
        end,
        triggerData = {
        triggerName = "openShopEvent",
        args = {}
    }
})
    -- Text UI Interact
    exports['sgx-textui-2']:create3DTextUI("247-1-2", {
        coords = vector3(24.93, -1346.72, 29.50),
        displayDist = 6.0,
        interactDist = 1.0,
        enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
        keyNum = 38,
        key = "E",
        text = "              Talk With Store Owner",
        theme = "green", -- or red
        job = "all", -- or the job you want to show this for
        canInteract = function()
            return true
        end,
        triggerData = {
        triggerName = "openShopEvent",
        args = {}
    }
})
  -- Text UI Interact
    exports['sgx-textui-2']:create3DTextUI("247-1-3", {
        coords = vector3(-47.50, -1757.85, 29.50),
        displayDist = 6.0,
        interactDist = 1.0,
        enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
        keyNum = 38,
        key = "E",
        text = "              Talk With Store Owner",
        theme = "green", -- or red
        job = "all", -- or the job you want to show this for
        canInteract = function()
            return true
        end,
        triggerData = {
        triggerName = "openShopEvent",
        args = {}
    }
})
  -- Text UI Interact
  exports['sgx-textui-2']:create3DTextUI("247-1-4", {
    coords = vector3(45.23, -1749.01, 29.70),
    displayDist = 6.0,
    interactDist = 1.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "              Talk With MegaMall Worker",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
    triggerName = "openShopEvent",
    args = {}
}
})
  -- Text UI Interact
  exports['sgx-textui-2']:create3DTextUI("247-1-5", {
    coords = vector3(2556.63, 381.50, 108.70),
    displayDist = 6.0,
    interactDist = 1.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "              Talk With Store Owner",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
    triggerName = "openShopEvent",
    args = {}
}
})
  -- Text UI Interact
  exports['sgx-textui-2']:create3DTextUI("247-1-6", {
    coords = vector3(2677.73, 3280.14, 55.20),
    displayDist = 6.0,
    interactDist = 1.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "              Talk With Store Owner",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
    triggerName = "openShopEvent",
    args = {}
}
})
  -- Text UI Interact
  exports['sgx-textui-2']:create3DTextUI("247-1-7", {
    coords = vector3(1960.40, 3740.89, 32.30),
    displayDist = 6.0,
    interactDist = 1.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "              Talk With Store Owner",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
    triggerName = "openShopEvent",
    args = {}
}
})
  -- Text UI Interact
  exports['sgx-textui-2']:create3DTextUI("247-1-8", {
    coords = vector3(1728.42, 6415.25, 34.99),
    displayDist = 6.0,
    interactDist = 1.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "              Talk With Store Owner",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
    triggerName = "openShopEvent",
    args = {}
}
})
  -- Text UI Interact
  exports['sgx-textui-2']:create3DTextUI("247-1-9", {
    coords = vector3(-3242.97, 1000.40, 12.85),
    displayDist = 6.0,
    interactDist = 1.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "              Talk With Store Owner",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
    triggerName = "openShopEvent",
    args = {}
}
})
  -- Text UI Interact
  exports['sgx-textui-2']:create3DTextUI("24-1-1", {
    coords = vector3(-3039.60, 584.93, 7.90),
    displayDist = 6.0,
    interactDist = 1.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "              Talk With Store Owner",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
    triggerName = "openShopEvent",
    args = {}
}
})
  -- Text UI Interact
  exports['sgx-textui-2']:create3DTextUI("24-1-2", {
    coords = vector3(373.16, 326.70, 103.70),
    displayDist = 6.0,
    interactDist = 1.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "              Talk With Store Owner",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
    triggerName = "openShopEvent",
    args = {}
}
})
  -- Text UI Interact
  exports['sgx-textui-2']:create3DTextUI("24-1-3", {
    coords = vector3(1135.20, -982.66, 46.55),
    displayDist = 6.0,
    interactDist = 1.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "              Talk With Store Owner",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
    triggerName = "openShopEvent",
    args = {}
}
})
  -- Text UI Interact
  exports['sgx-textui-2']:create3DTextUI("24-1-4", {
    coords = vector3(-1487.17, -378.44, 40.30),
    displayDist = 6.0,
    interactDist = 1.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "              Talk With Store Owner",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
    triggerName = "openShopEvent",
    args = {}
}
})
  -- Text UI Interact
  exports['sgx-textui-2']:create3DTextUI("24-1-5", {
    coords = vector3(1163.88, -323.80, 69.35),
    displayDist = 6.0,
    interactDist = 1.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "              Talk With Store Owner",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
    triggerName = "openShopEvent",
    args = {}
}
})
  -- Text UI Interact
  exports['sgx-textui-2']:create3DTextUI("24-1-6", {
    coords = vector3(-1820.20, 792.99, 138.20),
    displayDist = 6.0,
    interactDist = 1.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "              Talk With Store Owner",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
    triggerName = "openShopEvent",
    args = {}
}
})
  -- Text UI Interact
  exports['sgx-textui-2']:create3DTextUI("24-1-7", {
    coords = vector3(-2967.30, 391.10, 15.20),
    displayDist = 6.0,
    interactDist = 1.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "              Talk With Store Owner",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
    triggerName = "openShopEvent",
    args = {}
}
})
  -- Text UI Interact
  exports['sgx-textui-2']:create3DTextUI("24-1-8", {
    coords = vector3(548.50, 2670.85, 42.16),
    displayDist = 6.0,
    interactDist = 1.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "              Talk With Store Owner",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
    triggerName = "openShopEvent",
    args = {}
}
})
  -- Text UI Interact
  exports['sgx-textui-2']:create3DTextUI("24-1-9", {
    coords = vector3(1165.50, 2709.90, 38.30),
    displayDist = 6.0,
    interactDist = 1.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "              Talk With Store Owner",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
    triggerName = "openShopEvent",
    args = {}
}
})
  -- Text UI Interact
  exports['sgx-textui-2']:create3DTextUI("247-1-19", {
    coords = vector3(2748.10, 3472.73, 55.67),
    displayDist = 6.0,
    interactDist = 1.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "              Talk With MegaMall Worker",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
    triggerName = "openShopEvent",
    args = {}
}
})

  -- Text UI Interact
  exports['sgx-textui-2']:create3DTextUI("digital-den", {
    coords = vector3(-1530.46, -404.21, 36.11),
    displayDist = 6.0,
    interactDist = 2.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "              Talk With Technician",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
    triggerName = "openShopEvent",
    args = {}
}
})


  -- Text UI Interact
  exports['sgx-textui-2']:create3DTextUI("blackmarket", {
    coords = vector3(-1694.70, 3182.05, -47.86),
    displayDist = 6.0,
    interactDist = 2.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "              Talk With Russian Mafia",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
    triggerName = "openShopEvent",
    args = {}
}
})

  -- Text UI Interact
  exports['sgx-textui-2']:create3DTextUI("oxyrun", {
    coords = vector3(-574.41, 238.64, 74.64),
    displayDist = 6.0,
    interactDist = 3.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "              Would You Run Some Meds For Me?",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
    triggerName = "kevin-oxyruns:initiate",
    args = {}
}
})

-- Text UI Interact
exports['sgx-textui-2']:create3DTextUI("sellitems", {
  coords = vector3(-564.22, 237.35, 74.79),
  displayDist = 6.0,
  interactDist = 3.0,
  enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
  keyNum = 38,
  key = "E",
  text = "              Sell Me Illigal Sh*t!",
  theme = "green", -- or red
  job = "all", -- or the job you want to show this for
  canInteract = function()
      return true
  end,
  triggerData = {
  triggerName = "qb-blackmarket:hmenu",
  args = {}
}
})

-- Text UI Interact
exports['sgx-textui-2']:create3DTextUI("methrun", {
    coords = vector3(-569.53, 228.15, 74.89),
    displayDist = 6.0,
    interactDist = 3.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "              Are U Sure You Want To Enter The Black World? Cost 5000 Crypto!",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
    triggerName = "qb-methrun:client:start",
    args = {}
  }
})

exports['sgx-textui-2']:create3DTextUI("granny", {
    coords = vector3(1215.48, -492.23, 67.32),
    displayDist = 6.0,
    interactDist = 3.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "              Grand Pa! Help Me!",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
    triggerName = "qb-ambulancejob:checkin",
    args = {}
  }
})

exports['sgx-textui-2']:create3DTextUI("chopshop", {
    coords = vector3(1600.46, 3591.03, 38.77),
    displayDist = 6.0,
    interactDist = 3.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "              Wanna Chop Some Metal?",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
    triggerName = "sgx-chopshop:jobaccept",
    args = {}
  }
})