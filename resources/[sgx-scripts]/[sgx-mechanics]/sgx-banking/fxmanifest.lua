fx_version 'adamant'

game 'gta5'

description 'SGX - Banking script | NP Inspired Free!'

version '1.0.0'

ui_page 'UI/index.html'

files {
    'UI/index.html',
    'UI/styles/*.css',
    'UI/scripts/*.js',
    'UI/images/*.png',
	'UI/images/*.jpg',
    'UI/images/*.svg',
	'UI/fonts/*.ttf'
}

shared_script 'Config.lua'

client_script 'Client/*.lua'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'Server/*.lua',
}

lua54 'yes'