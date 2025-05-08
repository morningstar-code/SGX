current = {
    opened = false,
    cam = nil,
    isDead = false,
    playerId = 0,
    ped = 0,
    oldData = {
        isDead = false,
        status = {}
    },
    bones = {
        ["head"] = 94,
        ["body"] = 22,
        ["lArm"] = 41,
        ["rArm"] = 70,
        ["lLeg"] = 3,
        ["rLeg"] = 10
    },
    hitSide = {},
    status = {
        ["head"] = 100,
        ["body"] = 100,
        ["lArm"] = 100,
        ["rArm"] = 100,
        ["lLeg"] = 100,
        ["rLeg"] = 100
    }
}

function SendReactMessage(action, data)
    SendNUIMessage({
        action = action,
        data = data
    })
end

local boneNames = {
    [0] = "body",
    [1] = "body",
    [2] = "body",
    [3] = "rLeg",
    [4] = "rLeg",
    [5] = "rLeg",
    [6] = "rLeg",
    [7] = "rLeg",
    [8] = "rLeg",
    [9] = "body",
    [10] = "rLeg",
    [11] = "rLeg",
    [12] = "body",
    [13] = "rLeg",
    [14] = "body",
    [15] = "rLeg",
    [16] = "lLeg",
    [17] = "lLeg",
    [18] = "lLeg",
    [19] = "lLeg",
    [20] = "lLeg",
    [21] = "body",
    [22] = "lLeg",
    [23] = "lLeg",
    [24] = "body",
    [25] = "lLeg",
    [26] = "body",
    [27] = "body",
    [28] = "body",
    [29] = "body",
    [30] = "body",
    [31] = "body",
    [32] = "body",
    [33] = "body",
    [34] = "body",
    [35] = "body",
    [36] = "body",
    [37] = "body",
    [38] = "body",
    [39] = "head",
    [40] = "head",
    [41] = "rArm",
    [42] = "rArm",
    [43] = "rArm",
    [44] = "rArm",
    [45] = "rArm",
    [46] = "rArm",
    [47] = "rArm",
    [48] = "rArm",
    [49] = "rArm",
    [50] = "rArm",
    [51] = "rArm",
    [52] = "rArm",
    [53] = "rArm",
    [54] = "rArm",
    [55] = "rArm",
    [56] = "rArm",
    [57] = "rArm",
    [58] = "rArm",
    [59] = "rArm",
    [60] = "rArm",
    [61] = "rArm",
    [62] = "rArm",
    [63] = "rArm",
    [64] = "rArm",
    [65] = "rArm",
    [66] = "rArm",
    [67] = "rArm",
    [68] = "head",
    [69] = "lArm",
    [70] = "lArm",
    [71] = "lArm",
    [72] = "lArm",
    [73] = "lArm",
    [74] = "lArm",
    [75] = "lArm",
    [76] = "lArm",
    [77] = "lArm",
    [78] = "lArm",
    [79] = "lArm",
    [80] = "lArm",
    [81] = "lArm",
    [82] = "lArm",
    [83] = "lArm",
    [84] = "lArm",
    [85] = "lArm",
    [86] = "lArm",
    [87] = "lArm",
    [88] = "lArm",
    [89] = "lArm",
    [90] = "lArm",
    [91] = "lArm",
    [92] = "lArm",
    [93] = "lArm",
    [94] = "lArm",
    [95] = "lArm",
    [96] = "lArm",
    [97] = "head",
    [98] = "head",
    [99] = "head",
    [100] = "head",
    [101] = "head",
    [102] = "head",
    [103] = "head",
    [104] = "head",
    [105] = "head",
    [106] = "head",
    [107] = "head",
    [108] = "head",
    [109] = "head",
    [110] = "head",
    [111] = "head",
    [112] = "head",
    [114] = "head",
    [115] = "head",
    [116] = "head",
    [117] = "head",
    [118] = "head",
    [119] = "head",
    [120] = "head",
    [121] = "head",
    [122] = "head",
    [123] = "head",
    [124] = "head",
    [125] = "body",
    [126] = "body",
    [127] = "body",
}

local function canRespawn()
    for _, hp in pairs(current.status) do
        if hp < 100 then
            return false
        end
    end
    return true
end

