fx_version 'cerulean'
game 'gta5'
author 'DON'
version '1.5.0'
shared_scripts {
    'config.lua',
}
client_scripts {
    'client/main.lua'
}
server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}
ui_page 'ui/index.html'
files {
    'ui/script.js',
    'ui/index.html',
    'ui/fonts/*.ttf',
    'ui/Akrobat-Black.otf',
    'ui/style.css'
}
escrow_ignore {
    'config.lua', 
}
lua54 'yes'server_scripts { '@mysql-async/lib/MySQL.lua' }