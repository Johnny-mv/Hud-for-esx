# Mileniov HUD für ESX

Dies ist ein anpassbares HUD für FiveM/ESX mit vielen Features wie Speedometer, Statusanzeigen, Postleitzahlen, Benachrichtigungen, Fortschrittsbalken, Radio-Liste und mehr.

## Features

- Spieler-ID, Job und Kontostände (Bargeld, Bank)
- Fahrzeug-HUD (Geschwindigkeit, RPM, Tank)
- Statusanzeigen (Hunger, Durst)
- Postleitzahlen- und Straßennamenanzeige
- Fortschrittsbalken
- Benachrichtigungen (Notify, Announce, HelpNotify)
- Radio-Liste (pma-voice Integration)
- Spielerzähler

---

## Exports

Diese Funktionen können von anderen Ressourcen über `exports['mileniov_hud']:ExportName(...)` aufgerufen werden:

### Hud_HideHud(status)
Blendet das HUD ein/aus.
```lua
exports['mileniov_hud']:Hud_HideHud(true) -- HUD ausblenden
exports['mileniov_hud']:Hud_HideHud(false) -- HUD einblenden
```

### Hud_HelpNotify(message)
Zeigt eine temporäre Hilfsbenachrichtigung an.
```lua
exports['mileniov_hud']:Hud_HelpNotify('Drücke E um zu interagieren')
```

### Hud_Progressbar(title, time)
Zeigt einen Fortschrittsbalken an.
```lua
exports['mileniov_hud']:Hud_Progressbar('Lädt...', 3000)
```

### Hud_StopProgressbar()
Blendet den Fortschrittsbalken aus.
```lua
exports['mileniov_hud']:Hud_StopProgressbar()
```

### Hud_Notify(type, title, description, time)
Zeigt eine Benachrichtigung an. Typen: `success`, `warning`, `error`.
```lua
exports['mileniov_hud']:Hud_Notify('success', 'Titel', 'Beschreibung', 5000)
```

### Hud_Announce(title, description, time)
Große Ankündigung oben auf dem Bildschirm.
```lua
exports['mileniov_hud']:Hud_Announce('Titel', 'Beschreibung', 8000)
```

---

## Events

Diese Events können per `TriggerEvent` ausgelöst werden:

- `Hud_Progressbar`, `Hud_StopProgressbar`, `Hud_Notify`, `Hud_Announce`
	- Beispiel:
		```lua
		TriggerEvent('Hud_Notify', 'success', 'Titel', 'Beschreibung', 5000)
		TriggerEvent('Hud_Announce', 'Titel', 'Beschreibung', 8000)
		TriggerEvent('Hud_Progressbar', 'Lädt...', 3000)
		TriggerEvent('Hud_StopProgressbar')
		```

---

## Server Callbacks

- `Hud_GetPlayerName(playerId)` → Spielername
- `Hud_GetPlayerCount()` → Anzahl der Spieler
- `Hud_GetRadioPlayers()` → Spieler im aktuellen Funkkanal

---

## Sonstiges

- Postleitzahlen werden aus der Datei `postal.json` geladen und automatisch angezeigt.
- Die Radio-Liste ist mit pma-voice kompatibel.
- Testbefehl: `/testhud` (zeigt alle HUD-Elemente als Demo)

---

## Installation

1. In deinen Ressourcenordner legen und in der `server.cfg` starten:
	 ```
	 ensure mileniov_hud
	 ```
2. Abhängigkeiten: ESX, pma-voice

---

## Credits

Erstellt von Johnny-mv, angepasst für Mileniov.

Dieses Script ist kostenlos und darf nicht verkauft werden. Bitte respektiere die Arbeit der Entwickler.