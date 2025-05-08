-- $$\   $$\  $$$$$$\  $$\   $$\ $$\   $$\ $$$$$$$\  
-- $$$\  $$ |$$  __$$\ $$ |  $$ |$$ |  $$ |$$  __$$\ 
-- $$$$\ $$ |$$ /  \__|$$ |  $$ |$$ |  $$ |$$ |  $$ |
-- $$ $$\$$ |$$ |      $$$$$$$$ |$$ |  $$ |$$$$$$$\ |
-- $$ \$$$$ |$$ |      $$  __$$ |$$ |  $$ |$$  __$$\ 
-- $$ |\$$$ |$$ |  $$\ $$ |  $$ |$$ |  $$ |$$ |  $$ |
-- $$ | \$$ |\$$$$$$  |$$ |  $$ |\$$$$$$  |$$$$$$$  |
-- \__|  \__| \______/ \__|  \__| \______/ \_______/  
-- Discord.gg/NCHub & Patreon.com/NCHub
fx_version "cerulean"

games { "gta5" }
version "0.1.0"

-- Load NUI project
--loadscreen 'http://localhost:3000'
loadscreen 'nui/dist/index.html'
loadscreen_manual_shutdown "yes"
loadscreen_cursor 'yes'

files {
    "nui/dist/**/*",
    'html/assets/music.mp3',
}

server_scripts { "build/sv_*.js" }
client_scripts { "build/cl_*.js" }
