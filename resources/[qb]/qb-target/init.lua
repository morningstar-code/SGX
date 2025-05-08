function Load(name)
	local resourceName = GetCurrentResourceName()
	local chunk = LoadResourceFile(resourceName, ('data/%s.lua'):format(name))
	if chunk then
		local err
		chunk, err = load(chunk, ('@@%s/data/%s.lua'):format(resourceName, name), 't')
		if err then
			error(('\n^1 %s'):format(err), 0)
		end
		return chunk()
	end
end

-------------------------------------------------------------------------------
-- Settings
-------------------------------------------------------------------------------

Config = {
	FrameWork = 'qb', -- ['qb', 'esx']
	MaxDistance = 7.0,
	-- Whether to have the target as a toggle or not
	Toggle = false,
	DrawSprite = true,
	DrawDistance = 200.0,
	-- Enable default options (Toggling vehicle doors)
	EnableDefaultOptions = false,
	-- Disable the target eye whilst being in a vehicle
	DisableInVehicle = false,
	-- Key to open the target eye, here you can find all the names: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
	OpenKey = 'LMENU', -- Left Alt
	-- Control for key press detection on the context menu, it's the Right Mouse Button by default, controls are found here https://docs.fivem.net/docs/game-references/controls/
	MenuControlKey = 237,

	-- These are all empty for you to fill in, refer to the .md files for help in filling these in
	CircleZones = {},

	BoxZones = {},

	PolyZones = {},

	TargetBones = {},

	TargetModels = {	['Atm4'] = {
		models = 506770882,
		options = {
			{
				type = "client",
				event = "sgx-banking:Client:BankMenu:Show",
				icon = "fas fa-money-bill",
				label = "Access ATM",
				entity = entity,
				atm = true
			},
		},

		distance = 2.5
	},
	['Atm3'] = {
		models = -1364697528,
		options = {
			{
				type = "client",
				event = "sgx-banking:Client:BankMenu:Show",
				icon = "fas fa-money-bill",
				label = "Access ATM",
				entity = entity,
				atm = true
			},
		},
	
		distance = 2.5
	},
	['Atm2'] = {
		models = -1126237515,
		options = {
			{
				type = "client",
				event = "sgx-banking:Client:BankMenu:Show",
				icon = "fas fa-money-bill",
				label = "Access ATM",
				entity = entity,
				atm = true
			},
		},
	
		distance = 2.5
	},
	['Atm'] = {
		models = -870868698,
		options = {
			{
				type = "client",
				event = "sgx-banking:Client:BankMenu:Show",
				icon = "fas fa-money-bill",
				label = "Access ATM",
				entity = entity,
				atm = true
			},
		},
	
		distance = 2.5
	},
	['Laptop'] = {
		models = 583241575,
		options = {
			{
				type = "client",
				event = "sgx-laptop:client:openlaptop",
				icon = "fa-solid fa-laptop",
				label = "Use Laptop",
				entity = entity,
			},
		},
	
		distance = 2.5
	},
	['Laptop1'] = {
		models = 1083697584,
		options = {
			{
				type = "client",
				event = "sgx-laptop:client:openlaptop",
				icon = "fa-solid fa-laptop",
				label = "Use Laptop",
				entity = entity,
			},
		},
	
		distance = 2.5
	},
	['Laptop2'] = {
		models = -1113053091,
		options = {
			{
				type = "client",
				event = "sgx-laptop:client:openlaptop",
				icon = "fa-solid fa-laptop",
				label = "Use Laptop",
				entity = 970498,
			},
		},
	
		distance = 2.5
	},
	['Laptop3'] = {
		models = 668041498,
		options = {
			{
				type = "client",
				event = "sgx-laptop:client:openlaptop",
				icon = "fa-solid fa-laptop",
				label = "Use Laptop",
				entity = entity,
			},
		},
	
		distance = 2.5
	},
	['Laptop4'] = {
		models = 1385417869,
		options = {
			{
				type = "client",
				event = "sgx-laptop:client:openlaptop",
				icon = "fa-solid fa-laptop",
				label = "Use Laptop",
				entity = entity,
			},
		},
	
		distance = 2.5
	},
},

	GlobalPedOptions = {},

	GlobalVehicleOptions = {},

	GlobalObjectOptions = {},

	GlobalPlayerOptions = {},

	Peds = {
    {  -------Pacific Bank 04------
    model = `cs_fbisuit_01`,
    coords = vector4(249.25, 224.20, 104.89, 191.45),
    gender = 'male',
    scenario = 'PROP_HUMAN_SEAT_COMPUTER',
    freeze = true,
    invincible = true,
    blockevents = true,
},
    {  -------Pacific Bank 03------
    model = `u_f_m_debbie_01`,
    coords = vector4(246.80, 225.05, 104.79, 136.24),
    gender = 'male',
    scenario = 'PROP_HUMAN_SEAT_COMPUTER',
    freeze = true,
    invincible = true,
    blockevents = true,
},
    {  -------Pacific Bank 02------
    model = `u_m_m_jewelsec_01`,
    coords = vector4(244.20, 225.99, 104.89, 186.35),
    gender = 'male',
    scenario = 'PROP_HUMAN_SEAT_COMPUTER',
    freeze = true,
    invincible = true,
    blockevents = true,
},
    {  -------Pacific Bank 01------
    model = `u_f_y_princess`,
    coords = vector4(241.59, 226.95, 104.79, 138.19),
    scenario = 'PROP_HUMAN_SEAT_COMPUTER',
    freeze = true,
    invincible = true,
    blockevents = true,
},

---------hospital-------------
{
	model = `s_f_y_scrubs_01`,
	coords = vector4(302.76, -591.40, 42.76, 342.1),
	invincible = true,
	freeze = true,
	blockevents = true,
	scenario = 'PROP_HUMAN_SEAT_COMPUTER_LOW',
	minusOne = true,
	target = {
		options = {
			{
				type = "client",
				event = "qb-ambulancejob:checkin",
				icon = "fa-solid fa-check",
				label = "Check In",
			},
		},
		distance = 0.0
	}
},

{
	model = `s_f_y_scrubs_01`,
	coords = vector4(1768.09, 3641.58, 34.85, 158.18),
	invincible = true,
	freeze = true,
	blockevents = true,
	scenario = 'WORLD_HUMAN_PROSTITUTE_HIGH_CLASS',
	minusOne = true,
	target = {
		options = {
			{
				type = "client",
				event = "qb-ambulancejob:checkin",
				icon = "fa-solid fa-check",
				label = "Check In",
			},
		},
		distance = 0.0
	}
},
--granny
{
	model = `a_m_m_eastsa_01`,
	coords = vector4(1215.33, -492.43, 67.16, 153.04),
	invincible = true,
	freeze = true,
	blockevents = true,
	scenario = 'WORLD_HUMAN_LEANING',
	minusOne = true,
	target = {
		options = {
			{
				type = "client",
				event = "qb-ambulancejob:checkin",
				icon = "fa-solid fa-check",
				label = "Grannd Pa!",
			},
		},
		distance = 0.0
	}
},


---------hunter-------------
{
	model = `ig_hunter`,
	coords = vector4(-679.33, 5837.46, 17.33, 237.54),
	invincible = true,
	freeze = true,
	minusOne = true,
	blockevents = true,
	scenario = 'WORLD_HUMAN_GUARD_STAND_CLUBHOUSE',
	target = {
		options = {
        {
            event = "qb-shops:client:hunting",
            icon = "fas fa-shopping-cart",
            label = "Open Shop",
        },
        {
            event = "qb-hunting:payammo",
            icon = "fas fa-circle",
            label = "Purchase Bullets $500",
        },
        {
          event = "qb-hunting:server:sell",
          icon = "fas fa-circle",
          label = "Sell The Meat",
        },
	},
		distance = 2.5
	}
},

{
	model = `a_m_m_soucent_04`,
	coords = vector4(-564.26, 237.39, 74.39, 215.67),
	invincible = true,
	freeze = true,
	minusOne = true,
	blockevents = true,
	scenario = 'PROP_HUMAN_SEAT_BENCH_DRINK',
	target = {
		options = {
        {
			event = "qb-blackmarket:hmenu",
			icon = "fas fa-circle",
			label = "Got Something For Me?",
        },
	},
		distance = 0.0
	}
},

{
	model = `cs_jewelass`,
	coords = vector4(-569.60, 228.20, 74.50, 195.99),
	invincible = true,
	freeze = true,
	minusOne = true,
	blockevents = true,
	scenario = 'PROP_HUMAN_SEAT_STRIP_WATCH',
	target = {
		options = {
        {
			event = "qb-methrun:client:start",
			icon = "fas fa-circle",
			label = "Talk? Cost 5K Crypto!",
        },
	},
		distance = 0.0
	}
},

{
	model = `csb_hao`,
	coords = vector4(-574.60, 238.74, 74.39, 252.70),
	invincible = true,
	freeze = true,
	minusOne = true,
	blockevents = true,
	scenario = 'PROP_HUMAN_SEAT_BUS_STOP_WAIT',
	target = {
		options = {
        {
			event = "kevin-oxyruns:initiate",
			icon = 'fas fa-circle',
			label = 'Wanna Do Oxy Run?',
        },
	},
		distance = 0.0
	}
},
{
	model = `a_m_y_salton_01`,
	coords = vector4(1600.46, 3591.03, 38.77, 111.61),
	invincible = true,
	freeze = true,
	minusOne = true,
	blockevents = true,
	scenario = 'WORLD_HUMAN_LEANING',
	target = {
		options = {
        {
			type = "client",
			event = "sgx-chopshop:jobaccept",
			icon = 'fas fa-car',
			label = 'Locate A Vehicle',
        },
	},
		distance = 0.0
	}
},

{
	model = `a_m_y_salton_01`,
	coords = vector4(1704.93, 3784.88, 34.71, 214.81),
	invincible = true,
	freeze = true,
	minusOne = true,
	blockevents = true,
	scenario = 'WORLD_HUMAN_LEANING',
	target = {
		options = {
        {
			type = "client",
			event = "qb-pawnshop:client:openMenu",
			icon = 'fas fa-car',
			label = 'Locate A Vehicle',
        },
	},
		distance = 0.0
	}
},

},
}

