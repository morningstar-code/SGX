-- Options for AddTargetEntity look like this
-- { 
--     num = integer,
--     icon = string,
--     label = string,
--     action = function() end,
-- }
function AddTargetEntity(ped, options, distance)
    if not ped then
        print("No PED provided for AddTargetEntity. Function will not proceed.")
        return
    end

    if not options or #options == 0 then
        print("No options provided for AddTargetEntity. Function will not proceed.")
        return
    end

    if not distance then
        print("No distance provided for AddTargetEntity. Function will not proceed.")
        return
    end

    local targetData = {
        options = options,
        distance = distance
    }

    if cfg.Target == "qb-target" and isExportAvailable('qb-target', 'AddTargetEntity') then
        exports['qb-target']:AddTargetEntity(ped, targetData)
    elseif cfg.Target == "ox_target" and isExportAvailable('ox_target', 'addLocalEntity') then
        local adjustedOptions = {}
        for _, opt in ipairs(options) do
            table.insert(adjustedOptions, {
                icon = opt.icon,
                label = opt.label,
                onSelect = opt.action,
                distance = distance
            })
        end

        exports.ox_target:addLocalEntity(ped, adjustedOptions)
    else
        print("Set the correct target in config.lua or configure a different target in target.lua for AddTargetEntity")
    end
end


function RemoveTargetEntity(entity)
    if cfg.Target == "qb-target" and isExportAvailable('qb-target', 'RemoveTargetEntity') then
        exports['qb-target']:RemoveTargetEntity(entity)
    elseif cfg.Target == "ox_target" and isExportAvailable('ox_target', 'removeLocalEntity') then
        exports.ox_target:removeLocalEntity(entity)
    else 
        print("Set the correct target in config.lua or configure a different target in target.lua for RemoveTargetEntity")
    end
end

function isExportAvailable(resourceName, exportName)
    if type(exports[resourceName]) ~= "table" then
        print("Resource '" .. resourceName .. "' does not exist or is not correctly loaded.")
        return false
    end

    if type(exports[resourceName][exportName]) ~= "function" then
        print("Export '" .. exportName .. "' in resource '" .. resourceName .. "' is not a function.")
        return false
    end

    return true
end