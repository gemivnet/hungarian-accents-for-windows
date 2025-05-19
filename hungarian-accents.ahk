#SingleInstance Force
SendMode "Input"
SetWorkingDir A_ScriptDir

; Accent character mappings
global accentMaps := Map(
    "acute", Map(
        "a", "á", "e", "é", "i", "í", "o", "ó", "u", "ú",
        "A", "Á", "E", "É", "I", "Í", "O", "Ó", "U", "Ú"
    ),
    "umlaut", Map(
        "o", "ö", "u", "ü", "O", "Ö", "U", "Ü"
    ),
    "doubleacute", Map(
        "o", "ő", "u", "ű", "O", "Ő", "U", "Ű"
    )
)

; Process the next keypress and convert to accented character if applicable
HandleAccent(accentType) {
    global accentMaps
    
    ; Capture the next key without passing it through
    ih := InputHook("L1 B")
    ih.KeyOpt("{Backspace}", "E")
    ih.KeyOpt("{Escape}", "E")
    ih.Start()
    ih.Wait()
    
    ; Cancel if Escape or Backspace was pressed
    if (ih.EndKey)
        return
    
    ; Get the pressed key and send accented version if available
    key := ih.Input
    if (accentMaps[accentType].Has(key))
        Send accentMaps[accentType][key]
    else
        Send key
}

; Alt + e for acute accent (á, é, í, ó, ú)
>!e::HandleAccent("acute")
<!e::HandleAccent("acute")

; Alt + u for umlaut (ö, ü)
>!u::HandleAccent("umlaut")
<!u::HandleAccent("umlaut")

; Alt + o for double acute accent (ő, ű)
>!o::HandleAccent("doubleacute")
<!o::HandleAccent("doubleacute")
