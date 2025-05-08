local QBCore = exports['qb-core']:GetCoreObject()

PlayerJob = {}
local onDuty = false
local alcoholCount = 0
local function installCheck()
	local items = { "ambeer", "dusche", "logger", "pisswasser", "pisswasser2", "pisswasser3", "sprunk", "ecola", "ecolalight", "amarone", "barbera", "dolceto",
	"housered",	"housewhite", "rosso", "tiramisu", "gelato", "medfruits", "bolognese", "calamari", "meatball", "alla", "pescatore", "capricciosa",
	"diavola", "marinara", "margherita", "prosciuttio", "vegetariana", "capricciosabox", "diavolabox", "marinarabox", "margheritabox", "prosciuttiobox",
	"vegetarianabox", "pizzabase", "pizzadough", "mozz", "sauce", "salami", "ham", "squid", "pizzmushrooms", "olives", "basil", "meat", "pasta", "lettuce" }
	for k, v in pairs(items) do if QBCore.Shared.Items[v] == nil then print("Missing Item from QBCore.Shared.Items: '"..v.."'") end end
	if QBCore.Shared.Jobs["pizzathis"] == nil then print("Error: Job role not found - 'pizzathis'") end
	if Config.Debug then print((#Config.Chairs).." Total seating locations") end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
		installCheck()
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then if PlayerData.job.name == "pizzathis" then TriggerServerEvent("QBCore:ToggleDuty") end end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate') AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo) PlayerJob = JobInfo onDuty = PlayerJob.onduty end) 
RegisterNetEvent('QBCore:Client:SetDuty') AddEventHandler('QBCore:Client:SetDuty', function(duty) onDuty = duty end)

AddEventHandler('onResourceStart', function(resource)
	installCheck()
    if GetCurrentResourceName() == resource then
		QBCore.Functions.GetPlayerData(function(PlayerData)
			PlayerJob = PlayerData.job
			if PlayerData.job.name == "pizzathis" then onDuty = PlayerJob.onduty end 
		end)
    end
end)

local function jobCheck()
	canDo = true
	if not onDuty then TriggerEvent('QBCore:Notify', "Not clocked in!", 'error') canDo = false end
	return canDo
end

CreateThread(function()
	local bossroles = {}
	for k, v in pairs(QBCore.Shared.Jobs["pizzathis"].grades) do
		if QBCore.Shared.Jobs["pizzathis"].grades[k].isboss == true then
			if bossroles["pizzathis"] ~= nil then
				if bossroles["pizzathis"] > tonumber(k) then bossroles["pizzathis"] = tonumber(k) end
			else bossroles["pizzathis"] = tonumber(k)	end
		end
	end
	for k, v in pairs(Config.Locations) do
		if Config.Locations[k].zoneEnable then
			JobLocation = PolyZone:Create(Config.Locations[k].zones, { name = Config.Locations[k].label, debugPoly = Config.Debug })
			JobLocation:onPlayerInOut(function(isPointInside) if not isPointInside and onDuty and PlayerJob.name == "pizzathis" then TriggerServerEvent("QBCore:ToggleDuty") end end)	
		end
	end
	for k, v in pairs(Config.Locations) do
		if Config.Locations[k].zoneEnable then
			blip = AddBlipForCoord(Config.Locations[k].blip)	
			SetBlipAsShortRange(blip, true)
			SetBlipSprite(blip, 570)
			SetBlipColour(blip, Config.Locations[k].blipcolor)
			SetBlipScale(blip, 0.6)
			SetBlipDisplay(blip, 6)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString("Pizza This")
			EndTextCommandSetBlipName(blip)
		end
	end
------------------------------	
	exports['qb-target']:AddBoxZone("PizzBase", vector3(-579.7, -891.28, 25.67), 0.4, 0.4, { name="PizzBase", heading = 0.0, debugPoly=Config.Debug, minZ = 24.58, maxZ = 27.18, }, 
		{ options = { {  event = "qb-pizzathis:Menu:PizzaBase:Check", icon = "fas fa-pizza-slice", label = "Prepare Pizza", job = "pizzathis" }, }, distance = 1.0 })
		
	exports['qb-target']:AddBoxZone("PizzDough", vector3(-583.99, -893.62, 25.45), 1.2, 3.2, { name="PizzDough", heading = 0.0, debugPoly=Config.Debug, minZ = 25.00, maxZ = 27.58, }, 
		{ options = { {  event = "qb-pizzathis:JustGive", icon = "fas fa-cookie", label = "Prepare Dough", job = "pizzathis", id = "pizzadough" }, }, distance = 1.0 })	
		
	exports['qb-target']:AddBoxZone("PizzOven", vector3(-582.7586, -897.9107, 25.648233), 2.8, 0.7, { name="PizzOven", heading = 0.0, debugPoly=Config.Debug, minZ = 25.00, maxZ = 27.38, }, 
		{ options = { {  event = "qb-pizzathis:Menu:Oven:Check", icon = "fas fa-temperature-high", label = "Use Oven", job = "pizzathis" }, }, distance = 1.0 })
		
	exports['qb-target']:AddBoxZone("PizzChop", vector3(-580.72, -901.91, 25.68), 0.6, 0.6, { name="PizzChop", heading = 0.0, debugPoly=Config.Debug, minZ = 25.18, maxZ = 27.38, }, 
		{ options = { {  event = "qb-pizzathis:Menu:ChoppingBoard:Check", icon = "fas fa-utensils", label = "Use Chopping Board", job = "pizzathis" }, }, distance = 1.0 })
	
	exports['qb-target']:AddBoxZone("PizzBurner", vector3(-576.8987, -889.6307, 25.842315), 2.4, 1.2, { name="PizzBurner", heading = 0.0, debugPoly=Config.Debug, minZ = 25.00, maxZ = 27.98, }, 
		{ options = { {  event = "qb-pizzathis:Menu:PizzaOven:Check", icon = "fas fa-temperature-high", label = "Use Stone Oven", job = "pizzathis" }, }, distance = 1.0 })

	exports['qb-target']:AddBoxZone("PizzWine", vector3(-581.6409, -898.3499, 21.102369), 0.4, 1.7, { name="PizzWine", heading = 0.0, debugPoly=Config.Debug, minZ = 20.3, maxZ = 22.9, }, 
		{ options = { {  event = "qb-pizzathis:Menu:Wine", icon = "fas fa-wine-bottle	", label = "Open Wine Rack", job = "pizzathis" }, }, distance = 1.0 })	
	exports['qb-target']:AddBoxZone("PizzWine2", vector3(-584.0015, -898.5402, 20.979867), 0.4, 1.7, { name="PizzWine", heading = 0.0, debugPoly=Config.Debug, minZ = 20.3, maxZ = 22.9, }, 
		{ options = { {  event = "qb-pizzathis:Menu:Wine", icon = "fas fa-wine-bottle", label = "Open Wine Rack", job = "pizzathis" }, }, distance = 1.0 })
	
	exports['qb-target']:AddBoxZone("PizzFridge", vector3(-577.1388, -886.7847, 25.526424), 0.6, 0.6, { name="PizzFridge", heading = 0.0, debugPoly=Config.Debug, minZ=25.00, maxZ=26.83 }, 
		{ options = { {  event = "qb-pizzathis:Shop", icon = "fas fa-archive", label = "Open Drink Fridge", shop = 1, job = "pizzathis" }, }, distance = 1.5 })	
	exports['qb-target']:AddBoxZone("PizzFridge3", vector3(-585.3997, -898.4534, 25.614009), 1.6, 0.6, { name="PizzFridge3", heading = 0.0, debugPoly=Config.Debug, minZ = 25.00, maxZ = 28.18, }, 
		{ options = { {  event = "qb-pizzathis:Shop", icon = "fas fa-temperature-low", label = "Open Food Fridge", shop = 2, job = "pizzathis" }, }, distance = 2.0 })	
	exports['qb-target']:AddBoxZone("PizzFreezer", vector3(-588.3927, -893.4234, 25.65385), 0.6, 4.0, { name="PizzFreezer", heading = 0.0, debugPoly=Config.Debug, minZ = 24.78, maxZ = 28.58, }, 
		{ options = { {  event = "qb-pizzathis:Shop", icon = "fas fa-temperature-low", label = "Open Freezer", shop = 3, job = "pizzathis" }, }, distance = 1.0 })
		
	exports['qb-target']:AddBoxZone("PizzWash1", vector3(-577.7246, -892.118, 25.466928), 0.6, 0.8, { name="PizzWash1", heading = 0.0, debugPoly=Config.Debug, minZ = 24.58, maxZ = 27.38, }, 
		{ options = { { event = "qb-pizzathis:washHands", icon = "fas fa-hand-holding-water", label = "Wash Your Hands", }, }, distance = 1.5 })		
	exports['qb-target']:AddBoxZone("PizzWash2", vector3(-581.7429, -901.871, 25.464771), 0.8, 0.6, { name="PizzWash2", heading = 0.0, debugPoly=Config.Debug, minZ = 24.58, maxZ = 27.38, }, 
		{ options = { { event = "qb-pizzathis:washHands", icon = "fas fa-hand-holding-water", label = "Wash Your Hands" }, }, distance = 1.5 })		
		
	exports['qb-target']:AddBoxZone("PizzReceipt", vector3(-579.86, -887.33, 25.68), 0.7, 0.35, { name="PizzReceipt", heading = 0.0, debugPoly=Config.Debug, minZ = 16.78, maxZ = 27.18, }, 
		{ options = { { event = "sgx-payments:client:Charge", icon = "fas fa-credit-card", label = "Charge Customer", job = "pizzathis",
						img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/5/59/PizzaThis.png width=200px></p>",
		} }, distance = 2.0 })		
	exports['qb-target']:AddBoxZone("PizzReceipt2", vector3(-579.86, -888.65, 25.68), 0.7, 0.35, { name="PizzReceipt2", heading = 0.0, debugPoly=Config.Debug, minZ = 16.78, maxZ = 27.18, }, 
		{ options = { { event = "sgx-payments:client:Charge", icon = "fas fa-credit-card", label = "Charge Customer", job = "pizzathis",
						img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/5/59/PizzaThis.png width=200px></p>",
		} }, distance = 2.0	})		

	exports['qb-target']:AddBoxZone("PizzTap", vector3(0, 0, 0), 0.9, 0.6, { name="PizzTap", heading = 0.0, debugPoly=Config.Debug, minZ = 26.78, maxZ = 27.48, }, 
		{ options = { { event = "qb-pizzathis:Menu:Beer", icon = "fas fa-beer", label = "Pour Beer", job = "pizzathis" }, }, distance = 1.5 })
		
	exports['qb-target']:AddBoxZone("PizzCoffee", vector3(-582.46, -902.17, 25.87), 0.6, 0.6, { name="PizzCoffee", heading = 0.0, debugPoly=Config.Debug, minZ = 25.60, maxZ = 27.58, }, 
		{ options = { { event = "qb-pizzathis:JustGive", icon = "fas fa-mug-hot", label = "Pour Coffee", job = "pizzathis", id = "coffee"}, }, distance = 2.0 })				
	exports['qb-target']:AddBoxZone("PizzCoffee2", vector3(-579.69, -901.12, 25.86), 1.6, 0.63, { name="PizzCoffee2", heading = 0.0, debugPoly=Config.Debug, minZ = 25.58, maxZ = 27.58, }, 
		{ options = { { event = "qb-pizzathis:JustGive", icon = "fas fa-mug-hot", label = "Pour Coffee", job = "pizzathis", id = "coffee"}, }, distance = 2.0 })
		
	exports['qb-target']:AddBoxZone("PizzClockin", vector3(-586.6166, -897.2617, 29.949815), 1.2, 0.2, { name="PizzClockin", heading = 0.0, debugPoly=Config.Debug, minZ = 29.27, maxZ = 32.52, }, 
		{ options = { { type = "server", event = "QBCore:ToggleDuty", icon = "fas fa-user-check", label = "Toggle Duty", job = "pizzathis" }, }, distance = 2.0 })				

	exports['qb-target']:AddBoxZone("PizzTable", vector3(0, 0, 0), 1.0, 1.0, { name="PizzTable", heading = 0.0, debugPoly=Config.Debug, minZ=25.98, maxZ=27.18 }, 
		{ options = { { event = "qb-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table1" }, }, distance = 2.0 })	
	exports['qb-target']:AddBoxZone("PizzTable2", vector3(0, 0, 0), 1.0, 1.0, { name="PizzTable2", heading = 0.0, debugPoly=Config.Debug, minZ=25.98, maxZ=27.18 }, 
		{ options = { { event = "qb-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table2" }, }, distance = 2.0 })	
	exports['qb-target']:AddBoxZone("PizzTable3", vector3(0, 0, 0), 1.0, 1.0, { name="PizzTable3", heading = 0.0, debugPoly=Config.Debug, minZ=25.98, maxZ=27.18 }, 
		{ options = { { event = "qb-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table3" }, }, distance = 2.0 })	
	exports['qb-target']:AddBoxZone("PizzTable4", vector3(0, 0, 0), 1.0, 1.0, { name="PizzTable4", heading = 0.0, debugPoly=Config.Debug, minZ=25.98, maxZ=27.18 }, 
		{ options = { { event = "qb-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table4" }, }, distance = 2.0 })	
	exports['qb-target']:AddBoxZone("PizzTable5", vector3(0, 0, 0), 1.0, 1.0, { name="PizzTable5", heading = 0.0, debugPoly=Config.Debug, minZ=25.98, maxZ=27.18 }, 
		{ options = { { event = "qb-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table5" }, }, distance = 2.0 })	
	exports['qb-target']:AddBoxZone("PizzTable6", vector3(0, 0, 0), 1.0, 1.0, { name="PizzTable6", heading = 0.0, debugPoly=Config.Debug, minZ=25.98, maxZ=27.18 }, 
		{ options = { { event = "qb-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table6" }, }, distance = 2.0 })	
	exports['qb-target']:AddBoxZone("PizzTable7", vector3(0, 0, 0), 2.0, 0.8, { name="PizzTable7", heading = 0.0, debugPoly=Config.Debug, minZ=26.18, maxZ=26.98 }, 
		{ options = { { event = "qb-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table7" }, }, distance = 2.0 })	
	exports['qb-target']:AddBoxZone("PizzTable8", vector3(0, 0, 0), 2.0, 0.8, { name="PizzTable8", heading = 0.0, debugPoly=Config.Debug, minZ=26.18, maxZ=26.98 }, 
		{ options = { { event = "qb-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table8" }, }, distance = 2.0 })	
	exports['qb-target']:AddBoxZone("PizzTable9", vector3(0, 0, 0), 2.0, 0.8, { name="PizzTable9", heading = 0.0, debugPoly=Config.Debug, minZ=26.18, maxZ=26.98 }, 
		{ options = { { event = "qb-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table9" }, }, distance = 2.0 })	
	exports['qb-target']:AddBoxZone("PizzTable10", vector3(0, 0, 0), 2.0, 0.8, { name="PizzTable10", heading = 0.0, debugPoly=Config.Debug, minZ=26.18, maxZ=26.98 }, 
		{ options = { { event = "qb-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table10" }, }, distance = 2.0 })	
	exports['qb-target']:AddBoxZone("PizzTable11", vector3(0, 0, 0), 0.8, 1.4, { name="PizzTable11", heading = 0.0, debugPoly=Config.Debug, minZ=26.18, maxZ=26.98 }, 
		{ options = { { event = "qb-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table11" }, }, distance = 2.0 })	
	exports['qb-target']:AddBoxZone("PizzTable12", vector3(0, 0, 0), 0.8, 1.4, { name="PizzTable12", heading = 0.0, debugPoly=Config.Debug, minZ=26.18, maxZ=26.98 }, 
		{ options = { { event = "qb-pizzathis:Stash", icon = "fas fa-hamburger", label = "Open Table", stash = "Table12" }, }, distance = 2.0 })
end)

CreateThread(function()
	-- Quick Prop Changes
	if box == nil then
		RequestModel(604847691)
		while not HasModelLoaded(604847691) do Citizen.Wait(1) end
		local box = CreateObject(604847691,810.94, -749.94, 28.03-1.0,false,false,false)
		SetEntityHeading(box,GetEntityHeading(box)-150)
		FreezeEntityPosition(box, true)
	end
	if box2 == nil then
		RequestModel(-856584171)
		while not HasModelLoaded(-856584171) do Citizen.Wait(1) end
		local box2 = CreateObject(-856584171,810.98, -752.89, 28.03-1.0,false,false,false)
		SetEntityHeading(box2,GetEntityHeading(box2)-80)
		FreezeEntityPosition(box2, true)
	end
	if clockin == nil then
		RequestModel(502084445)
		while not HasModelLoaded(502084445) do Citizen.Wait(1) end
		local clockin = CreateObject(502084445,807.07, -761.83, 31.27,false,false,false)
		SetEntityHeading(clockin,GetEntityHeading(clockin)-270)
		FreezeEntityPosition(clockin, true)
	end
end)

--RegisterNetEvent('qb-pizzathis:toggleDuty', function() onDuty = not onDuty TriggerServerEvent('QBCore:ToggleDuty') end)

RegisterNetEvent('qb-pizzathis:washHands', function()
    QBCore.Functions.Progressbar('washing_hands', 'Washing hands', 5000, false, false, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
	{ animDict = "mp_arresting", anim = "a_uncuff", flags = 8, }, {}, {}, function()
		TriggerEvent('QBCore:Notify', "You've washed your hands!", 'success')
	end, function()
        TriggerEvent('inventory:client:busy:status', false)
		TriggerEvent('QBCore:Notify', "Cancelled", 'error')
    end)
end)

RegisterNetEvent('qb-pizzathis:MakeItem')
AddEventHandler('qb-pizzathis:MakeItem', function(data)
	if not jobCheck() then return else
		--Food
		if data.item == "bolognese" or data.item == "calamari" or data.item == "meatball" or data.item == "alla" or data.item == "pescatore" or data.item == "capricciosabox" or data.item == "diavolabox" or data.item == "marinarabox" or data.item == "margheritabox" or data.item == "prosciuttiobox" or data.item == "vegetarianabox" or data.item == "pizzabase" or data.item == "salami" or data.item == "ham" then
			QBCore.Functions.TriggerCallback('qb-pizzathis:get:'..data.item, function(amount) 
				if not amount then TriggerEvent('QBCore:Notify', "You don't have the correct ingredients", 'error') else FoodProgress(data.item) end		
			end)
		end
	end
end)

RegisterNetEvent('qb-pizzathis:Stash')
AddEventHandler('qb-pizzathis:Stash',function(data)
	id = data.stash
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "pizza_"..id)
    TriggerEvent("inventory:client:SetCurrentStash", "pizza_"..id)
end)

RegisterNetEvent('qb-pizzathis:Shop')
AddEventHandler('qb-pizzathis:Shop',function(data)
	if not jobCheck() then return else
		if data.shop == 1 then
			TriggerServerEvent("inventory:server:OpenInventory", "shop", "pizzathis", Config.DrinkItems)
		elseif data.shop == 2 then
			TriggerServerEvent("inventory:server:OpenInventory", "shop", "pizzathis", Config.FoodItems)		
		elseif data.shop == 3 then
			TriggerServerEvent("inventory:server:OpenInventory", "shop", "pizzathis", Config.FreezerItems)
		end
	end
end)

-- // Functions \\

function FoodProgress(ItemMake)
	if ItemMake == "pizzadough" then
		bartext = "Grabbing "..QBCore.Shared.Items[ItemMake].label
		bartime = 7000
		animDictNow = "anim@heists@prison_heiststation@cop_reactions"
		animNow = "cop_b_idle"	
	elseif ItemMake == "pizzabase" or ItemMake == "ham" or ItemMake == "salami" then
		bartext = "Preparing "..QBCore.Shared.Items[ItemMake].label
		bartime = 7000
		animDictNow = "anim@heists@prison_heiststation@cop_reactions"
		animNow = "cop_b_idle"
	elseif ItemMake == "bolognese" or ItemMake == "calamari" or ItemMake == "meatball" or ItemMake == "alla" or ItemMake == "pescatore" or ItemMake == "capricciosabox" or ItemMake == "diavolabox" or ItemMake == "marinarabox"  or ItemMake == "margheritabox"  or ItemMake == "prosciuttiobox"  or ItemMake == "vegetarianabox" then
		bartext = "Cooking a "..QBCore.Shared.Items[ItemMake].label
		bartime = 5000
        animDictNow = "amb@prop_human_bbq@male@base"
        animNow = "base"
	elseif ItemMake == "ambeer" or ItemMake == "dusche" or ItemMake == "logger" or ItemMake == "pisswasser" or ItemMake == "pisswasser2" or ItemMake == "pisswasser3" or ItemMake == "coffee" then
		bartext = "Pouring "..QBCore.Shared.Items[ItemMake].label
		bartime = 3000
		animDictNow = "mp_ped_interaction"
		animNow = "handshake_guy_a"	
	elseif ItemMake == "amarone" or ItemMake == "barbera" or ItemMake == "dolceto" or ItemMake == "housered" or ItemMake == "housewhite" or ItemMake == "rosso" then
		bartext = "Grabbing "..QBCore.Shared.Items[ItemMake].label
		bartime = 3000
		animDictNow = "mp_ped_interaction"
		animNow = "handshake_guy_a"
	end
	QBCore.Functions.Progressbar('making_food', bartext, bartime, false, false, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, }, 
	{ animDict = animDictNow, anim = animNow, flags = 8, },	{}, {}, function()  
		TriggerServerEvent('qb-pizzathis:GetFood', ItemMake)
		StopAnimTask(GetPlayerPed(-1), animDictNow, animNow, 1.0)
	end, function() -- Cancel
		TriggerEvent('inventory:client:busy:status', false)
		TriggerEvent('QBCore:Notify', "Cancelled!", 'error')
	end)
