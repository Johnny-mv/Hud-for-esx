fx_version 'cerulean'
game 'gta5'

author 'void_gr20'
description 'Dies ist ein anpassbares HUD für FiveM/ESX mit vielen Features wie Speedometer, Statusanzeigen, Postleitzahlen, Benachrichtigungen, Fortschrittsbalken, Radio-Liste und mehr. - Only for esx asap for qbox and qbcore soon'

client_script 'client/client.lua'
server_script 'server/server.lua'

shared_script '@es_extended/imports.lua'

ui_page 'html/index.html'
files {
   'html/index.html',
   'html/assets/css/**',
   'html/assets/fonts/**',
   'html/assets/img/**',
   'html/assets/js/script.js',
   'postal.json'
}