-- DEV BY POOYA HPX --

local QBCore = exports['qb-core']:GetCoreObject()
local Drops = {}
local Trunks = {}
local Gloveboxes = {}
local Stashes = {}
local ShopItems = {}

-- Functions
function GetDrops()
    return Drops
end

-- you can change this trigger for protection.
-- if you change this dont forget to change,
-- the `Config.UpdateTrigger` in `sgx-cashasitem` config.lua
local CashAsItemUpdateTrigger = "sgx-cashasitem:server:updateCash"

local lastUsedStashItem = nil
local function IsItemAllowedToAdd(src, stash, item)
    if Config.Stashes[stash] then
        if lastUsedStashItem ~= nil and lastUsedStashItem.info.allowedItems ~= nil and
            not lastUsedStashItem.info.allowedItems[item] then
            TriggerEvent('sgx-stashes:server:allowed_items_error', src, lastUsedStashItem.info.allowedItems)
            lastUsedStashItem = nil
            return false
        end
    end
    return true
end

local function IsStashItemLootable(src, stash)
    if Config.Stashes[stash] and lastUsedStashItem ~= nil and lastUsedStashItem.info and
        not lastUsedStashItem.info.canloot then
        lastUsedStashItem = nil
        TriggerEvent('sgx-stashes:server:not_allowed_to_loot', src)
        return false
    end
    return true
end

---Loads the inventory for the player with the citizenid that is provided

local function LoadInventory(source, citizenid)
    local inventory = MySQL.prepare.await('SELECT inventory FROM players WHERE citizenid = ?', { citizenid })
	local loadedInventory = {}
    local missingItems = {}

    if not inventory then return loadedInventory end

	inventory = json.decode(inventory)
	if table.type(inventory) == "empty" then return loadedInventory end

	for _, item in pairs(inventory) do
		if item then
			local itemInfo = QBCore.Shared.Items[item.name:lower()]
			if itemInfo then
				loadedInventory[item.slot] = {
					name = itemInfo['name'],
					amount = item.amount,
					info = item.info or '',
					label = itemInfo['label'],
					description = itemInfo['description'] or '',
					weight = itemInfo['weight'],
					type = itemInfo['type'],
					unique = itemInfo['unique'],
					useable = itemInfo['useable'],
					image = itemInfo['image'],
					shouldClose = itemInfo['shouldClose'],
					slot = item.slot,
					combinable = itemInfo['combinable'],
					created = item.created,
				}
			else
				missingItems[#missingItems + 1] = item.name:lower()
			end
		end
	end

    if #missingItems > 0 then
        print(("The following items were removed for player %s as they no longer exist"):format(GetPlayerName(source)))
		QBCore.Debug(missingItems)
    end

    return loadedInventory
end

exports("LoadInventory", LoadInventory)

---Saves the inventory for the player with the provided source or PlayerData is they're offline

local function SaveInventory(source, offline)
	local PlayerData
	if not offline then
		local Player = QBCore.Functions.GetPlayer(source)

		if not Player then return end

		PlayerData = Player.PlayerData
	else
		PlayerData = source -- for offline users, the playerdata gets sent over the source variable
	end

    local items = PlayerData.items
    local ItemsJson = {}
    if items and table.type(items) ~= "empty" then
        for slot, item in pairs(items) do
            if items[slot] then
                ItemsJson[#ItemsJson+1] = {
                    name = item.name,
                    amount = item.amount,
                    info = item.info,
                    type = item.type,
                    slot = slot,
					created = item.created
                }
            end
        end
        MySQL.prepare('UPDATE players SET inventory = ? WHERE citizenid = ?', { json.encode(ItemsJson), PlayerData.citizenid })
    else
        MySQL.prepare('UPDATE players SET inventory = ? WHERE citizenid = ?', { '[]', PlayerData.citizenid })
    end
end

exports("SaveInventory", SaveInventory)

---Gets the totalweight of the items provided

local function GetTotalWeight(items)
	local weight = 0
    if not items then return 0 end
    for _, item in pairs(items) do
        weight += item.weight * item.amount
    end
    return tonumber(weight)
end

exports("GetTotalWeight", GetTotalWeight)

---Gets the slots that the provided item is in

local function GetSlotsByItem(items, itemName)
    local slotsFound = {}
    if not items then return slotsFound end
    for slot, item in pairs(items) do
        if item.name:lower() == itemName:lower() then
            slotsFound[#slotsFound+1] = slot
        end
    end
    return slotsFound
end

exports("GetSlotsByItem", GetSlotsByItem)

---Get the first slot where the item is located

local function GetFirstSlotByItem(items, itemName)
    if not items then return nil end
    for slot, item in pairs(items) do
        if item.name:lower() == itemName:lower() then
            return tonumber(slot)
        end
    end
    return nil
end

exports("GetFirstSlotByItem", GetFirstSlotByItem)

---Add an item to the inventory of the player

local function AddItem(source, item, amount, slot, info, created)
	local Player = QBCore.Functions.GetPlayer(source)

	if not Player then return false end

	local totalWeight = GetTotalWeight(Player.PlayerData.items)
	local itemInfo = QBCore.Shared.Items[item:lower()]
	local time = os.time()
	if not created then
		itemInfo['created'] = time
	else
		itemInfo['created'] = created
	end
	if not itemInfo and not Player.Offline then
		QBCore.Functions.Notify(source, "Item does not exist", 'error')
		return false
	end

	amount = tonumber(amount) or 1
	slot = tonumber(slot) or GetFirstSlotByItem(Player.PlayerData.items, item)
	info = info or {}
	itemInfo['created'] = created or time
	info.quality = info.quality or 100

	if itemInfo['type'] == 'weapon' then
		info.serie = info.serie or tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4))
		info.quality = info.quality or 100
	end
	if (totalWeight + (itemInfo['weight'] * amount)) <= Config.MaxInventoryWeight then
		if (slot and Player.PlayerData.items[slot]) and (Player.PlayerData.items[slot].name:lower() == item:lower()) and (itemInfo['type'] == 'item' and not itemInfo['unique']) then
			if Player.PlayerData.items[slot].info.quality == info.quality then
			Player.PlayerData.items[slot].amount = Player.PlayerData.items[slot].amount + amount
			Player.Functions.SetPlayerData("items", Player.PlayerData.items)
			if Player.Offline then return true end
			TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'AddItem', 'green', '**' .. GetPlayerName(source) .. ' (citizenid: ' .. Player.PlayerData.citizenid .. ' | id: ' .. source .. ')** got item: [slot:' .. slot .. '], itemname: ' .. Player.PlayerData.items[slot].name .. ', added amount: ' .. amount .. ', new total amount: ' .. Player.PlayerData.items[slot].amount)
			return true
			else
				for i = 1, Config.MaxInventorySlots, 1 do
					if Player.PlayerData.items[i] == nil then
						Player.PlayerData.items[i] = { name = itemInfo['name'], amount = amount, info = info or '', label = itemInfo['label'], description = itemInfo['description'] or '', weight = itemInfo['weight'], type = itemInfo['type'], unique = itemInfo['unique'], useable = itemInfo['useable'], image = itemInfo['image'], shouldClose = itemInfo['shouldClose'], slot = i, combinable = itemInfo['combinable'], created = itemInfo['created'] }
						Player.Functions.SetPlayerData("items", Player.PlayerData.items)
						if Player.Offline then return true end
						TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'AddItem', 'green', '**' .. GetPlayerName(source) .. ' (citizenid: ' .. Player.PlayerData.citizenid .. ' | id: ' .. source .. ')** got item: [slot:' .. i .. '], itemname: ' .. Player.PlayerData.items[i].name .. ', added amount: ' .. amount .. ', new total amount: ' .. Player.PlayerData.items[i].amount)
						return true
					end
				end
			end
		elseif not itemInfo['unique'] and slot or slot and Player.PlayerData.items[slot] == nil then
			Player.PlayerData.items[slot] = { name = itemInfo['name'], amount = amount, info = info or '', label = itemInfo['label'], description = itemInfo['description'] or '', weight = itemInfo['weight'], type = itemInfo['type'], unique = itemInfo['unique'], useable = itemInfo['useable'], image = itemInfo['image'], shouldClose = itemInfo['shouldClose'], slot = slot, combinable = itemInfo['combinable'], created = itemInfo['created'] }
			Player.Functions.SetPlayerData("items", Player.PlayerData.items)

			if Player.Offline then return true end

			TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'AddItem', 'green', '**' .. GetPlayerName(source) .. ' (citizenid: ' .. Player.PlayerData.citizenid .. ' | id: ' .. source .. ')** got item: [slot:' .. slot .. '], itemname: ' .. Player.PlayerData.items[slot].name .. ', added amount: ' .. amount .. ', new total amount: ' .. Player.PlayerData.items[slot].amount)

			return true
		elseif itemInfo['unique'] or (not slot or slot == nil) or itemInfo['type'] == 'weapon' then
			for i = 1, Config.MaxInventorySlots, 1 do
				if Player.PlayerData.items[i] == nil then
					Player.PlayerData.items[i] = { name = itemInfo['name'], amount = amount, info = info or '', label = itemInfo['label'], description = itemInfo['description'] or '', weight = itemInfo['weight'], type = itemInfo['type'], unique = itemInfo['unique'], useable = itemInfo['useable'], image = itemInfo['image'], shouldClose = itemInfo['shouldClose'], slot = i, combinable = itemInfo['combinable'], created = itemInfo['created'] }
					Player.Functions.SetPlayerData("items", Player.PlayerData.items)

					if Player.Offline then return true end

					TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'AddItem', 'green', '**' .. GetPlayerName(source) .. ' (citizenid: ' .. Player.PlayerData.citizenid .. ' | id: ' .. source .. ')** got item: [slot:' .. i .. '], itemname: ' .. Player.PlayerData.items[i].name .. ', added amount: ' .. amount .. ', new total amount: ' .. Player.PlayerData.items[i].amount)

					return true
				end
			end
		end
	elseif not Player.Offline then
		QBCore.Functions.Notify(source, "Inventory too full", 'error')
	end
	return false
end

exports("AddItem", AddItem)

---Remove an item from the inventory of the player

local function RemoveItem(source, item, amount, slot)
	local Player = QBCore.Functions.GetPlayer(source)

	if not Player then return false end

	amount = tonumber(amount) or 1
	slot = tonumber(slot)

	if slot then
		if Player.PlayerData.items[slot].amount > amount then
			Player.PlayerData.items[slot].amount = Player.PlayerData.items[slot].amount - amount
			Player.Functions.SetPlayerData("items", Player.PlayerData.items)

			if not Player.Offline then
				TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'RemoveItem', 'red', '**' .. GetPlayerName(source) .. ' (citizenid: ' .. Player.PlayerData.citizenid .. ' | id: ' .. source .. ')** lost item: [slot:' .. slot .. '], itemname: ' .. Player.PlayerData.items[slot].name .. ', removed amount: ' .. amount .. ', new total amount: ' .. Player.PlayerData.items[slot].amount)
			end

			return true
		elseif Player.PlayerData.items[slot].amount == amount then
			Player.PlayerData.items[slot] = nil
			Player.Functions.SetPlayerData("items", Player.PlayerData.items)

			if Player.Offline then return true end

			TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'RemoveItem', 'red', '**' .. GetPlayerName(source) .. ' (citizenid: ' .. Player.PlayerData.citizenid .. ' | id: ' .. source .. ')** lost item: [slot:' .. slot .. '], itemname: ' .. item .. ', removed amount: ' .. amount .. ', item removed')

			return true
		end
	else
		local slots = GetSlotsByItem(Player.PlayerData.items, item)
		local amountToRemove = amount

		if not slots then return false end

		for _, _slot in pairs(slots) do
			if Player.PlayerData.items[_slot].amount > amountToRemove then
				Player.PlayerData.items[_slot].amount = Player.PlayerData.items[_slot].amount - amountToRemove
				Player.Functions.SetPlayerData("items", Player.PlayerData.items)

				if not Player.Offline then
					TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'RemoveItem', 'red', '**' .. GetPlayerName(source) .. ' (citizenid: ' .. Player.PlayerData.citizenid .. ' | id: ' .. source .. ')** lost item: [slot:' .. _slot .. '], itemname: ' .. Player.PlayerData.items[_slot].name .. ', removed amount: ' .. amount .. ', new total amount: ' .. Player.PlayerData.items[_slot].amount)
				end

				return true
			elseif Player.PlayerData.items[_slot].amount == amountToRemove then
				Player.PlayerData.items[_slot] = nil
				Player.Functions.SetPlayerData("items", Player.PlayerData.items)

				if Player.Offline then return true end

				TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'RemoveItem', 'red', '**' .. GetPlayerName(source) .. ' (citizenid: ' .. Player.PlayerData.citizenid .. ' | id: ' .. source .. ')** lost item: [slot:' .. _slot .. '], itemname: ' .. item .. ', removed amount: ' .. amount .. ', item removed')

				return true
			end
		end
	end
	return false