end

-- // Utilities \\ 
RegisterNetEvent('qb-pizzathis:Menu:Oven:Check', function()
	if not jobCheck() then return end
	QBCore.Functions.TriggerCallback('qb-pizzathis:get:bolognese', function(amount) if amount 		then bolognese = "✔" else bolognese = "" end end)
	QBCore.Functions.TriggerCallback('qb-pizzathis:get:calamari', function(amount) if amount 		then calamari = "✔" else calamari = "" end end)
	QBCore.Functions.TriggerCallback('qb-pizzathis:get:meatball', function(amount) if amount 		then meatball = "✔" else meatball = "" end end)
	QBCore.Functions.TriggerCallback('qb-pizzathis:get:alla', function(amount) if amount 			then alla = "✔" else alla = "" end end)
	QBCore.Functions.TriggerCallback('qb-pizzathis:get:pescatore', function(amount) if amount 		then pescatore = "✔" else pescatore = "" end end)
	Wait(500)
	TriggerEvent('qb-pizzathis:Menu:Oven')
end)
RegisterNetEvent('qb-pizzathis:Menu:Oven', function()
    exports['qb-menu']:openMenu({
		{ header = "Oven Menu", isMenuHeader = true },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["bolognese"].image.." width=35px> "..QBCore.Shared.Items["bolognese"].label.." "..bolognese, txt = "- "..QBCore.Shared.Items["meat"].label.."<br>- "..QBCore.Shared.Items["sauce"].label, params = { event = "qb-pizzathis:MakeItem", args = { item = 'bolognese' } } },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["calamari"].image.." width=35px> "..QBCore.Shared.Items["calamari"].label.." "..calamari, txt = "- "..QBCore.Shared.Items["squid"].label.."<br>- "..QBCore.Shared.Items["sauce"].label.."<br>- "..QBCore.Shared.Items["pasta"].label, params = { event = "qb-pizzathis:MakeItem", args = { item = 'calamari' } } },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["meatball"].image.." width=35px> "..QBCore.Shared.Items["meatball"].label.." "..meatball, txt = "- "..QBCore.Shared.Items["meat"].label.."<br>- "..QBCore.Shared.Items["pasta"].label, params = { event = "qb-pizzathis:MakeItem", args = { item = 'meatball' } } },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["alla"].image.." width=35px> "..QBCore.Shared.Items["alla"].label.." "..alla, txt = "- "..QBCore.Shared.Items["ham"].label.."<br>- "..QBCore.Shared.Items["pasta"].label.."<br>- "..QBCore.Shared.Items["vodka"].label, params = { event = "qb-pizzathis:MakeItem", args = { item = 'alla' } } },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["pescatore"].image.." width=35px> "..QBCore.Shared.Items["pescatore"].label.." "..pescatore, txt = "- "..QBCore.Shared.Items["squid"].label, params = { event = "qb-pizzathis:MakeItem", args = { item = 'pescatore' } } },
    })
