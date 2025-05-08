fx_version 'cerulean'

game 'gta5'

client_script 'cl_zoyg.lua'

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	'sv_zoyg.lua'
}

shared_script 'config.lua'

files {
	'html/ui.html',
	'html/script.js',
	'html/*.css',

	'html/images/*.png',
		'html/images/*.jpg',
	'html/images/*.gif',
}

ui_page 'html/ui.html'