end

exports("RemoveItem", RemoveItem)

---Get the item with the slot

local function GetItemBySlot(source, slot)
	local Player = QBCore.Functions.GetPlayer(source)
	slot = tonumber(slot)
	return Player.PlayerData.items[slot]
end

exports("GetItemBySlot", GetItemBySlot)

---Get the item from the inventory of the player with the provided source by the name of the item

local function GetItemByName(source, item)
	local Player = QBCore.Functions.GetPlayer(source)
	item = tostring(item):lower()
	local slot = GetFirstSlotByItem(Player.PlayerData.items, item)
	return Player.PlayerData.items[slot]
end

exports("GetItemByName", GetItemByName)

---Get the item from the inventory of the player with the provided source by the name of the item in an array for all slots that the item is in

local function GetItemsByName(source, item)
	local Player = QBCore.Functions.GetPlayer(source)
	item = tostring(item):lower()
	local items = {}
	local slots = GetSlotsByItem(Player.PlayerData.items, item)
	for _, slot in pairs(slots) do
		if slot then
			items[#items+1] = Player.PlayerData.items[slot]
		end
	end
	return items
end

exports("GetItemsByName", GetItemsByName)


local function ClearInventory(source, filterItems)
	local Player = QBCore.Functions.GetPlayer(source)
	local savedItemData = {}

	if filterItems then
		local filterItemsType = type(filterItems)
		if filterItemsType == "string" then
			local item = GetItemByName(source, filterItems)

			if item then
				savedItemData[item.slot] = item
			end
		elseif filterItemsType == "table" and table.type(filterItems) == "array" then
			for i = 1, #filterItems do
				local item = GetItemByName(source, filterItems[i])

				if item then
					savedItemData[item.slot] = item
				end
			end
		end
	end

	Player.Functions.SetPlayerData("items", savedItemData)

	if Player.Offline then return end

	TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'ClearInventory', 'red', '**' .. GetPlayerName(source) .. ' (citizenid: ' .. Player.PlayerData.citizenid .. ' | id: ' .. source .. ')** inventory cleared')
end

exports("ClearInventory", ClearInventory)

---Sets the items playerdata to the provided items param

local function SetInventory(source, items)
	local Player = QBCore.Functions.GetPlayer(source)

	Player.Functions.SetPlayerData("items", items)

	if Player.Offline then return end

	TriggerEvent('qb-log:server:CreateLog', 'playerinventory', 'SetInventory', 'blue', '**' .. GetPlayerName(source) .. ' (citizenid: ' .. Player.PlayerData.citizenid .. ' | id: ' .. source .. ')** items set: ' .. json.encode(items))
end

exports("SetInventory", SetInventory)

---Set the data of a specific item

local function SetItemData(source, itemName, key, val)
	if not itemName or not key then return false end

	local Player = QBCore.Functions.GetPlayer(source)

	if not Player then return end

	local item = GetItemByName(source, itemName)

	if not item then return false end

	item[key] = val
	Player.PlayerData.items[item.slot] = item
	Player.Functions.SetPlayerData("items", Player.PlayerData.items)

	return true
end

exports("SetItemData", SetItemData)

---Checks if you have an item or not
local function HasItem(source, items, amount)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end
    local isTable = type(items) == 'table'
    local isArray = isTable and table.type(items) == 'array' or false
    local totalItems = #items
    local count = 0
    local kvIndex = 2
    if isTable and not isArray then
        totalItems = 0
        for _ in pairs(items) do totalItems += 1 end
        kvIndex = 1
    end
    if isTable then
        for k, v in pairs(items) do
            local itemKV = {k, v}
            local item = GetItemByName(source, itemKV[kvIndex])
            if item and ((amount and item.amount >= amount) or (not isArray and item.amount >= v) or (not amount and isArray)) then
                count += 1
            end
        end
        if count == totalItems then
            return true
        end
    else -- Single item as string
        local item = GetItemByName(source, items)
        if item and (not amount or (item and amount and item.amount >= amount)) then
            return true
        end
    end
    return false
end

exports("HasItem", HasItem)

---Create a usable item with a callback on use
---@param itemName string The name of the item to make usable
---@param data any
local function CreateUsableItem(itemName, data)
	QBCore.Functions.CreateUseableItem(itemName, data)
end

exports("CreateUsableItem", CreateUsableItem)

---Get the usable item data for the specified item
---@param itemName string The item to get the data for
---@return any usable_item
local function GetUsableItem(itemName)
	return QBCore.Functions.CanUseItem(itemName)
end

exports("GetUsableItem", GetUsableItem)

---Use an item from the QBCore.UsableItems table if a callback is present
---@param itemName string The name of the item to use
---@param ... any Arguments for the callback, this will be sent to the callback and can be used to get certain values
local function UseItem(itemName, ...)
	local itemData = GetUsableItem(itemName)
	local callback = type(itemData) == 'table' and (rawget(itemData, '__cfx_functionReference') and itemData or itemData.cb or itemData.callback) or type(itemData) == 'function' and itemData
	if not callback then return end
	callback(...)
end

exports("UseItem", UseItem)

local function recipeContains(recipe, fromItem)
	for _, v in pairs(recipe.accept) do
		if v == fromItem.name then
			return true
		end
	end

	return false
end


local function hasCraftItems(source, CostItems, amount)
	for k, v in pairs(CostItems) do
		local item = GetItemByName(source, k)

		if not item then return false end

		if item.amount < (v * amount) then return false end
	end
	return true
end

local function IsVehicleOwned(plate)
    local result = MySQL.scalar.await('SELECT 1 from player_vehicles WHERE plate = ?', {plate})
    return result
end

-- Shop Items
local function SetupShopItems(shopItems)
	local items = {}
	if shopItems and next(shopItems) then
		for _, item in pairs(shopItems) do
			local itemInfo = QBCore.Shared.Items[item.name:lower()]
			if itemInfo then
				items[item.slot] = {
					name = itemInfo["name"],
					amount = tonumber(item.amount),
					info = item.info or "",
					label = itemInfo["label"],
					description = itemInfo["description"] or "",
					weight = itemInfo["weight"],
					type = itemInfo["type"],
					unique = itemInfo["unique"],
					useable = itemInfo["useable"],
					price = item.price,
					image = itemInfo["image"],
					slot = item.slot,
				}
			end
		end
	end
	return items
end

-- Stash Items
local function GetStashItems(stashId)
	local items = {}
	local result = MySQL.scalar.await('SELECT items FROM stashitems WHERE stash = ?', {stashId})
	if not result then return items end

	local stashItems = json.decode(result)
	if not stashItems then return items end

	for _, item in pairs(stashItems) do
		local itemInfo = QBCore.Shared.Items[item.name:lower()]
		if itemInfo then
			items[item.slot] = {
				name = itemInfo["name"],
				amount = tonumber(item.amount),
				info = item.info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = itemInfo["image"],
				created = item.created,
				slot = item.slot,
			}
		end
	end
	return items
end

local function SaveStashItems(stashId, items)
	if Stashes[stashId].label == "Stash-None" or not items then return end

	for _, item in pairs(items) do
		item.description = nil
	end

	MySQL.insert('INSERT INTO stashitems (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items', {
		['stash'] = stashId,
		['items'] = json.encode(items)
	})

	Stashes[stashId].isOpen = false
end

local function AddToStash(stashId, slot, otherslot, itemName, amount, info, created)
	amount = tonumber(amount) or 1
	local ItemData = QBCore.Shared.Items[itemName]
	if not ItemData.unique then
		if Stashes[stashId].items[slot] and Stashes[stashId].items[slot].name == itemName then
			Stashes[stashId].items[slot].amount = Stashes[stashId].items[slot].amount + amount
		else
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Stashes[stashId].items[slot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = itemInfo["image"],
				created = created,
				slot = slot,
			}
		end
	else
		if Stashes[stashId].items[slot] and Stashes[stashId].items[slot].name == itemName then
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Stashes[stashId].items[otherslot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = itemInfo["image"],
				created = created,
				slot = otherslot,
			}
		else
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Stashes[stashId].items[slot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = itemInfo["image"],
				created = created,
				slot = slot,
			}
		end
	end
end

local function RemoveFromStash(stashId, slot, itemName, amount)
	amount = tonumber(amount) or 1
	if Stashes[stashId].items[slot] and Stashes[stashId].items[slot].name == itemName then
		if Stashes[stashId].items[slot].amount > amount then
			Stashes[stashId].items[slot].amount = Stashes[stashId].items[slot].amount - amount
		else
			Stashes[stashId].items[slot] = nil
		end
	else
		Stashes[stashId].items[slot] = nil
		if Stashes[stashId].items == nil then
			Stashes[stashId].items[slot] = nil
		end
	end
end

-- Trunk items
local function GetOwnedVehicleItems(plate)
	local items = {}
	local result = MySQL.scalar.await('SELECT items FROM trunkitems WHERE plate = ?', {plate})
	if not result then return items end

	local trunkItems = json.decode(result)
	if not trunkItems then return items end

	for _, item in pairs(trunkItems) do
		local itemInfo = QBCore.Shared.Items[item.name:lower()]
		if itemInfo then
			items[item.slot] = {
				name = itemInfo["name"],
				amount = tonumber(item.amount),
				info = item.info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = itemInfo["image"],
				created = item.created,
				slot = item.slot,
			}
		end
	end
	return items
end

local function SaveOwnedVehicleItems(plate, items)
	if Trunks[plate].label == "Trunk-None" or not items then return end

	for _, item in pairs(items) do
		item.description = nil
	end

	MySQL.insert('INSERT INTO trunkitems (plate, items) VALUES (:plate, :items) ON DUPLICATE KEY UPDATE items = :items', {
		['plate'] = plate,
		['items'] = json.encode(items)
	})

	Trunks[plate].isOpen = false
end

local function AddToTrunk(plate, slot, otherslot, itemName, amount, info, created)
	amount = tonumber(amount) or 1
	local ItemData = QBCore.Shared.Items[itemName]

	if not ItemData.unique then
		if Trunks[plate].items[slot] and Trunks[plate].items[slot].name == itemName then
			Trunks[plate].items[slot].amount = Trunks[plate].items[slot].amount + amount
		else
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Trunks[plate].items[slot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = itemInfo["image"],
				created = created,
				slot = slot,
			}
		end
	else
		if Trunks[plate].items[slot] and Trunks[plate].items[slot].name == itemName then
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Trunks[plate].items[otherslot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = itemInfo["image"],
				created = created,
				slot = otherslot,
			}
		else
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Trunks[plate].items[slot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = itemInfo["image"],
				created = created,
				slot = slot,
			}
		end
	end
end

local function RemoveFromTrunk(plate, slot, itemName, amount)
	amount = tonumber(amount) or 1
	if Trunks[plate].items[slot] and Trunks[plate].items[slot].name == itemName then
		if Trunks[plate].items[slot].amount > amount then
			Trunks[plate].items[slot].amount = Trunks[plate].items[slot].amount - amount
		else
			Trunks[plate].items[slot] = nil
		end
	else
		Trunks[plate].items[slot] = nil
		if Trunks[plate].items == nil then
			Trunks[plate].items[slot] = nil
		end
	end
end


-- Glovebox items
local function GetOwnedVehicleGloveboxItems(plate)
	local items = {}
	local result = MySQL.scalar.await('SELECT items FROM gloveboxitems WHERE plate = ?', {plate})
	if not result then return items end

	local gloveboxItems = json.decode(result)
	if not gloveboxItems then return items end

	for _, item in pairs(gloveboxItems) do
		local itemInfo = QBCore.Shared.Items[item.name:lower()]
		if itemInfo then
			items[item.slot] = {
				name = itemInfo["name"],
				amount = tonumber(item.amount),
				info = item.info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = itemInfo["image"],
				created = item.created,
				slot = item.slot,
			}
		end
	end
	return items
end

local function SaveOwnedGloveboxItems(plate, items)
	if Gloveboxes[plate].label == "Glovebox-None" or not items then return end

	for _, item in pairs(items) do
		item.description = nil
	end

	MySQL.insert('INSERT INTO gloveboxitems (plate, items) VALUES (:plate, :items) ON DUPLICATE KEY UPDATE items = :items', {
		['plate'] = plate,
		['items'] = json.encode(items)
	})

	Gloveboxes[plate].isOpen = false
end

