fx_version 'cerulean'

games { 'gta5' }

lua54 'yes'

version '1.0.3'

shared_scripts {
	'config/*.lua'
}

client_scripts {
	'client/interactionHandler.lua',
	'client/main.lua',
	'client/functions.lua',
	'editable/client_editable.lua'
}

server_scripts {
	'editable/server_editable.lua'
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/style.css',
	'html/images/**/*.png',
	'html/vehicleImages/**/*.png',
	'html/js/*.js'
}

escrow_ignore {
	'client/interactionHandler.lua',
	'config/*.lua',
	'editable/*.lua',
	'client/*.lua',
}

exports {
	'GetFuel',
	'SetFuel'
}
dependency '/assetpacks'