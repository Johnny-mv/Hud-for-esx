-- MARK: StartHud
CreateThread(function()
   while ESX == nil do
      Wait(0)
   end
   while not ESX.PlayerLoaded do
      Wait(0)
   end

   local PlayerData

   repeat
      PlayerData = ESX.GetPlayerData()
      Wait(100)
   until PlayerData and PlayerData.job and PlayerData.accounts

   SendNuiMessage(json.encode({
      action = "UpdateId",
      id = GetPlayerServerId(PlayerId())
   }))

   SendNuiMessage(json.encode({
      action = "UpdateJob",
      job = PlayerData.job.label,
      jobgrade = PlayerData.job.grade_label,
   }))

   for k, v in pairs(PlayerData.accounts) do
      if v.name == 'money' then
         SendNuiMessage(json.encode({
            action = "UpdateMoney",
            money = v.money
         }))
         SendNuiMessage(json.encode({
            action = "UpdateBank",
            bank = v.money
         }))
      end
   end

   ESX.TriggerServerCallback("Hud_GetPlayerCount", function(playerCount)
      SendNuiMessage(json.encode({
         action = "UpdatePlayerCount",
         playerCount = playerCount
      }))
   end)
end)

-- MARK: CarHud
CreateThread(function()
   while true do
      local sleep = 500
      if IsPedInAnyVehicle(PlayerPedId(), false) then
         sleep = 50
         local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
         if vehicle then
            SendNuiMessage(json.encode({
               action = "UpdateCarHud",
               status = true,
               speed = math.floor(GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false))* 3.6),
               rpm = GetVehicleCurrentRpm(GetVehiclePedIsIn(PlayerPedId(), false)),
               fuel = math.floor(GetVehicleFuelLevel(GetVehiclePedIsIn(PlayerPedId(), false)))
            }))
         end
      else
         sleep = 500
         SendNuiMessage(json.encode({
            action = "UpdateCarHud",
            status = false,
         }))
      end

      Wait(sleep)
   end
end)

-- MARK: StatusHud
CreateThread(function()
   while true do
      Wait(1000)
      TriggerEvent('esx_status:getStatus', 'hunger', function(hunger)
         TriggerEvent('esx_status:getStatus', 'thirst', function(thirst)
            if hunger and thirst then
               local hunger = math.floor(hunger.val / 10000)
               local thirst = math.floor(thirst.val / 10000)
               SendNuiMessage(json.encode({
                  action = "UpdateStatusStatus",
                  hunger = hunger,
                  thirst = thirst
               }))
            end
         end)
      end)
   end
end)

-- MARK: Postals
local postalsData = LoadResourceFile(GetCurrentResourceName(), 'postal.json')
local postals = json.decode(postalsData)
for i, postal in ipairs(postals) do
   postals[i] = { vec(postal.x, postal.y), code = postal.code}
end

CreateThread(function()
   while postals == nil do
      Wait(0)
   end
   while true do
      Wait(1000)
      local coords = GetEntityCoords(PlayerPedId())
      local nearestIndex, nearsestDestance
      coords = vec(coords[1], coords[2])

      for i = 1, #postals do
         local Distance = #(coords - postals[i][1])
         if not nearestIndex or Distance < nearsestDestance then
            nearestIndex = i
            nearsestDestance = Distance
         end
      end

      local nearestPostalCode = postals[nearestIndex].code
      local streetNameHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
      local streetName = GetStreetNameFromHashKey(streetNameHash)

      SendNuiMessage(json.encode({
         action = "UpdatePostal",
         postal = nearestPostalCode,
         street = streetName
      }))
   end
end)

-- MARK: Exports
exports('Hud_HideHud', function(status)
   SendNuiMessage(json.encode({
      action = "HideHud",
      status = status
   }))
end)

local isHelpNotify = false
exports('Hud_HelpNotify', function(message)
   timer = GetGameTimer()
   if not isHelpNotify then
      isHelpNotify = true
      SendNuiMessage(json.encode({
         action = "HelpNotify",
         status = true,
         message = message
      }))
      CreateThread(function()
         while timer + 100 >= GetGameTimer() do
            SendNuiMessage(json.encode({
               action = "HelpNotify",
               status = true,
               message = message
            }))
            Wait(100)
         end
         isHelpNotify = false
         Wait(0)
         if not isHelpNotify then
            SendNuiMessage(json.encode({
               action = "HelpNotify",
               status = false
            }))
         end
      end)
   end
end)

exports('Hud_Progressbar', function(title, time)
   SendNuiMessage(json.encode({
      action = "Progressbar",
      status = true,
      title = title,
      time = time
   }))
end)

exports('Hud_StopProgressbar', function()
   SendNuiMessage(json.encode({
      action = "Progressbar",
      status = false,
   }))
end)