local function AddToGlovebox(plate, slot, otherslot, itemName, amount, info, created)
	amount = tonumber(amount) or 1
	local ItemData = QBCore.Shared.Items[itemName]

	if not ItemData.unique then
		if Gloveboxes[plate].items[slot] and Gloveboxes[plate].items[slot].name == itemName then
			Gloveboxes[plate].items[slot].amount = Gloveboxes[plate].items[slot].amount + amount
		else
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Gloveboxes[plate].items[slot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = itemInfo["image"],
				created = created,
				slot = slot,
			}
		end
	else
		if Gloveboxes[plate].items[slot] and Gloveboxes[plate].items[slot].name == itemName then
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Gloveboxes[plate].items[otherslot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = itemInfo["image"],
				created = created,
				slot = otherslot,
			}
		else
			local itemInfo = QBCore.Shared.Items[itemName:lower()]
			Gloveboxes[plate].items[slot] = {
				name = itemInfo["name"],
				amount = amount,
				info = info or "",
				label = itemInfo["label"],
				description = itemInfo["description"] or "",
				weight = itemInfo["weight"],
				type = itemInfo["type"],
				unique = itemInfo["unique"],
				useable = itemInfo["useable"],
				image = itemInfo["image"],
				created = created,
				slot = slot,
			}
		end
	end
end

local function RemoveFromGlovebox(plate, slot, itemName, amount)
	amount = tonumber(amount) or 1
	if Gloveboxes[plate].items[slot] and Gloveboxes[plate].items[slot].name == itemName then
		if Gloveboxes[plate].items[slot].amount > amount then
			Gloveboxes[plate].items[slot].amount = Gloveboxes[plate].items[slot].amount - amount
		else
			Gloveboxes[plate].items[slot] = nil
		end
	else
		Gloveboxes[plate].items[slot] = nil
		if Gloveboxes[plate].items == nil then
			Gloveboxes[plate].items[slot] = nil
		end
	end
end

---Add an item to a drop
---@param dropId integer The id of the drop
---@param slot number The slot of the drop inventory to add the item to
---@param itemName string Name of the item to add
---@param amount? number The amount of the item to add
---@param info? table Extra info to add to the item
local function AddToDrop(dropId, slot, itemName, amount, info, created)
	amount = tonumber(amount) or 1
	Drops[dropId].createdTime = os.time()
	if Drops[dropId].items[slot] and Drops[dropId].items[slot].name == itemName then
		Drops[dropId].items[slot].amount = Drops[dropId].items[slot].amount + amount
	else
		local itemInfo = QBCore.Shared.Items[itemName:lower()]
		Drops[dropId].items[slot] = {
			name = itemInfo["name"],
			amount = amount,
			info = info or "",
			label = itemInfo["label"],
			description = itemInfo["description"] or "",
			weight = itemInfo["weight"],
			type = itemInfo["type"],
			unique = itemInfo["unique"],
			useable = itemInfo["useable"],
			image = itemInfo["image"],
			created = created,
			slot = slot,
			id = dropId,
		}
	end

	OnDropUpdate(dropId, Drops[dropId])
end


local function RemoveFromDrop(dropId, slot, itemName, amount)
	amount = tonumber(amount) or 1
	Drops[dropId].createdTime = os.time()
	if Drops[dropId].items[slot] and Drops[dropId].items[slot].name == itemName then
		if Drops[dropId].items[slot].amount > amount then
			Drops[dropId].items[slot].amount = Drops[dropId].items[slot].amount - amount
		else
			Drops[dropId].items[slot] = nil
		end
	else
		Drops[dropId].items[slot] = nil
		if Drops[dropId].items == nil then
			Drops[dropId].items[slot] = nil
		end
	end
	
	OnDropUpdate(dropId, Drops[dropId])
end

local function CreateDropId()
	if Drops then
		local id = math.random(10000, 99999)
		local dropid = id
		while Drops[dropid] do
			id = math.random(10000, 99999)
			dropid = id
		end
		return dropid
	else
		local id = math.random(10000, 99999)
		local dropid = id
		return dropid
	end
end

local function CreateNewDrop(source, fromSlot, toSlot, itemAmount, created)
	itemAmount = tonumber(itemAmount) or 1
	local Player = QBCore.Functions.GetPlayer(source)
	local itemData = GetItemBySlot(source, fromSlot)

	if not itemData then return end

	local coords = GetEntityCoords(GetPlayerPed(source))
	if RemoveItem(source, itemData.name, itemAmount, itemData.slot) then
		TriggerClientEvent("inventory:client:CheckWeapon", source, itemData.name)
		local itemInfo = QBCore.Shared.Items[itemData.name:lower()]
		local dropId = CreateDropId()
		Drops[dropId] = {}
		Drops[dropId].coords = coords
		Drops[dropId].createdTime = os.time()

		Drops[dropId].items = {}

		Drops[dropId].items[toSlot] = {
			name = itemInfo["name"],
			amount = itemAmount,
			info = itemData.info or "",
			label = itemInfo["label"],
			description = itemInfo["description"] or "",
			weight = itemInfo["weight"],
			type = itemInfo["type"],
			unique = itemInfo["unique"],
			useable = itemInfo["useable"],
			image = itemInfo["image"],
			created = created,
			slot = toSlot,
			id = dropId,
		}
		TriggerEvent("qb-log:server:CreateLog", "drop", "New Item Drop", "red", "**".. GetPlayerName(source) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..source.."*) dropped new item; name: **"..itemData.name.."**, amount: **" .. itemAmount .. "**")
		TriggerClientEvent("inventory:client:DropItemAnim", source)
		TriggerClientEvent("inventory:client:AddDropItem", -1, dropId, source, coords)
		if itemData.name:lower() == "radio" then
			TriggerClientEvent('Radio.Set', source, false)
		end

		
		OnDropUpdate(dropId, Drops[dropId])
	else
		TriggerClientEvent("QBCore:Notify", source, "You don't have this item!", "error")
		return
	end
end

local function OpenInventory(name, id, other, origin)
	local src = origin
	local ply = Player(src)
    local Player = QBCore.Functions.GetPlayer(src)
	if ply.state.inv_busy then
		return QBCore.Functions.Notify(src, Lang:t("notify.noaccess"), 'error')
	end
	if name and id then
		local secondInv = {}
		if name == "stash" then
			if Stashes[id] then
				if Stashes[id].isOpen then
					local Target = QBCore.Functions.GetPlayer(Stashes[id].isOpen)
					if Target then
						TriggerClientEvent('inventory:client:CheckOpenState', Stashes[id].isOpen, name, id, Stashes[id].label)
					else
						Stashes[id].isOpen = false
					end
				end
			end
			local maxweight = 1000000
			local slots = 50
			if other then
				maxweight = other.maxweight or 1000000
				slots = other.slots or 50
			end
			secondInv.name = "stash-"..id
			secondInv.label = "Stash-"..id
			secondInv.maxweight = maxweight
			secondInv.inventory = {}
			secondInv.slots = slots
			if Stashes[id] and Stashes[id].isOpen then
				secondInv.name = "none-inv"
				secondInv.label = "Stash-None"
				secondInv.maxweight = 1000000
				secondInv.inventory = {}
				secondInv.slots = 0
			else
				local stashItems = GetStashItems(id)
				if next(stashItems) then
					secondInv.inventory = stashItems
					Stashes[id] = {}
					Stashes[id].items = stashItems
					Stashes[id].isOpen = src
					Stashes[id].label = secondInv.label
				else
					Stashes[id] = {}
					Stashes[id].items = {}
					Stashes[id].isOpen = src
					Stashes[id].label = secondInv.label
				end
			end
		elseif name == "trunk" then
			if Trunks[id] then
				if Trunks[id].isOpen then
					local Target = QBCore.Functions.GetPlayer(Trunks[id].isOpen)
					if Target then
						TriggerClientEvent('inventory:client:CheckOpenState', Trunks[id].isOpen, name, id, Trunks[id].label)
					else
						Trunks[id].isOpen = false
					end
				end
			end
			secondInv.name = "trunk-"..id
			secondInv.label = "Trunk-"..id
			secondInv.maxweight = other.maxweight or 60000
			secondInv.inventory = {}
			secondInv.slots = other.slots or 50
			if (Trunks[id] and Trunks[id].isOpen) or (QBCore.Shared.SplitStr(id, "PLZI")[2] and (Player.PlayerData.job.name ~= "police" or Player.PlayerData.job.type ~= "leo")) then
				secondInv.name = "none-inv"
				secondInv.label = "Trunk-None"
				secondInv.maxweight = other.maxweight or 60000
				secondInv.inventory = {}
				secondInv.slots = 0
			else
				if id then
					local ownedItems = GetOwnedVehicleItems(id)
					if IsVehicleOwned(id) and next(ownedItems) then
						secondInv.inventory = ownedItems
						Trunks[id] = {}
						Trunks[id].items = ownedItems
						Trunks[id].isOpen = src
						Trunks[id].label = secondInv.label
					elseif Trunks[id] and not Trunks[id].isOpen then
						secondInv.inventory = Trunks[id].items
						Trunks[id].isOpen = src
						Trunks[id].label = secondInv.label
					else
						Trunks[id] = {}
						Trunks[id].items = {}
						Trunks[id].isOpen = src
						Trunks[id].label = secondInv.label
					end
				end
			end
		elseif name == "glovebox" then
			if Gloveboxes[id] then
				if Gloveboxes[id].isOpen then
					local Target = QBCore.Functions.GetPlayer(Gloveboxes[id].isOpen)
					if Target then
						TriggerClientEvent('inventory:client:CheckOpenState', Gloveboxes[id].isOpen, name, id, Gloveboxes[id].label)
					else
						Gloveboxes[id].isOpen = false
					end
				end
			end
			secondInv.name = "glovebox-"..id
			secondInv.label = "Glovebox-"..id
			secondInv.maxweight = 10000
			secondInv.inventory = {}
			secondInv.slots = 5
			if Gloveboxes[id] and Gloveboxes[id].isOpen then
				secondInv.name = "none-inv"
				secondInv.label = "Glovebox-None"
				secondInv.maxweight = 10000
				secondInv.inventory = {}
				secondInv.slots = 0
			else
				local ownedItems = GetOwnedVehicleGloveboxItems(id)
				if Gloveboxes[id] and not Gloveboxes[id].isOpen then
					secondInv.inventory = Gloveboxes[id].items
					Gloveboxes[id].isOpen = src
					Gloveboxes[id].label = secondInv.label
				elseif IsVehicleOwned(id) and next(ownedItems) then
					secondInv.inventory = ownedItems
					Gloveboxes[id] = {}
					Gloveboxes[id].items = ownedItems
					Gloveboxes[id].isOpen = src
					Gloveboxes[id].label = secondInv.label
				else
					Gloveboxes[id] = {}
					Gloveboxes[id].items = {}
					Gloveboxes[id].isOpen = src
					Gloveboxes[id].label = secondInv.label
				end
			end
		elseif name == "shop" then
			secondInv.name = "itemshop-"..id
			secondInv.label = other.label
			secondInv.maxweight = 900000
			secondInv.inventory = SetupShopItems(other.items)
			ShopItems[id] = {}
			ShopItems[id].items = other.items
			secondInv.slots = #other.items
		elseif name == "traphouse" then
			secondInv.name = "traphouse-"..id
			secondInv.label = other.label
			secondInv.maxweight = 900000
			secondInv.inventory = other.items
			secondInv.slots = other.slots
		elseif name == "crafting" then
			secondInv.name = "crafting"
			secondInv.label = other.label
			secondInv.maxweight = 900000
			secondInv.inventory = other.items
			secondInv.slots = #other.items
		elseif name == "attachment_crafting" then
			secondInv.name = "attachment_crafting"
			secondInv.label = other.label
			secondInv.maxweight = 900000
			secondInv.inventory = other.items
			secondInv.slots = #other.items
		elseif name == "otherplayer" then
			local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(id))
			if OtherPlayer then
				secondInv.name = "otherplayer-"..id
				secondInv.label = "Player-"..id
				secondInv.maxweight = Config.MaxInventoryWeight
				secondInv.inventory = OtherPlayer.PlayerData.items
				if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.type == "leo") and Player.PlayerData.job.onduty then
					secondInv.slots = Config.MaxInventorySlots + 150
				else
					secondInv.slots = Config.MaxInventorySlots + 150
				end
				Wait(250)
			end
		else
			if Drops[id] then
				if Drops[id].isOpen then
					local Target = QBCore.Functions.GetPlayer(Drops[id].isOpen)
					if Target then
						TriggerClientEvent('inventory:client:CheckOpenState', Drops[id].isOpen, name, id, Drops[id].label)
					else
						Drops[id].isOpen = false
					end
				end
			end
			if Drops[id] and not Drops[id].isOpen then
				secondInv.coords = Drops[id].coords
				secondInv.name = id
				secondInv.label = "Dropped-"..tostring(id)
				secondInv.maxweight = 100000
				secondInv.inventory = Drops[id].items
				secondInv.slots = 30
				Drops[id].isOpen = src
				Drops[id].label = secondInv.label
				Drops[id].createdTime = os.time()
			else
				secondInv.name = "none-inv"
				secondInv.label = "Dropped-None"
				secondInv.maxweight = 100000
				secondInv.inventory = {}
				secondInv.slots = 0
			end
		end
		TriggerClientEvent("qb-inventory:client:closeinv", id)
		TriggerClientEvent("inventory:client:OpenInventory", src, {}, Player.PlayerData.items, secondInv)
	else
		TriggerClientEvent("inventory:client:OpenInventory", src, {}, Player.PlayerData.items)
	end