end)

RegisterNetEvent('qb-pizzathis:Menu:PizzaBase:Check', function()
	if not jobCheck() then return end
	QBCore.Functions.TriggerCallback('qb-pizzathis:get:pizzabase', function(amount) if amount 		then pizzabase = "✔" else pizzabase = "" end end)
	Wait(500)
	TriggerEvent('qb-pizzathis:Menu:PizzaBase')
end)
RegisterNetEvent('qb-pizzathis:Menu:PizzaBase', function()
    exports['qb-menu']:openMenu({
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["pizzabase"].image.." width=35px> "..QBCore.Shared.Items["pizzabase"].label..' '..pizzabase, txt = "- "..QBCore.Shared.Items["pizzadough"].label.."<br>- "..QBCore.Shared.Items["sauce"].label, params = { event = "qb-pizzathis:MakeItem", args = { item = 'pizzabase' } } },
    })
end)

RegisterNetEvent('qb-pizzathis:Menu:PizzaOven:Check', function()
	if not jobCheck() then return end
	QBCore.Functions.TriggerCallback('qb-pizzathis:get:margheritabox', function(amount) if amount 		then margherita = "✔" else margherita = "" end end)
	QBCore.Functions.TriggerCallback('qb-pizzathis:get:marinarabox', function(amount) if amount 		then marinara = "✔" else marinara = "" end end)
	QBCore.Functions.TriggerCallback('qb-pizzathis:get:prosciuttiobox', function(amount) if amount 	then prosciuttio = "✔" else prosciuttio = "" end end)
	QBCore.Functions.TriggerCallback('qb-pizzathis:get:diavolabox', function(amount) if amount 		then diavola = "✔" else diavola = "" end end)
	QBCore.Functions.TriggerCallback('qb-pizzathis:get:capricciosabox', function(amount) if amount 	then capricciosa = "✔" else capricciosa = "" end end)
	QBCore.Functions.TriggerCallback('qb-pizzathis:get:vegetarianabox', function(amount) if amount 	then vegetariana = "✔" else vegetariana = "" end end)
	Wait(500)
	TriggerEvent('qb-pizzathis:Menu:PizzaOven')
end)
RegisterNetEvent('qb-pizzathis:Menu:PizzaOven', function()
    exports['qb-menu']:openMenu({
		{ header = "Pizza Menu", isMenuHeader = true },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["margherita"].image.." width=35px> "..QBCore.Shared.Items["margherita"].label.." "..margherita, txt = "- "..QBCore.Shared.Items["pizzabase"].label.."<br>- "..QBCore.Shared.Items["mozz"].label, params = { event = "qb-pizzathis:MakeItem", args = { item = 'margheritabox' } } },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["marinara"].image.." width=35px> "..QBCore.Shared.Items["marinara"].label.." "..marinara, txt = "- "..QBCore.Shared.Items["pizzabase"].label.."<br>- "..QBCore.Shared.Items["basil"].label, params = { event = "qb-pizzathis:MakeItem", args = { item = 'marinarabox' } } },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["prosciuttio"].image.." width=35px> "..QBCore.Shared.Items["prosciuttio"].label.." "..prosciuttio, txt = "- "..QBCore.Shared.Items["pizzabase"].label.."<br>- "..QBCore.Shared.Items["mozz"].label.."<br>- "..QBCore.Shared.Items["ham"].label.."<br> - "..QBCore.Shared.Items["pizzmushrooms"].label, params = { event = "qb-pizzathis:MakeItem", args = { item = 'prosciuttiobox' } } },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["diavola"].image.." width=35px> "..QBCore.Shared.Items["diavola"].label.." "..diavola, txt = "- "..QBCore.Shared.Items["pizzabase"].label.."<br>- "..QBCore.Shared.Items["mozz"].label.."<br>- "..QBCore.Shared.Items["salami"].label.."<br> - "..QBCore.Shared.Items["basil"].label, params = { event = "qb-pizzathis:MakeItem", args = { item = 'diavolabox' } } },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["capricciosa"].image.." width=35px> "..QBCore.Shared.Items["capricciosa"].label.." "..capricciosa, txt = "- "..QBCore.Shared.Items["pizzabase"].label.."<br>- "..QBCore.Shared.Items["ham"].label.."<br>- "..QBCore.Shared.Items["pizzmushrooms"].label.."<br> - "..QBCore.Shared.Items["olives"].label, params = { event = "qb-pizzathis:MakeItem", args = { item = 'capricciosabox' } } },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["vegetariana"].image.." width=35px> "..QBCore.Shared.Items["vegetariana"].label.." "..vegetariana, txt = "- "..QBCore.Shared.Items["pizzabase"].label.."<br>- "..QBCore.Shared.Items["mozz"].label.."<br>- "..QBCore.Shared.Items["lettuce"].label.."<br> - "..QBCore.Shared.Items["basil"].label, params = { event = "qb-pizzathis:MakeItem", args = { item = 'vegetarianabox' } } },
    })
