fx_version "cerulean"

games { "gta5" }

description "FiveM Library"
author "ANTUNES"

version "0.1.0"

server_scripts {
    "server/*.js",
}

client_scripts {
    "client/*.js",
}

shared_scripts {
    "shared/*.*",
}

exports {
    'GetLibrary',
}

-- escrow_ignore {
--     'client/*.js',  -- Only ignore one file
--     'server/*.js',  -- Only ignore one file
--   }