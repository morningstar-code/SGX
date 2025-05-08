Config = {}
Config.Framework = {
    ["Framework"] = "qbcore", -- esx or qbcore
    ["ResourceName"] = "qb-core", -- es_extended or qb-core or your resource name
    ["NewCore"] = true, -- If you use the new core, set this to true ( esx or qb ). If you are using the old one, make it false and edit the event below according to yourself.
    ["SharedEvent"] = "qb-core:getSharedObjec" -- Event name for old cores.
}

Config.Jobs = {
    ["police"] = {
        ["watch"] = vector3(446.7202, -998.7824, 34.9701),
        ["text"] = "[E] Přístup k BodyCam Menu",
        ["distance"] = 3.0,
        ["useTarget"] = true, -- If you set this option to true, the coords, text and distance variables will be valid for target
        ["uiSettings"] = {
            ["color"] = "#6792FF", -- Color of the main color theme of the menu (base on a lighter or pastel shade of the selected color)
            ["title"] = "Police Department", -- Menu title above the categories in the right browser
            ["subtitle"] = "Watch the cams", -- Subtitle on the right side
            ["videoUpload"] = {
                ["webhook"] = "https://discord.com/api/webhooks/1369388853772812539/ZZTW1aLPOpeykYhjaomZSHQ5n6y4XQjAsN6oJD6WgckKnPwaNz80b4y2K2Nl66FraguU",
                ["fivemanage"] = false, -- https://www.fivemanage.com
                ["fivemanage_token"] = "c54yfbBR165JfCAcE4syfb56tzHJq8dJ", -- https://www.fivemanage.com
            }, -- api or webhook to forward when recordings are stopped 
            ["backgroundColor"] = "#090814", -- Background color of the menu (based on a more muted shade of the selected color)
            ["badgeSettings"] = {
                ["image"] = "pd-badge", -- the photo that will appear on the back when the camera is turned on
                ["darkerColor"] = "#152538",  --  the color of the badge that will appear on the back when the camera is turned on
                ["lighterColor"] = "#6792FF", --  the color of the badge that will appear on the back when the camera is turned on
                ["departmentName"] = "los santos police department" -- the name of the department that will appear on the back when the camera is turned on
            }
        }
    },
    ["sheriff"] = {
        ["watch"] = vector3(1855.358, 3688.718, 34.252),
        ["text"] = "~[E]~ Přístup k BodyCam Menu",
        ["distance"] = 3.0,
        ["useTarget"] = false, -- If you set this option to true, the coords, text and distance variables will be valid for target
        ["uiSettings"] = {
            ["color"] = "#FDCC00", -- Color of the main color theme of the menu (base on a lighter or pastel shade of the selected color)
            ["title"] = "Sheriff Department", -- Menu title above the categories in the right browser
            ["subtitle"] = "Watch the cams", -- Subtitle on the right side
            ["videoUpload"] = {
                ["webhook"] = "https://discord.com/api/webhooks/1369388853772812539/ZZTW1aLPOpeykYhjaomZSHQ5n6y4XQjAsN6oJD6WgckKnPwaNz80b4y2K2Nl66FraguU",
                ["fivemanage"] = false, -- https://www.fivemanage.com
                ["fivemanage_token"] = "c54yfbBR165JfCAcE4syfb56tzHJq8dJ", -- https://www.fivemanage.com
            }, -- api or webhook to forward when recordings are stopped 
            ["backgroundColor"] = "#17150B", -- Background color of the menu (based on a more muted shade of the selected color)
            ["badgeSettings"] = {
                ["image"] = "ems-badge", -- the photo that will appear on the back when the camera is turned on
                ["darkerColor"] = "#221B00", --  the color of the badge that will appear on the back when the camera is turned on
                ["lighterColor"] = "#FDCC00", --  the color of the badge that will appear on the back when the camera is turned on
                ["departmentName"] = "los santos sheriff department" -- the name of the department that will appear on the back when the camera is turned on
            }
        }
    },
    ["ambulance"] = {
        ["watch"] = vector3(324.524, -600.161, 43.267),
        ["text"] = "~[E]~ Přístup k BodyCam Menu",
        ["distance"] = 3.0,
        ["useTarget"] = false, -- If you set this option to true, the coords, text and distance variables will be valid for target
        ["uiSettings"] = {
            ["color"] = "#FF2F2F", -- Color of the main color theme of the menu (base on a lighter or pastel shade of the selected color)
            ["title"] = "Emergy Department", -- Menu title above the categories in the right browser
            ["subtitle"] = "Watch the cams", -- Subtitle on the right side
            ["videoUpload"] = {
                ["webhook"] = "https://discord.com/api/webhooks/1369388853772812539/ZZTW1aLPOpeykYhjaomZSHQ5n6y4XQjAsN6oJD6WgckKnPwaNz80b4y2K2Nl66FraguU",
                ["fivemanage"] = false, -- https://www.fivemanage.com
                ["fivemanage_token"] = "c54yfbBR165JfCAcE4syfb56tzHJq8dJ", -- https://www.fivemanage.com
            }, -- api or webhook to forward when recordings are stopped 
            ["backgroundColor"] = "#1D100E", -- Background color of the menu (based on a more muted shade of the selected color)
            ["badgeSettings"] = {
                ["image"] = "ems-badge", -- the photo that will appear on the back when the camera is turned on
                ["darkerColor"] = "#280000", --  the color of the badge that will appear on the back when the camera is turned on
                ["lighterColor"] = "#FF2F2F", --  the color of the badge that will appear on the back when the camera is turned on
                ["departmentName"] = "los santos emergency department" -- the name of the department that will appear on the back when the camera is turned on
            }
        }
    },
}