end)
RegisterNetEvent('qb-pizzathis:Menu:Beer', function()
	if not jobCheck() then return end
    exports['qb-menu']:openMenu({
		{ header = "Beer Menu", isMenuHeader = true },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["ambeer"].image.." width=35px> "..QBCore.Shared.Items["ambeer"].label, params = { event = "qb-pizzathis:JustGive", args = { id = 'ambeer' } } },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["dusche"].image.." width=35px> "..QBCore.Shared.Items["dusche"].label, params = { event = "qb-pizzathis:JustGive", args = { id = 'dusche' } } },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["logger"].image.." width=35px> "..QBCore.Shared.Items["logger"].label, params = { event = "qb-pizzathis:JustGive", args = { id = 'logger' } } },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["pisswasser"].image.." width=35px> "..QBCore.Shared.Items["pisswasser"].label,  params = { event = "qb-pizzathis:JustGive", args = { id = 'pisswasser' } } },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["pisswasser2"].image.." width=35px> "..QBCore.Shared.Items["pisswasser2"].label, params = { event = "qb-pizzathis:JustGive", args = { id = 'pisswasser2' } } },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["pisswasser3"].image.." width=35px> "..QBCore.Shared.Items["pisswasser3"].label, params = { event = "qb-pizzathis:JustGive", args = { id = 'pisswasser3' } } },
    })
