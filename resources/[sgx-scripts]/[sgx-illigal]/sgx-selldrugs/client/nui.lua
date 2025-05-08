function generateRandomString(length)
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local randomString = ""

    for i = 1, length do
        local randomIndex = math.random(#chars)
        local randomChar = chars:sub(randomIndex, randomIndex)
        randomString = randomString .. randomChar
    end

    return randomString
end

local isPhoneDataSent = false
local isNPCSellDataSent = false

function togglePhoneNUI(showNUI)
    cfg.Prefix.Functions.TriggerCallback('SellDrugs:Get_Player_Info', function(data)
        SetNuiFocus(showNUI, showNUI)
        local message = {
            action = "togglePhoneNUI",
            showNUI = showNUI,
            playerExperience = data.stats,
            settings = data.settings,
            mole = data.mole
        }
        if not isPhoneDataSent then
            message.config = cfg.Wholesale_Settings
            message.translations = translations['html']
            isPhoneDataSent = true
        end
        SendNUIMessage(message)
    end)
end

function toggleNPCSellNUI(showNUI, playerDrugs, stats)
    SetNuiFocus(showNUI, showNUI)
    local message = {
        action = "toggleNPCSellNUI",
        showNUI = showNUI
    }
    if showNUI then
        message.npcID = generateRandomString(6)
        message.inventory = playerDrugs
        message.playerExperience = stats
        if not isNPCSellDataSent then
            message.config = cfg.Sales_Skill
            message.translations = translations['html']
            isNPCSellDataSent = true
        end
    end
    SendNUIMessage(message)
end

RegisterNetEvent("SellDrugs:OpenPhone", function()
    togglePhoneNUI(true)
end)

local addPhoneConversationTranslate = false
function addPhoneConversation(npcID, itemName)
    local message = {
        action = "addPhoneConversation",
        npcID = npcID,
        itemName = itemName,
    }

    if not addPhoneConversationTranslate then
        message.translations = translations['html']
        addPhoneConversationTranslate = true
    end

    SendNUIMessage(message)
end

function sendPhoneMessage(npcID, text)
    SendNUIMessage({
        action = "sendPhoneMessage",
        npcID = npcID,
        text = text
    })
end

function sendMolePhoneMessage(moleName, text)
    SendNUIMessage({
        action = "sendMolePhoneMessage",
        moleName = moleName,
        text = text
    })
end

local modalState = {
    result = nil,
    isActive = false
}
function showModal(title, text)
    modalState.isActive = true

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "showModal",
        title = title,
        text = text
    })

    while modalState.isActive do
        SetNuiFocus(modalState.isActive, modalState.isActive)
        Wait(5)
    end

    SetNuiFocus(false, false)
    return modalState.result
end

RegisterNUICallback('dialogBack', function(data, cb)
    if data.action == "exit" then
        local ped = PlayerPedId()

        toggleNPCSellNUI(false)

        RenderScriptCams(false, true, 1500)

        Wait(750)

        TriggerServerEvent("SellDrugs:Clear_Prices")
        TriggerServerEvent("SellDrugs:Send_Speech", NetworkGetNetworkIdFromEntity(UsingPed), "GENERIC_BYE", "SPEECH_PARAMS_STANDARD")
        ClearPedTasks(ped)
        ClearPedTasks(UsingPed)
        TaskSetBlockingOfNonTemporaryEvents(UsingPed, false)
        SetPedDiesWhenInjured(UsingPed, true)
        SetEntityInvincible(UsingPed, false)
        SetPedAsNoLongerNeeded(UsingPed)
        SetPedCanBeTargetted(UsingPed, true)
        FreezeEntityPosition(UsingPed, false)
        UsingPed = nil
        DestroyCam(cam, true)
        cam = nil
    elseif data.action == "sell" then
        cfg.Prefix.Functions.TriggerCallback('SellDrugs:Calculate_Percentage', function(result, totalNegotiation)
            cb( { result = result, totalNegotiation = totalNegotiation } )
        end, data.itemName, data.inputValue, data.isWholesale)
    end
end)

