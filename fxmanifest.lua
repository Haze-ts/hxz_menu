fx_version 'adamant'

shared_script '@es_extended/imports.lua'

games {'gta5'}

author 'Haze#3355'

version '1.0.1'

client_scripts {
    'client.lua',
    'config.lua'
}

server_scripts{
    '@mysql-async/lib/MySQL.lua',
    'server.lua',
    'config.lua'
}