function handleDisplay()
    current.opened = not current.opened
    SendReactMessage("HandleDisplay", current.opened)
    SetNuiFocus(current.opened, current.opened)

    if current.opened then
        SendReactMessage("setLang", cfg.locales[cfg.locale])
        local playerId, distance = sgx.getClosestPlayer()
        if not playerId then playerId = PlayerId() else TriggerServerEvent("sgx-healthsystem:server:sendPlayerData", GetPlayerServerId(playerId)) end
        Wait(500)
        initialize(playerId)
    end
end

function updateInventoryItems()
    sgx.triggerCallback("sgx-healthsystem:getInventoryItems", function(res)
        SendReactMessage("setData", { items = cfg.items, injuryList = current.hitSide, inventoryItems = res })
    end, GetPlayerServerId(PlayerId()))
end

function initialize(playerId)
    local ped = GetPlayerPed(playerId)
    local pedCoords = current.isDead and GetOffsetFromEntityInWorldCoords(ped, 0.0, 2.0, 9.0) or GetOffsetFromEntityInWorldCoords(ped, 0.0, 7.0, 0.3)
    current.ped = ped
    current.playerId = playerId
    current.cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    PointCamAtEntity(current.cam, ped, 0.0, 0.0, current.isDead and 0.0 or 0.3, true)
    SetCamCoord(current.cam, pedCoords.x, pedCoords.y, pedCoords.z)
    RenderScriptCams(true, true, 1000, true, true)
    SetCamActive(current.cam, true)
    SetCamFov(current.cam, current.isDead and 10.0 or 15.0)
    updateInventoryItems()
    repeat
        Wait(0)
        for k, v in pairs(current.bones) do
            local coords = GetWorldPositionOfEntityBone(ped, v)
            local _, x, y = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z)
            local screenX, screenY = GetScreenResolution()
            SendReactMessage("updatePosition", {
                key = k,
                position = { x = x * 100, y = y * 100 }
            })
        end
    
        SendReactMessage("setData", {
            healthStatus = current.status
        })
    until not current.opened
end

function close()
    current.opened = false
    SendReactMessage("HandleDisplay", current.opened)
    SetNuiFocus(current.opened, current.opened)
    DestroyCam(current.cam, true)
    RenderScriptCams(false, true, 1000, true, true)
    current.cam = nil
    if current.ped ~= PlayerPedId() then
        TriggerServerEvent("sgx-healthsystem:server:savePlayer", GetPlayerServerId(current.playerId), current)
        current.status = current.oldData.status
        current.hitSide = current.oldData.hitSide
        current.isDead = current.oldData.isDead
    end
    current.ped = 0
    current.playerId = 0
    current.oldData = { isDead = false, status = {}, hitSide = {} }
end
exports("close", close)

RegisterNUICallback("close", function(_, cb)
    close()
    cb({ 'ok' })
end)

RegisterCommand("openht", function()
    local job = getPlayerJob()
    if (cfg.accessableJobs[job] or cfg.accessableJobs["all"]) then
        handleDisplay()
    else
        sgx.notification("error", sgx._t("youCantAccess"))
    end
end)

RegisterNetEvent('custom:client:OpenHT')
AddEventHandler('custom:client:OpenHT', function()
    ExecuteCommand('openht')
end)


RegisterNetEvent("sgx-healthsystem:client:setPlayerData", function(playerData)
    current.oldData = {
        isDead = current.isDead,
        status = current.status,
        hitSide = current.hitSide
    }

    current.status = playerData.status
    current.hitSide = playerData.hitSide
    current.isDead = playerData.isDead
end)

RegisterNetEvent("sgx-healthsystem:client:savePlayer", function(playerData)
    current.status = playerData.status
    current.hitSide = playerData.hitSide
    current.isDead = playerData.isDead
end)

RegisterNetEvent("sgx-healthsystem:client:getPlayerData", function(doctor)
    TriggerServerEvent("sgx-healthsystem:server:setPlayerData", doctor, current)
end)

