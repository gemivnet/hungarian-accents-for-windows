; Hungarian accent maps and the input-hook handler that applies them.

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

global accentEnabled := Map("acute", true, "umlaut", true, "doubleacute", true)

HandleAccent(accentType) {
    global accentMaps, accentEnabled
    if !accentEnabled[accentType] {
        ; Group disabled — send the original modifier+key combo would be lost;
        ; nothing to do here, the hotkey simply consumed the press.
        return
    }
    ih := InputHook("L1 B")
    ih.KeyOpt("{Backspace}", "E")
    ih.KeyOpt("{Escape}", "E")
    ih.Start()
    ih.Wait()
    if (ih.EndKey)
        return
    key := ih.Input
    if (accentMaps[accentType].Has(key))
        Send accentMaps[accentType][key]
    else
        Send key
}
