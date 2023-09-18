fx_version 'adamant'
game 'gta5'

author ".meeth"
description 'ZM BOSS JOB CASES'
version '1.1.0'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/*.lua'
}

server_scripts {
    'server/*.lua',
    '@mysql-async/lib/MySQL.lua',
} 

ui_page {
    "html/index.html"
}

files {
    'html/*.html',
    'html/*.js',
    'html/*.css',
    'html/img/*.png'
}

shared_scripts {
    'config.lua'
}

--dependencies {
--    'qb-core',
--    'PolyZone'
--}

lua54 'yes'
