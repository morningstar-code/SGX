local QBCore = exports['qb-core']:GetCoreObject()
local pGang = {}
local pJob = {}
local IsBlocking = false

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    local Data = QBCore.Functions.GetPlayerData()
    pGang = Data.gang
    pJob = Data.job
    createBlips(pJob.name)
end)

RegisterNetEvent('QBCore:Client:SetDuty', function()
    local Data = QBCore.Functions.GetPlayerData()
    pJob = Data.job
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate', function(gang)
    pGang = gang
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    pJob = job
end)

-- RegisterNetEvent('qb-carkeys:client:houseGarageConfig', function(garageConfig)
--     TriggerServerEvent('qb-carkeys:server:houseGarageConfig', garageConfig)
--     HouseGarages = garageConfig
-- end)

-- RegisterNetEvent('qb-carkeys:client:addHouseGarage', function(house, garageInfo)
--     TriggerServerEvent('qb-carkeys:server:addHouseGarage', house, garageInfo)
--     HouseGarages[house] = garageInfo
-- end)

RegisterNetEvent('Garages:Open', function()
    IsBlocking = false
    local pGarage = GetCurrentGarage()
    if pGarage ~= nil then
        TriggerEvent('qb-carkeys:VehicleList')
    else
        pGarage = GetJobGarage()
        if pGarage ~= nil then
            if pJob.name == JobGarages[pGarage].job then
                TriggerEvent('qb-carkeys:OpenJobGarage', pGarage)
            else
                QBCore.Functions.Notify("You are not Authorized!", "error", 3000)
            end
        else
            pGarage = GetGangGarage()
            if pGarage ~= nil then
                if pGang.name == GangGarages[pGarage].gang then
                    TriggerEvent('qb-carkeys:VehicleList')
                else
                    QBCore.Functions.Notify("How do you even think about it bitch?", "error", 3000)
                end
            else
                QBCore.Functions.Notify("We couldn't Find Garage Sir!", "error", 3000)
            end
        end
    end
end)

RegisterNetEvent('Garages:OpenHouseGarage', function()
    local pGarage = GetHouseGarage()
    if pGarage ~= nil then
        QBCore.Functions.TriggerCallback("qb-houses:server:hasKey", function(result)
            if result then
                TriggerEvent('qb-carkeys:HouseVehicleList')
            else
                QBCore.Functions.Notify("You have no Access to the Garage!", "error", 3000)
            end
        end, pGarage)
    else
        QBCore.Functions.Notify("We couldn't Find Garage here Sir!", "error", 3000)
    end
end)

RegisterNetEvent('qb-carkeys:OpenJobGarage', function()
    local pGarage = GetJobGarage()
    if JobGarages[pGarage].isHelipad then
        if pJob.onduty then
            TriggerEvent('qb-carkeys:client:SharedHeliGarage')
        else
            TriggerEvent('QBCore:Notify', "Shared Garages can be accessed only when in Onduty!", "error")
        end
    else
        local pSpot = GetpSpot(pGarage)
        if pSpot ~= nil then
            exports['qb-menu']:openMenu({
                {
                    header = "Personal Vehicles",
                    txt = "List of owned vehicles.",
                    params = {
                        event = "qb-carkeys:JobVehicleList",
                    }
                },
                {
                    header = "Shared Vehicles",
                    txt = "List of shared vehicles.",
                    params = {
                        event = "qb-carkeys:client:SharedVehicleMenu"
                    }
                },
                {
                    header = "< Close Menu",
                    params = {
                        event = 'qb-menu:closeMenu',
                    }
                },
            })
        else
            QBCore.Functions.Notify("You need to be near a free parking spot!")
        end
    end
end)

RegisterNetEvent('Garages:OpenDepot', function()
    local pDepot = GetCurrentDepot()
    exports['qb-menu']:openMenu({
        {
			header = Depots[pDepot].label,
			isMenuHeader = true
		},
		{
			header = "My Vehicles",
			txt = "List of my depoted vehicles.",
			params = {
				event = "qb-carkeys:client:DepotVehicleList",
			}
		},
		{
			header = "< Close Menu",
			params = {
				event = 'qb-menu:closeMenu',
			}
		},
    })
end)