end
exports('OpenInventory',OpenInventory)

-- Events

AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
	QBCore.Functions.AddPlayerMethod(Player.PlayerData.source, "AddItem", function(item, amount, slot, info)
		return AddItem(Player.PlayerData.source, item, amount, slot, info)
	end)

	QBCore.Functions.AddPlayerMethod(Player.PlayerData.source, "RemoveItem", function(item, amount, slot)
		return RemoveItem(Player.PlayerData.source, item, amount, slot)
	end)

	QBCore.Functions.AddPlayerMethod(Player.PlayerData.source, "GetItemBySlot", function(slot)
		return GetItemBySlot(Player.PlayerData.source, slot)
	end)

	QBCore.Functions.AddPlayerMethod(Player.PlayerData.source, "GetItemByName", function(item)
		return GetItemByName(Player.PlayerData.source, item)
	end)

	QBCore.Functions.AddPlayerMethod(Player.PlayerData.source, "GetItemsByName", function(item)
		return GetItemsByName(Player.PlayerData.source, item)
	end)

	QBCore.Functions.AddPlayerMethod(Player.PlayerData.source, "ClearInventory", function(filterItems)
		ClearInventory(Player.PlayerData.source, filterItems)
	end)

	QBCore.Functions.AddPlayerMethod(Player.PlayerData.source, "SetInventory", function(items)
		SetInventory(Player.PlayerData.source, items)
	end)
end)

AddEventHandler('onResourceStart', function(resourceName)
	if resourceName ~= GetCurrentResourceName() then return end
	local Players = QBCore.Functions.GetQBPlayers()
	for k in pairs(Players) do
		QBCore.Functions.AddPlayerMethod(k, "AddItem", function(item, amount, slot, info)
			return AddItem(k, item, amount, slot, info)
		end)

		QBCore.Functions.AddPlayerMethod(k, "RemoveItem", function(item, amount, slot)
			return RemoveItem(k, item, amount, slot)
		end)

		QBCore.Functions.AddPlayerMethod(k, "GetItemBySlot", function(slot)
			return GetItemBySlot(k, slot)
		end)

		QBCore.Functions.AddPlayerMethod(k, "GetItemByName", function(item)
			return GetItemByName(k, item)
		end)

		QBCore.Functions.AddPlayerMethod(k, "GetItemsByName", function(item)
			return GetItemsByName(k, item)
		end)

		QBCore.Functions.AddPlayerMethod(k, "ClearInventory", function(filterItems)
			ClearInventory(k, filterItems)
		end)

		QBCore.Functions.AddPlayerMethod(k, "SetInventory", function(items)
			SetInventory(k, items)
		end)
	end
end)

RegisterNetEvent('QBCore:Server:UpdateObject', function()
    if source ~= '' then return end -- Safety check if the event was not called from the server.
    QBCore = exports['qb-core']:GetCoreObject()
end)

function addTrunkItems(plate, items)
	Trunks[plate] = {}
	Trunks[plate].items = items
end

exports('addTrunkItems',addTrunkItems)

function addGloveboxItems(plate, items)
	Gloveboxes[plate] = {}
	Gloveboxes[plate].items = items
end

exports('addGloveboxItems',addGloveboxItems)

RegisterNetEvent('inventory:server:combineItem', function(item, fromItem, toItem)
	local src = source

	-- Check that inputs are not nil
	-- Most commonly when abusing this exploit, this values are left as
	if fromItem == nil  then return end
	if toItem == nil then return end

	-- Check that they have the items
	fromItem = GetItemByName(src, fromItem)
	toItem = GetItemByName(src, toItem)

	if fromItem == nil  then return end
	if toItem == nil then return end

	-- Check the recipe is valid
	local recipe = QBCore.Shared.Items[toItem.name].combinable

	if recipe and recipe.reward ~= item then return end
	if not recipeContains(recipe, fromItem) then return end

	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
	AddItem(src, item, 1)
	RemoveItem(src, fromItem.name, 1)
	RemoveItem(src, toItem.name, 1)
end)

RegisterNetEvent('inventory:server:CraftItems', function(itemName, itemCosts, amount, toSlot, points)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	amount = tonumber(amount)

	if not itemName or not itemCosts then return end

	for k, v in pairs(itemCosts) do
		RemoveItem(src, k, (v*amount))
	end
	AddItem(src, itemName, amount, toSlot)
	Player.Functions.SetMetaData("craftingrep", Player.PlayerData.metadata["craftingrep"] + (points * amount))
	TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, false)
end)

RegisterNetEvent('inventory:server:CraftAttachment', function(itemName, itemCosts, amount, toSlot, points)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	amount = tonumber(amount)

	if not itemName or not itemCosts then return end

	for k, v in pairs(itemCosts) do
		RemoveItem(src, k, (v*amount))
	end
	AddItem(src, itemName, amount, toSlot)
	Player.Functions.SetMetaData("attachmentcraftingrep", Player.PlayerData.metadata["attachmentcraftingrep"] + (points * amount))
	TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, false)
end)

RegisterNetEvent('inventory:server:SetIsOpenState', function(IsOpen, type, id)
	if IsOpen then return end

	if type == "stash" then
		Stashes[id].isOpen = false
	elseif type == "trunk" then
		Trunks[id].isOpen = false
	elseif type == "glovebox" then
		Gloveboxes[id].isOpen = false
	elseif type == "drop" then
		Drops[id].isOpen = false
	end
end)

RegisterNetEvent('inventory:server:OpenInventory', function(name, id, other)
		local src = source
		local ply = Player(src)
		local Player = QBCore.Functions.GetPlayer(src)
		local Lang = QBCore.Shared.Lang
		local Lang = QBCore.Shared.Lang or { t = function() return "Can't Open Inventory Right Now!" end }

		if ply.state.inv_busy then
			return QBCore.Functions.Notify(src, Lang:t("notify.noaccess"), 'error')
		end
		if name and id then
			local secondInv = {}
			if name == "stash" then
				if Stashes[id] then
					if Stashes[id].isOpen then
						local Target = QBCore.Functions.GetPlayer(Stashes[id].isOpen)
						if Target then
							TriggerClientEvent('inventory:client:CheckOpenState', Stashes[id].isOpen, name, id, Stashes[id].label)
						else
							Stashes[id].isOpen = false
						end
					end
				end
				local maxweight = 1000000
				local slots = 50
				if other then
					maxweight = other.maxweight or 1000000
					slots = other.slots or 50
				end
				secondInv.name = "stash-"..id
				secondInv.label = "Stash-"..id
				secondInv.maxweight = maxweight
				secondInv.inventory = {}
				secondInv.slots = slots
				if Stashes[id] and Stashes[id].isOpen then
					secondInv.name = "none-inv"
					secondInv.label = "Stash-None"
					secondInv.maxweight = 1000000
					secondInv.inventory = {}
					secondInv.slots = 0
				else
					local stashItems = GetStashItems(id)
					if next(stashItems) then
						secondInv.inventory = stashItems
						Stashes[id] = {}
						Stashes[id].items = stashItems
						Stashes[id].isOpen = src
						Stashes[id].label = secondInv.label
					else
						Stashes[id] = {}
						Stashes[id].items = {}
						Stashes[id].isOpen = src
						Stashes[id].label = secondInv.label
					end
				end
			elseif name == "trunk" then
				if Trunks[id] then
					if Trunks[id].isOpen then
						local Target = QBCore.Functions.GetPlayer(Trunks[id].isOpen)
						if Target then
							TriggerClientEvent('inventory:client:CheckOpenState', Trunks[id].isOpen, name, id, Trunks[id].label)
						else
							Trunks[id].isOpen = false
						end
					end
				end
				secondInv.name = "trunk-"..id
				secondInv.label = "Trunk-"..id
				secondInv.maxweight = other.maxweight or 60000
				secondInv.inventory = {}
				secondInv.slots = other.slots or 50
				if (Trunks[id] and Trunks[id].isOpen) or (QBCore.Shared.SplitStr(id, "PLZI")[2] and (Player.PlayerData.job.name ~= "police" or Player.PlayerData.job.type ~= "leo")) then
					secondInv.name = "none-inv"
					secondInv.label = "Trunk-None"
					secondInv.maxweight = other.maxweight or 60000
					secondInv.inventory = {}
					secondInv.slots = 0
				else
					if id then
						local ownedItems = GetOwnedVehicleItems(id)
						if IsVehicleOwned(id) and next(ownedItems) then
							secondInv.inventory = ownedItems
							Trunks[id] = {}
							Trunks[id].items = ownedItems
							Trunks[id].isOpen = src
							Trunks[id].label = secondInv.label
						elseif Trunks[id] and not Trunks[id].isOpen then
							secondInv.inventory = Trunks[id].items
							Trunks[id].isOpen = src
							Trunks[id].label = secondInv.label
						else
							Trunks[id] = {}
							Trunks[id].items = {}
							Trunks[id].isOpen = src
							Trunks[id].label = secondInv.label
						end
					end
				end
			elseif name == "glovebox" then
				if Gloveboxes[id] then
					if Gloveboxes[id].isOpen then
						local Target = QBCore.Functions.GetPlayer(Gloveboxes[id].isOpen)
						if Target then
							TriggerClientEvent('inventory:client:CheckOpenState', Gloveboxes[id].isOpen, name, id, Gloveboxes[id].label)
						else
							Gloveboxes[id].isOpen = false
						end
					end
				end
				secondInv.name = "glovebox-"..id
				secondInv.label = "Glovebox-"..id
				secondInv.maxweight = 10000
				secondInv.inventory = {}
				secondInv.slots = 5
				if Gloveboxes[id] and Gloveboxes[id].isOpen then
					secondInv.name = "none-inv"
					secondInv.label = "Glovebox-None"
					secondInv.maxweight = 10000
					secondInv.inventory = {}
					secondInv.slots = 0
				else
					local ownedItems = GetOwnedVehicleGloveboxItems(id)
					if Gloveboxes[id] and not Gloveboxes[id].isOpen then
						secondInv.inventory = Gloveboxes[id].items
						Gloveboxes[id].isOpen = src
						Gloveboxes[id].label = secondInv.label
					elseif IsVehicleOwned(id) and next(ownedItems) then
						secondInv.inventory = ownedItems
						Gloveboxes[id] = {}
						Gloveboxes[id].items = ownedItems
						Gloveboxes[id].isOpen = src
						Gloveboxes[id].label = secondInv.label
					else
						Gloveboxes[id] = {}
						Gloveboxes[id].items = {}
						Gloveboxes[id].isOpen = src
						Gloveboxes[id].label = secondInv.label
					end
				end
			elseif name == "shop" then
				secondInv.name = "itemshop-"..id
				secondInv.label = other.label
				secondInv.maxweight = 900000
				secondInv.inventory = SetupShopItems(other.items)
				ShopItems[id] = {}
				ShopItems[id].items = other.items
				secondInv.slots = #other.items
			elseif name == "traphouse" then
				secondInv.name = "traphouse-"..id
				secondInv.label = other.label
				secondInv.maxweight = 900000
				secondInv.inventory = other.items
				secondInv.slots = other.slots
			elseif name == "crafting" then
				secondInv.name = "crafting"
				secondInv.label = other.label
				secondInv.maxweight = 900000
				secondInv.inventory = other.items
				secondInv.slots = #other.items
			elseif name == "attachment_crafting" then
				secondInv.name = "attachment_crafting"
				secondInv.label = other.label
				secondInv.maxweight = 900000
				secondInv.inventory = other.items
				secondInv.slots = #other.items
			elseif name == "otherplayer" then
                local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(id))
                if OtherPlayer then
                    secondInv.name = "otherplayer-"..id
                    secondInv.label = "Player-"..id
                    secondInv.maxweight = Config.MaxInventoryWeight
                    secondInv.inventory = OtherPlayer.PlayerData.items
                    if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.type == "leo") and Player.PlayerData.job.onduty then
                        secondInv.slots = Config.MaxInventorySlots + 150
                    else
                        secondInv.slots = Config.MaxInventorySlots + 150
                    end
                    Wait(250)
                end
			else
				if Drops[id] then
					if Drops[id].isOpen then
						local Target = QBCore.Functions.GetPlayer(Drops[id].isOpen)
						if Target then
							TriggerClientEvent('inventory:client:CheckOpenState', Drops[id].isOpen, name, id, Drops[id].label)
						else
							Drops[id].isOpen = false
						end
					end
				end
				if Drops[id] and not Drops[id].isOpen then
					secondInv.coords = Drops[id].coords
					secondInv.name = id
					secondInv.label = "Dropped-"..tostring(id)
					secondInv.maxweight = 100000
					secondInv.inventory = Drops[id].items
					secondInv.slots = 30
					Drops[id].isOpen = src
					Drops[id].label = secondInv.label
					Drops[id].createdTime = os.time()
				else
					secondInv.name = "none-inv"
					secondInv.label = "Dropped-None"
					secondInv.maxweight = 100000
					secondInv.inventory = {}
					secondInv.slots = 0
				end
			end
			TriggerClientEvent("qb-inventory:client:closeinv", id)
			TriggerClientEvent("inventory:client:OpenInventory", src, {}, Player.PlayerData.items, secondInv)
		else
			TriggerClientEvent("inventory:client:OpenInventory", src, {}, Player.PlayerData.items)
	end
