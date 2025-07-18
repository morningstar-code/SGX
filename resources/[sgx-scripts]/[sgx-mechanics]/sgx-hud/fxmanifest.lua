--[[ FX Information ]]

fx_version "cerulean"
game "gta5"
lua54 "yes"

--[[ Resource Information ]]
name "sgx-hud"
author "0-Resmon"
version "2.0.0"
description "0Resmon:HUD | aliko."

--[[ Manifest ]]
shared_scripts {
    "shared/**/*"
}

client_scripts {
    "client/utils.lua",
    "client/variables.lua",
    "client/functions.lua",
    "client/events.lua",
    "client/nui.lua",
    "client/threads.lua",
    "client/commands.lua",
}

server_scripts {
    "server/variables.lua",
    "server/functions.lua",
    "server/commands.lua",
    "server/events.lua",
    "server/threads.lua"
}

ui_page "ui/build/index.html"

files {
    "locales/**/*",
    "ui/build/index.html",
    "ui/build/**/*"
}

escrow_ignore {
    "locales/**/*",
    "shared/**/*",
    "client/**/*",
    "server/**/*",
    "ui/**/*",
}

dependency '/assetpacks'