end)
RegisterNetEvent('qb-pizzathis:Menu:Wine', function()
	if not jobCheck() then return end
    exports['qb-menu']:openMenu({
		{ header = "Wine Cellar", isMenuHeader = true },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["amarone"].image.." width=35px> "..QBCore.Shared.Items["amarone"].label, params = { event = "qb-pizzathis:JustGive", args = { id = 'amarone' } } },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["barbera"].image.." width=35px> "..QBCore.Shared.Items["barbera"].label, params = { event = "qb-pizzathis:JustGive", args = { id = 'barbera' } } },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["dolceto"].image.." width=35px> "..QBCore.Shared.Items["dolceto"].label, params = { event = "qb-pizzathis:JustGive", args = { id = 'dolceto' } } },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["housered"].image.." width=35px> "..QBCore.Shared.Items["housered"].label,  params = { event = "qb-pizzathis:JustGive", args = { id = 'housered' } } },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["housewhite"].image.." width=35px> "..QBCore.Shared.Items["housewhite"].label, params = { event = "qb-pizzathis:JustGive", args = { id = 'housewhite' } } },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["rosso"].image.." width=35px> "..QBCore.Shared.Items["rosso"].label, params = { event = "qb-pizzathis:JustGive", args = { id = 'rosso' } } },
    })
