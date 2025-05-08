cfg = {}

cfg.Language           = 'en'               -- Language to load from locales
cfg.Prefix             =  QBCore
cfg.TriggerPrefix      = "QBCore"
cfg.ExportPrefix       = "qb-core"
cfg.Target             = "qb-target"        -- qb-target or ox_target (if you want to add another target, go to the target.lua file)
cfg.Discord_Webhook    = "URL"

cfg.Police 			   = {
	Job = {"police", "bcso" ,"sahp"},
	Required = 0							-- How many police officers should be on duty to start drug sales?
}

cfg.Time               = {					-- Actually configured for "GMT +1"
    ["Zone"]           = "plus", 			-- "plus" or "minus"
    ["Zone_Count"]     = 1,
    ["Format"]         = 24 				-- 24 or 12 (PM/AM)
}

cfg.Drug_List 		   = {
	["coke_baggy"] = {average_price = 75},
	["weed_baggy"] = {average_price = 110},
	["meth_baggy"] = {average_price = 125}
}


cfg.Phone       	   = {
	Price = 500,
	Item_Name = "trapphone"
}

cfg.Sales_Skill = {
	InterestInDrugs = 100,					-- In percentage 0-100%
	maxQuantity = 5,
	Threshold = 250,						-- Player must have more Points than this value to use Sale Skill
	Limit = 1000,							-- Limit of Sales Skill Points
	Skill = 5,								-- Player will receive this value of Sales Skill Points
	Increase_Chance = 20					-- Player will get extra percentage bonus of this value, if you increases the price by 1.2x you will receive 1.2x points more
}

cfg.Threshold_Respect  = {
	Mole = {
		["junkie"] = 0,
		["criminal"] = 2500,
		["professional"] = 5000
	},
	Wholesale = 2500,
	Limit = 10000
}

cfg.Wholesale 		   = {
	{
		Peds = {{isBuyer = true, model = "G_M_Y_SalvaGoon_03"}, {model = "G_M_M_CartelGuards_01"}, {model = "G_M_M_CartelGuards_02"}},
		Vehicle = "baller7",	--Must be 4-door with Trunk
		Gun = "weapon_microsmg",
		Coords = vector4(-1273.71, -810.19, 17.05, 306.62)
	},
	{
		Peds = {{isBuyer = true, model = "G_M_Y_SalvaBoss_01"}, {model = "G_M_Y_FamDNF_01"}, {model = "G_F_Y_Families_01"}},
		Vehicle = "cog55",	
		Gun = "weapon_pistol",
		Coords = vector4(-1541.41, -584.42, 33.35, 215.45)
	},
	{
        Peds = {{isBuyer = true, model = "a_m_m_malibu_01"}, {model = "a_m_m_hillbilly_02"}, {model = "a_m_m_rurmeth_01"}},
        Vehicle = "landstalker",
        Gun = "weapon_vintagepistol",
        Coords = vector4(-1566.49, -237.25, 48.97, 325.14)
    },
	{
        Peds = {{isBuyer = true, model = "a_m_m_stlat_02"}, {model = "a_m_m_rurmeth_01"}, {model = "a_m_o_acult_02"}},
        Vehicle = "seminole",
        Gun = "weapon_pistol50",
        Coords = vector4(62.16, 150.63, 104.08, 160.14)
    },
	{
        Peds = {{isBuyer = true, model = "a_m_m_golfer_01"}, {model = "a_m_m_eastsa_01"}, {model = "a_m_m_eastsa_02"}},
        Vehicle = "dubsta",
        Gun = "weapon_pumpshotgun",
        Coords = vector4(734.24, -552.98, 26.29, 239.91)
    },
	{
        Peds = {{isBuyer = true, model = "a_m_y_beachvesp_02"}, {model = "a_m_y_cyclist_01"}, {model = "a_m_y_eastsa_01"}},
        Vehicle = "intruder",
        Gun = "weapon_vintagepistol",
        Coords = vector4(1001.43, -1559.37, 30.35, 183.27)
    },
}

cfg.Wholesale_Settings = {
	Guns_Whitelist = {GetHashKey("weapon_unarmed"), GetHashKey("weapon_ball"), GetHashKey("weapon_snowball")},
	minQuantity = 50,
	maxQuantity = 300,
	Respect = 500, 						-- Add when trade is done/Remove when you leave zone
	Remove_Respect = 3000,				-- Remove when you rob a customer
	Money_Robbery = 75,					-- Money that player will get from robbery (in percentage)
	Repeat = 45,						-- Cooldown to next offer (in minutes)
	Waiting = 10						-- Maximum waiting time of client (in minutes)
}