Config.Audible = true -- If you do true, you will hear the sounds from the cameras you ring. If false, you will not hear the sound of the cameras.

Config.BadgeSettings = {
    ["scale"] = 0.6, -- I recommend using between 0.0 and 1. Default value 0.8
    ["position"] = "right", -- When the camera is turned on, the sign indicating that the camera is on is only "left" or "right"
    ["hideableKey"] = "H" -- This button hides or unhides the badge at the set location. The first time a player enters the server, the typed key takes effect. After the key is changed, it will only be active for first time users. If this key was previously registered in the person's system, it will not change with the new key.
}

Config.Records = {
    ["enableRecord"] = true, -- Limited to 1 minute bodycam screen recording. Please be aware that when the player opens the screen recording, an average of 20 to 30 fps is lost, so it is not recommended to open it.
    ["recordKey"] = "J" -- Recording can be closed and opened with the specified key.The first time a player enters the server, the typed key takes effect. After the key is changed, it will only be active for first time users. If this key was previously registered in the person's system, it will not change with the new key.
}

Config.Props = {
    ["attachBodycam"] = true, -- If True, the outfit you set will appear on the character.
    ["componentSettings"] = {
        -- componentId: PV_COMP_HEAD = 0, "HEAD" PV_COMP_BERD = 1, "BEARD" PV_COMP_HAIR = 2, "HAIR" PV_COMP_UPPR = 3, "UPPER" PV_COMP_LOWR = 4, "LOWER" PV_COMP_HAND = 5, "HAND" PV_COMP_FEET = 6, "FEET" PV_COMP_TEEF = 7, "TEETH" PV_COMP_ACCS = 8, "ACCESSORIES" PV_COMP_TASK = 9, "TASK" PV_COMP_DECL = 10, "DECL" PV_COMP_JBIB = 11, "JBIB"
        ["male"] = {
            ["componentId"] = 9, -- 0: Face 1: Mask 2: Hair 3: Torso 4: Leg 5: Parachute / bag 6: Shoes 7: Accessory 8: Undershirt 9: Kevlar 10: Badge 11: Torso 2 List of Component IDs
            ["drawableId"] = 129, -- he drawable id that is going to be set
            ["textureId"] = 0, -- he texture id of the drawable
        }, 
        ["female"] = {
            ["componentId"] = 9, -- 0: Face 1: Mask 2: Hair 3: Torso 4: Leg 5: Parachute / bag 6: Shoes 7: Accessory 8: Undershirt 9: Kevlar 10: Badge 11: Torso 2 List of Component IDs
            ["drawableId"] = 136, -- he drawable id that is going to be set
            ["textureId"] = 0, -- he texture id of the drawable
        }
    }
}

Config.Items = {
    ["bodycam"] = "bodycam",
    ["dashcam"] = "dashcam",
    ["qs_inventory"] = false -- make true if using qs-inventory
}

Config.CamSettings = {
    ["dashcamFov"] = 80.0,
    ["bodycamFov"] = 80.0,
    ["bodycamPositions"] = {
        x = 0.05, 
        y = -0.005, 
        z = 0.1
    } -- xOffset, yOffset, zOffset
}

Config.Notifications = {
    ["no_vehicle"] = {
        ["text"] = "V okolí nebyla nalezena žádná vozidla",
        ["type"] = "error"
    },
    ["not_found"] = {
        ["text"] = "Nebylo nalezeno žádné sledované vozidlo",
        ["type"] = "error"
    },
    ["cant_watch_self"] = {
        ["text"] = "Nemůžete se dívat sami na sebe",
        ["type"] = "error"
    },
    ["bodycam_on"] = {
        ["text"] = "Bodycam je zapnuta",
        ["type"] = "success"
    },
    ["bodycam_off"] = {
        ["text"] = "Bodycam je vypnuta",
        ["type"] = "error"
    },
    ["record_start"] = {
        ["text"] = "Zahájení nahrávání",
        ["type"] = "success"
    },
    ["record_stop"] = {
        ["text"] = "Nahrávání bylo zastaveno",
        ["type"] = "error"
    },
    ["record_uploaded"] = {
        ["text"] = "Nahraný záznam",
        ["type"] = "success"
    },
    ["record_failed_load"] = {
        ["text"] = "Nepodařilo se načíst záznam",
        ["type"] = "error"
    },
    ["disconnected"] = {
        ["text"] = "Spojení se zobrazovací kamerou je přerušeno!",
        ["type"] = "error"
    },
    ["dashcam_added"] = {
        ["text"] = "Přidána palubní kamera",
        ["type"] = "success"
    }
}

Config.SendNotifications = function(notif)
    --exports['okokNotify']:Alert('Title', Config.Notifications[notif].text, 2500, Config.Notifications[notif].type, false)
    --ESX.ShowNotification(Config.Notifications[notif].text)
    --QBCore.Functions.Notify(Config.Notifications[notif].text, Config.Notifications[notif].type)
    TriggerEvent('codem-notification:Create', Config.Notifications[notif].text, Config.Notifications[notif].type, 'BodyCam', 5000)
end

Config.OpenUIs = function()
    -- You can reopen closed UIs from here with export or trigger again
end

Config.CloseUIs = function()
    -- You can close UIs that you do not want to appear on the screen with export or trigger here
end

