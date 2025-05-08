fx_version 'bodacious'
lua54 'yes'
game 'gta5'

--[[ Resource Information ]]--

author 'Ayazwai'
version '1.0.2'
scriptname 'wais-bodycamv2'

--[[ Resource Information ]]--

client_scripts {
    'config.lua',
    'client.lua',
    'open-cl.lua',
}

server_scripts {
    'config.lua',
    '@mysql-async/lib/MySQL.lua',
    'server.lua',
}

-- dependencys {
--     'wais-compatibility',
-- }

escrow_ignore {
    'config.lua',
    'client.lua',
    'server.lua',
}

-- ui_page "html/devui.html"
-- files {
--     'html/*.*'
-- }

ui_page "html/dist/index.html"
files {
    'html/dist/*.js',
    'html/dist/index.html',

    'html/public/*.png',
    'html/public/*.json',
    'html/public/css/*.*',
    'html/public/fonts/*.*',
    'html/public/sounds/*.ogg',
    'html/public/images/*.*',
    'html/public/images/frames/*.*',
}
dependency '/assetpacks'