end)

RegisterNetEvent('inventory:server:SaveInventory', function(type, id)
	if type == "trunk" then
		if IsVehicleOwned(id) then
			SaveOwnedVehicleItems(id, Trunks[id].items)
		else
			Trunks[id].isOpen = false
		end
	elseif type == "glovebox" then
		if (IsVehicleOwned(id)) then
			SaveOwnedGloveboxItems(id, Gloveboxes[id].items)
		else
			Gloveboxes[id].isOpen = false
		end
	elseif type == "stash" then
		SaveStashItems(id, Stashes[id].items)
	elseif type == "drop" then
		if Drops[id] then
			Drops[id].isOpen = false
			if Drops[id].items == nil or next(Drops[id].items) == nil then
				Drops[id] = nil
				TriggerClientEvent("inventory:client:RemoveDropItem", -1, id)
			end
		end
	end
end)

RegisterNetEvent('inventory:server:UseItemSlot', function(slot)
    local src = source
    local itemData = GetItemBySlot(src, slot)
    if not itemData then return end
    local itemInfo = QBCore.Shared.Items[itemData.name]
    if itemData.type == 'weapon' then
        TriggerClientEvent('inventory:client:UseWeapon', src, itemData, itemData.info.quality and itemData.info.quality > 0)
        TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, 'use')
    elseif itemData.useable then
        if Config.Stashes[itemData.name] then lastUsedStashItem = itemData end -- <-- ADD HERE
        UseItem(itemData.name, src, itemData)
        TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, 'use')
    end
end)

RegisterNetEvent('inventory:server:UseItem', function(inventory, item)
    local src = source
    if inventory ~= 'player' and inventory ~= 'hotbar' then return end
    local itemData = GetItemBySlot(src, item.slot)
    if not itemData then return end
    local itemInfo = QBCore.Shared.Items[itemData.name]
    if itemData.type == 'weapon' then
        TriggerClientEvent('inventory:client:UseWeapon', src, itemData, itemData.info.quality and itemData.info.quality > 0)
        TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, 'use')
    else
        if Config.Stashes[itemData.name] then lastUsedStashItem = itemData end -- <-- ADD HERE
        UseItem(itemData.name, src, itemData)
        TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, 'use')
    end
end)

