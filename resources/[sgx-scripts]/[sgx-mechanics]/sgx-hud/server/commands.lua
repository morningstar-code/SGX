if Config.FrameWork == "esx" then
    -- @ --
    Koci.Framework.RegisterCommand("hudsettings", "user", function(xPlayer, args, showError)
        xPlayer.triggerEvent("sgx-hud:Client:OpenHudSettings")
    end, true, {
        help = _t("hud.commands.hudsettings.help"),
        validate = true,
    })
    -- @ --
    Koci.Framework.RegisterCommand("hudclose", "user", function(xPlayer, args, showError)
        local code = tonumber(args.code)
        local element = Utils.Functions:HUD_CodeToElement(code)
        xPlayer.triggerEvent("sgx-hud:Client:HiddenHudElement", element, code)
    end, true, {
        help = _t("hud.commands.hodclose.help"),
        validate = true,
        arguments = {
            { name = "code", help = _t("hud.commands.hudclose.code.arguments.code.help"), type = "number" }
        }
    })
    -- @ --
    Koci.Framework.RegisterCommand("hudopen", "user", function(xPlayer, args, showError)
        local code = tonumber(args.code)
        local element = Utils.Functions:HUD_CodeToElement(code)
        xPlayer.triggerEvent("sgx-hud:Client:ShowHudElement", element, code)
    end, true, {
        help = _t("hud.commands.hodclose.help"),
        validate = true,
        arguments = {
            { name = "code", help = _t("hud.commands.hudclose.code.arguments.code.help"), type = "number" }
        }
    })
    -- @ --
elseif Config.FrameWork == "qb" then
    -- @ --
    Koci.Framework.Commands.Add("hudsettings", _t("hud.commands.hudsettings.help"), {}, false, function(source, args)
        local src = source
        TriggerClientEvent("sgx-hud:Client:OpenHudSettings", src)
    end)
    -- @ --
    Koci.Framework.Commands.Add("hudclose", _t("hud.commands.hudsettings.help"), {
        {
            name = "code",
            help = _t("hud.commands.hudclose.arguments.code.help"),
        }
    }, false, function(source, args)
        local src = source
        local code = tonumber(args[1])
        local element = Utils.Functions:HUD_CodeToElement(code)
        TriggerClientEvent("sgx-hud:Client:HiddenHudElement", src, element, code)
    end)
    -- @ --
    Koci.Framework.Commands.Add("hudopen", _t("hud.commands.hudsettings.help"), {
        {
            name = "code",
            help = _t("hud.commands.hudopen.arguments.code.help"),
        }
    }, false, function(source, args)
        local src = source
        local code = tonumber(args[1])
        local element = Utils.Functions:HUD_CodeToElement(code)
        TriggerClientEvent("sgx-hud:Client:ShowHudElement", src, element, code)
    end)
end
