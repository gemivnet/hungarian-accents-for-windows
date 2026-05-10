; Settings window — toggles for each accent group. Persists to config.ini.

global settingsGui := ""

ShowSettings(*) {
    global settingsGui, accentEnabled
    if (settingsGui != "") {
        try {
            settingsGui.Show()
            return
        } catch {
        }
    }
    settingsGui := Gui("+AlwaysOnTop", TRAY_APP_NAME " — Settings")
    settingsGui.SetFont("s10")
    settingsGui.Add("Text", , "Enable accent groups:")
    cbAcute := settingsGui.Add("Checkbox", "vAcute Checked" (accentEnabled["acute"] ? 1 : 0), "Acute (Alt+E → á é í ó ú)")
    cbUml   := settingsGui.Add("Checkbox", "vUmlaut Checked" (accentEnabled["umlaut"] ? 1 : 0), "Umlaut (Alt+U → ö ü)")
    cbDbl   := settingsGui.Add("Checkbox", "vDoubleAcute Checked" (accentEnabled["doubleacute"] ? 1 : 0), "Double acute (Alt+J → ő ű)")
    settingsGui.Add("Text", "y+10", "Hotkey changes require restarting the app.")
    saveBtn := settingsGui.Add("Button", "Default w90", "Save")
    closeBtn := settingsGui.Add("Button", "x+10 w90", "Cancel")
    saveBtn.OnEvent("Click", (*) => SettingsSave(settingsGui))
    closeBtn.OnEvent("Click", (*) => settingsGui.Hide())
    settingsGui.OnEvent("Close", (*) => settingsGui.Hide())
    settingsGui.Show()
}

SettingsSave(gui) {
    global accentEnabled
    data := gui.Submit(false)
    accentEnabled["acute"]       := data.Acute ? true : false
    accentEnabled["umlaut"]      := data.Umlaut ? true : false
    accentEnabled["doubleacute"] := data.DoubleAcute ? true : false
    ConfigWriteBool("Accents", "Acute", accentEnabled["acute"])
    ConfigWriteBool("Accents", "Umlaut", accentEnabled["umlaut"])
    ConfigWriteBool("Accents", "DoubleAcute", accentEnabled["doubleacute"])
    gui.Hide()
}

SettingsLoad() {
    global accentEnabled
    accentEnabled["acute"]       := ConfigReadBool("Accents", "Acute", true)
    accentEnabled["umlaut"]      := ConfigReadBool("Accents", "Umlaut", true)
    accentEnabled["doubleacute"] := ConfigReadBool("Accents", "DoubleAcute", true)
}