RegisterNetEvent('inventory:server:SetInventoryData', function(fromInventory, toInventory, fromSlot, toSlot, fromAmount, toAmount)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	fromSlot = tonumber(fromSlot)
	toSlot = tonumber(toSlot)
	if (fromInventory == "player" or fromInventory == "hotbar") and
		(QBCore.Shared.SplitStr(toInventory, "-")[1] == "itemshop" or toInventory == "crafting") then
		return
	end
	if fromInventory == "player" or fromInventory == "hotbar" then
		local fromItemData = Player.Functions.GetItemBySlot(fromSlot)
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.Functions.GetItemBySlot(toSlot)
				Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot)
				TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "remove", false)
				TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
				if toItemData ~= nil then
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
						TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "remove", false)
						Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info)
						TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "add", false)
					end
				end
				Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info)
				TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "add", false)
			elseif QBCore.Shared.SplitStr(toInventory, "-")[1] == "otherplayer" then
				local playerId = tonumber(QBCore.Shared.SplitStr(toInventory, "-")[2])
				local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
				local toItemData = OtherPlayer.PlayerData.items[toSlot]
				Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot)
				TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "remove", true)
				TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						OtherPlayer.Functions.RemoveItem(itemInfo["name"], toAmount, fromSlot)
						TriggerEvent(CashAsItemUpdateTrigger, playerId, toItemData, toAmount, "remove",
							true)
						Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info)
						TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "add", true)
						TriggerEvent("qb-log:server:CreateLog", "robbing", "Swapped Item", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | *" .. src .. "*) swapped item; name: **" .. itemInfo["name"] ..
								"**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name ..
								"**, amount: **" .. fromAmount .. "** with player: **" ..
								GetPlayerName(OtherPlayer.PlayerData.source) .. "** (citizenid: *" ..
								OtherPlayer.PlayerData.citizenid .. "* | id: *" .. OtherPlayer.PlayerData.source ..
								"*)")
					end
				else
					local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
					TriggerEvent("qb-log:server:CreateLog", "robbing", "Dropped Item", "red",
						"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid .. "* | *" ..
							src .. "*) dropped new item; name: **" .. itemInfo["name"] .. "**, amount: **" ..
							fromAmount .. "** to player: **" .. GetPlayerName(OtherPlayer.PlayerData.source) ..
							"** (citizenid: *" .. OtherPlayer.PlayerData.citizenid .. "* | id: *" ..
							OtherPlayer.PlayerData.source .. "*)")
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				OtherPlayer.Functions.AddItem(itemInfo["name"], fromAmount, toSlot, fromItemData.info)
				TriggerEvent(CashAsItemUpdateTrigger, playerId, fromItemData, fromAmount, "add", true)
			elseif QBCore.Shared.SplitStr(toInventory, "-")[1] == "trunk" then
				local plate = QBCore.Shared.SplitStr(toInventory, "-")[2]
				local toItemData = Trunks[plate].items[toSlot]
				Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot)
				TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "remove", true)
				TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						RemoveFromTrunk(plate, fromSlot, itemInfo["name"], toAmount)
						Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info)
						TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "add", true)
						TriggerEvent("qb-log:server:CreateLog", "trunk", "Swapped Item", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) swapped item; name: **" .. itemInfo["name"] ..
								"**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name ..
								"**, amount: **" .. fromAmount .. "** - plate: *" .. plate .. "*")
					end
				else
					local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
					TriggerEvent("qb-log:server:CreateLog", "trunk", "Dropped Item", "red",
						"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
							"* | id: *" .. src .. "*) dropped new item; name: **" .. itemInfo["name"] ..
							"**, amount: **" .. fromAmount .. "** - plate: *" .. plate .. "*")
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				AddToTrunk(plate, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
			elseif QBCore.Shared.SplitStr(toInventory, "-")[1] == "glovebox" then
				local plate = QBCore.Shared.SplitStr(toInventory, "-")[2]
				local toItemData = Gloveboxes[plate].items[toSlot]
				Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot)
				if Config.Stashes[fromItemData.name:lower()] then
					TriggerEvent('sgx-stashes:client:RemoveProp', src)
				end
				TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "remove", true)
				TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						RemoveFromGlovebox(plate, fromSlot, itemInfo["name"], toAmount)
						Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info)
						TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "add", true)
						TriggerEvent("qb-log:server:CreateLog", "glovebox", "Swapped Item", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) swapped item; name: **" .. itemInfo["name"] ..
								"**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name ..
								"**, amount: **" .. fromAmount .. "** - plate: *" .. plate .. "*")
					end
				else
					local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
					TriggerEvent("qb-log:server:CreateLog", "glovebox", "Dropped Item", "red",
						"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
							"* | id: *" .. src .. "*) dropped new item; name: **" .. itemInfo["name"] ..
							"**, amount: **" .. fromAmount .. "** - plate: *" .. plate .. "*")
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				AddToGlovebox(plate, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
			elseif QBCore.Shared.SplitStr(toInventory, "-")[1] == "stash" then
				local stashId = QBCore.Shared.SplitStr(toInventory, "-")[2]
				local toItemData = Stashes[stashId].items[toSlot]
				local stashName = QBCore.Shared.SplitStr(stashId, "_")[1]
				local allowedToAdd = IsItemAllowedToAdd(src, stashName, fromItemData.name)
				if allowedToAdd then
					Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot)
					TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "remove", true)
					TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
					if toItemData ~= nil then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
						if toItemData.name ~= fromItemData.name then
							RemoveFromStash(stashId, toSlot, itemInfo["name"], toAmount)
							Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info)
							TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "add", true)
							TriggerEvent("qb-log:server:CreateLog", "stash", "Swapped Item", "orange", "**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid .. "* | id: *" .. src .. "*) swapped item; name: **" .. itemInfo["name"] .. "**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name .. "**, amount: **" .. fromAmount .. "** - stash: *" .. stashId .. "*")
						end
					else
						local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
						TriggerEvent("qb-log:server:CreateLog", "stash", "Dropped Item", "red", "**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid .. "* | id: *" .. src .. "*) dropped new item; name: **" .. itemInfo["name"] .. "**, amount: **" .. fromAmount .. "** - stash: *" .. stashId .. "*")
					end
					local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
					AddToStash(stashId, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
				end
			elseif QBCore.Shared.SplitStr(toInventory, "-")[1] == "traphouse" then
				-- Traphouse
				local traphouseId = QBCore.Shared.SplitStr(toInventory, "-")[2]
				local toItemData = exports['qb-traphouse']:GetInventoryData(traphouseId, toSlot)
				local IsItemValid = exports['qb-traphouse']:CanItemBeSaled(fromItemData.name:lower())
				if IsItemValid then
					Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot)
					TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "remove", true)
					TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
					if toItemData ~= nil then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
						if toItemData.name ~= fromItemData.name then
							exports['qb-traphouse']:RemoveHouseItem(traphouseId, fromSlot, itemInfo["name"],
								toAmount)
							Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info)
							TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "add", true)
							TriggerEvent("qb-log:server:CreateLog", "traphouse", "Swapped Item", "orange",
								"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
									"* | id: *" .. src .. "*) swapped item; name: **" .. itemInfo["name"] ..
									"**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name ..
									"**, amount: **" .. fromAmount .. "** - traphouse: *" .. traphouseId .. "*")
						end
					else
						local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
						TriggerEvent("qb-log:server:CreateLog", "traphouse", "Dropped Item", "red",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) dropped new item; name: **" .. itemInfo["name"] ..
								"**, amount: **" .. fromAmount .. "** - traphouse: *" .. traphouseId .. "*")
					end
					local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
					exports['qb-traphouse']:AddHouseItem(traphouseId, toSlot, itemInfo["name"], fromAmount,
						fromItemData.info, src)
				else
					TriggerClientEvent('QBCore:Notify', src, "You can\'t sell this item..", 'error')
				end
			else
				-- drop
				toInventory = tonumber(toInventory)
				if toInventory == nil or toInventory == 0 then
					if Config.Stashes[fromItemData.name:lower()] then
						local coords = GetEntityCoords(GetPlayerPed(src))
						local pos = {["x"] = coords.x + 0.5, ["y"] = coords.y + 0.5, ["z"] = coords.z }
						TriggerEvent('sgx-stashes:server:dropstash', src, fromItemData, pos)
					else
						CreateNewDrop(src, fromSlot, toSlot, fromAmount)
						TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "remove", true)
					end
				else
					local toItemData = Drops[toInventory].items[toSlot]
					Player.Functions.RemoveItem(fromItemData.name, fromAmount, fromSlot)
					TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "remove", true)
					TriggerClientEvent("inventory:client:CheckWeapon", src, fromItemData.name)
					if toItemData ~= nil then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
						if toItemData.name ~= fromItemData.name then
							Player.Functions.AddItem(toItemData.name, toAmount, fromSlot, toItemData.info)
							TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "add",
								true)
							RemoveFromDrop(toInventory, fromSlot, itemInfo["name"], toAmount)
							TriggerEvent("qb-log:server:CreateLog", "drop", "Swapped Item", "orange",
								"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
									"* | id: *" .. src .. "*) swapped item; name: **" .. itemInfo["name"] ..
									"**, amount: **" .. toAmount .. "** with name: **" .. fromItemData.name ..
									"**, amount: **" .. fromAmount .. "** - dropid: *" .. toInventory .. "*")
						end
					else
						local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
						TriggerEvent("qb-log:server:CreateLog", "drop", "Dropped Item", "red",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) dropped new item; name: **" .. itemInfo["name"] ..
								"**, amount: **" .. fromAmount .. "** - dropid: *" .. toInventory .. "*")
					end
					local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
					AddToDrop(toInventory, toSlot, itemInfo["name"], fromAmount, fromItemData.info)
					if itemInfo["name"] == "radio" then
						TriggerClientEvent('Radio.Set', src, false)
					end
				end
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "You don\'t have this item!", "error")
		end
	elseif QBCore.Shared.SplitStr(fromInventory, "-")[1] == "otherplayer" then
		local playerId = tonumber(QBCore.Shared.SplitStr(fromInventory, "-")[2])
		local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
		local fromItemData = OtherPlayer.PlayerData.items[fromSlot]
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.Functions.GetItemBySlot(toSlot)
				OtherPlayer.Functions.RemoveItem(itemInfo["name"], fromAmount, fromSlot)
				TriggerEvent(CashAsItemUpdateTrigger, playerId, fromItemData, fromAmount, "remove", true)
				TriggerClientEvent("inventory:client:CheckWeapon", OtherPlayer.PlayerData.source, fromItemData.name)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
						TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "remove", true)
						OtherPlayer.Functions.AddItem(itemInfo["name"], toAmount, fromSlot, toItemData.info)
						TriggerEvent(CashAsItemUpdateTrigger, playerId, toItemData, toAmount, "add", true)
						TriggerEvent("qb-log:server:CreateLog", "robbing", "Swapped Item", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) swapped item; name: **" .. toItemData.name ..
								"**, amount: **" .. toAmount .. "** with item; **" .. itemInfo["name"] ..
								"**, amount: **" .. toAmount .. "** from player: **" ..
								GetPlayerName(OtherPlayer.PlayerData.source) .. "** (citizenid: *" ..
								OtherPlayer.PlayerData.citizenid .. "* | *" .. OtherPlayer.PlayerData.source .. "*)")
					end
				else
					TriggerEvent("qb-log:server:CreateLog", "robbing", "Retrieved Item", "green",
						"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
							"* | id: *" .. src .. "*) took item; name: **" .. fromItemData.name .. "**, amount: **" ..
							fromAmount .. "** from player: **" .. GetPlayerName(OtherPlayer.PlayerData.source) ..
							"** (citizenid: *" .. OtherPlayer.PlayerData.citizenid .. "* | *" ..
							OtherPlayer.PlayerData.source .. "*)")
				end
				Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info)
				TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "add", true)
			else
				local toItemData = OtherPlayer.PlayerData.items[toSlot]
				OtherPlayer.Functions.RemoveItem(itemInfo["name"], fromAmount, fromSlot)
				TriggerEvent(CashAsItemUpdateTrigger, playerId, toItemData, fromAmount, "remove", true)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						OtherPlayer.Functions.RemoveItem(itemInfo["name"], toAmount, toSlot)
						TriggerEvent(CashAsItemUpdateTrigger, playerId, toItemData, toAmount, "remove",
							true)
						OtherPlayer.Functions.AddItem(itemInfo["name"], toAmount, fromSlot, toItemData.info)
						TriggerEvent(CashAsItemUpdateTrigger, playerId, toItemData, toAmount, "add", true)
					end
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				OtherPlayer.Functions.AddItem(itemInfo["name"], fromAmount, toSlot, fromItemData.info)
				TriggerEvent(CashAsItemUpdateTrigger, playerId, fromItemData, fromAmount, "add", true)
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "Item doesn\'t exist??", "error")
		end
	elseif QBCore.Shared.SplitStr(fromInventory, "-")[1] == "trunk" then
		local plate = QBCore.Shared.SplitStr(fromInventory, "-")[2]
		local fromItemData = Trunks[plate].items[fromSlot]
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.Functions.GetItemBySlot(toSlot)
				RemoveFromTrunk(plate, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
						TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "remove", true)
						AddToTrunk(plate, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
						TriggerEvent("qb-log:server:CreateLog", "trunk", "Swapped Item", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) swapped item; name: **" .. toItemData.name ..
								"**, amount: **" .. toAmount .. "** with item; name: **" .. itemInfo["name"] ..
								"**, amount: **" .. toAmount .. "** plate: *" .. plate .. "*")
					else
						TriggerEvent("qb-log:server:CreateLog", "trunk", "Stacked Item", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) stacked item; name: **" .. toItemData.name ..
								"**, amount: **" .. toAmount .. "** from plate: *" .. plate .. "*")
					end
				else
					TriggerEvent("qb-log:server:CreateLog", "trunk", "Received Item", "green",
						"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
							"* | id: *" .. src .. "*) received item; name: **" .. fromItemData.name ..
							"**, amount: **" .. fromAmount .. "** plate: *" .. plate .. "*")
				end
				Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info)
				TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "add", true)
			else
				local toItemData = Trunks[plate].items[toSlot]
				RemoveFromTrunk(plate, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						RemoveFromTrunk(plate, toSlot, itemInfo["name"], toAmount)
						AddToTrunk(plate, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
					end
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				AddToTrunk(plate, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "Item doesn\'t exist??", "error")
		end
	elseif QBCore.Shared.SplitStr(fromInventory, "-")[1] == "glovebox" then
		local plate = QBCore.Shared.SplitStr(fromInventory, "-")[2]
		local fromItemData = Gloveboxes[plate].items[fromSlot]
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.Functions.GetItemBySlot(toSlot)
				RemoveFromGlovebox(plate, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
						TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "remove", true)
						AddToGlovebox(plate, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
						TriggerEvent("qb-log:server:CreateLog", "glovebox", "Swapped", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. ")* swapped item; name: **" .. toItemData.name ..
								"**, amount: **" .. toAmount .. "** with item; name: **" .. itemInfo["name"] ..
								"**, amount: **" .. toAmount .. "** plate: *" .. plate .. "*")
					else
						TriggerEvent("qb-log:server:CreateLog", "glovebox", "Stacked Item", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) stacked item; name: **" .. toItemData.name ..
								"**, amount: **" .. toAmount .. "** from plate: *" .. plate .. "*")
					end
				else
					TriggerEvent("qb-log:server:CreateLog", "glovebox", "Received Item", "green",
						"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
							"* | id: *" .. src .. "*) received item; name: **" .. fromItemData.name ..
							"**, amount: **" .. fromAmount .. "** plate: *" .. plate .. "*")
				end
				Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info)
				TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "add", true)
			else
				local toItemData = Gloveboxes[plate].items[toSlot]
				RemoveFromGlovebox(plate, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						RemoveFromGlovebox(plate, toSlot, itemInfo["name"], toAmount)
						AddToGlovebox(plate, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
					end
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				AddToGlovebox(plate, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "Item doesn\'t exist??", "error")
		end
	elseif QBCore.Shared.SplitStr(fromInventory, "-")[1] == "stash" then
		local stashId = QBCore.Shared.SplitStr(fromInventory, "-")[2]
		local fromItemData = Stashes[stashId].items[fromSlot]
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local stashName = QBCore.Shared.SplitStr(stashId, "_")[1]
				local isLootable = IsStashItemLootable(src, stashName)
				if isLootable then
					local toItemData = Player.Functions.GetItemBySlot(toSlot)
					RemoveFromStash(stashId, fromSlot, itemInfo["name"], fromAmount)
					if toItemData ~= nil then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
						if toItemData.name ~= fromItemData.name then
							Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
							TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "remove", true)
							AddToStash(stashId, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
							TriggerEvent("qb-log:server:CreateLog", "stash", "Swapped Item", "orange",
								"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
									"* | id: *" .. src .. "*) swapped item; name: **" .. toItemData.name ..
									"**, amount: **" .. toAmount .. "** with item; name: **" .. fromItemData.name ..
									"**, amount: **" .. fromAmount .. "** stash: *" .. stashId .. "*")
						else
							TriggerEvent("qb-log:server:CreateLog", "stash", "Stacked Item", "orange",
								"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
									"* | id: *" .. src .. "*) stacked item; name: **" .. toItemData.name ..
									"**, amount: **" .. toAmount .. "** from stash: *" .. stashId .. "*")
						end
					else
						TriggerEvent("qb-log:server:CreateLog", "stash", "Received Item", "green",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) received item; name: **" .. fromItemData.name ..
								"**, amount: **" .. fromAmount .. "** stash: *" .. stashId .. "*")
					end
					SaveStashItems(stashId, Stashes[stashId].items)
					Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info)
					TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "add", true)
				end

			else
				local toItemData = Stashes[stashId].items[toSlot]
				RemoveFromStash(stashId, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						RemoveFromStash(stashId, toSlot, itemInfo["name"], toAmount)
						AddToStash(stashId, fromSlot, toSlot, itemInfo["name"], toAmount, toItemData.info)
					end
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				AddToStash(stashId, toSlot, fromSlot, itemInfo["name"], fromAmount, fromItemData.info)
			end

		else
			TriggerClientEvent("QBCore:Notify", src, "Item doesn\'t exist??", "error")
		end
	elseif QBCore.Shared.SplitStr(fromInventory, "-")[1] == "traphouse" then
		local traphouseId = QBCore.Shared.SplitStr(fromInventory, "-")[2]
		local fromItemData = exports['qb-traphouse']:GetInventoryData(traphouseId, fromSlot)
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.Functions.GetItemBySlot(toSlot)
				exports['qb-traphouse']:RemoveHouseItem(traphouseId, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
						TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "remove", true)
						exports['qb-traphouse']:AddHouseItem(traphouseId, fromSlot, itemInfo["name"], toAmount,
							toItemData.info, src)
						TriggerEvent("qb-log:server:CreateLog", "stash", "Swapped Item", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) swapped item; name: **" .. toItemData.name ..
								"**, amount: **" .. toAmount .. "** with item; name: **" .. fromItemData.name ..
								"**, amount: **" .. fromAmount .. "** stash: *" .. traphouseId .. "*")
					else
						TriggerEvent("qb-log:server:CreateLog", "stash", "Stacked Item", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) stacked item; name: **" .. toItemData.name ..
								"**, amount: **" .. toAmount .. "** from stash: *" .. traphouseId .. "*")
					end
				else
					TriggerEvent("qb-log:server:CreateLog", "stash", "Received Item", "green",
						"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
							"* | id: *" .. src .. "*) received item; name: **" .. fromItemData.name ..
							"**, amount: **" .. fromAmount .. "** stash: *" .. traphouseId .. "*")
				end
				Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info)
				TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "add", true)
			else
				local toItemData = exports['qb-traphouse']:GetInventoryData(traphouseId, toSlot)
				exports['qb-traphouse']:RemoveHouseItem(traphouseId, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						exports['qb-traphouse']:RemoveHouseItem(traphouseId, toSlot, itemInfo["name"], toAmount)
						exports['qb-traphouse']:AddHouseItem(traphouseId, fromSlot, itemInfo["name"], toAmount,
							toItemData.info, src)
					end
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				exports['qb-traphouse']:AddHouseItem(traphouseId, toSlot, itemInfo["name"], fromAmount,
					fromItemData.info, src)
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "Item doesn't exist??", "error")
		end
	elseif QBCore.Shared.SplitStr(fromInventory, "-")[1] == "itemshop" then
		local shopType = QBCore.Shared.SplitStr(fromInventory, "-")[2]
		local itemData = ShopItems[shopType].items[fromSlot]
		local itemInfo = QBCore.Shared.Items[itemData.name:lower()]
		local bankBalance = Player.PlayerData.money["bank"]
		local price = tonumber((itemData.price * fromAmount))

		if QBCore.Shared.SplitStr(shopType, "_")[1] == "Dealer" then
			if QBCore.Shared.SplitStr(itemData.name, "_")[1] == "weapon" then
				price = tonumber(itemData.price)
				if Player.Functions.RemoveMoney("cash", price, "dealer-item-bought") then
					itemData.info.serie = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) ..
													   QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) ..
													   QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4))
					Player.Functions.AddItem(itemData.name, 1, toSlot, itemData.info)
					TriggerClientEvent('qb-drugs:client:updateDealerItems', src, itemData, 1)
					TriggerClientEvent('QBCore:Notify', src, itemInfo["label"] .. " bought!", "success")
					TriggerEvent("qb-log:server:CreateLog", "dealers", "Dealer item bought", "green", "**" ..
						GetPlayerName(src) .. "** bought a " .. itemInfo["label"] .. " for $" .. price)
				else
					TriggerClientEvent('QBCore:Notify', src, "You don\'t have enough cash..", "error")
				end
			else
				if Player.Functions.RemoveMoney("cash", price, "dealer-item-bought") then
					Player.Functions.AddItem(itemData.name, fromAmount, toSlot, itemData.info)
					TriggerClientEvent('qb-drugs:client:updateDealerItems', src, itemData, fromAmount)
					TriggerClientEvent('QBCore:Notify', src, itemInfo["label"] .. " bought!", "success")
					TriggerEvent("qb-log:server:CreateLog", "dealers", "Dealer item bought", "green", "**" ..
						GetPlayerName(src) .. "** bought a " .. itemInfo["label"] .. "  for $" .. price)
				else
					TriggerClientEvent('QBCore:Notify', src, "You don't have enough cash..", "error")
				end
			end
		elseif QBCore.Shared.SplitStr(shopType, "_")[1] == "Itemshop" then
			if Player.Functions.RemoveMoney("cash", price, "itemshop-bought-item") then
				if QBCore.Shared.SplitStr(itemData.name, "_")[1] == "weapon" then
					itemData.info.serie = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) ..
													   QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) ..
													   QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4))
				end
				if itemData.name:lower() == 'wallet' then
					itemData.info.walletid = math.random(11111, 99999)
				end
				Player.Functions.AddItem(itemData.name, fromAmount, toSlot, itemData.info)
				TriggerClientEvent('qb-shops:client:UpdateShop', src, QBCore.Shared.SplitStr(shopType, "_")[2],
					itemData, fromAmount)
				TriggerClientEvent('QBCore:Notify', src, itemInfo["label"] .. " bought!", "success")
				TriggerEvent("qb-log:server:CreateLog", "shops", "Shop item bought", "green",
					"**" .. GetPlayerName(src) .. "** bought a " .. itemInfo["label"] .. " for $" .. price)
			elseif bankBalance >= price then
				Player.Functions.RemoveMoney("bank", price, "itemshop-bought-item")
				if QBCore.Shared.SplitStr(itemData.name, "_")[1] == "weapon" then
					itemData.info.serie = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) ..
													   QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) ..
													   QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4))
				end
				if itemData.name:lower() == 'wallet' then
					itemData.info.walletid = math.random(11111, 99999)
				end
				Player.Functions.AddItem(itemData.name, fromAmount, toSlot, itemData.info)
				TriggerClientEvent('qb-shops:client:UpdateShop', src, QBCore.Shared.SplitStr(shopType, "_")[2],
					itemData, fromAmount)
				TriggerClientEvent('QBCore:Notify', src, itemInfo["label"] .. " bought!", "success")
				TriggerEvent("qb-log:server:CreateLog", "shops", "Shop item bought", "green",
					"**" .. GetPlayerName(src) .. "** bought a " .. itemInfo["label"] .. " for $" .. price)
			else
				TriggerClientEvent('QBCore:Notify', src, "You don't have enough cash..", "error")
			end

		elseif QBCore.Shared.SplitStr(shopType, "_")[1] == "market" then
			if Player.Functions.RemoveMoney("black_money", price, "blackmarket-item-bought") then
				AddItem(src, itemData.name, fromAmount, toSlot, itemData.info)
				TriggerEvent(CashAsItemUpdateTrigger, src, itemData.name, price, "remove", true)
				QBCore.Functions.Notify(src, itemInfo["label"] .. " bought!", "success")
				TriggerEvent("qb-log:server:CreateLog", "blackmarket", "Blackmarket item bought", "green", "**" ..
					GetPlayerName(src) .. "** bought a " .. itemInfo["label"] .. "  for $" .. price)
			else
				QBCore.Functions.Notify(src, "You don't have blackmoney", "error")
			end

		else
			if Player.Functions.RemoveMoney("cash", price, "unkown-itemshop-bought-item") then
				Player.Functions.AddItem(itemData.name, fromAmount, toSlot, itemData.info)
				TriggerClientEvent('QBCore:Notify', src, itemInfo["label"] .. " bought!", "success")
				TriggerEvent("qb-log:server:CreateLog", "shops", "Shop item bought", "green",
					"**" .. GetPlayerName(src) .. "** bought a " .. itemInfo["label"] .. " for $" .. price)
			elseif bankBalance >= price then
				Player.Functions.RemoveMoney("bank", price, "unkown-itemshop-bought-item")
				Player.Functions.AddItem(itemData.name, fromAmount, toSlot, itemData.info)
				TriggerClientEvent('QBCore:Notify', src, itemInfo["label"] .. " bought!", "success")
				TriggerEvent("qb-log:server:CreateLog", "shops", "Shop item bought", "green",
					"**" .. GetPlayerName(src) .. "** bought a " .. itemInfo["label"] .. " for $" .. price)
			else
				TriggerClientEvent('QBCore:Notify', src, "You don\'t have enough cash..", "error")
			end
		end
	elseif fromInventory == "crafting" then
		local itemData = Config.CraftingItems[fromSlot]
		if hasCraftItems(src, itemData.costs, fromAmount) then
			TriggerClientEvent("inventory:client:CraftItems", src, itemData.name, itemData.costs, fromAmount,
				toSlot, itemData.points)
		else
			TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, true)
			TriggerClientEvent('QBCore:Notify', src, "You don't have the right items..", "error")
		end
	elseif fromInventory == "attachment_crafting" then
		local itemData = Config.AttachmentCrafting["items"][fromSlot]
		if hasCraftItems(src, itemData.costs, fromAmount) then
			TriggerClientEvent("inventory:client:CraftAttachment", src, itemData.name, itemData.costs, fromAmount,
				toSlot, itemData.points)
		else
			TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, true)
			TriggerClientEvent('QBCore:Notify', src, "You don't have the right items..", "error")
		end
	else
		-- drop
		fromInventory = tonumber(fromInventory)
		local fromItemData = Drops[fromInventory].items[fromSlot]
		local fromAmount = tonumber(fromAmount) ~= nil and tonumber(fromAmount) or fromItemData.amount
		if fromItemData ~= nil and fromItemData.amount >= fromAmount then
			local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
			if toInventory == "player" or toInventory == "hotbar" then
				local toItemData = Player.Functions.GetItemBySlot(toSlot)
				RemoveFromDrop(fromInventory, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						Player.Functions.RemoveItem(toItemData.name, toAmount, toSlot)
						TriggerEvent(CashAsItemUpdateTrigger, src, toItemData, toAmount, "remove", true)
						AddToDrop(fromInventory, toSlot, itemInfo["name"], toAmount, toItemData.info)
						if itemInfo["name"] == "radio" then
							TriggerClientEvent('Radio.Set', src, false)
						end
						TriggerEvent("qb-log:server:CreateLog", "drop", "Swapped Item", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) swapped item; name: **" .. toItemData.name ..
								"**, amount: **" .. toAmount .. "** with item; name: **" .. fromItemData.name ..
								"**, amount: **" .. fromAmount .. "** - dropid: *" .. fromInventory .. "*")
					else
						TriggerEvent("qb-log:server:CreateLog", "drop", "Stacked Item", "orange",
							"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
								"* | id: *" .. src .. "*) stacked item; name: **" .. toItemData.name ..
								"**, amount: **" .. toAmount .. "** - from dropid: *" .. fromInventory .. "*")
					end
				else
					TriggerEvent("qb-log:server:CreateLog", "drop", "Received Item", "green",
						"**" .. GetPlayerName(src) .. "** (citizenid: *" .. Player.PlayerData.citizenid ..
							"* | id: *" .. src .. "*) received item; name: **" .. fromItemData.name ..
							"**, amount: **" .. fromAmount .. "** -  dropid: *" .. fromInventory .. "*")
				end
				Player.Functions.AddItem(fromItemData.name, fromAmount, toSlot, fromItemData.info)
				TriggerEvent(CashAsItemUpdateTrigger, src, fromItemData, fromAmount, "add", true)
			else
				toInventory = tonumber(toInventory)
				local toItemData = Drops[toInventory].items[toSlot]
				RemoveFromDrop(fromInventory, fromSlot, itemInfo["name"], fromAmount)
				if toItemData ~= nil then
					local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
					local toAmount = tonumber(toAmount) ~= nil and tonumber(toAmount) or toItemData.amount
					if toItemData.name ~= fromItemData.name then
						local itemInfo = QBCore.Shared.Items[toItemData.name:lower()]
						RemoveFromDrop(toInventory, toSlot, itemInfo["name"], toAmount)
						AddToDrop(fromInventory, fromSlot, itemInfo["name"], toAmount, toItemData.info)
						if itemInfo["name"] == "radio" then
							TriggerClientEvent('Radio.Set', src, false)
						end
					end
				end
				local itemInfo = QBCore.Shared.Items[fromItemData.name:lower()]
				AddToDrop(toInventory, toSlot, itemInfo["name"], fromAmount, fromItemData.info)
				if itemInfo["name"] == "radio" then
					TriggerClientEvent('Radio.Set', src, false)
				end
			end
		else
			TriggerClientEvent("QBCore:Notify", src, "Item doesn't exist??", "error")
		end
	end
