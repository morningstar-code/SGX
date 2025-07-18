local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('QBCore:Client:UpdateObject', function() QBCore = exports['qb-core']:GetCoreObject() end)

PlayerJob = {}
PlayerGang = {}

local onDuty = false
local BankPed = nil
local Targets = {}
local Till = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function() QBCore.Functions.GetPlayerData(function(PlayerData) PlayerJob = PlayerData.job PlayerGang = PlayerData.gang end) end)
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo) PlayerJob = JobInfo onDuty = PlayerJob.onduty end)
RegisterNetEvent('QBCore:Client:SetDuty', function(duty) onDuty = duty end)
RegisterNetEvent('QBCore:Client:OnGangUpdate', function(GangInfo) PlayerGang = GangInfo end)

--Keeps track of duty on script restarts
AddEventHandler('onResourceStart', function(resource) if GetCurrentResourceName() ~= resource then return end
	QBCore.Functions.GetPlayerData(function(PlayerData)
		PlayerJob = PlayerData.job
		PlayerGang = PlayerData.gang
		onDuty = PlayerJob.onduty
	end)
end)

CreateThread(function()
	local jobroles = {} local gangroles = {}
	--Build Job/Gang Checks for cashin location
	for k, v in pairs(Config.Jobs) do if v.gang then gangroles[tostring(k)] = 0 else jobroles[tostring(k)] = 0 end end
	--Create Target at location
	Targets["JimBank"] =
	exports['qb-target']:AddCircleZone("JimBank", vector3(Config.CashInLocation.x, Config.CashInLocation.y, Config.CashInLocation.z), 2.0, { name="JimBank", debugPoly=Config.Debug, useZ=true, },
		{ options = {
			{ event = "sgx-payments:Tickets:Menu", icon = "fas fa-receipt", label = Loc[Config.Lan].target["cashin_boss"], job = jobroles, },
			{ event = "sgx-payments:Tickets:Menu", icon = "fas fa-receipt", label = Loc[Config.Lan].target["cashin_gang"], gang = gangroles, } },
		distance = 2.0 })
	--Crete Ped at the location
	if Config.Peds then
		if not Config.Gabz then CreateModelHide(vector3(Config.CashInLocation.x, Config.CashInLocation.y, Config.CashInLocation.z), 1.0, `v_corp_bk_chair3`, true) end
		BankPed = makePed(Config.PedPool[math.random(1, #Config.PedPool)], Config.CashInLocation, false, false)
	end

	--Spawn Custom Cash Register Targets
	for k, v in pairs(Config.CustomCashRegisters) do
		for i = 1, #v do
			local job = k
			local gang = nil
			if v[i].gang then job = nil gang = k end
			Targets["CustomRegister: "..k..i] =
			exports['qb-target']:AddBoxZone("CustomRegister: "..k..i, v[i].coords.xyz, 0.47, 0.34, { name="CustomRegister: "..k..i, heading = v[i].coords[4], debugPoly=Config.Debug, minZ=v[i].coords.z-0.1, maxZ=v[i].coords.z+0.4 },
				{ options = { { event = "sgx-payments:client:Charge", icon = "fas fa-credit-card", label = Loc[Config.Lan].target["charge"], job = job, gang = gang, img = "" }, },
					distance = 2.0 })
			if v[i].prop then
				Till[#Till+1] = makeProp({prop = `prop_till_03`, coords = v[i].coords}, 1, false)
			end
		end
	end
end)

RegisterNetEvent('sgx-payments:client:Charge', function(data, outside)
	--Check if player is using /cashregister command
	local dialog
	if not outside and not onDuty and data.gang == nil then triggerNotify(nil, Loc[Config.Lan].error["not_onduty"], "error") return end
	local newinputs = {} -- Begin qb-input creation here.
	if Config.List then -- If nearby player list is wanted:
		--Retrieve a list of nearby players from server
		local p = promise.new() QBCore.Functions.TriggerCallback('sgx-payments:MakePlayerList', function(cb) p:resolve(cb) end)
		local onlineList = Citizen.Await(p)
		local nearbyList = {}
		--Convert list of players nearby into one qb-input understands + add distance info
		for _, v in pairs(QBCore.Functions.GetPlayersFromCoords(GetEntityCoords(PlayerPedId()), Config.PaymentRadius)) do
			local dist = #(GetEntityCoords(GetPlayerPed(v)) - GetEntityCoords(PlayerPedId()))
			for i = 1, #onlineList do
				if onlineList[i].value == GetPlayerServerId(v) then
					if v ~= PlayerId() or Config.Debug then
						nearbyList[#nearbyList+1] = { value = onlineList[i].value, label = onlineList[i].text..' ('..math.floor(dist+0.05)..'m)', text = onlineList[i].text..' ('..math.floor(dist+0.05)..'m)' }
					end
				end
			end
		end
		--If list is empty(no one nearby) show error and stop
		if not nearbyList[1] then triggerNotify(nil, Loc[Config.Lan].error["no_one"], "error") return end
		newinputs[#newinputs+1] = { text = " ", name = "citizen", label = Loc[Config.Lan].menu["cus_id"], type = "select", options = nearbyList }
	else -- If Config.List is false, create input text box for ID's
		if Config.Menu == "qb" then
		newinputs[#newinputs+1] = { type = 'text', isRequired = true, name = 'citizen',  text = Loc[Config.Lan].menu["cus_id"] }
		elseif Config.Menu == "ox" then
		newinputs[#newinputs+1] = {type = 'input', required = true, name = 'citizen', label = Loc[Config.Lan].menu["cus_id"], text = Loc[Config.Lan].menu["cus_id"]}
		end
	end
	--Check if image was given when opening the regsiter
	local img = data.img or ""
	--Continue adding payment options to qb-input
	if Config.Menu == "qb" then
	newinputs[#newinputs+1] = { type = 'radio', name = 'billtype', text = Loc[Config.Lan].menu["type"], options = { { value = "cash", text = Loc[Config.Lan].menu["cash"] }, { value = "bank", text = Loc[Config.Lan].menu["card"] } } }
	elseif Config.Menu == "ox" then
		newinputs[#newinputs+1] = {type = 'select',
		options = {
			{ value = 'bank', label = "Bank" }
		},
		required = true,
		label = "Payment Type"
	}
	end
	if Config.Menu == "qb" then
	newinputs[#newinputs+1] = { type = 'number', isRequired = true, name = 'price', text = Loc[Config.Lan].menu["amount_charge"] }
	elseif Config.Menu == "ox" then
		newinputs[#newinputs+1] = {type = 'number', required = true, label = Loc[Config.Lan].menu["amount_charge"], text = Loc[Config.Lan].menu["amount_charge"] }
	end
	--Grab Player Job name or Gang Name if needed
	local label = PlayerJob.label
	local gang = false
	if data.gang then label = PlayerGang.label gang = true end
	if Config.Menu == "qb" then 
		dialog = exports['qb-input']:ShowInput({ header = img..label..Loc[Config.Lan].menu["cash_reg"], submitText = Loc[Config.Lan].menu["send"], inputs = newinputs})
	elseif Config.Menu == "ox" then
		dialog = exports.ox_lib:inputDialog(label..Loc[Config.Lan].menu["cash_reg"], newinputs)
	end
	if dialog then
        local inputs = {
            citizen = dialog.citizen or dialog[1],
            price = dialog.price or dialog[3],
            billtype = dialog.billtype or dialog[2],
        }
        if not inputs.citizen or not inputs.price then return end
        TriggerServerEvent('sgx-payments:server:Charge', inputs.citizen, inputs.price, inputs.billtype, data.img, outside, gang)
    end
end)

RegisterNetEvent('sgx-payments:client:PolCharge', function()
	--Check if player is allowed to use /cashregister command
	local allowed = false
	for k in pairs(Config.FineJobs) do if k == PlayerJob.name then allowed = true end end
	if not allowed then triggerNotify(nil, Loc[Config.Lan].error["no_job"], "error") return end

	local newinputs = {} -- Begin qb-input creation here.
	if Config.FineJobList then -- If nearby player list is wanted:
		--Retrieve a list of nearby players from server
		local p = promise.new() QBCore.Functions.TriggerCallback('sgx-payments:MakePlayerList', function(cb) p:resolve(cb) end)
		local onlineList = Citizen.Await(p)
		local nearbyList = {}
		--Convert list of players nearby into one qb-input understands + add distance info
		for _, v in pairs(QBCore.Functions.GetPlayersFromCoords(GetEntityCoords(PlayerPedId()), Config.PaymentRadius)) do
			local dist = #(GetEntityCoords(GetPlayerPed(v)) - GetEntityCoords(PlayerPedId()))
			for i = 1, #onlineList do
				if onlineList[i].value == GetPlayerServerId(v) then
					if v ~= PlayerId() or Config.Debug then
						nearbyList[#nearbyList+1] = { value = onlineList[i].value, text = onlineList[i].text..' ('..math.floor(dist+0.05)..'m)', label = onlineList[i].text..' ('..math.floor(dist+0.05)..'m)' }
					end
				end
			end
		end
		--If list is empty(no one nearby) show error and stop
		if not nearbyList[1] then triggerNotify(nil, Loc[Config.Lan].error["no_one"], "error") return end
		newinputs[#newinputs+1] = { text = " ", name = "citizen", type = "select", options = nearbyList }
	else -- If Config.List is false, create input text box for ID's
		newinputs[#newinputs+1] = { type = 'text', isRequired = true, required = true, name = 'citizen', label = Loc[Config.Lan].menu["person_id"], text = Loc[Config.Lan].menu["person_id"] }
	end
	--Continue adding payment options to qb-input
	if Config.Menu == "qb" then
	newinputs[#newinputs+1] = { type = 'number', isRequired = true, name = 'price', text = Loc[Config.Lan].menu["amount_charge"] }
	elseif Config.Menu == "ox" then
		newinputs[#newinputs+1] = {type = 'number', required = true, label = Loc[Config.Lan].menu["amount_charge"], text = Loc[Config.Lan].menu["amount_charge"] }
	end
	--Grab Player Job name or Gang Name if needed
	local label = PlayerJob.label
	local gang = false
	local dialog  
	if Config.Menu == "qb" then
		dialog = exports['qb-input']:ShowInput({ header = label..Loc[Config.Lan].menu["charge"], submitText = Loc[Config.Lan].menu["send"], inputs = newinputs})
	elseif Config.Menu == "ox" then
		dialog = exports.ox_lib:inputDialog(label..Loc[Config.Lan].menu["charge"], newinputs)
	end
	if dialog then
        local inputs = {
            citizen = dialog.citizen or dialog[1],
            price = dialog.price or dialog[2],
        }
        if not inputs.citizen or not inputs.price then return end
		TriggerServerEvent('sgx-payments:server:PolCharge', dialog.citizen, dialog.price)
    end
end)

RegisterNetEvent('sgx-payments:Tickets:Menu', function(data)
	--Get ticket info
	local p = promise.new() QBCore.Functions.TriggerCallback('sgx-payments:Ticket:Count', function(cb) p:resolve(cb) end)
	local amount = Citizen.Await(p)
	if not amount then triggerNotify(nil, Loc[Config.Lan].error["no_ticket"], "error") amount = 0 return else amount = amount.amount end
	local sellable = false
	local name = "" local label = ""
	--Check/adjust for job/gang names
	for k, v in pairs(Config.Jobs) do
		if data.gang then if v.gang and k == PlayerGang.name then name = k label = PlayerGang.label sellable = true end
		else if not v.gang and k == PlayerJob.name then name = k label = PlayerJob.label sellable = true end
	end
			if sellable then -- if info is found then:
				if Config.Menu == "qb" then
				exports['qb-menu']:openMenu({
					{ isMenuHeader = true, header = "🧾 "..label..Loc[Config.Lan].menu["receipt"], txt = Loc[Config.Lan].menu["trade_confirm"] },
					{ isMenuHeader = true, header = "", txt = Loc[Config.Lan].menu["ticket_amount"]..amount..Loc[Config.Lan].menu["total_pay"]..(Config.Jobs[name].PayPerTicket * amount) },
					{ icon = "fas fa-circle-check", header = Loc[Config.Lan].menu["yes"], txt = "", params = { event = "sgx-payments:Tickets:Sell:yes" } },
					{ icon = "fas fa-circle-xmark", header = Loc[Config.Lan].menu["no"], txt = "", params = { event = "sgx-payments:Tickets:Sell:no" } },
				})
			elseif Config.Menu == "ox" then
				lib.registerContext({
					id = 'ticketmenu',
					title = "🧾 "..label..Loc[Config.Lan].menu["receipt"],
					options = {
						{ readOnly = true, title = "🧾 "..label..Loc[Config.Lan].menu["receipt"], description = Loc[Config.Lan].menu["trade_confirm"] },
						{ readOnly = true, title = Loc[Config.Lan].menu["ticket_amount"]..amount..Loc[Config.Lan].menu["total_pay"]..(Config.Jobs[name].PayPerTicket * amount), description = "", txt = Loc[Config.Lan].menu["ticket_amount"]..amount..Loc[Config.Lan].menu["total_pay"]..(Config.Jobs[name].PayPerTicket * amount) },
						{ icon = "fas fa-circle-check", title = Loc[Config.Lan].menu["yes"], description = "",  event = "sgx-payments:Tickets:Sell:yes"  },
						{ icon = "fas fa-circle-xmark", title = Loc[Config.Lan].menu["no"], description = "",  event = "sgx-payments:Tickets:Sell:no"  },
					}
				})
				lib.showContext('ticketmenu')
			end
		end
	end
end)

RegisterNetEvent("sgx-payments:client:PayPopup", function(amount, biller, billtype, img, billerjob, gang, outside)
	local img = img or ""
	if Config.Menu == "qb" then
	exports['qb-menu']:openMenu({
		{ isMenuHeader = true, header = img.."🧾 "..billerjob..Loc[Config.Lan].menu["payment"], txt = Loc[Config.Lan].menu["accept_payment"] },
		{ isMenuHeader = true, header = "", txt = billtype:gsub("^%l", string.upper)..Loc[Config.Lan].menu["payment_amount"]..amount },
		{ icon = "fas fa-circle-check", header = Loc[Config.Lan].menu["yes"], txt = "", params = { isServer = true, event = "sgx-payments:server:PayPopup", args = { accept = true, amount = amount, biller = biller, billtype = billtype, gang = gang, outside = outside } } },
		{ icon = "fas fa-circle-xmark", header = Loc[Config.Lan].menu["no"], txt = "", params = { isServer = true, event = "sgx-payments:server:PayPopup", args = { accept = false, amount = amount, biller = biller, billtype = billtype, outside = outside } } }, })
	else
		lib.registerContext({
			id = 'paypopup',
			title = "🧾 "..billerjob..Loc[Config.Lan].menu["payment"],
			options = {
				{
					title = billtype:gsub("^%l", string.upper)..Loc[Config.Lan].menu["payment_amount"]..amount,
					icon = 'fas fa-money',
					readOnly = true,
				},
				{
					title = Loc[Config.Lan].menu["yes"],
					icon = "fas fa-circle-check",
					serverEvent = "sgx-payments:server:PayPopup",
					args = { 
						accept = true, 
						amount = amount, 
						biller = biller, 
						billtype = billtype, 
						gang = gang, 
						outside = outside 
					}
				},
				{
					title = Loc[Config.Lan].menu["no"],
					icon = "fas fa-circle-xmark",
					serverEvent = "sgx-payments:server:PayPopup",
					args = {
						accept = false,
						amount = amount,
						biller = biller,
						billtype = billtype,
						outside = outside
					}
				}
			}
		})
		lib.showContext('paypopup')
	end
end)

RegisterNetEvent("sgx-payments:client:PolPopup", function(amount, biller, billerjob)
	if Config.Menu == "qb" then
	exports['qb-menu']:openMenu({
		{ isMenuHeader = true, header = "🧾 "..billerjob..Loc[Config.Lan].menu["payment"], txt = Loc[Config.Lan].menu["accept_charge"] },
		{ isMenuHeader = true, header = "", txt = Loc[Config.Lan].menu["bank_charge"]..amount },
		{ icon = "fas fa-circle-check", header = Loc[Config.Lan].menu["yes"], txt = "", params = { isServer = true, event = "sgx-payments:server:PolPopup", args = { accept = true, amount = amount, biller = biller } } },
		{ icon = "fas fa-circle-xmark", header = Loc[Config.Lan].menu["no"], txt = "", params = { isServer = true, event = "sgx-payments:server:PolPopup", args = { accept = false, amount = amount, biller = biller } } }, })
	else
		lib.registerContext({
			id = 'polpopup',
			title = "🧾 "..billerjob..Loc[Config.Lan].menu["payment"],
			options = {
				{readOnly = true, title = "🧾 "..billerjob..Loc[Config.Lan].menu["payment"], description = Loc[Config.Lan].menu["accept_charge"] },
				{ readOnly = true, title = "", description = Loc[Config.Lan].menu["bank_charge"]..amount },
				{ icon = "fas fa-circle-check", title = Loc[Config.Lan].menu["yes"], description = "",  serverEvent = "sgx-payments:server:PolPopup", args = { accept = true, amount = amount, biller = biller  } },
				{ icon = "fas fa-circle-xmark", title = Loc[Config.Lan].menu["no"], description = "",  serverEvent = "sgx-payments:server:PolPopup", args = { accept = false, amount = amount, biller = biller  } }, 
			}
		})
		lib.showContext('polpopup')
	end
end)

RegisterNetEvent('sgx-payments:Tickets:Sell:yes', function() TriggerServerEvent('sgx-payments:Tickets:Sell') end)
RegisterNetEvent('sgx-payments:Tickets:Sell:no', function() exports['qb-menu']:closeMenu() end)

AddEventHandler('onResourceStop', function(r) if r ~= GetCurrentResourceName() then return end
	for k in pairs(Targets) do exports['qb-target']:RemoveZone(k) end
	for i = 1, #Till do DeleteEntity(Till[i]) end
	unloadModel(GetEntityModel(BankPed)) DeletePed(BankPed)
end)