end)
RegisterNetEvent('qb-pizzathis:Menu:ChoppingBoard:Check', function()
	if not jobCheck() then return end
	QBCore.Functions.TriggerCallback('qb-pizzathis:get:salami', function(amount) if amount 	then salami = "✔" else salami = "" end end)
	QBCore.Functions.TriggerCallback('qb-pizzathis:get:ham', function(amount) if amount 		then ham = "✔" else ham = "" end end)
	Wait(500)
	TriggerEvent('qb-pizzathis:Menu:ChoppingBoard')
end)
RegisterNetEvent('qb-pizzathis:Menu:ChoppingBoard', function()
    exports['qb-menu']:openMenu({
		{ header = "Chopping Board", isMenuHeader = true },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["salami"].image.." width=35px> "..QBCore.Shared.Items["salami"].label.." "..salami, txt = "- "..QBCore.Shared.Items["meat"].label, params = { event = "qb-pizzathis:MakeItem", args = { item = 'salami' } } },
        { header = "<img src=nui://"..Config.link..QBCore.Shared.Items["ham"].image.." width=35px> "..QBCore.Shared.Items["ham"].label.." "..ham, txt = "- "..QBCore.Shared.Items["meat"].label, params = { event = "qb-pizzathis:MakeItem", args = { item = 'ham' } } },
    })
