fx_version 'cerulean'
game 'gta5'

lua54 'yes'  

shared_scripts {
    'config.lua',
    '@qb-apartments/config.lua'
} 

escrow_ignore {
    'clmain.lua',
    'svmain.lua',
    'config.lua',
    'example-qb-apartments-config'
}

client_script 'clmain.lua'
server_script 'svmain.lua'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/index.js',
    'html/files/*.png',
    'html/files/*.jpg',
    'html/fonts/*.otf',
    'html/fonts/*.ttf'
}
