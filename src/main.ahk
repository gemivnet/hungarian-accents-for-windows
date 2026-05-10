#Requires AutoHotkey v2.0
#SingleInstance Force
Persistent
SendMode "Input"
SetWorkingDir A_ScriptDir

;@Ahk2Exe-Set Name, HungarianAccents
;@Ahk2Exe-Set Description, macOS-style Hungarian accent input for Windows
;@Ahk2Exe-Set Copyright, MIT License
;@Ahk2Exe-SetMainIcon ..\assets\icon.ico

#Include lib\version.ahk
#Include lib\config.ahk
#Include lib\autostart.ahk
#Include lib\updater.ahk
#Include lib\updater_ui.ahk
#Include lib\tray.ahk
#Include lib\accents.ahk
#Include lib\settings_gui.ahk

global APP_NAME := "HungarianAccents"

AppConfigInit(APP_NAME)
AutostartInit(APP_NAME)
UpdaterInit(APP_NAME, "gemivnet", "hungarian-accents-for-windows")
SettingsLoad()

TrayInit(APP_NAME, [], ShowSettings, UpdaterCheckAndPrompt)

; Delayed background update check so launch is never blocked by network IO.
SetTimer(() => UpdaterCheckAndPrompt(false), -5000)

; Hotkeys — left or right Alt + letter triggers the accent handler.
>!e::HandleAccent("acute")
<!e::HandleAccent("acute")
>!u::HandleAccent("umlaut")
<!u::HandleAccent("umlaut")
>!j::HandleAccent("doubleacute")
<!j::HandleAccent("doubleacute")