RegisterNetEvent('Garages:Store', function()
    local ped = PlayerPedId()
    local coordA = GetEntityCoords(ped, 1)
    local coordB = GetOffsetFromEntityInWorldCoords(ped, 0.0, 100.0, 0.0)
    local curVeh = getVehicleInDirection(coordA, coordB)
    local plate = GetVehicleNumberPlateText(curVeh)
    local bodyDamage = math.ceil(GetVehicleBodyHealth(curVeh))
    local engineDamage = math.ceil(GetVehicleEngineHealth(curVeh))
    local vehmods = QBCore.Functions.GetVehicleProperties(curVeh)
    local totalFuel = exports['sgx-fuel']:GetFuel(curVeh)
    local vehicleProps = GetVehicleProperties(curVeh)

    QBCore.Functions.TriggerCallback('qb-carkeys:server:checkVehicleOwner', function(owned)
        Citizen.Wait(100)
        if owned then
            local pGarage = GetCurrentGarage()
            if pGarage ~= nil then
                TriggerServerEvent('qb-carkeys:server:updateVehicleStatus', totalFuel, engineDamage, bodyDamage, plate, pGarage)
                TriggerServerEvent('qb-carkeys:server:updateVehicleState', 1, plate, pGarage)
                TriggerServerEvent('qb-carkeys:server:SaveVehicleMods', plate, vehmods) 
                TriggerServerEvent('qb-carkeys:server:modifystate', vehicleProps)
                RemoveOutsideVeh(plate)
                QBCore.Functions.DeleteVehicle(curVeh)
                QBCore.Functions.Notify("Vehicle Parked In : "..Garages[pGarage].label, "success", 44)
            else
                pGarage = GetJobGarage()
                if pGarage ~= nil then
                    if JobGarages[pGarage].isHelipad then
                        QBCore.Functions.Notify("This vehicle can not be stored!", "error", 3000)
                    else
                        if pJob.name == JobGarages[pGarage].job then
                            TriggerServerEvent('qb-carkeys:server:updateVehicleStatus', totalFuel, engineDamage, bodyDamage, plate, pGarage)
                            TriggerServerEvent('qb-carkeys:server:updateVehicleState', 1, plate, pGarage)
                            TriggerServerEvent('qb-carkeys:server:SaveVehicleMods', plate, vehmods)
                            RemoveOutsideVeh(plate)
                            QBCore.Functions.DeleteVehicle(curVeh)
                            QBCore.Functions.Notify("Vehicle Parked In : "..JobGarages[pGarage].label, "success", 4500)
                        else
                            QBCore.Functions.Notify("You Have No Acceess to Park here!", "error", 3000)
                        end
                    end
                else
                    pGarage = GetGangGarage()
                    if pGarage ~= nil then
                        if pGang.name == GangGarages[pGarage].gang then
                            TriggerServerEvent('qb-carkeys:server:updateVehicleStatus', totalFuel, engineDamage, bodyDamage, plate, pGarage)
                            TriggerServerEvent('qb-carkeys:server:updateVehicleState', 1, plate, pGarage)
                            TriggerServerEvent('qb-carkeys:server:SaveVehicleMods', plate, vehmods)
                            RemoveOutsideVeh(plate)
                            QBCore.Functions.DeleteVehicle(curVeh)
                            QBCore.Functions.Notify("Vehicle Parked In : "..GangGarages[pGarage].label, "success", 4500)
                        else
                            QBCore.Functions.Notify("You can't store your shit here Bitch!", "error", 3000)
                        end
                    else
                        QBCore.Functions.Notify("Unable to Find Garage", "error", 3000)
                    end
                end
            end
        else
            local pGarage = GetJobGarage()
            QBCore.Functions.TriggerCallback('qb-carkeys:server:isSharedVehicle', function(isShared)
                if isShared then
                    if pJob.name == JobGarages[pGarage].job then
                        TriggerServerEvent('qb-carkeys:server:updateVehicleStatus', totalFuel, engineDamage, bodyDamage, plate, pGarage, true)
                        TriggerServerEvent('qb-carkeys:server:updateSharedVehState', 'Stored', plate, pGarage)
                        TriggerServerEvent('qb-carkeys:server:SaveVehicleMods', plate, vehmods, true)
                        QBCore.Functions.DeleteVehicle(curVeh)
                    else
                        QBCore.Functions.Notify("You are not Authorized!", "error", 3000)
                    end
                else
                    QBCore.Functions.Notify("This vehicle can not be stored!", "error", 3500)
                end
            end, plate, pGarage)
        end
    end, plate)
end)

