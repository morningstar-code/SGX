fx_version 'cerulean'
game 'gta5'
ui_page 'html/index.html'
files {
  'html/index.html',
  'html/index.js',
  'html/style.css',
  'html/*otf',
  'html/*png',
  'fonts/*.ttf',
  'fonts/*.otf'
 
}
shared_script 'config.lua'
client_scripts{
  'client/client.lua'
}

escrow_ignore {
	'config.lua',
  'client/client.lua',
  'server/server.lua'
}



server_scripts {
  'server/server.lua'
}
lua54 "yes"
dependency '/assetpacks'server_scripts { '@mysql-async/lib/MySQL.lua' }