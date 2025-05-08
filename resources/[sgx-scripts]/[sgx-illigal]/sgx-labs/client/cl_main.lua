local QBCore = exports['qb-core']:GetCoreObject()
local CarryPackage = nil
local effectActive = false

--- Opens the menu to lock/unlock and enter a lab
--- @param lab string - Name of the lab
--- @return nil
function LockUnlock(lab)
    local menu = {
        {
            header = "Close",
            txt = "ESC or click to close",
            icon = "fas fa-angle-left",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
    }
    if Config.Labs[lab].locked then
        menu[#menu+1] = {
            header = "Unlock Door",
            txt = "",
            icon = "fas fa-lock-open",
            params = {
                isServer = true,
                event = "qb-labs:server:unlock",
                args = {
                    lab = lab
                }
            }
        }
    else
        menu[#menu+1] = {
            header = "Lock Door",
            txt = "",
            icon = "fas fa-lock",
            params = {
                isServer = true,
                event = "qb-labs:server:lock",
                args = {
                    lab = lab
                }
            }
        }
    end
    exports['qb-menu']:openMenu(menu)
end

function LockDark(darkroom)
    local menu = {
        {
            header = "Close",
            txt = "ESC or click to close",
            icon = "fas fa-angle-left",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
    }
    if Config.Labs[darkroom].locked then
        menu[#menu+1] = {
            header = "Unlock Door",
            txt = "",
            icon = "fas fa-lock-open",
            params = {
                isServer = true,
                event = "dark1",
                args = {
                    darkroom = darkroom
                }
            }
        }
    else
        menu[#menu+1] = {
            header = "Lock Door",
            txt = "",
            icon = "fas fa-lock",
            params = {
                isServer = true,
                event = "dark3",
                args = {
                    darkroom = darkroom
                }
            }
        }
    end
    exports['qb-menu']:openMenu(menu)
end

--- Teleports the player ped inside a given lab
--- @param lab string - Name of the lab
--- @return nil
local function enterLab(lab)
    Wait(500)
    DoScreenFadeOut(250)
    Wait(250)
    SetEntityCoords(PlayerPedId(), Config.Labs[lab].exit.x, Config.Labs[lab].exit.y, Config.Labs[lab].exit.z - 0.98)
    SetEntityHeading(PlayerPedId(), Config.Labs[lab].exit.w)
    Wait(1000)
    TriggerServerEvent("qb-log:server:CreateLog", "keylabs", "Enter "..lab, "white", "**"..GetPlayerName(PlayerId()).."** has entered the "..lab)
    DoScreenFadeIn(250)
end

--- Performs the keypad animation when exiting a lab
--- @param x number - X coordinate
--- @param y number - Y coordinate
--- @param z number - Z coordinate
--- @param h number - Heading
--- @return nil
local function KeyPadAnimation(x, y, z, h)
    local ped = PlayerPedId()
    local dict = "mp_heists@keypad@"
    local anim = "idle_a"
    SetEntityCoords(ped, x, y, z - 0.98)
    SetEntityHeading(ped, h)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(10) end
    TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 0, 0, false, false, false)
    Wait(2500)
    TaskPlayAnim(ped, dict, "exit", 2.0, 2.0, -1, 0, 0, false, false, false)
    Wait(1000)
end

-- Performs the unlocking animation and plays a sound
--- @return nil
local function OpenDoorAnimation()
    RequestAnimDict("anim@heists@keycard@")
    while not HasAnimDictLoaded("anim@heists@keycard@") do Wait(10) end
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.1)
    TaskPlayAnim(PlayerPedId(), "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0)
    Wait(400)
    ClearPedTasks(PlayerPedId())
end

--- Teleports the player ped inside a given lab
--- @param lab string - Name of the lab
--- @return nil
function enterKeyLab(lab)
    local pos = GetEntityCoords(PlayerPedId())
    if #(pos - Config.Labs[lab].entrance.xyz) < 1.50 then
        enterLab(lab)
    end
end

--- Teleports the player ped outside a given lab
--- @param lab string - Name of the lab
--- @return nil
function Exitlab(lab)
    local ped = PlayerPedId()
    if lab == "methlab" then
        KeyPadAnimation(996.92, -3199.85, -36.4, 94.5)
    elseif lab == 'methlab2' then
        KeyPadAnimation(969.38, -146.2, -46.4, 91.49)
    elseif lab == "moneywash" then
        KeyPadAnimation(1139.0957, -3198.721, -39.66567, 186.46743)
    else
        OpenDoorAnimation()
    end
    DoScreenFadeOut(250)
    Wait(250)
    SetEntityCoords(ped, Config.Labs[lab].entrance.x, Config.Labs[lab].entrance.y, Config.Labs[lab].entrance.z - 0.98)
    SetEntityHeading(ped, Config.Labs[lab].entrance.w)
    Wait(1000)
    DoScreenFadeIn(250)
end

--- Opens the ingredients menu for a given lab
--- @param lab string - Name of the lab
--- @return nil
function CheckIngredients(lab)
    if Config.Labs[lab].ingredients.busy then
        QBCore.Functions.Notify('Someone is already grabbing stuff..', 'error', 2500)
    else
        local menu = {
            {
                header = "Close",
                txt = "Stock: "..Config.Labs[lab].ingredients.stock,
                icon = "fas fa-angle-left",
                params = {
                    event = "qb-menu:closeMenu",
                }
            }
        }
        if Config.Labs[lab].ingredients.stock > 0 and not CarryPackage then
            menu[#menu+1] = {
                header = "Grab Ingredients",
                icon = "fas fa-hand-holding",
                params = {
                    event = "qb-labs:client:GrabStock",
                    args = {
                        lab = lab
                    }
                }
            }
        end
        if not CarryPackage then
            menu[#menu+1] = {
                header = "Store Ingredients",
                icon = "fas fa-hand-holding",
                params = {
                    event = "qb-labs:client:StoreStock",
                    args = {
                        lab = lab
                    }
                }
            }
        end
        if CarryPackage then
            menu[#menu+1] = {
                header = "Return Ingredients",
                icon = "fas fa-hand-holding",
                params = {
                    event = "qb-labs:client:ReturnStock",
                    args = {
                        lab = lab
                    }
                }
            }
        end
        exports['qb-menu']:openMenu(menu)
    end
end

--- Opens the task menu for a given lab and task number
--- @param lab string - Name of the lab
--- @param task number - Task number
--- @return nil
function CheckTask(lab, task)
    if Config.Labs[lab].tasks[task].busy then
        QBCore.Functions.Notify('Someone is already using this..', 'error', 2500)
    elseif Config.Labs[lab].tasks[task].completed then
        QBCore.Functions.Notify('Move on to the next step..', 'error', 5000)
    elseif Config.Labs[lab].tasks[task].started then
        QBCore.Functions.Notify('There is nothing you can do.. just wait!', 'error', 5000)
    else
        local menu = {
            {
                header = "Close",
                txt = "ESC or click to close",
                icon = "fas fa-angle-left",
                params = {
                    event = "qb-menu:closeMenu",
                }
            },
            {
                header = "Add Ingredients",
                txt = "Currently: "..Config.Labs[lab].tasks[task].ingredients.current.." / "..Config.Labs[lab].tasks[task].ingredients.needed,
                icon = "fas fa-plus",
                params = {
                    event = "qb-labs:client:addingredients",
                    args = {
                        lab = lab,
                        task = task
                    }
                }
            },
            {
                header = "Set "..Locales[lab].parameter,
                txt = "Currently: "..Config.Labs[lab].tasks[task].temperature.." "..Locales[lab].unit,
                icon = "fas fa-temperature-low",
                params = {
                    event = "qb-labs:client:SetTemp",
                    args = {
                        lab = lab,
                        task = task
                    }
                }
            },
            {
                header = Locales[lab].tasks[task],
                icon = "fas fa-hourglass-start",
                params = {
                    isServer = true,
                    event = "qb-labs:server:StartMachine",
                    args = {
                        lab = lab,
                        task = task
                    }
                }
            }
        }
        exports['qb-menu']:openMenu(menu)
    end
end

--- Opens the curing menu for a given lab
--- @param lab string - Name of the lab
--- @return nil
function CheckCure(lab)
    if Config.Labs[lab].curing.busy then
        QBCore.Functions.Notify('Someone is already using this..', 'error', 2500)
    elseif Config.Labs[lab].curing.started then
        QBCore.Functions.Notify('There is nothing you can do.. just wait!', 'error', 5000)
    else
        local menu = {
            {
                header = "Close",
                txt = "ESC or click to close",
                icon = "fas fa-angle-left",
                params = {
                    event = "qb-menu:closeMenu",
                }
            }
        }
        if not Config.Labs[lab].curing.completed and not Config.Labs[lab].curing.started and Config.Labs[lab].curing.purity ~= nil then
            menu[#menu+1] = {
                header = "Start "..Locales[lab].curelabel,
                icon = "fas fa-hourglass-start",
                params = {
                    isServer = true,
                    event = "qb-labs:server:StartCuring",
                    args = {
                        lab = lab
                    }
                }
            }
        end
        if not Config.Labs[lab].curing.completed and not Config.Labs[lab].curing.started and not Config.Labs[lab].curing.purity then
            menu[#menu+1] = {
                header = "Add Batch",
                icon = "fas fa-plus",
                params = {
                    event = "qb-labs:client:AddCureBatch",
                    args = {
                        lab = lab
                    }
                }
            }
        elseif Config.Labs[lab].curing.completed then
            menu[#menu+1] = {
                header = "Take "..Locales[lab].cureBatchType.." Batch",
                icon = "fas fa-hand-holding",
                params = {
                    event = "qb-labs:client:TakeCureBatch",
                    args = {
                        lab = lab
                    }
                }
            }
        end
        exports['qb-menu']:openMenu(menu)
    end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('qb-labs:server:GetConfig', function(config)
        Config = config
    end)
end)