-- RegisterNetEvent('Garages:StoreInHouseGarage', function()
--     local ped = PlayerPedId()
--     local coordA = GetEntityCoords(ped, 1)
--     local coordB = GetOffsetFromEntityInWorldCoords(ped, 0.0, 100.0, 0.0)
--     local curVeh = getVehicleInDirection(coordA, coordB)
--     local plate = GetVehicleNumberPlateText(curVeh)
--     local bodyDamage = math.ceil(GetVehicleBodyHealth(curVeh))
--     local engineDamage = math.ceil(GetVehicleEngineHealth(curVeh))
--     local totalFuel = exports['sgx-fuel']:GetFuel(curVeh)
--     QBCore.Functions.TriggerCallback('qb-carkeys:server:checkVehicleOwner', function(owned)
--         Citizen.Wait(1000)
--         if owned then
--             local pGarage = GetHouseGarage()
--             if pGarage ~= nil then
--                 QBCore.Functions.TriggerCallback("qb-houses:server:hasKey", function(result)
--                     if result then
--                         TriggerServerEvent('qb-carkeys:server:updateVehicleStatus', totalFuel, engineDamage, bodyDamage, plate, pGarage)
--                         TriggerServerEvent('qb-carkeys:server:updateVehicleState', 1, plate, pGarage)
--                         RemoveOutsideVeh(plate)
--                         QBCore.Functions.DeleteVehicle(curVeh)
--                         QBCore.Functions.Notify("Vehicle Parked In : "..HouseGarages[pGarage].label, "success", 4500)
--                     else
--                         QBCore.Functions.Notify("You have no Access to park here!", "error", 3000)
--                     end
--                 end, pGarage)
--             else
--                 QBCore.Functions.Notify("Unable to Find Garage", "error", 3000)
--             end
--         end
--     end, plate)
-- end)

RegisterNetEvent('qb-carkeys:VehicleList', function()
    DeleteViewedCar()
    local pGarage = GetCurrentGarage()
    if pGarage ~= nil then
        pGarage = pGarage
    else
        pGarage = GetGangGarage()
        if pGarage ~= nil then
            pGarage = pGarage
        else
            pGarage = GetJobGarage()
        end
    end
    local pSpot = GetpSpot(pGarage)
    QBCore.Functions.TriggerCallback('qb-carkeys:server:GetPlayerVehicles', function(vehcheck)
        if vehcheck ~= nil then
            if pSpot ~= nil then
                local state = nil
                local isLocked = false
                local menu = {{
                    header = "< Close Menu",
                    params = {
                        event = 'qb-menu:closeMenu',
                    },
                }}
                for i = 1, #vehcheck do
                    if vehcheck[i].state == 1 then
                        state = "Stored"
                    elseif vehcheck[i].state == 2 then
                        state = "Impounded"
                    elseif vehcheck[i].state == 0 then
                        state = "Out"
                    end
                    if vehcheck[i].state == 1 then
                        isLocked = false
                    else
                        isLocked = true
                    end
                    table.insert(menu, {
                        header = QBCore.Shared.Vehicles[vehcheck[i].vehicle].model,
                        txt = "Plate: "..vehcheck[i].plate.." | "..state,
                        isMenuHeader = isLocked,
                        params = {
                            event = "qb-carkeys:client:AttemptSpawn",
                            args = {
                                plate = vehcheck[i].plate,
                                vehicle = vehcheck[i].vehicle,
                                engine = vehcheck[i].engine,
                                body = vehcheck[i].body,
                                fuel = vehcheck[i].fuel,
                                vehstate = state,
                                garage = pGarage,
                                type = 0
                            }
                        }
                    })
                    exports['qb-menu']:openMenu(menu)
                end
            else
                QBCore.Functions.Notify("You need to be near a free parking spot!")
            end
        else
            TriggerEvent('QBCore:Notify', "You Have No Vehicles Parked here!", "error")
        end
    end, pGarage)
end)

RegisterNetEvent('qb-carkeys:HouseVehicleList', function(Data)
    DeleteViewedCar()
    local pGarage = GetHouseGarage()
    QBCore.Functions.TriggerCallback('qb-carkeys:server:GetPlayerVehicles', function(vehcheck)
        if vehcheck ~= nil then
            local state = nil
            local isLocked = false
            local menu = {{
                header = "< Close Menu",
                params = {
                    event = 'qb-menu:closeMenu',
                }
            }}
            for i = 1, #vehcheck do
                if vehcheck[i].state == 1 then
                    state = "Stored"
                elseif vehcheck[i].state == 2 then
                    state = "Impounded"
                elseif vehcheck[i].state == 0 then
                    state = "Out"
                end
                if vehcheck[i].state == 1 then
                    isLocked = false
                else
                    isLocked = true
                end
                table.insert(menu, {
                    header = QBCore.Shared.Vehicles[vehcheck[i].vehicle].model,
                    txt = "Plate: "..vehcheck[i].plate.." | "..state,
                    isMenuHeader = isLocked,
                    params = {
                        event = "qb-carkeys:client:AttemptHouseSpawn",
                        args = {
                            plate = vehcheck[i].plate,
                            vehicle = vehcheck[i].vehicle,
                            engine = vehcheck[i].engine,
                            body = vehcheck[i].body,
                            fuel = vehcheck[i].fuel,
                            vehstate = state,
                            garage = pGarage
                        }
                    }
                })
                exports['qb-menu']:openMenu(menu)
            end
        else
            TriggerEvent('QBCore:Notify', "You Have No Vehicles Parked in Garage!", "error")
        end
    end, pGarage)
end)