CreateThread(function()
	if Config.FrameWork == 'qb' then
		local state = GetResourceState('qb-core')
		if state ~= 'missing' then
			if state ~= 'started' then
				local timeout = 0
				repeat
					timeout += 1
					Wait(0)
				until GetResourceState('qb-core') == 'started' or timeout > 100
			end
		end
		local QBCore = exports['qb-core']:GetCoreObject()
		local PlayerData = QBCore.Functions.GetPlayerData()

		ItemCount = function(item)
			for _, v in pairs(PlayerData.items) do
				if v.name == item then
					return true
				end
			end
			return false
		end

		JobCheck = function(job)
			if type(job) == 'table' then
				job = job[PlayerData.job.name]
				if job and PlayerData.job.grade.level >= job then
					return true
				end
			elseif job == 'all' or job == PlayerData.job.name then
				return true
			end
			return false
		end

		GangCheck = function(gang)
			if type(gang) == 'table' then
				gang = gang[PlayerData.gang.name]
				if gang and PlayerData.gang.grade.level >= gang then
					return true
				end
			elseif gang == 'all' or gang == PlayerData.gang.name then
				return true
			end
			return false
		end

		CitizenCheck = function(citizenid)
			return citizenid == PlayerData.citizenid or citizenid[PlayerData.citizenid]
		end

		RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
			PlayerData = QBCore.Functions.GetPlayerData()
			SpawnPeds()
		end)

		RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
			PlayerData = {}
			DeletePeds()
		end)

		RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
			PlayerData.job = JobInfo
		end)

		RegisterNetEvent('QBCore:Client:OnGangUpdate', function(GangInfo)
			PlayerData.gang = GangInfo
		end)

		RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
			PlayerData = val
		end)
	else
		local state = GetResourceState('es_extended')
		if state ~= 'missing' then
			if state ~= 'started' then
				local timeout = 0
				repeat
					timeout += 1
					Wait(0)
				until GetResourceState('es_extended') == 'started' or timeout > 100
			end
		end
		ESX = exports["es_extended"]:getSharedObject()
		local PlayerData = ESX.PlayerData
	
		ItemCount = function(item)
			for _, v in pairs(PlayerData.inventory) do
				if v.name == item then
					return true
				end
			end
			return false
		end
	
		JobCheck = function(job)
			if job == 'all' or job == PlayerData.job.name then
				return true
			end
			return false
		end
	
		CitizenCheck = function(citizenid)
			return citizenid == PlayerData.identifier or citizenid[PlayerData.identifier]
		end
	
		RegisterNetEvent('esx:playerLoaded', function()
			PlayerData = ESX.PlayerData
			SpawnPeds()
		end)
	
		RegisterNetEvent('esx:setJob', function(JobInfo)
			PlayerData.job = JobInfo
		end)
	end
end)

function CheckOptions(data, entity, distance)
	if Config.FrameWork == 'qb' then
		if distance and data.distance and distance > data.distance then return false end
		if data.job and not JobCheck(data.job) then return false end
		if data.gang and not GangCheck(data.gang) then return false end
		if data.item and not ItemCount(data.item) then return false end
		if data.citizenid and not CitizenCheck(data.citizenid) then return false end
		if data.canInteract and not data.canInteract(entity, distance, data) then return false end
		return true
	else
		if distance and data.distance and distance > data.distance then return false end
		if data.job and not JobCheck(data.job) then return false end
		if data.item and not ItemCount(data.item) then return false end
		if data.citizenid and not CitizenCheck(data.citizenid) then return false end
		if data.canInteract and not data.canInteract(entity, distance, data) then return false end
		return true
	end
end