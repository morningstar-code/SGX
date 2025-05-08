-- $$\   $$\  $$$$$$\  $$\   $$\ $$\   $$\ $$$$$$$\  
-- $$$\  $$ |$$  __$$\ $$ |  $$ |$$ |  $$ |$$  __$$\ 
-- $$$$\ $$ |$$ /  \__|$$ |  $$ |$$ |  $$ |$$ |  $$ |
-- $$ $$\$$ |$$ |      $$$$$$$$ |$$ |  $$ |$$$$$$$\ |
-- $$ \$$$$ |$$ |      $$  __$$ |$$ |  $$ |$$  __$$\ 
-- $$ |\$$$ |$$ |  $$\ $$ |  $$ |$$ |  $$ |$$ |  $$ |
-- $$ | \$$ |\$$$$$$  |$$ |  $$ |\$$$$$$  |$$$$$$$  |
-- \__|  \__| \______/ \__|  \__| \______/ \_______/  
-- discord.gg/sgx & Patreon.com/NCHub
fx_version 'cerulean'

game 'gta5'

lua54 'yes'

ui_page 'html/index.html'

escrow_ignore {
    'config.lua',
    'client/target.lua',
    'client/main.lua',
    'client/retail.lua',
    'client/wholesale.lua',
    'client/mole.lua',
    'client/nui.lua',
    'server/main.lua',
    'server/retail.lua',
    'server/wholesale.lua',
    'server/mole.lua',
    'server/configurable.lua'
}

files { 
    'html/index.html', 
    'html/css/*.css',
    'html/css/jquery/*.css',
    'html/js/jquery/*.js',
    'html/js/*.js',
    'html/img/*.png',
    'html/img/inventory/*.png',
    'html/audio/*.mp3',
    'locales/*.json'
}
    
client_scripts {
    'config.lua',
    'client/target.lua',
    'client/main.lua',
    'client/retail.lua',
    'client/wholesale.lua',
    'client/mole.lua',
    'client/nui.lua'
}

server_scripts {
    'config.lua',
    'server/main.lua',
    'server/retail.lua',
    'server/wholesale.lua',
    'server/mole.lua',
    'server/configurable.lua'
}

dependency '/assetpacks'