cfg.Mole = {
	["junkie"] = {
		["Joe"] = {ped_model = "a_m_m_trampbeac_01", coords = vector4(-717.09, -905.32, 20.0, 63.43), price = 2500},
		["Casey"] = {ped_model = "a_m_y_hippy_01", coords = vector4(-364.35, -350.95, 31.56, 251.99), price = 2500},
		["Jamie"] = {ped_model = "a_m_y_methhead_01", coords = vector4(-1451.17, -579.44, 31.25, 213.6), price = 2500},
		["Blake"] = {ped_model = "a_m_o_genstreet_01", coords = vector4(-965.53, -1172.45, 2.15, 293.15), price = 2500},
		["Drew"] = {ped_model = "a_m_o_tramp_01", coords = vector4(776.65, -1194.67, 24.29, 72.89), price = 2500}
	},
	["criminal"] = {
		["Louis"] = {ped_model = "a_m_m_soucent_04", coords = vector4(1141.28, -1657.09, 36.41, 34.49), price = 5000},
		["Charlie"] = {ped_model = "G_M_Y_PoloGoon_02", coords = vector4(152.34, -72.67, 71.86, 340.98), price = 5000},
		["Noah"] = {ped_model = "G_M_Y_PoloGoon_01", coords = vector4(-1590.74, -412.46, 43.06, 45.73), price = 5000},
		["Morgan"] = {ped_model = "G_M_M_CartelGoons_01", coords = vector4(-982.47, -270.98, 38.29, 223.28), price = 5000},
		["Taylor"] = {ped_model = "G_M_M_MaraGrande_01", coords = vector4(-280.89, 193.68, 85.56, 350.64), price = 5000}
	},
	["professional"] = {
		["Blackie"] = {ped_model = "a_m_m_og_boss_01", coords = vector4(-26.96, -1531.43, 30.52, 314.79), price = 15000},
		["Debony"] = {ped_model = "G_M_Y_StrPunk_02", coords = vector4(332.55, -1990.2, 30.64, 42.54), price = 15000},
		["Jordan"] = {ped_model = "a_m_m_tourist_01", coords = vector4(-2005.01, -356.68, 26.1, 140.32), price = 15000},
		["Riley"] = {ped_model = "a_m_m_soucent_01", coords = vector4(-534.31, -2216.95, 6.39, 227.89), price = 15000},
		["Alex"] = {ped_model = "a_m_m_salton_02", coords = vector4(948.43, -2102.17, 30.67, 209.5), price = 15000}
	}
}

cfg.Mole_Settings 	   = {
	Subscription = 3,							-- For how many days should the informant subscription be valid?
	Blip = {
		["Mole"] = {
			Sprite = 78,
			Scale = 0.6,
			Color = 4,
			Text = "Mole"
		},
		["Police"] = {
			Sprite = 137,
			Scale = 0.6,
			Color = 1,
			Text = "Last seen Officer",
			Duration = 30
		}
	},
	Distance = {
		["junkie"] = 75.0,
		["criminal"] = 100.0,
		["professional"] = 200.0
	},
}

function Dispatch(coords, ped)
	TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
		job = { 'police', 'bcso', 'sahp'},
		callLocation = vector3(coords.x, coords.y, coords.z),
		callCode = { code = '<CALL CODE>', snippet = '<CALL SNIPPED EX: 10-10>' },
		message = "Call Message",
		flashes = false, -- you can set to true if you need call flashing sirens...
		image = "URL", -- Url for image to attach to the call 
		--you can use the getSSURL export to get this url
		blip = {
			sprite = 488, --blip sprite
			scale = 1.5, -- blip scale
			colour = 1, -- blio colour
			flashes = true, -- blip flashes
			text = 'Hight Speed', -- blip text
			time = (20 * 1000), --blip fadeout time (1 * 60000) = 1 minute
		},
		otherData = {
	-- optional if you dont need this you can remove it and remember remove the `,` after blip end and this block
		   {
			   text = 'Red Obscure', -- text of the other data item (can add more than one)
			   icon = 'fas fa-user-secret', -- icon font awesome https://fontawesome.com/icons/
		   }
		 }
	})
end

function clientNotify(txt, type, duration)
	TriggerEvent('QBCore:Notify', txt, type, duration)
end

function serverNotify(source, txt, type, duration)
	TriggerClientEvent('QBCore:Notify', source, txt, type, duration)
end

function reformatInt(i)
    return tostring(i):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
end


translations = json.decode(LoadResourceFile(GetCurrentResourceName(), 'locales/' .. cfg.Language .. '.json'))
function translate(category, key, ...) -- translate: Replace placeholders (%s) in a translation key with args; remove unused placeholders.
    if translations[category] and translations[category][key] then
        local result = translations[category][key]
        local args = {...}
        for i, arg in ipairs(args) do
            result = string.gsub(result, "%%s", arg, 1)
        end
        result = string.gsub(result, "%%s", "")
        return result
    else
        return 'Translation missing category: '..category..', key: '..key
    end
end

function randomTranslate(category, key, ...) -- randomTranslate: Choose a random translation under key, replace (%s) with args; remove unused placeholders.
    if translations[category] and translations[category]["randomTexts"] and translations[category]["randomTexts"][key] then
        local texts = translations[category]["randomTexts"][key]
        local randomIndex = math.random(#texts)
        local result = texts[randomIndex]
        local args = {...}
        for i, arg in ipairs(args) do
            result = string.gsub(result, "%%s", arg, 1)
        end
        result = string.gsub(result, "%%s", "")
        return result
    else
        return 'No random texts available for category: '..category..', key: '..key
    end
end

