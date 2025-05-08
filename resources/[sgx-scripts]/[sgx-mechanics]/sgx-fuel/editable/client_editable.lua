function GetFuel(vehicle)
	return DecorGetFloat(vehicle, Config.FuelDecor)
end

exports('GetFuel', GetFuel)

function SetFuel(vehicle, fuel)
	if type(fuel) == 'number' and fuel >= 0 and fuel <= 100 then
		SetVehicleFuelLevel(vehicle, fuel + 0.0)
		DecorSetFloat(vehicle, Config.FuelDecor, GetVehicleFuelLevel(vehicle))
	end
end

exports('SetFuel', SetFuel)

function CreateBlip(coords)
	local blip = AddBlipForCoord(coords)
	SetBlipSprite(blip, Config.blipSettings['sprite'])
	SetBlipScale(blip, Config.blipSettings['scale'])
	SetBlipColour(blip, Config.blipSettings['color'])
	SetBlipDisplay(blip, Config.blipSettings['display'])
	SetBlipAsShortRange(blip, Config.blipSettings['shortRange'])
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Config.blipSettings['name'])
	EndTextCommandSetBlipName(blip)
	return blip
end

function openFuelMenu()
	if not nuiOpened then
		local vehicle = vehicleInFront()
	    if vehicle ~= nil and vehicle ~= 0 then
			local vehicleFuel = GetFuel(vehicle)
			local vehicleFuelType = getFuelType(vehicle)
			local vehicleName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)) or Config.DefaultVehicleName
			local vehiclePlate = GetVehicleNumberPlateText(vehicle)
			local vehicleMaxSpeed = math.floor(GetVehicleEstimatedMaxSpeed(vehicle) * speedMultiplier)
			local vehicleEngineTemperature = GetVehicleEngineTemperature(vehicle)
			SetNuiFocus(true, true)
			NuiMessage("OPEN_FUEL_MENU")
			NuiMessage("SET_FUEL_LEVEL", vehicleFuel)
			NuiMessage("SET_FUEL_TYPE", vehicleFuelType)
			NuiMessage("SET_VEHICLE_NAME", vehicleName)
			NuiMessage("SET_VEHICLE_PLATE", vehiclePlate)
			NuiMessage("SET_VEHICLE_MAX_SPEED", vehicleMaxSpeed)
			NuiMessage("SET_VEHICLE_ENGINE_TEMPERATURE", vehicleEngineTemperature)
			nuiOpened = true
		end
	end
end

function getFuelType(vehicle)
    local model = GetEntityModel(vehicle)
    local isMotorCycle = IsThisModelABike(model) or IsThisModelAQuadbike(model)
    local topSpeedKM = math.floor(GetVehicleEstimatedMaxSpeed(vehicle) * 3.6)
    local vehClass = "DIESEL"
	if topSpeedKM < 150 then
        vehClass = "DIESEL"
    elseif topSpeedKM < 200 then
        vehClass = "ECONOMIC"
	elseif topSpeedKM < 250 then
		vehClass = "SUPER"
    else
        vehClass = "SUPER_PLUS"
    end
    return vehClass
end

RegisterNUICallback("purchaseFuel", function(data,cb)
    local fuelPrice = Config.Prices[data.fuelType] * tonumber(data.fuelAmount)
    local selectedMethod = data.selectedPaymentMethod
    local fuel = GetFuel(vehicleInFront())
    local totalFuel = fuel + tonumber(data.fuelAmount) * 1.0
    if totalFuel > 100 then
        totalFuel = 100.0
    end
    if Config.Framework == 'esx' then
        local playerCash = TriggerCallback(Config.eventPrefix .. 'getESXCash', fuelPrice)
        local playerBank = TriggerCallback(Config.eventPrefix .. 'getESXBank', fuelPrice)

        if selectedMethod == "cash" then
            if playerCash >= fuelPrice then
                local removed = TriggerCallback(Config.eventPrefix .. 'removeCashMoney', fuelPrice)
                SetFuel(vehicleInFront(), totalFuel)
                cb(true)
            else
                Config.Notification(Config.NotificationText['enoughmnoney'].text, Config.NotificationText['enoughmnoney'].type, false)
                cb(false)
            end
        elseif selectedMethod == "bank" then
            if playerBank >= fuelPrice then
                local removed = TriggerCallback(Config.eventPrefix .. 'removeBankMoney', fuelPrice)
                SetFuel(vehicleInFront(), totalFuel)
                cb(true)
            else
                Config.Notification(Config.NotificationText['enoughmnoney'].text, Config.NotificationText['enoughmnoney'].type, false)
                cb(false)
            end
        end
    elseif Config.Framework == 'qb' then
        local PlayerData = Core.Functions.GetPlayerData()
        cash = PlayerData["money"].cash
        bank = PlayerData["money"].bank
        if selectedMethod == "cash" then
            if cash >= fuelPrice then
                local removed = TriggerCallback(Config.eventPrefix .. 'removeCashMoney', fuelPrice)
                SetFuel(vehicleInFront(), totalFuel)
                cb(true)
            else
                Config.Notification(Config.NotificationText['enoughmnoney'].text, Config.NotificationText['enoughmnoney'].type, false)
                cb(false)
            end
        elseif selectedMethod == "bank" then
            if bank >= fuelPrice then
                local removed = TriggerCallback(Config.eventPrefix .. 'removeBankMoney', fuelPrice)
                SetFuel(vehicleInFront(), totalFuel)
                cb(true)
            else
                Config.Notification(Config.NotificationText['enoughmnoney'].text, Config.NotificationText['enoughmnoney'].type, false)
                cb(false)
            end
        end
    else
        cb(true)
        SetFuel(vehicleInFront(), totalFuel)
    end
end)

function TriggerCallback(name, data)
    local incomingData = false
    local status = 'UNKOWN'
    local counter = 0
    WaitCore()

    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        Core.TriggerServerCallback(name, function(payload)
            status = 'SUCCESS'
            incomingData = payload
        end, data)
    else
        Core.Functions.TriggerCallback(name, function(payload)
            status = 'SUCCESS'
            incomingData = payload
        end, data)
    end
    CreateThread(function()
        while incomingData == 'UNKOWN' do
            Citizen.Wait(1000)
            if counter == 4 then
                status = 'FAILED'
                incomingData = false
                break
            end
            counter = counter + 1
        end
    end)

    while status == 'UNKOWN' do
        Citizen.Wait(0)
    end
    return incomingData
end