RegisterNetEvent('qb-carkeys:JobVehicleList', function()
    DeleteViewedCar()
    local pGarage = GetCurrentGarage()
    if pGarage ~= nil then
        pGarage = pGarage
    else
        pGarage = GetGangGarage()
        if pGarage ~= nil then
            pGarage = pGarage
        else
            pGarage = GetJobGarage()
        end
    end
    local pSpot = GetpSpot(pGarage)
    QBCore.Functions.TriggerCallback('qb-carkeys:server:GetPlayerVehicles', function(vehcheck)
        if vehcheck ~= nil then
            if pSpot ~= nil then
                local state = nil
                local isLocked = false
                local menu = {{
                    header = "< Go Back",
                    params = {
                        event = "qb-carkeys:OpenJobGarage",       
                    },
                }}
                for i = 1, #vehcheck do
                    if vehcheck[i].state == 1 then
                        state = "Stored"
                    elseif vehcheck[i].state == 2 then
                        state = "Impounded"
                    elseif vehcheck[i].state == 0 then
                        state = "Out"
                    end
                    if vehcheck[i].state == 1 then
                        isLocked = false
                    else
                        isLocked = true
                    end
                    table.insert(menu, {
                        header = QBCore.Shared.Vehicles[vehcheck[i].vehicle].model,
                        txt = "Plate: "..vehcheck[i].plate.." | "..state,
                        isMenuHeader = isLocked,
                        params = {
                            event = "qb-carkeys:client:AttemptSpawn",
                            args = {
                                plate = vehcheck[i].plate,
                                vehicle = vehcheck[i].vehicle,
                                engine = vehcheck[i].engine,
                                body = vehcheck[i].body,
                                fuel = vehcheck[i].fuel,
                                vehstate = state,
                                garage = pGarage,
                                type = 1
                            }
                        }
                    })
                    exports['qb-menu']:openMenu(menu)
                end
            else
                QBCore.Functions.Notify("You need to be near a free parking spot!")
            end
        else
            TriggerEvent('QBCore:Notify', "You Have No Vehicles Parked here!", "error")
        end
    end, pGarage)
end)

RegisterNetEvent('qb-carkeys:client:DepotVehicleList', function()
    -- QBCore.Functions.TriggerCallback("qb-carkeys:server:checkFines", function(hasFines)
        local citizenId = QBCore.Functions.GetPlayerData().citizenid;
        -- if (hasFines) then
        --     TriggerEvent('QBCore:Notify', "oof we have some unpaid fines, are we?", "error", 3000);
        -- else
            QBCore.Functions.TriggerCallback('qb-carkeys:server:GetDepotVehicles', function(vehcheck)
                local NoVeh = false
                local menu = {{
                    header = "< Go Back",
                    params = {
                        event = "Garages:OpenDepot",
                    }
                }}
                for i = 1, #vehcheck do
                    if vehcheck[i].state == 0 then
                        table.insert(menu, {
                            header = QBCore.Shared.Vehicles[vehcheck[i].vehicle].model,
                            txt = "Plate: "..vehcheck[i].plate.." | Fine: "..vehcheck[i].depotprice.."$",
                            params = {
                                event = "qb-carkeys:client:SpawnDepotVehicle",
                                args = {
                                    plate = vehcheck[i].plate,
                                    vehicle = vehcheck[i].vehicle,
                                    engine = vehcheck[i].engine,
                                    body = vehcheck[i].body,
                                    fuel = vehcheck[i].fuel,
                                    fine = vehcheck[i].depotprice,
                                    garage = vehcheck[i].garage
                                }
                            }
                        })
                        NoVeh = true
                    end
                    if NoVeh then
                        exports['qb-menu']:openMenu(menu)
                    end
                end
                if not NoVeh then
                    TriggerEvent('QBCore:Notify', "You Have No Vehicles in Depot!", "error", 3000)
                end
            end)
    -- end, citizenid)
end)

