fx_version 'cerulean'
game 'gta5'
author 'sgx <sgx.tebex.io>'
lua54 'yes'

client_script 'client.lua'
server_script 'server.lua'

shared_scripts {
    'shared/cfg.lua',
    'shared/utils.lua',
    'shared/shared.lua',
}

ui_page 'web/dist/index.html'
files {
    'web/dist/*',
    'web/dist/**/*',
}

escrow_ignore {
    'client.lua',
    'server.lua',
    'shared/cfg.lua',
    'shared/utils.lua',
    'shared/shared.lua',
}

dependency '/assetpacks'