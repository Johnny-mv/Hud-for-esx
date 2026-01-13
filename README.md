
# Mileniov HUD for ESX

This is a customizable HUD for FiveM/ESX with many features such as speedometer, status displays, postal codes, notifications, progress bar, radio list, and more.

## Features

- Player ID, job, and account balances (cash, bank)
- Vehicle HUD (speed, RPM, fuel)
- Status displays (hunger, thirst)
- Postal code and street name display
- Progress bar
- Notifications (Notify, Announce, HelpNotify)
- Radio list (pma-voice integration)
- Player counter

---

## Exports

These functions can be called from other resources via `exports['Hud']:ExportName(...)`:

### Hud_HideHud(status)
Shows or hides the HUD.
```lua
exports['Hud']:Hud_HideHud(true) -- Hide HUD
exports['Hud']:Hud_HideHud(false) -- Show HUD
```

### Hud_HelpNotify(message)
Shows a temporary help notification.
```lua
exports['Hud']:Hud_HelpNotify('Press E to interact')
```

### Hud_Progressbar(title, time)
Shows a progress bar.
```lua
exports['Hud']:Hud_Progressbar('Loading...', 3000)
```

### Hud_StopProgressbar()
Hides the progress bar.
```lua
exports['Hud']:Hud_StopProgressbar()
```

### Hud_Notify(type, title, description, time)
Shows a notification. Types: `success`, `warning`, `error`.
```lua
exports['Hud']:Hud_Notify('success', 'Title', 'Description', 5000)
```

### Hud_Announce(title, description, time)
Large announcement at the top of the screen.
```lua
exports['Hud']:Hud_Announce('Title', 'Description', 8000)
```

---

## Events

These events can be triggered via `TriggerEvent`:

- `Hud_Progressbar`, `Hud_StopProgressbar`, `Hud_Notify`, `Hud_Announce`
	- Example:
		```lua
		TriggerEvent('Hud_Notify', 'success', 'Title', 'Description', 5000)
		TriggerEvent('Hud_Announce', 'Title', 'Description', 8000)
		TriggerEvent('Hud_Progressbar', 'Loading...', 3000)
		TriggerEvent('Hud_StopProgressbar')
		```

---

## Server Callbacks

- `Hud_GetPlayerName(playerId)` → Player name
- `Hud_GetPlayerCount()` → Number of players
- `Hud_GetRadioPlayers()` → Players in the current radio channel

---

## Miscellaneous

- Postal codes are loaded from the `postal.json` file and displayed automatically.
- The radio list is compatible with pma-voice.
- Test command: `/testhud` (shows all HUD elements as a demo)

---

## Installation

1. Place in your resources folder and start in `server.cfg`:
	 ```
	 ensure Hud
	 ```
2. Dependencies: ESX, pma-voice

---

## Credits

Created by Johnny-mv, adapted for Mileniov.

This script is free and may not be sold. Please respect the work of the developers.