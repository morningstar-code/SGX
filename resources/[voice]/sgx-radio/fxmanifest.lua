fx_version 'cerulean'
game 'gta5'
lua54 'yes'
escrow_ignore {
    'shared/*.lua',
    'client/*.lua',
    'server/*.lua'
}
shared_scripts {
	'shared/cores.lua',
    'shared/config.lua'
}
client_scripts {
	'client/*.lua'
}
server_scripts {
    'server/*.lua'
}
ui_page 'html/index.html'
files {
    'html/*',
	'html/index.html',
	'html/style.css',
	'html/index.js',
    'html/files/*.png',
    'html/files/*.jpg',
    'html/fonts/*.ttf',
    'html/fonts/*.otf'
}
dependency '/assetpacks'