end)

RegisterNetEvent('inventory:server:snowball', function(action)
	if action == "add" then
		AddItem(source, "weapon_snowball")
	elseif action == "remove" then
		RemoveItem(source, "weapon_snowball")
	end
end)

RegisterNetEvent("inventory:server:GiveItem", function(target, name, amount, slot)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(target))
    local dist = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target)))
    if Player == OtherPlayer then
        return TriggerClientEvent('QBCore:Notify', src, "You can't give yourself an item?")
    end
    if dist > 2 then
        return TriggerClientEvent('QBCore:Notify', src, "You are too far away to give items!")
    end
    local item = Player.Functions.GetItemBySlot(slot)
    if not item then
        TriggerClientEvent('QBCore:Notify', src, "Item you tried giving not found!");
        return
    end
    if item.name ~= name then
        TriggerClientEvent('QBCore:Notify', src, "Incorrect item found try again!");
        return
    end
    if amount <= item.amount then
        if amount == 0 then
            amount = item.amount
        end
        if Player.Functions.RemoveItem(item.name, amount, item.slot) then
            TriggerEvent('sgx-cashasitem:server:updateCash', src, item, amount, "remove", true)
            if OtherPlayer.Functions.AddItem(item.name, amount, false, item.info) then
                TriggerEvent('sgx-cashasitem:server:updateCash', target, item, amount, "add", true)
                TriggerClientEvent('inventory:client:ItemBox', target, QBCore.Shared.Items[item.name], "add")
                TriggerClientEvent('QBCore:Notify', target,
                    "You Received " .. amount .. ' ' .. item.label .. " From " .. Player.PlayerData.charinfo.firstname ..
                        " " .. Player.PlayerData.charinfo.lastname)
                TriggerClientEvent("inventory:client:UpdatePlayerInventory", target, true)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove")
                TriggerClientEvent('QBCore:Notify', src,
                    "You gave " .. OtherPlayer.PlayerData.charinfo.firstname .. " " ..
                        OtherPlayer.PlayerData.charinfo.lastname .. " " .. amount .. " " .. item.label .. "!")
                TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, true)
                TriggerClientEvent('qb-inventory:client:giveAnim', src)
                TriggerClientEvent('qb-inventory:client:giveAnim', target)
            else
                Player.Functions.AddItem(item.name, amount, item.slot, item.info)
                TriggerEvent('sgx-cashasitem:server:updateCash', src, item, amount, "add", true)
                TriggerClientEvent('QBCore:Notify', src, "The other players inventory is full!", "error")
                TriggerClientEvent('QBCore:Notify', target, "Your inventory is full!", "error")
                TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, false)
                TriggerClientEvent("inventory:client:UpdatePlayerInventory", target, false)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You do not have enough of the item", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You do not have enough items to transfer")
    end
end)

-- callback

QBCore.Functions.CreateCallback('qb-inventory:server:GetStashItems', function(source, cb, stashId)
	cb(GetStashItems(stashId))
end)

QBCore.Functions.CreateCallback('inventory:server:GetCurrentDrops', function(_, cb)
	cb(Drops)
end)

QBCore.Functions.CreateCallback('QBCore:HasItem', function(source, cb, items, amount)
	print("^3QBCore:HasItem is deprecated, please use QBCore.Functions.HasItem, it can be used on both server- and client-side and uses the same arguments.^0")
    local retval = false
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return cb(false) end
    local isTable = type(items) == 'table'
    local isArray = isTable and table.type(items) == 'array' or false
    local totalItems = #items
    local count = 0
    local kvIndex = 2
    if isTable and not isArray then
        totalItems = 0
        for _ in pairs(items) do totalItems += 1 end
        kvIndex = 1
    end
    if isTable then
        for k, v in pairs(items) do
            local itemKV = {k, v}
            local item = GetItemByName(source, itemKV[kvIndex])
            if item and ((amount and item.amount >= amount) or (not amount and not isArray and item.amount >= v) or (not amount and isArray)) then
                count += 1
            end
        end
        if count == totalItems then
            retval = true
        end
    else -- Single item as string
        local item = GetItemByName(source, items)
        if item and not amount or (item and amount and item.amount >= amount) then
            retval = true
        end
    end
    cb(retval)
end)

-- command