exports('Hud_Notify', function(type, title, description, time)
   SendNuiMessage(json.encode({
      action = "Notify",
      type = type,
      title = title,
      description = description,
      time = time
   }))
   PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
end)

exports('Hud_Announce', function(title, description, time)
   SendNuiMessage(json.encode({
      action = "Announce",
      title = title,
      description = description,
      time = time
   }))
   PlaySoundFrontend(-1, "Exit_Capture_Zone", "DLC_Apartments_Drop_Zone_Sounds", 1)
end)

-- MARK: Events
RegisterNetEvent('Hud_Progressbar', function(title, time)
   SendNuiMessage(json.encode({
      action = "Progressbar",
      status = true,
      title = title,
      time = time
   }))
end)

RegisterNetEvent('Hud_StopProgressbar', function(time)
   SendNuiMessage(json.encode({
      action = "Progressbar",
      status = false,
   }))
end)

RegisterNetEvent('Hud_Notify', function(type, title, description, time)
   SendNuiMessage(json.encode({
      action = "Notify",
      type = type,
      title = title,
      description = description,
      time = time
   }))
   PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
end)

RegisterNetEvent('Hud_Announce', function(title, description, time)
   SendNuiMessage(json.encode({
      action = "Announce",
      title = title,
      description = description,
      time = time
   }))
   PlaySoundFrontend(-1, "Exit_Capture_Zone", "DLC_Apartments_Drop_Zone_Sounds", 1)
end)

RegisterNetEvent('esx:setJob', function(job)
   SendNuiMessage(json.encode({
      action = "UpdateJob",
      job = ESX.PlayerData().job.label,
      jobgrade = ESX.PlayerData().job.grade_label,
   }))
end)

RegisterNetEvent('esx:setAccountMoney', function(account, money)
   if account.name == 'money' then
      SendNuiMessage(json.encode({
         action = "UpdateMoney",
         money = account.money
      }))
   elseif account.name == 'bank' then
      SendNuiMessage(json.encode({
         action = "UpdateBank",
         bank = account.money
      }))
   end
end)

RegisterNetEvent('Hud_UpdatePlayerCount', function(playerCount)
   SendNuiMessage(json.encode({
      action = "UpdatePlayerCount",
      playerCount = playerCount
   }))
end)

-- MARK: RadioList
RegisterNetEvent("pma-voice:addPlayerToRadio", function(playerId)
   ESX.TriggerServerCallback("Hud_GetPlayerName", function(playerName)
      SendNuiMessage(json.encode({
         action = "AddPlayerToRadio",
         playerId = playerId,
         playerName = playerName
      }))
   end, playerId)
end)

RegisterNetEvent("pma-voice:removePlayerFromRadio", function(playerId)
   SendNuiMessage(json.encode({
      action = "RemovePlayerFromRadio",
      playerId = playerId
   }))
end)

RegisterNetEvent("pma-voice:syncRadioData", function()
   SendNuiMessage(json.encode({
      action = "ClearRadio"
   }))

   ESX.TriggerServerCallback("Hud_GetRadioPlayers", function(playersInRadio, radioChannel)
      SendNuiMessage(json.encode{
         action = "SetRadioChannel",
         channel = radioChannel
      })

      for playerId, playerName in pairs(playersInRadio) do
         SendNuiMessage(json.encode({
            action = "AddPlayerToRadio",
            playerId = playerId,
            playerName = playerName
         }))
      end
   end)
end)

RegisterNetEvent("pma-voice:radioActive")
AddEventHandler("pma-voice:radioActive", function(talkingState)
   SendNuiMessage(json.encode({
      action = "SetTalkingOnRadio",
      source = GetPlayerServerId(PlayerId()),
      talkingState = talkingState
   }))
end)

RegisterNetEvent("pma-voice:setTalkingOnRadio")
AddEventHandler("pma-voice:setTalkingOnRadio", function(source, talkingState)
   SendNuiMessage(json.encode({
      action = "SetTalkingOnRadio",
      source = source,
      talkingState = talkingState
   }))
end)

RegisterCommand('testhud', function()
   TriggerEvent('Hud_Notify', 'success', "Test", "Test", 5000)
   TriggerEvent('Hud_Notify', 'warning', "Test", "Test", 5000)
   TriggerEvent('Hud_Notify', 'error', "Test", "Test", 5000)
   TriggerEvent('Hud_Announce', "Test", "Test", 10000)
   TriggerEvent('Hud_Progressbar', "Test", 2000)

   ia = 0

   CreateThread(function()
      while ia < 800 do
         exports['Hud']:Hud_HelpNotify("Drücke E um zu Interagieren")
         ia = ia + 1
         Wait(0)
      end
   end)
end)