RegisterNetEvent('qb-carkeys:client:SharedVehicleMenu', function()
    local garage = GetJobGarage()
    if pJob.onduty then
        QBCore.Functions.TriggerCallback('qb-carkeys:server:CheckSharedCategories', function(result)
            if result ~= nil then
                local categories = {}
                for i = 1, #result do
                    if categories[result[i].category] == nil then
                        categories[result[i].category] = 1
                    else
                        categories[result[i].category] = tonumber(categories[result[i].category]) + 1
                    end
                end
                local menu = {{
                    header = "< Go Back",
                    params = {
                    event = "qb-carkeys:OpenJobGarage",
                    },
                }}
                for k, v in pairs(categories) do
                    table.insert(menu, {
                        header = k,
                        txt = v.." vehicles.",
                        params = {
                            event = "qb-carkeys:client:SharedVehicleList",
                            args = {
                                cat = k
                            }
                        },
                    })
                end
                exports['qb-menu']:openMenu(menu)
            else
                TriggerEvent('QBCore:Notify', "No Vehicles!", "error")
            end
        end, garage)
    else
        TriggerEvent('QBCore:Notify', "Shared Garages can be accessed only when in Onduty!", "error")
    end
end)

RegisterNetEvent('qb-carkeys:client:SharedHeliGarage', function()
    DeleteViewedCar()
    local pGarage = GetJobGarage()
    QBCore.Functions.TriggerCallback('qb-carkeys:server:GetSharedHeli', function(vehcheck)
        if vehcheck ~= nil then
            local isLocked = false
            local menu = {{
                header = "< Close Menu",
                params = {
                    event = 'qb-menu:closeMenu',
                }
            }}
            for i = 1, #vehcheck do
                table.insert(menu, {
                    header = QBCore.Shared.Vehicles[vehcheck[i].vehicle].model,
                    txt = "Plate: "..vehcheck[i].plate.." | "..vehcheck[i].state,
                    params = {
                        event = "qb-carkeys:client:AttemptSpawn",
                        args = {
                            plate = vehcheck[i].plate,
                            vehicle = vehcheck[i].vehicle,
                            engine = vehcheck[i].engine,
                            body = vehcheck[i].body,
                            fuel = vehcheck[i].fuel,
                            vehstate = vehcheck[i].state,
                            garage = pGarage,
                            type = 3
                        }
                    }
                })
                exports['qb-menu']:openMenu(menu)
            end
        else
            TriggerEvent('QBCore:Notify', "No Vehicles!", "error")
        end
    end, pGarage)
end)

RegisterNetEvent('qb-carkeys:client:SharedVehicleList', function(Data)
    DeleteViewedCar()
    local pGarage = GetJobGarage()
    QBCore.Functions.TriggerCallback('qb-carkeys:server:GetSharedVehicles', function(vehcheck)
        if vehcheck ~= nil then
            local isLocked = false
            local menu = {{
                header = "< Go Back",
                params = {
                    event = "qb-carkeys:client:SharedVehicleMenu",
                }
            }}
            for i = 1, #vehcheck do
                table.insert(menu, {
                    header = QBCore.Shared.Vehicles[vehcheck[i].vehicle].model,
                    txt = "Plate: "..vehcheck[i].plate.." | "..vehcheck[i].state,
                    params = {
                        event = "qb-carkeys:client:AttemptSpawn",
                        args = {
                            plate = vehcheck[i].plate,
                            vehicle = vehcheck[i].vehicle,
                            engine = vehcheck[i].engine,
                            body = vehcheck[i].body,
                            fuel = vehcheck[i].fuel,
                            vehstate = vehcheck[i].state,
                            cat = Data.cat,
                            garage = pGarage,
                            type = 2
                        }
                    }
                })
                exports['qb-menu']:openMenu(menu)
            end
        else
            TriggerEvent('QBCore:Notify', "You Have No Vehicles Parked here!", "error")
        end
    end, pGarage, Data.cat)
end)

