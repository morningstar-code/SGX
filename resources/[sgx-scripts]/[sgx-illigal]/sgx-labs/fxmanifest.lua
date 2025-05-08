fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'Keybased labs for QBCore'
version '2.3'

dependencies {
    'qb-target'
}

shared_script {
    'shared/locales.lua',
    'shared/sh_config.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_*.lua',
}

client_scripts {
    'client/cl_*.lua'
}
