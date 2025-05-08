Config = {
	Debug = false,  -- false to remove green boxes
	Lan = "en", -- change the language
	img = "qb-inventory/html/images/", -- Change this to your inventory's name and image folder

	Core = "qb-core", -- set this to your core folder
	Inv = "qb", -- set to "ox" if using OX Inventory
	Menu = "qb", -- set to "ox" if using ox_lib context menus
	Notify = "qb",
	ProgressBar = "qb", -- set to "ox" if using ox_lib progressbar

	JimConsumables = true, -- Enable this to disable this scripts control of food/drink items
	JimShop = false, -- If true shops will open in jim-shops

	MultiCraft = true,
	MultiCraftAmounts = { [1], [5], [10] },

		--Simple Toy Reward Support - disabled if JimConsumables are true
	RewardItem = "", --Set this to the name of an item eg "bento"
	RewardPool = { -- Set this to the list of items to be given out as random prizes when the item is used - can be more or less items in the list
		"",
		"",
		"",
	},

	FoodItems = {
		label = "Food Store",
		slots = 8,
		items = {
			{ name = "water_bottle", price = 0, amount = 50, info = {}, type = "item", slot = 1, },
			{ name = "orange", price = 0, amount = 50, info = {}, type = "item", slot = 2, },
			{ name = "sugar", price = 0, amount = 50, info = {}, type = "item", slot = 3, },
			{ name = "chickenbreast", price = 0, amount = 50, info = {}, type = "item", slot = 4, },
			{ name = "rhinohorn", price = 0, amount = 50, info = {}, type = "item", slot = 5, },
			{ name = "oystershell", price = 0, amount = 50, info = {}, type = "item", slot = 6, },
			{ name = "milk", price = 0, amount = 50, info = {}, type = "item", slot = 7, },
			{ name = "beancoffee", price = 0, amount = 50, info = {}, type = "item", slot = 8, },
		},
	},
	DesertItems = {
		label = "Desert Store",
		slots = 6,
		items = {
			{ name = "donut", price = 0, amount = 50, info = {}, type = "item", slot = 1, },
			{ name = "chocolate", price = 0, amount = 50, info = {}, type = "item", slot = 2, },
			{ name = "crisps", price = 0, amount = 50, info = {}, type = "item", slot = 3, },
			{ name = "watermelon", price = 0, amount = 50, info = {}, type = "item", slot = 4, },
			{ name = "cheesecake", price = 0, amount = 50, info = {}, type = "item", slot = 5, },
			{ name = "tosti", price = 0, amount = 50, info = {}, type = "item", slot = 6, },
			{ name = "water_bottle", price = 0, amount = 50, info = {}, type = "item", slot = 7, },
		},
	},
	SodaItems = {
		label = "Soda Storage",
		slots = 4,
		items = {
			{ name = "ecola", price = 0, amount = 50, info = {}, type = "item", slot = 1, },
			{ name = "ecolalight", price = 0, amount = 50, info = {}, type = "item", slot = 2, },
			{ name = "sprunk", price = 0, amount = 50, info = {}, type = "item", slot = 3, },
			{ name = "sprunklight", price = 0, amount = 50, info = {}, type = "item", slot = 4, },
		},
	},
	Locations = {
		["beangabzlegion"] = {
			zoneEnable = true,
			label = "Cool Beans",
			job = "coolbeans",
			autoClock = { enter = false, exit = true, },
			zones = {
				vec2(137.44329833984, -1019.5242919922),
				vec2(122.99235534668, -1058.451171875),
				vec2(101.35326385498, -1048.4799804688),
				vec2(115.27521514893, -1011.9081420898)
			},
			garage = { spawn = vec4(130.93, -1032.04, 28.76, 340.2),
						out = vec4(129.41, -1031.15, 29.43, 253.32),
						list = { "panto", } },
			blip = vector3(-1208.053, -1135.826, 7.7074279), blipcolor = 8, blipsprite = 89, blipdisp = 6, blipscale = 0.7, blipcat = nil,
		},
		["beanunclejust"] = {
			zoneEnable = false,
			label = "Bean Machine(Vinewood)",
			job = "coolbeans",
			autoClock = { enter = false, exit = true, },
			zones = {
				vec2(-649.89886474609, 259.69918823242),
				vec2(-611.98547363281, 257.3210144043),
				vec2(-614.646484375, 203.47846984863),
				vec2(-649.29040527344, 203.21409606934)
			},
			garage = { spawn = vec4(-631.99, 207.03, 73.31, 93.9),
						out = vec4(-632.39, 209.14, 74.32, 179.94),
						list = { "panto", } },
			blip = vec3(-629.63, 234.39, 81.88), blipcolor = 56, blipsprite = 106, blipdisp = 6, blipscale = 0.7, blipcat = nil,
		},
		["beanrflx"] = {
			zoneEnable = false,
			label = "Bean Machine(Legion)",
			job = "coolbeans",
			autoClock = { enter = false, exit = true, },
			zones = {
				vec2(271.67, -955.77),
				vec2(291.9, -954.33),
				vec2(291.61, -986.73),
				vec2(261.14, -973.50)
			},
			garage = { spawn = vec4(278.17, -956.56, 28.6, 269.1),
						out = vec4(277.52, -958.44, 29.4, 356.56),
						list = { "panto", } },
			blip = vec3(281.54, -965.68, 29.42), blipcolor = 56, blipsprite = 106, blipdisp = 6, blipscale = 0.7, blipcat = nil,
		},
	},
}

Crafting = {
	Slush = {
		{ ['bigfruit'] = { ['watermelon'] = 1, ['water_bottle'] = 1, ['orange'] = 1, ['sugar'] = 1, }, },
	},
	Drinks = {
		{ ['highnoon'] = { ['beancoffee'] = 1, ['water_bottle'] = 1, ['orange'] = 1, }, },
		{ ['speedball'] = { ['beancoffee'] = 3, ['sugar'] = 1, }, },
		{ ['gunkaccino'] = { ['beancoffee'] = 1, ['sugar'] = 2, ['cheesecake'] = 1, }, },
		{ ['bratte'] = { ['beancoffee'] = 2, ['sugar'] = 5, }, },
		{ ['flusher'] = { ['beancoffee'] = 1, ['water_bottle'] = 1, ['orange'] = 1, ['chickenbreast'] = 1, }, },
		{ ['ecocoffee'] = { ['beancoffee'] = 1, ['water_bottle'] = 1, ['milk'] = 1, ['plastic'] = 1, }, },
		{ ['caffeagra'] = { ['beancoffee'] = 1, ['rhinohorn'] = 2, ['oystershell'] = 1, }, },
	},
}

Loc = {}