AddEventHandler('onClientResourceStart',function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    Wait(2000) -- Wait to give server time to fetch from database
    QBCore.Functions.TriggerCallback('qb-labs:server:GetConfig', function(config)
        Config = config
    end)
end)

RegisterNetEvent('qb-labs:client:DoorAnimation', function()
    OpenDoorAnimation()
end)

RegisterNetEvent('qb-labs:client:lock', function(lab)
    Config.Labs[lab].locked = true
end)

RegisterNetEvent('dark4', function(darkroom)
    Config.Labs[darkroom].locked = true
end)

RegisterNetEvent('qb-labs:client:unlock', function(lab)
    Config.Labs[lab].locked = false
end)

RegisterNetEvent('dark2', function(darkroom)
    Config.Labs[darkroom].locked = false
end)


RegisterNetEvent('qb-labs:client:GrabStock', function(data)
    TriggerServerEvent('qb-labs:server:UpdateIngredients', data.lab, true)
    local ped = PlayerPedId()
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)

    QBCore.Functions.Progressbar("pickup_reycle_package", "Grabbing ingredients..", 5000, false, true, {}, {}, {}, {}, function() -- Done
        ClearPedTasks(ped)
        local pos = GetEntityCoords(ped, true)
        local model = `bkr_prop_meth_toulene`
        RequestModel(model)
        while not HasModelLoaded(model) do Wait(10) end
        local object = CreateObject(model, pos.x, pos.y, pos.z, true, true, true)
        AttachEntityToEntity(object, ped, GetPedBoneIndex(ped, 28422), 0.55, 0.00, 0.00, 00.0, -90.0, 0.0, true, true, false, true, 1, true)
        CarryPackage = object
        Config.Labs[data.lab].ingredients.taken = true

        TriggerServerEvent('qb-labs:server:UpdateStock', data.lab, "grab")
        TriggerServerEvent('qb-labs:server:UpdateIngredients', data.lab, false)
    end, function() -- cancel
        ClearPedTasks(ped)
        TriggerServerEvent('qb-labs:server:UpdateIngredients', data.lab, false)
    end)
