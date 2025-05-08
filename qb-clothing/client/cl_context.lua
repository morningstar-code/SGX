QBCore = exports['qb-core']:GetCoreObject()

-- [ Events ] --

RegisterNetEvent('qb-clothing:client:openOutfitMenu', function()
    local OutfitsMenu = {
        {
            header = "Outfit Management",
            icon = "fas fa-tshirt",
            params = {},
        },
        {
            header = "View Outfits",
            txt = "View outfits in wardrobe.",
            params = {
                event = "qb-clothing/client/openOutfitsContext",
            }
        },
        {
            header = "Add Outfit",
            txt = "Adds current outfit to wardrobe.",
            params = {
                event = "qb-clothing/client/add-outfit",
            }
        },
    }
    exports[Config.ContextMenu]:openMenu(OutfitsMenu)
end)

RegisterNetEvent("qb-clothing/client/openOutfitsContext", function()
    local Promise = promise:new()
    QBCore.Functions.TriggerCallback('qb-clothing/server/getOutfits', function(Outfits)
        Promise:resolve(Outfits)
    end)
    local Outfits = Citizen.Await(Promise)

    local OutfitList = {}
    OutfitList[#OutfitList + 1] = {
        header = "Outfits",
        icon = "fas fa-tshirt",
        params = {},
    }
    OutfitList[#OutfitList + 1] = {
        header = "Go back",
        icon = "fas fa-chevron-left",
        params = {
            event = "qb-clothing:client:openOutfitMenu",
        },
    }

    for i = 1, #Outfits do
        OutfitList[#OutfitList + 1] = {
            header = Outfits[i].outfitname,
            txt = "Click to open outfit options.",
            params = {
                event = "qb-clothing/open-outfit-options",
                args = {
                    outfitData = Outfits[i]
                }
            }
        }
    end

    if #OutfitList > 0 then
        exports[Config.ContextMenu]:openMenu(OutfitList)
    else
        QBCore.Functions.Notify("You don't have any outfits yet.", "error")
    end
end)

RegisterNetEvent("qb-clothing/open-outfit-options", function(Data)
    local outfitData = Data.outfitData

    local OutfitList = {}
    OutfitList[#OutfitList + 1] = {
        header = "Outfit Options",
        icon = "fas fa-tshirt",
        params = {},
    }
    OutfitList[#OutfitList + 1] = {
        header = "Go back",
        icon = "fas fa-chevron-left",
        params = {
            event = "qb-clothing/client/openOutfitsContext",
        },
    }
    OutfitList[#OutfitList + 1] = {
        header = "Use Outfit",
        txt = "Click to use this outfit.",
        params = {
            event = "qb-clothing/client/loadOutfit",
            args = {
                outfitData = outfitData.skin
            }
        }
    }
    OutfitList[#OutfitList + 1] = {
        header = "Delete Outfit",
        txt = "Click to delete this outfit.",
        params = {
            event = "qb-clothing/server/removeOutfit",
            isServer = true,
            args = {
                name = outfitData.outfitname,
                id = outfitData.outfitId
            }
        }
    }

    if #OutfitList > 0 then
        exports[Config.ContextMenu]:openMenu(OutfitList)
    end
end)


RegisterNetEvent('qb-clothing/client/add-outfit', function()
    local dialog = exports["qb-input"]:ShowInput({
        header = 'Outfit Name',
        submitText = 'Submit',
        inputs = {
            {
                text = '',
                name = "submit",
                type = "text",
                isRequired = true
            }
        }
    })
    if dialog and dialog.submit then
        local Model = GetEntityModel(PlayerPedId())
        TriggerServerEvent('qb-clothes/saveOutfit', dialog.submit, Model, Config.SkinData)
        TriggerEvent("notify", "Successfully saved outfit: " .. dialog.submit)
    end
end)

RegisterNetEvent("qb-clothing/client/saveCurrentOutfit", function(Name)
    local Model = GetEntityModel(PlayerPedId())
    TriggerServerEvent('qb-clothes/saveOutfit', Name, Model, Config.SkinData)
    QBCore.Functions.Notify("Successfully saved outfit: " .. Name, "success")
end)