RegisterNUICallback('successInteraction', function(data, cb)
    local ped = PlayerPedId()

    toggleNPCSellNUI(false)

    RenderScriptCams(false, true, 1500)

    Wait(750)

    TriggerServerEvent("SellDrugs:Send_Speech", NetworkGetNetworkIdFromEntity(UsingPed), "GENERIC_THANKS", "SPEECH_PARAMS_STANDARD")
    local Random_Anim = Trade_Animation[math.random(1, #Trade_Animation)]
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, Face_To_Face(ped, UsingPed))
    SetEntityHeading(UsingPed, Face_To_Face(UsingPed, ped))
    TriggerServerEvent("SellDrugs:Send_Animation", NetworkGetNetworkIdFromEntity(ped), Random_Anim.dict, Random_Anim.anim, 8.0, Random_Anim.duration, true)
    TriggerServerEvent("SellDrugs:Send_Animation", NetworkGetNetworkIdFromEntity(UsingPed), Random_Anim.dict, Random_Anim.anim, 8.0, Random_Anim.duration, true)
    local DrugObj = CreateObject(GetHashKey('v_ret_ml_cigs3'), 0.0, 0.0, 0.0, true, true, false)
    local CashObj = CreateObject(GetHashKey('prop_anim_cash_pile_01'), 0.0, 0.0, 0.0, true, true, false)
    AttachEntityToEntity(CashObj, UsingPed, GetPedBoneIndex(UsingPed,  57005), 0.1, 0.01, -0.02, 0.0, 0.0, -90.0, false, true, false, false, 0, true)
    AttachEntityToEntity(DrugObj, ped, GetPedBoneIndex(ped,  57005), 0.1, 0.01, -0.02, -90.0, 0.0, -90.0, false, true, false, false, 0, true)
    Wait(Random_Anim.swap)
    TriggerServerEvent("SellDrugs:Make_Trade", data.itemName, data.amount, data.price, true)
    DetachEntity(DrugObj, true, true)
    DetachEntity(CashObj, true, true)
    AttachEntityToEntity(CashObj, ped, GetPedBoneIndex(ped,  57005), 0.1, 0.01, -0.02, 0.0, 0.0, -90.0, false, true, false, false, 0, true)
    AttachEntityToEntity(DrugObj, UsingPed, GetPedBoneIndex(UsingPed,  57005), 0.1, 0.01, -0.02, -90.0, 0.0, -90.0, false, true, false, false, 0, true)
    Wait(Random_Anim.duration - Random_Anim.swap)
    DeleteObject(CashObj)
    DeleteObject(DrugObj)
    TriggerServerEvent("SellDrugs:Send_Speech", NetworkGetNetworkIdFromEntity(UsingPed), "GENERIC_BYE", "SPEECH_PARAMS_STANDARD")
    FreezeEntityPosition(ped, false)
    ClearPedTasks(ped)
    ClearPedTasks(UsingPed)
    TaskSetBlockingOfNonTemporaryEvents(UsingPed, false)
    SetPedDiesWhenInjured(UsingPed, true)
    SetEntityInvincible(UsingPed, false)
    SetPedAsNoLongerNeeded(UsingPed)
    SetPedCanBeTargetted(UsingPed, true)
    FreezeEntityPosition(UsingPed, false)
    UsingPed = nil
    DestroyCam(cam, true)
    cam = nil
end)

RegisterNUICallback('phoneExit', function(data, cb)
    SetNuiFocus(false, false)
end)

RegisterNUICallback('phoneStartTradeMission', function(data, cb)
    cfg.Prefix.Functions.TriggerCallback('SellDrugs:Create_Wholesale', function(result)
        if result then
            TriggerEvent("SellDrugs:Wholesale", result)
            local coords = {x = cfg.Wholesale[result].Coords.x, y = cfg.Wholesale[result].Coords.y, z = cfg.Wholesale[result].Coords.z}
            cb(coords)
        else 
            cb(false)
        end
    end, data.price, data.quantity)
end)

RegisterNUICallback('setWaypoint', function(data, cb)
    clientNotify(translate("client", "notify_set_waypoint"), "success", 2500)
    SetNewWaypoint(data.coords.x, data.coords.y)
end)

RegisterNUICallback('modalChoice', function(result, cb)
    modalState.isActive = false
    modalState.result = result
end)

RegisterNUICallback('saveSettings', function(settings, cb)
    TriggerServerEvent("SellDrugs:Change_Phone_Settings", settings)
    cb(true)
end)

-- RegisterNUICallback('playerDeletedConversation', function(conversationID, cb)
--     print('usun id:'..conversationID..' z tabel')
-- end)

RegisterNUICallback('notification', function(data)
    clientNotify(data.text, data.type, data.duration)
end)