end)

RegisterNetEvent('qb-labs:client:StoreStock', function(data)

    TriggerServerEvent('qb-labs:server:UpdateIngredients', data.lab, true)

    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
    Wait(5000)
    ClearPedTasks(PlayerPedId())

    TriggerServerEvent('qb-labs:server:UpdateStock', data.lab, "stock")
    TriggerServerEvent('qb-labs:server:UpdateIngredients', data.lab, false)
end)

RegisterNetEvent('qb-labs:client:ReturnStock', function(data)
    local ped = PlayerPedId()
    TriggerServerEvent('qb-labs:server:UpdateIngredients', data.lab, true)
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)
    QBCore.Functions.Progressbar("pickup_reycle_package", "Returning ingredients..", 2500, false, true, {}, {}, {}, {}, function() -- Done
        ClearPedTasks(ped)
        DetachEntity(CarryPackage, true, true)
        DeleteObject(CarryPackage)
        CarryPackage = nil
        Config.Labs[data.lab].ingredients.taken = false

        TriggerServerEvent('qb-labs:server:UpdateStock', data.lab, "return")
        TriggerServerEvent('qb-labs:server:UpdateIngredients', data.lab, false)
    end, function() -- cancel
        ClearPedTasks(ped)
        DetachEntity(CarryPackage, true, true)
        DeleteObject(CarryPackage)
        CarryPackage = nil
        Config.Labs[data.lab].ingredients.taken = false

        TriggerServerEvent('qb-labs:server:UpdateStock', data.lab, "return")
        TriggerServerEvent('qb-labs:server:UpdateIngredients', data.lab, false)
    end)
end)

