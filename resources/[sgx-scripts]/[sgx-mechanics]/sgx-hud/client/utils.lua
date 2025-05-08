function Utils.Functions:CustomFuelExport(vehicle)
    -- Check if the vehicle is valid
    if not DoesEntityExist(vehicle) then
        return false
    end

    -- TriggerServerEvent("nchub-hud:Server:ErrorHandle", _t("hud.export.fuel_missing"))

    local fuelLevel = exports['sgx-fuel']:GetFuel(vehicle)
    return fuelLevel
end

function Utils.Functions:CustomVoiceResource()
    -- Add your custom sound system events.
    -- for ex:
    --[[
        AddEventHandler("customVoice:setVoiceRange", function(mode)
            Koci.Client.HUD.data.bars.voice.range = mode
        end)

        AddEventHandler("customVoice:setRadioTalking", function(radioTalking)
            Koci.Client.HUD.data.bars.voice.radio = radioTalking
        end)
    --]]
end

local function SetVehicleCruiseControlState(state)
    Koci.Client.HUD.data.vehicle.cruiseControlStatus = state
end
local function SetVehicleSeatbeltState(state)
    Koci.Client.HUD.data.vehicle.isSeatbeltOn = state
end

function Utils.Functions:GetPedVehicleSeat(ped, vehicle)
    for i = -1, 16 do
        if (GetPedInVehicleSeat(vehicle, i) == ped) then return i end
    end
    return -1
end

exports("CruiseControlState", function(...)
    SetVehicleCruiseControlState(...)
end)
exports("SeatbeltState", function(...)
    SetVehicleSeatbeltState(...)
end)