QBCore.Commands.Add("resetinv", "Reset Inventory (Admin Only)", {{name="type", help="stash/trunk/glovebox"},{name="id/plate", help="ID of stash or license plate"}}, true, function(source, args)
	local invType = args[1]:lower()
	table.remove(args, 1)
	local invId = table.concat(args, " ")
	if invType and invId then
		if invType == "trunk" then
			if Trunks[invId] then
				Trunks[invId].isOpen = false
			end
		elseif invType == "glovebox" then
			if Gloveboxes[invId] then
				Gloveboxes[invId].isOpen = false
			end
		elseif invType == "stash" then
			if Stashes[invId] then
				Stashes[invId].isOpen = false
			end
		else
			TriggerClientEvent('QBCore:Notify', source,  "Not a valid type..", "error")
		end
	else
		TriggerClientEvent('QBCore:Notify', source,  "Arguments not filled out correctly..", "error")
	end
end, "admin")

QBCore.Commands.Add("rob", "Rob Player", {}, false, function(source, args)
	TriggerClientEvent("police:client:RobPlayer", source)
end)

QBCore.Commands.Add("giveitem", "Give An Item (Admin Only)", {{name="id", help="Player ID"},{name="item", help="Name of the item (not a label)"}, {name="amount", help="Amount of items"}}, false, function(source, args)
	local id = tonumber(args[1])
	local Player = QBCore.Functions.GetPlayer(id)
	local amount = tonumber(args[3]) or 1
	local itemData = QBCore.Shared.Items[tostring(args[2]):lower()]
	if Player then
			if itemData then
				-- check iteminfo
				local info = {}
				if itemData["name"] == "id_card" then
					info.citizenid = Player.PlayerData.citizenid
					info.firstname = Player.PlayerData.charinfo.firstname
					info.lastname = Player.PlayerData.charinfo.lastname
					info.birthdate = Player.PlayerData.charinfo.birthdate
					info.gender = Player.PlayerData.charinfo.gender
					info.nationality = Player.PlayerData.charinfo.nationality
				elseif itemData["name"] == "driver_license" then
					info.firstname = Player.PlayerData.charinfo.firstname
					info.lastname = Player.PlayerData.charinfo.lastname
					info.birthdate = Player.PlayerData.charinfo.birthdate
					info.type = "Class C Driver License"
				elseif itemData["type"] == "weapon" then
					amount = 1
					info.serie = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4))
					info.quality = 100
				elseif itemData["name"] == "harness" then
					info.uses = 20
				elseif itemData["name"] == "markedbills" then
					info.worth = math.random(5000, 10000)
				elseif itemData["name"] == "labkey" then
					info.lab = exports["qb-methlab"]:GenerateRandomLab()
				elseif itemData["name"] == "printerdocument" then
					info.url = "https://cdn.discordapp.com/attachments/870094209783308299/870104331142189126/Logo_-_Display_Picture_-_Stylized_-_Red.png"
				elseif QBCore.Shared.Items[itemData["name"]]["decay"] and QBCore.Shared.Items[itemData["name"]]["decay"] > 0 then
					info.quality = 100
				end

				if AddItem(id, itemData["name"], amount, false, info) then
					QBCore.Functions.Notify(source, "You Have Given " ..GetPlayerName(id).." "..amount.." "..itemData["name"].. "", "success")
				else
					QBCore.Functions.Notify(source, "Can\'t give item!", "error")
				end
			else
				QBCore.Functions.Notify(source, "Item Does Not Exist", "error")
			end
	else
		QBCore.Functions.Notify(source,  "Player Is Not Online", "error")
	end
end, "admin")

QBCore.Commands.Add("randomitems", "Give Random Items (God Only)", {}, false, function(source, _)
	local filteredItems = {}
	for k, v in pairs(QBCore.Shared.Items) do
		if QBCore.Shared.Items[k]["type"] ~= "weapon" then
			filteredItems[#filteredItems+1] = v
		end
	end
	for _ = 1, 10, 1 do
		local randitem = filteredItems[math.random(1, #filteredItems)]
		local amount = math.random(1, 10)
		if randitem["unique"] then
			amount = 1
		end
		if AddItem(source, randitem["name"], amount) then
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[randitem["name"]], 'add')
            Wait(500)
		end
	end
end, "god")

QBCore.Commands.Add('clearinv', 'Clear Players Inventory (Admin Only)', { { name = 'id', help = 'Player ID' } }, false, function(source, args)
    local playerId = args[1] ~= '' and tonumber(args[1]) or source
    local Player = QBCore.Functions.GetPlayer(playerId)
    if Player then
        ClearInventory(playerId)
    else
        QBCore.Functions.Notify(source, "Player not online", 'error')
    end
end, 'admin')

-- item

-- QBCore.Functions.CreateUseableItem("snowball", function(source, item)
-- 	local Player = QBCore.Functions.GetPlayer(source)
-- 	local itemData = Player.Functions.GetItemBySlot(item.slot)       -- --- DID THIS GET PUT ELSEWHERE?? IDK
-- 	if Player.Functions.GetItemBySlot(item.slot) then
--         TriggerClientEvent("inventory:client:UseSnowball", source, itemData.amount)
--     end
-- end)

CreateUsableItem("driver_license", function(source, item)
	local playerPed = GetPlayerPed(source)
	local playerCoords = GetEntityCoords(playerPed)
	local players = QBCore.Functions.GetPlayers()
	for _, v in pairs(players) do
		local targetPed = GetPlayerPed(v)
		local dist = #(playerCoords - GetEntityCoords(targetPed))
		if dist < 3.0 then
			TriggerClientEvent('chat:addMessage', v,  {
					template = '<div class="chat-message advert"><div class="chat-message-body"><strong>{0}:</strong><br><br> <strong>First Name:</strong> {1} <br><strong>Last Name:</strong> {2} <br><strong>Birth Date:</strong> {3} <br><strong>Licenses:</strong> {4}</div></div>',
					args = {
						"Drivers License",
						item.info.firstname,
						item.info.lastname,
						item.info.birthdate,
						item.info.type
					}
				}
			)
		end
	end
end)

CreateUsableItem("id_card", function(source, item)
	local playerPed = GetPlayerPed(source)
	local playerCoords = GetEntityCoords(playerPed)
	local players = QBCore.Functions.GetPlayers()
	for _, v in pairs(players) do
		local targetPed = GetPlayerPed(v)
		local dist = #(playerCoords - GetEntityCoords(targetPed))
		if dist < 3.0 then
			local gender = "Man"
			if item.info.gender == 1 then
				gender = "Woman"
			end
			TriggerClientEvent('chat:addMessage', v,  {
					template = '<div class="chat-message advert"><div class="chat-message-body"><strong>{0}:</strong><br><br> <strong>Civ ID:</strong> {1} <br><strong>First Name:</strong> {2} <br><strong>Last Name:</strong> {3} <br><strong>Birthdate:</strong> {4} <br><strong>Gender:</strong> {5} <br><strong>Nationality:</strong> {6}</div></div>',
					args = {
						"ID Card",
						item.info.citizenid,
						item.info.firstname,
						item.info.lastname,
						item.info.birthdate,
						gender,
						item.info.nationality
					}
				}
			)
		end
	end
end)


CreateThread(function()
	while true do
		for k, v in pairs(Drops) do
			if v and (v.createdTime + Config.CleanupDropTime < os.time()) and not Drops[k].isOpen then
				Drops[k] = nil
				TriggerClientEvent("inventory:client:RemoveDropItem", -1, k)
			end
		end
		Wait(60 * 1000)
	end
end)

-- Decay System

------DEV BY POOYA HPX

--HP

local TimeAllowed = 60 * 60 * 24 * 1 -- Maths for 1 day dont touch its very important and could break everything
function ConvertQuality(item)
	local StartDate = item.created
    local DecayRate = QBCore.Shared.Items[item.name:lower()]["decay"] ~= nil and QBCore.Shared.Items[item.name:lower()]["decay"] or 0.0
    if DecayRate == nil then
        DecayRate = 0
    end
    local TimeExtra = math.ceil((TimeAllowed * DecayRate))
    local percentDone = 100 - math.ceil((((os.time() - StartDate) / TimeExtra) * 100))
    if DecayRate == 0 then
        percentDone = 100
    end
    if percentDone < 0 then
        percentDone = 0
    end
    return percentDone
end

QBCore.Functions.CreateCallback('inventory:server:ConvertQuality', function(source, cb, inventory, other)
    local src = source
    local data = {}
    local Player = QBCore.Functions.GetPlayer(src)
    for _, item in pairs(inventory) do
        if item.created then
            if QBCore.Shared.Items[item.name:lower()]["decay"] ~= nil or QBCore.Shared.Items[item.name:lower()]["decay"] ~= 0 then
                if item.info then
                    if type(item.info) == "string" then
                        item.info = {}
                    end
                    if item.info.quality == nil then
                        item.info.quality = 100
                    end
                else
                    local info = {quality = 100}
                    item.info = info
                end
                local quality = ConvertQuality(item)
                if item.info.quality then
                    if quality < item.info.quality then
                        item.info.quality = quality
                    end
                else
                    item.info = {quality = quality}
                end
            else
                if item.info then
                    item.info.quality = 100
                else
                    local info = {quality = 100}
                    item.info = info
                end
            end
        end
    end
    if other then
		local inventoryType = QBCore.Shared.SplitStr(other.name, "-")[1]
		local uniqueId = QBCore.Shared.SplitStr(other.name, "-")[2]
		if inventoryType == "trunk" then
			for _, item in pairs(other.inventory) do
				if item.created then
					if QBCore.Shared.Items[item.name:lower()]["decay"] ~= nil or QBCore.Shared.Items[item.name:lower()]["decay"] ~= 0 then
						if item.info then
							if item.info.quality == nil then
								item.info.quality = 100
							end
						else
							local info = {quality = 100}
							item.info = info
						end
						local quality = ConvertQuality(item)
                    	if item.info.quality then
							if quality < item.info.quality then
								item.info.quality = quality
							end
						else
							item.info = {quality = quality}
						end
					else
						if item.info then
							item.info.quality = 100
						else
							local info = {quality = 100}
							item.info = info
						end
					end
				end
			end
			Trunks[uniqueId].items = other.inventory
			TriggerClientEvent("inventory:client:UpdateOtherInventory", Player.PlayerData.source, other.inventory, false)
		elseif inventoryType == "glovebox" then
			for _, item in pairs(other.inventory) do
				if item.created then
					if QBCore.Shared.Items[item.name:lower()]["decay"] ~= nil or QBCore.Shared.Items[item.name:lower()]["decay"] ~= 0 then
						if item.info then
							if item.info.quality == nil then
								item.info.quality = 100
							end
						else
							local info = {quality = 100}
							item.info = info
						end
						local quality = ConvertQuality(item)
                    	if item.info.quality then
							if quality < item.info.quality then
								item.info.quality = quality
							end
						else
							item.info = {quality = quality}
						end
					else
						if item.info then
							item.info.quality = 100
						else
							local info = {quality = 100}
							item.info = info
						end
					end
				end
			end
			Gloveboxes[uniqueId].items = other.inventory
			TriggerClientEvent("inventory:client:UpdateOtherInventory", Player.PlayerData.source, other.inventory, false)
		elseif inventoryType == "stash" then
			for _, item in pairs(other.inventory) do
				if item.created then
					if QBCore.Shared.Items[item.name:lower()]["decay"] ~= nil or QBCore.Shared.Items[item.name:lower()]["decay"] ~= 0 then
						if item.info then
							if type(item.info) == "string" then
								item.info = {}
							end
							if item.info.quality == nil then
								item.info.quality = 100
							end
						else
							local info = {quality = 100}
							item.info = info
						end
						local quality = ConvertQuality(item)
						if item.info.quality then
							if quality < item.info.quality then
								item.info.quality = quality
							end
						else
							item.info = {quality = quality}
						end
					else
						if item.info then
							item.info.quality = 100
						else
							local info = {quality = 100}
							item.info = info
						end
					end
				end
			end
			Stashes[uniqueId].items = other.inventory
			TriggerClientEvent("inventory:client:UpdateOtherInventory", Player.PlayerData.source, other.inventory, false)
		end
    end
    Player.Functions.SetInventory(inventory)
    TriggerClientEvent("inventory:client:UpdatePlayerInventory", Player.PlayerData.source, false)
    data.inventory = inventory
    data.other = other
    cb(data)
end)

-- Warning Messages

RegisterNetEvent('inventory:server:addTrunkItems', function()
	print('inventory:server:addTrunkItems has been deprecated please use exports[\'qb-inventory\']:addTrunkItems(plate, items)')
end)
RegisterNetEvent('inventory:server:addGloveboxItems', function()
	print('inventory:server:addGloveboxItems has been deprecated please use exports[\'qb-inventory\']:addGloveboxItems(plate, items)')
end)



