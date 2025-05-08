fx_version "cerulean"
game "gta5"

description "SGX's Crypto Mining"

author 'SGX Scripts'

version '1.0'

lua54 'yes'

client_script {
    'client/client.lua',
    'client/gpu.lua'
}

server_script {
    'server/server.lua',
    '@oxmysql/lib/MySQL.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}