end)

RegisterNetEvent('qb-pizzathis:JustGive', function(data) if not jobCheck() then return else FoodProgress(data.id) end end)

RegisterNetEvent('qb-pizzathis:client:Eat', function(itemName)
	if itemName == "capricciosa" or itemName == "diavola" or itemName == "marinara" or itemName == "margherita" or itemName == "prosciuttio" or itemName == "vegetariana" then TriggerEvent('animations:client:EmoteCommandStart', {"pizza"})
	elseif itemName == "tiramisu" or itemName == "gelato" then TriggerEvent('animations:client:EmoteCommandStart', {"bowl"})
	elseif itemName == "medfruits" then TriggerEvent('animations:client:EmoteCommandStart', {"pineapple"})
	elseif itemName == "calamari" or itemName == "bolognese" or itemName == "meatball" or itemName == "alla" or itemName == "pescatore" then TriggerEvent('animations:client:EmoteCommandStart', {"foodbowl"}) end
    QBCore.Functions.Progressbar("eat_something", "Eating "..QBCore.Shared.Items[itemName].label.."..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove", 1)
		TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		if QBCore.Shared.Items[itemName].thirst then TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + QBCore.Shared.Items[itemName].thirst) end
		if QBCore.Shared.Items[itemName].hunger then TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + QBCore.Shared.Items[itemName].hunger) end
        TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
    end)
end)

RegisterNetEvent('qb-pizzathis:client:DrinkAlcohol', function(itemName)
	if itemName == "ambeer" then TriggerEvent('animations:client:EmoteCommandStart', {"beer3"})
	elseif itemName == "dusche" then TriggerEvent('animations:client:EmoteCommandStart', {"beer1"})
	elseif itemName == "logger" then TriggerEvent('animations:client:EmoteCommandStart', {"beer2"})
	elseif itemName == "pisswasser" then TriggerEvent('animations:client:EmoteCommandStart', {"beer4"})
	elseif itemName == "pisswasser2" then TriggerEvent('animations:client:EmoteCommandStart', {"beer5"})
	elseif itemName == "pisswasser3" then TriggerEvent('animations:client:EmoteCommandStart', {"beer6"})
	elseif itemName == "amarone" or itemName == "barbera" or itemName == "housered" or itemName == "rosso" then	TriggerEvent('animations:client:EmoteCommandStart', {"redwine"})
	elseif itemName == "dolceto" or itemName == "housewhite" then TriggerEvent('animations:client:EmoteCommandStart', {"whitewine"})
	else TriggerEvent('animations:client:EmoteCommandStart', {"flute"}) end
    QBCore.Functions.Progressbar("snort_coke", "Drinking "..QBCore.Shared.Items[itemName].label.."..", math.random(3000, 6000), false, true, { disableMovement = false, disableCarMovement = false, disableMouse = false, disableCombat = true, },
		{}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove", 1)
        TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1)
		if QBCore.Shared.Items[itemName].thirst then TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + QBCore.Shared.Items[itemName].thirst) end
		if QBCore.Shared.Items[itemName].hunger then TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + QBCore.Shared.Items[itemName].hunger) end
        alcoholCount = alcoholCount + 1
        if alcoholCount > 1 and alcoholCount < 4 then TriggerEvent("evidence:client:SetStatus", "alcohol", 200)
        elseif alcoholCount >= 4 then TriggerEvent("evidence:client:SetStatus", "heavyalcohol", 200)
			AlienEffect()
        end
        
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify("Cancelled..", "error")
    end)