RegisterNetEvent('qb-labs:client:addingredients', function(data)
    if Config.Labs[data.lab].tasks[data.task].ingredients.current >= Config.Labs[data.lab].tasks[data.task].ingredients.needed then 
        QBCore.Functions.Notify('Cannot add more ingredients, it is already filled!', 'error', 2500)
        return 
    end
    
    if CarryPackage then
        TriggerServerEvent('qb-labs:server:UpdateTasks', data.lab, data.task, true)
        local ped = PlayerPedId()
        ClearPedTasks(ped)
        RequestAnimDict("weapon@w_sp_jerrycan")
        while not HasAnimDictLoaded("weapon@w_sp_jerrycan") do Wait(10) end
        TaskPlayAnim(ped, "weapon@w_sp_jerrycan", "fire", 8.0, 1.0, -1, 1, 0, 0, 0, 0)

        QBCore.Functions.Progressbar("pickup_reycle_package", "Adding ingredients..", 5000, false, true, {}, {}, {}, {}, function() -- Done
            ClearPedTasks(ped)
            DetachEntity(CarryPackage, true, true)
            DeleteObject(CarryPackage)
            CarryPackage = nil

            TriggerServerEvent('qb-labs:server:AddIngredients', data.lab, data.task)
            TriggerServerEvent('qb-labs:server:UpdateTasks', data.lab, data.task, false)
        end, function() -- cancel
            ClearPedTasks(ped)
            DetachEntity(CarryPackage, true, true)
            DeleteObject(CarryPackage)
            CarryPackage = nil
            TriggerServerEvent('qb-labs:server:UpdateTasks', data.lab, data.task, false)
        end)
    else
        QBCore.Functions.Notify("Maybe you should first grab some ingredients!", "error", 2500)
    end
end)

RegisterNetEvent('qb-labs:client:SetTemp', function(data)
    TriggerServerEvent('qb-labs:server:UpdateTasks', data.lab, data.task, true)

    local input = exports['qb-input']:ShowInput({
        header = "Set "..Locales[data.lab].parameter,
        submitText = "Enter",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'temperature',
                text = Locales[data.lab].unit
            }
        }
    })
    if input then
        if not input.temperature then 
            TriggerServerEvent('qb-labs:server:UpdateTasks', data.lab, data.task, false)
            return 
        end
        local temp = tonumber(input.temperature)
        if temp <= 0 or temp >= 100 then
            TriggerServerEvent('qb-labs:server:UpdateTasks', data.lab, data.task, false)
            QBCore.Functions.Notify('Invalid '..Locales[data.lab].parameter..'.. (1 to 100)', 'error', 2500)
            return
        end
        TriggerServerEvent('qb-labs:server:UpdateTasks', data.lab, data.task, false)
        TriggerServerEvent('qb-labs:server:SetTemperature', data.lab, data.task, temp)
    else
        TriggerServerEvent('qb-labs:server:UpdateTasks', data.lab, data.task, false)
    end
end)

RegisterNetEvent('qb-labs:client:UpdateStock', function(lab, amount)
    Config.Labs[lab].ingredients.stock = amount
end)

RegisterNetEvent('qb-labs:client:UpdateIngredients', function(lab, bool)
    Config.Labs[lab].ingredients.busy = bool
end)

RegisterNetEvent('qb-labs:client:UpdateTasks', function(lab, task, bool)
    Config.Labs[lab].tasks[task].busy = bool
end)

RegisterNetEvent('qb-labs:client:SetTemperature', function(lab, task, temp)
    Config.Labs[lab].tasks[task].temperature = temp
end)

RegisterNetEvent('qb-labs:client:SetTaskStarted', function(lab, task, bool)
    Config.Labs[lab].tasks[task].started = bool
end)

RegisterNetEvent('qb-labs:client:SetTaskCompleted', function(lab, task, bool)
    Config.Labs[lab].tasks[task].completed = bool
end)

RegisterNetEvent('qb-labs:client:AddIngredients', function(lab, task, amount)
    Config.Labs[lab].tasks[task].ingredients.current = amount
end)

RegisterNetEvent('qb-labs:client:FinishLab', function(lab)
    for k, v in pairs(Config.Labs[lab].tasks) do
        v.busy = false
        v.completed = false
        v.started = false
        v.ingredients.current = 0
        v.timeremaining = v.duration
        v.temperature = 80
    end
end)

RegisterNetEvent('qb-labs:client:CureBusyState', function(lab, state)
    Config.Labs[lab].curing.busy = state
end)

RegisterNetEvent('qb-labs:client:CureStartedState', function(lab, state)
    Config.Labs[lab].curing.started = state
end)

