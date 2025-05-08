Made by Lionh34rt#4305
Discord: https://discord.gg/AWyTUEnGeN
Tebex: https://lionh34rt.tebex.io/

# Description
* **Six key-based labs made for QBCore. Give these assets to the gangs in your servers and let them control it. However if they lose their keys they will lose their control! Uses the bob74_ipl, comes with extensive logging for moderation. These labs will be the heart of your economy. Durations and ingredients are highly customizable. Everything is server synced and logic is run on the server-side and saved in database upon server restarts.**
* **1: Weaponbunkerunder Mt. Chilliad is a large bunker where guncrafters can craft weapons. Materials are used to craft weapons and ammo. In the config files you can quickly edit the materials and quantities required. Stash is included.**
* **2: Moneywash: After a succesful bankrobbery, players need to wash their inked money. They hand over their bags of inked money to the group that controls the moneywash.** 
* **3: Druglabs (Coke, 2x Meth, Weed): Gangs that control these labs need the correct key to enter the lab. Once inside they require ingredients (ecgonine, methylamine and plant nutrition for coke, meth and weed) after running the process players receive a batch or brick of drugs. These large packs are easy to distribute and sell to the rest of the players on your server. ***

# Dependencies
* [QBCore Framework](https://github.com/qbcore-framework)
* [qb-target by BerkieBb](https://github.com/BerkieBb/qb-target)
* [bob74_ipl loader by Bob74](https://github.com/Bob74/bob74_ipl)

# Installation
* **Add the items to your shared > items.lua and images**
* **Make adjustments to your inventory script with the code underneath**
* **Change the bob74_ipl config files in dlcbikers with the included ones.**
* **Change the mean values in sv_druglabs (Optional, recommended).**

# Add to your giveitem function in qb-inventory/server/main.lua
```lua
elseif itemData["name"] == "meth_batch" then
    info.purity = math.random(1, 100)
elseif itemData["name"] == "meth_cured" then
    info.purity = math.random(1, 100)
elseif itemData["name"] == "meth_baggy" then
    info.purity = math.random(1, 100)
elseif itemData["name"] == "weed_batch" then
    info.purity = math.random(1, 100)
elseif itemData["name"] == "weed_cured" then
    info.purity = math.random(1, 100)
elseif itemData["name"] == "weed_baggy" then
    info.purity = math.random(1, 100)
elseif itemData["name"] == "coke_batch" then
    info.purity = math.random(1, 100)
elseif itemData["name"] == "coke_cured" then
    info.purity = math.random(1, 100)
elseif itemData["name"] == "coke_baggy" then
    info.purity = math.random(1, 100)
```

# Add to your inventory app.js to display the purity of items in the description:
```js
} else if (itemData.name == "meth_batch") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html("<p>Purity: " + itemData.info.purity + "%</p>");
} else if (itemData.name == "meth_cured") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html("<p>Purity: " + itemData.info.purity + "%</p>");
} else if (itemData.name == "meth_baggy") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html("<p>Purity: " + itemData.info.purity + "%</p>");
} else if (itemData.name == "coke_batch") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html("<p>Purity: " + itemData.info.purity + "%</p>");
} else if (itemData.name == "coke_cured") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html("<p>Purity: " + itemData.info.purity + "%</p>");
} else if (itemData.name == "coke_baggy") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html("<p>Purity: " + itemData.info.purity + "%</p>");
} else if (itemData.name == "weed_batch") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html("<p>Purity: " + itemData.info.purity + "%</p>");
} else if (itemData.name == "weed_cured") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html("<p>Purity: " + itemData.info.purity + "%</p>");
} else if (itemData.name == "weed_baggy") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html("<p>Purity: " + itemData.info.purity + "%</p>");
```

# Items for qb-core/shared/items.lua
```lua
["methkey"] 			 		 = {["name"] = "methkey", 						["label"] = "Strange key", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "methkey.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   	["combinable"] = nil,   ["description"] = "A key with an M engraved"},
["methkey2"] 			 		 = {["name"] = "methkey2", 						["label"] = "Strange key", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "methkey.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   	["combinable"] = nil,   ["description"] = "A key with an M engraved"},
["weedkey"] 			 		 = {["name"] = "weedkey", 						["label"] = "Strange key", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "methkey.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   	["combinable"] = nil,   ["description"] = "A key with a W engraved"},
["cokekey"] 			 		 = {["name"] = "cokekey", 						["label"] = "Strange key", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "methkey.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   	["combinable"] = nil,   ["description"] = "A key with a C engraved"},
["mwkey"] 			 		 	 = {["name"] = "mwkey", 						["label"] = "Strange key", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "methkey.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   	["combinable"] = nil,   ["description"] = "A key with MW engraved"},
["gunkey"] 			 		 	 = {["name"] = "gunkey", 						["label"] = "Strange key", 				["weight"] = 1000, 		["type"] = "item", 		["image"] = "methkey.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   	["combinable"] = nil,   ["description"] = "A key with a G engraved"},

["empty_plastic_bag"] 			 = {["name"] = "empty_plastic_bag", 			["label"] = "Empty Ziploc baggies",		["weight"] = 100, 		["type"] = "item", 		["image"] = "empty-plastic-bag.png", 	["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,	["combinable"] = nil,   ["description"] = "A small and empty plastic bag."},
["meth_batch"] 		 		 	 = {["name"] = "meth_batch", 					["label"] = "Batch of Meth", 			["weight"] = 10000, 	["type"] = "item", 		["image"] = "meth_batch.png", 			["unique"] = true, 		["useable"] = false, 	["shouldClose"] = false,	["combinable"] = nil,   ["description"] = "A batch of meth that still needs curing..."},
["meth_cured"] 		 	 		 = {["name"] = "meth_cured", 					["label"] = "Cured Batch of Meth", 		["weight"] = 10000, 	["type"] = "item", 		["image"] = "meth_cured.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,		["combinable"] = nil,   ["description"] = "A cured batch of meth, ready to sell!"},
["meth_baggy"] 		 	 		 = {["name"] = "meth_baggy", 					["label"] = "Bag of Meth", 				["weight"] = 100, 		["type"] = "item", 		["image"] = "meth_baggy.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,		["combinable"] = nil,   ["description"] = "A bag of meth!"},
["coke_batch"] 		 		 	 = {["name"] = "coke_batch", 					["label"] = "Batch of Coke", 			["weight"] = 10000, 	["type"] = "item", 		["image"] = "coke_batch.png", 			["unique"] = true, 		["useable"] = false, 	["shouldClose"] = false,	["combinable"] = nil,   ["description"] = "A batch of coke that still needs processing..."},
["coke_cured"] 		 	 		 = {["name"] = "coke_cured", 					["label"] = "Brick of Coke", 			["weight"] = 10000, 	["type"] = "item", 		["image"] = "coke_cured.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,		["combinable"] = nil,   ["description"] = "A processed brick of coke, ready to sell!"},
["coke_baggy"] 		 	 		 = {["name"] = "coke_baggy", 					["label"] = "Bag of Coke", 				["weight"] = 100, 		["type"] = "item", 		["image"] = "coke_baggy.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,		["combinable"] = nil,   ["description"] = "A bag of cocaine!"},
["weed_batch"] 		 		 	 = {["name"] = "weed_batch", 					["label"] = "Batch of Weed", 			["weight"] = 10000, 	["type"] = "item", 		["image"] = "weed_batch.png", 			["unique"] = true, 		["useable"] = false, 	["shouldClose"] = false,	["combinable"] = nil,   ["description"] = "A batch of weed that still needs drying..."},
["weed_cured"] 		 	 		 = {["name"] = "weed_cured", 					["label"] = "Dried Weed", 				["weight"] = 10000, 	["type"] = "item", 		["image"] = "weed_cured.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,		["combinable"] = nil,   ["description"] = "A dried batch of weed, ready to sell!"},
["weed_baggy"] 		 	 		 = {["name"] = "weed_baggy", 					["label"] = "Bag of Weed", 				["weight"] = 100, 		["type"] = "item", 		["image"] = "weed_baggy.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,		["combinable"] = nil,   ["description"] = "A bag of weed!"},
["methylamine"] 			 	 = {["name"] = "methylamine", 					["label"] = "Methylamine", 				["weight"] = 4000, 		["type"] = "item", 		["image"] = "methylamine.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,	["combinable"] = nil,   ["description"] = "A derivative of ammonia, but with one H atom replaced by a methyl group"},
["ecgonine"] 			 		 = {["name"] = "ecgonine", 						["label"] = "Ecgonine", 				["weight"] = 4000, 		["type"] = "item", 		["image"] = "ecgonine.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,	["combinable"] = nil,   ["description"] = "Ecgonine (tropane derivative) is a tropane alkaloid"},
```

# LOGGING: ADD FOLLOWING ENTRY TO YOUR QB-SMALLRESOURCES/LOGS:
['keylabs'] = {webhook},