end)

function AlienEffect()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Wait(math.random(5000, 8000))
    local ped = PlayerPedId()
    RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK") 
    while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
      Citizen.Wait(0)
    end    
    SetPedCanRagdoll( ped, true )
    ShakeGameplayCam('DRUNK_SHAKE', 2.80)
    SetTimecycleModifier("Drunk")
    SetPedMovementClipset(ped, "MOVE_M@DRUNK@VERYDRUNK", true)
    SetPedMotionBlur(ped, true)
    SetPedIsDrunk(ped, true)
    Wait(1500)
    SetPedToRagdoll(ped, 5000, 1000, 1, false, false, false )
    Wait(13500)
    SetPedToRagdoll(ped, 5000, 1000, 1, false, false, false )
    Wait(120500)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(ped, 0)
    SetPedIsDrunk(ped, false)
    SetPedMotionBlur(ped, false)
    AnimpostfxStopAll()
    ShakeGameplayCam('DRUNK_SHAKE', 0.0)
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Wait(math.random(45000, 60000))    
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
end

RegisterNetEvent('qb-pizzathis:client:Drink', function(itemName)
	if itemName == "sprunk" or itemName == "sprunklight" then TriggerEvent('animations:client:EmoteCommandStart', {"sprunk"})
	elseif itemName == "ecola" or itemName == "ecolalight" then TriggerEvent('animations:client:EmoteCommandStart', {"ecola"}) end
    QBCore.Functions.Progressbar("drink_something", "Drinking "..QBCore.Shared.Items[itemName].label.."..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove", 1)
		TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		if QBCore.Shared.Items[itemName].thirst then TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + QBCore.Shared.Items[itemName].thirst) end
		if QBCore.Shared.Items[itemName].hunger then TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + QBCore.Shared.Items[itemName].hunger) end
	end)
end)

AddEventHandler('onResourceStop', function(r)
    if r == GetCurrentResourceName() then
		DeleteEntity(clockin)
		DeleteEntity(box)
		DeleteEntity(box2)
		exports['qb-target']:RemoveZone("PizzTray") 
		exports['qb-target']:RemoveZone("PizzBase") 
		exports['qb-target']:RemoveZone("PizzDough") 
		exports['qb-target']:RemoveZone("PizzOven") 
		exports['qb-target']:RemoveZone("PizzChop") 
		exports['qb-target']:RemoveZone("PizzChop2") 
		exports['qb-target']:RemoveZone("PizzBurner") 
		exports['qb-target']:RemoveZone("PizzWine") 
		exports['qb-target']:RemoveZone("PizzWine2") 
		exports['qb-target']:RemoveZone("PizzFridge") 
		exports['qb-target']:RemoveZone("PizzFridge2") 
		exports['qb-target']:RemoveZone("PizzFridge3") 
		exports['qb-target']:RemoveZone("PizzFreezer") 
		exports['qb-target']:RemoveZone("PizzWash1") 
		exports['qb-target']:RemoveZone("PizzWash2") 
		exports['qb-target']:RemoveZone("PizzWash3") 
		exports['qb-target']:RemoveZone("PizzWash4") 
		exports['qb-target']:RemoveZone("PizzWash5") 
		exports['qb-target']:RemoveZone("PizzWash6") 
		exports['qb-target']:RemoveZone("PizzWash7") 
		exports['qb-target']:RemoveZone("PizzWash8") 
		exports['qb-target']:RemoveZone("PizzWash9") 
		exports['qb-target']:RemoveZone("PizzCounter") 
		exports['qb-target']:RemoveZone("PizzCounter2") 
		exports['qb-target']:RemoveZone("PizzReceipt") 
		exports['qb-target']:RemoveZone("PizzReceipt2") 
		exports['qb-target']:RemoveZone("PizzTap") 
		exports['qb-target']:RemoveZone("PizzCoffee") 
		exports['qb-target']:RemoveZone("PizzCoffee2") 
		exports['qb-target']:RemoveZone("PizzClockin") 
		exports['qb-target']:RemoveZone("PizzClockin2") 
		exports['qb-target']:RemoveZone("PizzTable") 
		exports['qb-target']:RemoveZone("PizzTable2") 
		exports['qb-target']:RemoveZone("PizzTable3") 
		exports['qb-target']:RemoveZone("PizzTable4") 
		exports['qb-target']:RemoveZone("PizzTable5") 
		exports['qb-target']:RemoveZone("PizzTable6") 
		exports['qb-target']:RemoveZone("PizzTable7") 
		exports['qb-target']:RemoveZone("PizzTable8") 
		exports['qb-target']:RemoveZone("PizzTable9") 
		exports['qb-target']:RemoveZone("PizzTable10") 
		exports['qb-target']:RemoveZone("PizzTable11") 
		exports['qb-target']:RemoveZone("PizzTable12")
    end
end)

Citizen.CreateThread(function()
	local radar_property = AddBlipForCoord(-586.71, -887.47, 25.72)
	SetBlipSprite(radar_property, 267)
	SetBlipScale(radar_property, 1.0)
	SetBlipColour(radar_property, 37)
	SetBlipAsShortRange(radar_property, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Maldinis Pizza')
	EndTextCommandSetBlipName(radar_property)
end)