RegisterNetEvent('qb-labs:client:CureCompletedState', function(lab, state)
    Config.Labs[lab].curing.completed = state
end)

RegisterNetEvent('qb-labs:client:SetPurity', function(lab, purity)
    Config.Labs[lab].curing.purity = purity
end)

RegisterNetEvent('qb-labs:client:AddCureBatch', function(data)
    if Config.Labs[data.lab].curing.busy then
        QBCore.Functions.Notify('Someone is already using this!', 'error', 2500)
        return
    elseif Config.Labs[data.lab].curing.started then
        QBCore.Functions.Notify('The process has already started!', 'error', 2500)
        return
    else

        TriggerServerEvent('qb-labs:client:CureBusyState', data.lab, true)
        local ped = PlayerPedId()

        QBCore.Functions.Progressbar("pickup_reycle_package", "Adding Batch..", 500, false, true, {}, {}, {}, {}, function() -- Done
            ClearPedTasks(ped)
            TriggerServerEvent('qb-labs:server:AddCureBatch', data.lab)

            TriggerServerEvent('qb-labs:client:CureBusyState', data.lab, false)
        end, function() -- cancel
            ClearPedTasks(ped)
            TriggerServerEvent('qb-labs:client:CureBusyState', data.lab, false)
        end)
    end
end)

RegisterNetEvent('qb-labs:client:TakeCureBatch', function(data)
    if Config.Labs[data.lab].curing.busy then
        QBCore.Functions.Notify('Someone is already using this!', 'error', 2500)
        return
    else
        TriggerServerEvent('qb-labs:client:CureBusyState', data.lab, true)
        local ped = PlayerPedId()

        QBCore.Functions.Progressbar("pickup_reycle_package", "Taking Batch..", 500, false, true, {}, {}, {}, {}, function() -- Done
            ClearPedTasks(ped)
            TriggerServerEvent('qb-labs:server:TakeCureBatch', data.lab)

            TriggerServerEvent('qb-labs:client:CureBusyState', data.lab, false)
        end, function() -- cancel
            ClearPedTasks(ped)
            TriggerServerEvent('qb-labs:client:CureBusyState', data.lab, false)
        end)
    end
end)

RegisterNetEvent('qb-labs:client:MakeMethBags', function()
    QBCore.Functions.Progressbar("makeMethBags", "Making smaller meth bags..", 12000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('qb-labs:server:MakeMethBags')
    end, function() -- Cancel
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('qb-labs:client:MakeCokeBags', function()
    QBCore.Functions.Progressbar("makeCokeBags", "Making smaller coke bags..", 12000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('qb-labs:server:MakeCokeBags')
    end, function() -- Cancel
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('qb-labs:client:MakeWeedBags', function()
    QBCore.Functions.Progressbar("makeWeedBags", "Making smaller weed bags..", 12000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('qb-labs:server:MakeWeedBags')
    end, function() -- Cancel
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('qb-labs:client:UseCokeBag', function(purity)
    QBCore.Functions.Progressbar("snort_coke", "Quick sniff..", math.random(5000, 8000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "switch@trevor@trev_smoking_meth",
        anim = "trev_smoking_meth_loop",
        flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        TriggerEvent("evidence:client:SetStatus", "widepupils", 200)

        if effectActive then return end
        effectActive = true

        if purity > 74 then -- Coke effect from qb-smallresources
            local startStamina = 20
            local ped = PlayerPedId()
            StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
            Wait(math.random(5000, 8000))
            StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
            Wait(math.random(5000, 8000))
            StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
            StopScreenEffect("DrugsMichaelAliensFightIn")
            StopScreenEffect("DrugsMichaelAliensFight")
            StopScreenEffect("DrugsMichaelAliensFightOut")
            SetRunSprintMultiplierForPlayer(PlayerId(), 1.1)

            while startStamina > 0 do
                Wait(1000)
                if math.random(1, 100) < 20 then
                    RestorePlayerStamina(PlayerId(), 1.0)
                end
                startStamina = startStamina - 1
                if math.random(1, 100) < 10 and IsPedRunning(ped) then
                    SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
                end
                if math.random(1, 300) < 10 then
                    AlienEffect()
                    Wait(math.random(3000, 6000))
                end

                local armour = GetPedArmour(PlayerPedId())
                if armour + 5 <= 20 then
                    SetPedArmour(PlayerPedId(), GetPedArmour(PlayerPedId()) + 5)
                end
            end

            if IsPedRunning(ped) then
                SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
            end

            startStamina = 0
            SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
        end

        effectActive = false
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)