AddEventHandler("gameEventTriggered", function(event, data)
    if event == "CEventNetworkEntityDamage" then
        local victim = data[1]
        if PlayerPedId() == victim then
            local attacker = data[2]
            local weaponHash = data[3]
            local isFatal = data[4]
            local isMelee = data[10]
            local _, boneIndex = GetPedLastDamageBone(victim)
            local wp = GetSelectedPedWeapon(attacker)
            local boneName = boneNames[GetPedBoneIndex(victim, boneIndex)] or "Unknown Bone"
            if GetPedArmour(victim) > 0 and boneName == "body" then return end            

            local damage1 = 0            
            local hitItem = sgx.weapons[wp] or "knife"
            current.hitSide[hitItem] = current.hitSide[hitItem] and current.hitSide[hitItem]+1 or 1 
            if isMelee then
                local damage = cfg.damages[wp] and cfg.damages[wp]() or math.random(5, 40)
                damage1 = math.random(1, damage)
            elseif sgx.weapons[wp] then
                if wp == `weapon_unarmed` then
                    local damage = cfg.damages[wp] and cfg.damages[wp]() or math.random(5, 40)
                    damage1 = math.random(1, damage)
                else
                    local damage = cfg.damages[wp] and cfg.damages[wp]() or math.random(5, 40)
                    damage1 = math.random(5, damage)
                end
            else
                damage1 = math.random(0, 5)
            end

            if not current.status[boneName] then return end
            
            current.status[boneName] -= damage1
            
            if current.status[boneName] <= 0 then
                current.status[boneName] = 0
            end

            if GetEntityHealth(victim) <= 0 then
                current.isDead = true
                for bone, hp in pairs(current.status) do
                    if hp > 50 then
                        current.status[bone] = math.random(10, 50)
                    end
                end
            end

            ClearPedLastDamageBone(victim)
        end
    end
end)

RegisterNUICallback("healBone", function(data, cb)
    local bone, item, giveHealth, ped = data.bone, data.item, cfg.items[data.item].giveHealth, PlayerPedId()
    if not current.status[bone] then return end
    if not giveHealth then return end
    if current.status[bone] >= 100 then return sgx.notification("error", sgx._t("healthyBone")) end
    
    if string.find(bone, "Arm") then
        sgx.loadAnimDict("mp_gun_shop_tut")
        TaskPlayAnim(ped, "mp_gun_shop_tut", "indicate_right", 2.0, 2.0, -1, true, 0, false, false, false)
    elseif string.find(bone, "Leg") then
        sgx.loadAnimDict("gestures@f@standing@casual")
        TaskPlayAnim(ped, "gestures@f@standing@casual", "gesture_hand_down", 2.0, 2.0, -1, true, 0, false, false, false)
    else
        sgx.loadAnimDict("gestures@f@standing@casual")
        TaskPlayAnim(ped, "gestures@f@standing@casual", "gesture_point", 2.0, 2.0, -1, true, 0, false, false, false)
    end
    current.status[bone] += giveHealth

    if current.status[bone] > 100 then
        current.status[bone] = 100
    end

    if canRespawn() then
        TriggerServerEvent("sgx-healthsystem:server:revivePlayer", GetPlayerServerId(current.playerId))
        current.isDead = false
    end

    local currentHealth = GetEntityHealth(current.ped)
    local newHealth = currentHealth + giveHealth > GetEntityMaxHealth(current.ped) and GetEntityMaxHealth(current.ped) or currentHealth + giveHealth
    SetEntityHealth(current.ped, newHealth)

    TriggerServerEvent("sgx-healthsystem:server:removeItem", item, 1)
    sgx.notification("success", sgx._t("successfulAction"))
    updateInventoryItems()
    Wait(500)
    ClearPedTasks(PlayerPedId())
    cb({ 'ok' })
end)

CreateThread(function()
    while true do
        Wait(8000)

        if current.status["lLeg"] < cfg.minStumbleHealth or current.status["rLeg"] < cfg.minStumbleHealth then
            if IsPedWalking(PlayerPedId()) or IsPedRunning(PlayerPedId()) or IsPedSprinting(PlayerPedId()) then
                SetPedToRagdoll(PlayerPedId(), math.random(0,500), math.random(0,1500), 2, 0, 0, 0)
            end
        end

        if current.status["body"] <= 5 or current.status["body"] <= 5 then
            if not current.isDead then
                current.isDead = true
                SetEntityHealth(PlayerPedId(), 0)
            end
        end
    end
end)

RegisterNetEvent("sgx-healthsystem:client:revive", function()
    current.isDead = false
    current.hitSide = {}
    for bone, _ in pairs(current.status) do
        current.status[bone] = 100
    end
end)

RegisterNetEvent("hospital:client:Revive", function()
    current.isDead = false
    current.hitSide = {}
    for bone, hp in pairs(current.status) do
        current.status[bone] = 100
    end
end)

RegisterNetEvent("esx_ambulancejob:revive", function()
    current.isDead = false
    current.hitSide = {}
    for bone, hp in pairs(current.status) do
        current.status[bone] = 100
    end
end)