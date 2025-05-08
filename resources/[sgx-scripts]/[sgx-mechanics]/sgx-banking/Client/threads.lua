Citizen.CreateThread(function()
	if Config.ShowBlips then
		for k,v in ipairs(Config.Locations) do
            if v.name == "Bank" and Config.ShowBlips then 
                local blip = AddBlipForCoord(v.x, v.y, v.z)
                SetBlipSprite(blip, 108)
                SetBlipScale(blip, 0.7)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(tostring(v.name))
                EndTextCommandSetBlipName(blip)
            end
		end
	end
end)

exports['sgx-textui-2']:create3DTextUI("sgx-openbankmenu-legion", {
    coords = vector3(149.74, -1041.47, 29.60),
    displayDist = 6.0,
    interactDist = 2.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "           Acces Bank",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
        triggerName = "sgx-banking:Client:BankMenu:Show",
        args = {}
    }
})

exports['sgx-textui-2']:create3DTextUI("sgx-openbankmenu-pinkage", {
    coords = vector3(314.15, -279.64, 54.40),
    displayDist = 6.0,
    interactDist = 2.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "           Acces Bank",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
        triggerName = "sgx-banking:Client:BankMenu:Show",
        args = {}
    }
})

exports['sgx-textui-2']:create3DTextUI("sgx-openbankmenu-burton", {
    coords = vector3(-351.04, -50.51, 49.30),
    displayDist = 6.0,
    interactDist = 2.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "           Acces Bank",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
        triggerName = "sgx-banking:Client:BankMenu:Show",
        args = {}
    }
})

exports['sgx-textui-2']:create3DTextUI("sgx-openbankmenu-rockford", {
    coords = vector3(-1212.30, -331.11, 38.00),
    displayDist = 6.0,
    interactDist = 2.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "           Acces Bank",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
        triggerName = "sgx-banking:Client:BankMenu:Show",
        args = {}
    }
})

exports['sgx-textui-2']:create3DTextUI("sgx-openbankmenu-pacific", {
    coords = vector3(241.54, 225.85, 106.34),
    displayDist = 6.0,
    interactDist = 2.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "           Acces Bank",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
        triggerName = "sgx-banking:Client:BankMenu:Show",
        args = {}
    }
})

exports['sgx-textui-2']:create3DTextUI("sgx-openbankmenu-pacific02", {
    coords = vector3(243.34, 225.18, 106.34),
    displayDist = 6.0,
    interactDist = 2.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "           Acces Bank",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
        triggerName = "sgx-banking:Client:BankMenu:Show",
        args = {}
    }
})

exports['sgx-textui-2']:create3DTextUI("sgx-openbankmenu-pacific03", {
    coords = vector3(246.67, 223.99, 106.34),
    displayDist = 6.0,
    interactDist = 2.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "           Acces Bank",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
        triggerName = "sgx-banking:Client:BankMenu:Show",
        args = {}
    }
})

exports['sgx-textui-2']:create3DTextUI("sgx-openbankmenu-pacific04", {
    coords = vector3(248.45, 223.35, 106.34),
    displayDist = 6.0,
    interactDist = 2.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "           Acces Bank",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
        triggerName = "sgx-banking:Client:BankMenu:Show",
        args = {}
    }
})

exports['sgx-textui-2']:create3DTextUI("sgx-openbankmenu-great-coean-highway", {
    coords = vector3(-2962.02, 482.99, 15.95),
    displayDist = 6.0,
    interactDist = 2.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "           Acces Bank",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
        triggerName = "sgx-banking:Client:BankMenu:Show",
        args = {}
    }
})

exports['sgx-textui-2']:create3DTextUI("sgx-openbankmenu-paleto-bank", {
    coords = vector3(-112.74, 6470.55, 31.85),
    displayDist = 6.0,
    interactDist = 2.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "           Acces Bank",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
        triggerName = "sgx-banking:Client:BankMenu:Show",
        args = {}
    }
})

exports['sgx-textui-2']:create3DTextUI("sgx-openbankmenu-GRAND-SENORA-DESERT", {
    coords = vector3(1174.91, 2707.39, 38.35),
    displayDist = 6.0,
    interactDist = 2.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "           Acces Bank",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
        triggerName = "sgx-banking:Client:BankMenu:Show",
        args = {}
    }
})

exports['sgx-textui-2']:create3DTextUI("sgx-openbankmenu-pacific-atm00", {
    coords = vector3(238.41, 216.13, 106.30),
    displayDist = 6.0,
    interactDist = 2.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "           Acces ATM",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
        triggerName = "sgx-banking:Client:BankMenu:Show",
        args = {}
    }
})

exports['sgx-textui-2']:create3DTextUI("sgx-openbankmenu-pacific-atm01", {
    coords = vector3(238.00, 217.06, 106.30),
    displayDist = 6.0,
    interactDist = 2.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "           Acces ATM",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
        triggerName = "sgx-banking:Client:BankMenu:Show",
        args = {}
    }
})

exports['sgx-textui-2']:create3DTextUI("sgx-openbankmenu-pacific-atm02", {
    coords = vector3(237.55, 217.96, 106.30),
    displayDist = 6.0,
    interactDist = 2.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "           Acces ATM",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
        triggerName = "sgx-banking:Client:BankMenu:Show",
        args = {}
    }
})

exports['sgx-textui-2']:create3DTextUI("sgx-openbankmenu-pacific-atm03", {
    coords = vector3(237.08, 218.82, 106.30),
    displayDist = 6.0,
    interactDist = 2.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "           Acces ATM",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
        triggerName = "sgx-banking:Client:BankMenu:Show",
        args = {}
    }
})

exports['sgx-textui-2']:create3DTextUI("sgx-openbankmenu-pacific-atm04", {
    coords = vector3(236.59, 219.78, 106.30),
    displayDist = 6.0,
    interactDist = 2.0,
    enableKeyClick = true, -- If true when you near it and click key it will trigger the event that you write inside triggerData
    keyNum = 38,
    key = "E",
    text = "           Acces ATM",
    theme = "green", -- or red
    job = "all", -- or the job you want to show this for
    canInteract = function()
        return true
    end,
    triggerData = {
        triggerName = "sgx-banking:Client:BankMenu:Show",
        args = {}
    }
})

