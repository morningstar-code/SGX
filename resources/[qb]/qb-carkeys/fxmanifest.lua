
fx_version 'cerulean'
game 'gta5'

description 'Nopixel inspired qb-carkeys'
version 'v2.1'

server_script {
    'Server/sv_main.lua',
    'Server/sv_keys.lua',
}

client_script {
    'Client/cl_functions.lua',
    'Client/cl_main.lua',
    'Client/cl_keys.lua',
}

shared_script {
    'config.lua',
}