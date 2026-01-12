ESX.RegisterServerCallback("Hud_GetPlayerName", function(source, cb, playerId)
   local xPlayer = ESX.GetPlayerFromId(playerId)
   if xPlayer then
      cb(GetPlayerName(xPlayer.source))
   else
      cb("Unknown")
   end
end)

ESX.RegisterServerCallback("Hud_GetPlayerCount", function(source, cb)
   cb(#GetPlayers())
end)

function UpdatePlayerCountLoop()
   TriggerClientEvent("Hud:UpdatePlayerCount", -1, #GetPlayers())
   SetTimeout(1 * 60 * 1000, UpdatePlayerCountLoop)
end
UpdatePlayerCountLoop()

ESX.RegisterServerCallback("Hud_GetRadioPlayers", function(source, cb)
   local playersInRadio = {}
   local radioChannel = Player(source).state.radioChannel or 0

   for player in pairs(exports["pma-voice"]:getPlayersInRadioChannel(radioChannel)) do
      playersInRadio[player] = GetPlayerName(player)
   end
   cb(playersInRadio, radioChannel)
end)