RegisterNetEvent('qb-carkeys:client:AttemptSpawn', function(Data)
    local enginePercent = round(Data.engine / 10, 0)
	local bodyPercent = round(Data.body / 10, 0)
    if Data.type == 0 then
        exports['qb-menu']:openMenu({
            {
                header = "< Go Back",
                params = {
                    event = "qb-carkeys:VehicleList"
                }
            },
            {
                header = "Take Out Vehicle",
                params = {
                    event = "qb-carkeys:client:SpawnVehicle",
                    args = {
                        vehicle = Data.vehicle,
                        garage  = Data.garage,
                        fuel = Data.fuel,
                        body = Data.body,
                        engine = Data.engine,
                        plate = Data.plate,
                        gType = 0
                    }
                }
                
            },
            {
                header = "Vehicle Status",
                isMenuHeader = true,
                txt = Data.vehstate.." | Engine: "..enginePercent.."% | Body: "..bodyPercent.."%"
            },
        })
        SpawnVehicle(Data.vehicle, Data.garage, Data.fuel, Data.body, Data.engine, Data.plate, 0)
    elseif Data.type == 1 then
        exports['qb-menu']:openMenu({
            {
                header = "< Go Back",
                params = {
                    event = "qb-carkeys:JobVehicleList"
                }
            },
            {
                header = "Take Out Vehicle",
                params = {
                    event = "qb-carkeys:client:SpawnVehicle",
                    args = {
                        vehicle = Data.vehicle,
                        garage  = Data.garage,
                        fuel = Data.fuel,
                        body = Data.body,
                        engine = Data.engine,
                        plate = Data.plate,
                        gType = 0
                    }
                }
                
            },
            {
                header = "Vehicle Status",
                isMenuHeader = true,
                txt = Data.vehstate.." | Engine: "..enginePercent.."% | Body: "..bodyPercent.."%"
            },
        })
        SpawnVehicle(Data.vehicle, Data.garage, Data.fuel, Data.body, Data.engine, Data.plate, 0)
    elseif Data.type == 2 then
        local isLocked = false
        if Data.vehstate == "Out" then
            isLocked = true
        end
        exports['qb-menu']:openMenu({
            {
                header = "< Go Back",
                params = {
                    event = "qb-carkeys:client:SharedVehicleList",
                    args = {
                        cat = Data.cat
                    }
                }
            },
            {
                header = "Take Out Vehicle",
                isMenuHeader = isLocked,
                params = {
                    event = "qb-carkeys:client:SpawnVehicle",
                    args = {
                        vehicle = Data.vehicle,
                        garage  = Data.garage,
                        fuel = Data.fuel,
                        body = Data.body,
                        engine = Data.engine,
                        plate = Data.plate,
                        isShared = true,
                        gType = 0
                    }
                }
                
            },
            {
                header = "Vehicle Status",
                isMenuHeader = true,
                txt = Data.vehstate.." | Engine: "..enginePercent.."% | Body: "..bodyPercent.."%"
            },
            {
                header = "Vehicle Parking Log",
                params = {
                    event = "qb-carkeys:client:ParkingLog",
                    args = {
                        plate = Data.plate,
                        vehicle = Data.vehicle,
                        engine = Data.engine,
                        body = Data.body,
                        fuel = Data.fuel,
                        vehstate = Data.state,
                        garage = Data.garage,
                        state = Data.vehstate,
                        cat = Data.cat
                    }
                }
            },
        })
        if Data.isBack == nil then
            if not isLocked then
                SpawnVehicle(Data.vehicle, Data.garage, Data.fuel, Data.body, Data.engine, Data.plate, 0, false, true)
            end
        end
    elseif Data.type == 3 then
        local isLocked = false
        if Data.vehstate == "Out" then
            isLocked = true
        end
        exports['qb-menu']:openMenu({
            {
                header = "< Go Back",
                params = {
                    event = "qb-carkeys:client:SharedHeliGarage"
                },
            },
            {
                header = "Take Out Vehicle",
                isMenuHeader = isLocked,
                params = {
                    event = "qb-carkeys:client:SpawnVehicle",
                    args = {
                        vehicle = Data.vehicle,
                        garage  = Data.garage,
                        fuel = Data.fuel,
                        body = Data.body,
                        engine = Data.engine,
                        plate = Data.plate,
                        isShared = true,
                        gType = 2
                    }
                }
                
            },
            {
                header = "Vehicle Status",
                isMenuHeader = true,
                txt = Data.vehstate.." | Engine: "..enginePercent.."% | Body: "..bodyPercent.."%"
            },
            {
                header = "Vehicle Parking Log",
                params = {
                    event = "qb-carkeys:client:ParkingLog",
                    args = {
                        plate = Data.plate,
                        vehicle = Data.vehicle,
                        engine = Data.engine,
                        body = Data.body,
                        fuel = Data.fuel,
                        vehstate = Data.state,
                        garage = Data.garage,
                        state = Data.vehstate,
                        isHeli = true
                    }
                }
            },
        })
        if Data.isBack == nil then
            if not isLocked then
                SpawnVehicle(Data.vehicle, Data.garage, Data.fuel, Data.body, Data.engine, Data.plate, 2, false, true)
            end
        end
    end
end)

