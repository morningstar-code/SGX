fx_version 'cerulean'
game 'gta5'
lua54 'yes'


description 'sgx-lockpick'
version '1.0.0'

ui_page 'html/index.html'

client_scripts {
	'client/main.lua',
}

shared_scripts {
    'config.lua',
}

files {
	'html/index.html',
	'html/images/*.png',
	'html/sounds/*.mp3',
	'html/sounds/*.wav',
}