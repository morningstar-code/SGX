fx_version "cerulean"
game 'gta5'
description "NoPixel 4.0 - Bug Report"
author "SGX"
version '1.0.0'

lua54 'yes'

ui_page 'web/build/index.html'

files {
  'web/build/index.html',
  'web/build/**/*'
}

client_scripts { 
  "client/**/*",
}
server_scripts { 
  "server/**/*",
  "@oxmysql/lib/MySQL.lua",
}