RegisterNetEvent('qb-carkeys:client:AttemptHouseSpawn', function(Data)
    local enginePercent = round(Data.engine / 10, 0)
	local bodyPercent = round(Data.body / 10, 0)
    exports['qb-menu']:openMenu({
        {
			header = "< Go Back",
			params = {
				event = "qb-carkeys:HouseVehicleList"
			}
		},
		{
			header = "Take Out Vehicle",
			params = {
				event = "qb-carkeys:client:SpawnVehicle",
				args = {
                    vehicle = Data.vehicle,
                    garage  = Data.garage,
                    fuel = Data.fuel,
                    body = Data.body,
                    engine = Data.engine,
                    plate = Data.plate,
                    gType = 1
                }
			}
			
		},
		{
			header = "Vehicle Status",
            isMenuHeader = true,
			txt = Data.vehstate.." | Engine: "..enginePercent.."% | Body: "..bodyPercent.."%"
		},
    })
    SpawnVehicle(Data.vehicle, Data.garage, Data.fuel, Data.body, Data.engine, Data.plate, 1)
end)

RegisterNetEvent('qb-carkeys:client:SpawnVehicle', function(Data)
    SpawnVehicle(Data.vehicle, Data.garage, Data.fuel, Data.body, Data.engine, Data.plate, Data.gType, true, Data.isShared)
    QBCore.Functions.TriggerCallback('qb-carkeys:server:GetVehicleWheelfit', function(wheelfit)
        TriggerServerEvent('qb-wheelfitment_sv:setfit', wheelfit, Data.vehicle)
    end, Data.plate)
    if Data.isShared then
        TriggerServerEvent('qb-carkeys:server:UpdateParkingLog', Data.plate)
    end
    QBCore.Functions.Notify("Vehicle is out of garage!", "success")
end)

RegisterNetEvent('qb-carkeys:client:SpawnDepotVehicle', function(Data)
    SpawnDepotVehicle(Data)
end)

RegisterNetEvent('qb-carkeys:client:ParkingLog', function(Data)
    if Data.isHeli then
        vtype = 3
    else
        vtype = 2
    end
    local menu = {{
        header = "< Go Back",
        params = {
            event = "qb-carkeys:client:AttemptSpawn",
            args = {
                plate = Data.plate,
                vehicle = Data.vehicle,
                engine = Data.engine,
                body = Data.body,
                fuel = Data.fuel,
                vehstate = Data.state,
                garage = Data.garage,
                vehstate = Data.state,
                cat = Data.cat,
                isBack = 2,
                type = vtype
            }
        }
    }}
    QBCore.Functions.TriggerCallback('qb-carkeys:server:GetParkingLog', function(plog)
        if plog ~= nil then
            for i = 1, #plog do
                table.insert(menu, {
                    header = tostring(plog[i].id).." | "..tostring(plog[i].time),
                    txt = tostring(plog[i].name).." ("..tostring(plog[i].post)..")",
                    isMenuHeader = true
                })
            end
        end
        exports['qb-menu']:openMenu(menu)
    end, Data.plate)
end)


