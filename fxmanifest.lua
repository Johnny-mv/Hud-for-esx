fx_version 'cerulean'
game 'gta5'

author 'void_gr20'
description 'This is a customizable HUD for FiveM/ESX with many features such as a speedometer, status indicators, postal codes, notifications, progress bars, radio playlists, and more. - Only for ESX; QBox and QB Core versions coming soon.'

client_script 'client/client.lua'
server_script 'server/server.lua'

shared_script '@es_extended/imports.lua'

ui_page 'html/index.html'
files {
   "html/index.html",
   "html/**/*.*",
   'postal.json'
}