function dump(o)
	if type(o) == 'table' then
	   local s = '{ '
	   for k,v in pairs(o) do
		  if type(k) ~= 'number' then k = '"'..k..'"' end
		  s = s .. '['..k..'] = ' .. dump(v) .. ','
	   end
	   return s .. '} '
	else
	   return tostring(o)
	end
 end

 RegisterNetEvent('qb-carkeys:client:AddSharedVehicle', function(garage, faction, category)
    if JobGarages[garage] ~= nil then
        local ped = PlayerPedId()
        local coordA = GetEntityCoords(ped, 1)
        local coordB = GetOffsetFromEntityInWorldCoords(ped, 0.0, 100.0, 0.0)
        local curVeh = getVehicleInDirection(coordA, coordB)
        local vehhash = GetEntityModel(curVeh)
        local plate = GetVehicleNumberPlateText(curVeh)
        local vehname = GetDisplayNameFromVehicleModel(vehhash):lower()
        local model = QBCore.Shared.Vehicles[vehname].model
        for k, v in pairs(QBCore.Shared.Vehicles) do
            if vehhash == QBCore.Shared.Vehicles[k].hash then
                model = QBCore.Shared.Vehicles[k].model
                break
            end
        end
        if curVeh ~= 0 then
            if model ~= nil then
                QBCore.Functions.TriggerCallback('qb-carkeys:server:isVehicleOwned', function(owned)
                    if owned then
                        QBCore.Functions.Notify("You Can't save player owned vehicles!", "error")
                    else
                        QBCore.Functions.TriggerCallback('qb-carkeys:server:isVehicleShared', function(shared)
                            if shared then
                                QBCore.Functions.Notify("This Vehicle is already a Shared Vehicles!", "error")
                            else
                                local mods = json.encode(QBCore.Functions.GetVehicleProperties(curVeh))
                                TriggerServerEvent('qb-carkeys:server:SaveSharedVehicle', plate, model, category, vehhash, faction, garage, mods)
                                Wait(100)
                                QBCore.Functions.DeleteVehicle(curVeh)
                                QBCore.Functions.Notify("Vehicle plate: "..plate.." is stored in "..JobGarages[garage].label, "success")
                            end
                        end, plate)
                    end
                end, plate)
            else
                print("THIS VEHICLE MUST BE ADDED TO THE SHARED.LUA")
            end
        else
            QBCore.Functions.Notify("You need to look at a vehicle to store!", "error")
        end
    else
        QBCore.Functions.Notify("Shared Garage must be exist!", "error")
    end
end)


RegisterNetEvent('garages:Blips')
AddEventHandler('garages:Blips', function()
    ToggleGarageBlips()
end)

-- CreateThread(function()
--     local alreadyEnteredZone = false
--     while true do
--         Wait(500)
--         local inZone = false
--         for k, v in pairs(HouseGarages) do
--             if HouseGarages[k].takeVehicle.x ~= nil and HouseGarages[k].takeVehicle.y ~= nil and HouseGarages[k].takeVehicle.z ~= nil then
--                 if #(GetEntityCoords(PlayerPedId()) - vector3(HouseGarages[k].takeVehicle.x, HouseGarages[k].takeVehicle.y, HouseGarages[k].takeVehicle.z)) < 5 then 
--                     inZone = true
--                     text = "Garage"
--                 end
--             end
--             if inZone and not alreadyEnteredZone then
--                 alreadyEnteredZone = true
--                 exports['qb-ui']:showInteraction(text)
--             end
    
--             if not inZone and alreadyEnteredZone then
--                 alreadyEnteredZone = false
--                 exports['qb-ui']:hideInteraction()
--             end
--         end
--     end
-- end)

GetVehicleProperties = function(vehicle)
    if DoesEntityExist(vehicle) then
        local vehicleProps = QBCore.Functions.GetVehicleProperties(vehicle)

        vehicleProps["tyres"] = {}
        vehicleProps["windows"] = {}
        vehicleProps["doors"] = {}

        for id = 1, 7 do
            local tyreId = IsVehicleTyreBurst(vehicle, id, false)
        
            if tyreId then
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = tyreId
        
                if tyreId == false then
                    tyreId = IsVehicleTyreBurst(vehicle, id, true)
                    vehicleProps["tyres"][ #vehicleProps["tyres"]] = tyreId
                end
            else
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = false
            end
        end

        for id = 1, 13 do
            local windowId = IsVehicleWindowIntact(vehicle, id)

            if windowId ~= nil then
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = windowId
            else
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = true
            end
        end
        
        for id = 0, 5 do
            local doorId = IsVehicleDoorDamaged(vehicle, id)
        
            if doorId then
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = doorId
            else
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = false
            end
        end

        return vehicleProps
    end
end

SetVehicleProperties = function(vehicle, vehicleProps)
    QBCore.Functions.SetVehicleProperties(vehicle, vehicleProps)

    if vehicleProps["windows"] then
        for windowId = 1, 13, 1 do
            if vehicleProps["windows"][windowId] == false then
                SmashVehicleWindow(vehicle, windowId)
            end
        end
    end

    if vehicleProps["tyres"] then
        for tyreId = 1, 7, 1 do
            if vehicleProps["tyres"][tyreId] ~= false then
                SetVehicleTyreBurst(vehicle, tyreId, true, 1000)
            end
        end
    end

    if vehicleProps["doors"] then
        for doorId = 0, 5, 1 do
            if vehicleProps["doors"][doorId] ~= false then
                SetVehicleDoorBroken(vehicle, doorId - 1, true)
            end
        end
    end
end