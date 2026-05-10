# hungarian-accents-for-windows

macOS-style accent input for Hungarian characters on Windows. Hold `Alt + e/u/j`, then a letter, to type `á é í ó ú ö ü ő ű`. Distributed as a single self-contained `.exe` — no AutoHotkey install required.

## Install

1. Grab the latest `HungarianAccents.exe` from the [Releases page](https://github.com/gemivnet/hungarian-accents-for-windows/releases).
2. Drop it anywhere (e.g. `%LOCALAPPDATA%\HungarianAccents\`) and double-click to run.
3. SmartScreen will warn on first launch (the build is unsigned) — click **More info → Run anyway**.

A tray icon appears. Right-click it for Settings, autostart toggle, update check, and exit.

## Usage

Just like on macOS:

| Combo | Then type | Result |
|---|---|---|
| `Alt + e` | `a e i o u` (or uppercase) | `á é í ó ú` |
| `Alt + u` | `o u` | `ö ü` |
| `Alt + j` | `o u` | `ő ű` |

Press **Backspace** or **Escape** after the modifier to cancel.

## Tray menu

- **Settings…** — enable/disable each accent group
- **Start with Windows** — toggleable; writes to `HKCU\…\Run`
- **Check for updates** — manual check (the app also auto-checks 5 s after startup)
- **About** — version + link to repo
- **Exit**

The app stores its config at `%APPDATA%\HungarianAccents\config.ini`.

## Auto-update

On launch and via the tray menu, the app polls GitHub Releases. If a newer build is published, you're prompted with the release notes; clicking **Yes** downloads the new `.exe` and a small batch script swaps it in and relaunches.

## Building from source

Requires Windows + [AutoHotkey v2](https://www.autohotkey.com/) (which ships with Ahk2Exe under `Compiler\`):

```powershell
& "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" `
    /in src\main.ahk /out dist\HungarianAccents.exe `
    /base "C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe"
```

CI builds an artifact on every push; tag `vX.Y.Z` (and push the tag) to trigger a release build that publishes the `.exe` to GitHub Releases.

## Layout

```
src/
  main.ahk                  # entry point + hotkey bindings
  lib/
    version.ahk             # APP_VERSION (replaced in CI)
    config.ahk              # %APPDATA% ini read/write
    autostart.ahk           # HKCU Run toggle
    updater.ahk             # GitHub Releases polling + swap
    updater_ui.ahk          # update prompt
    tray.ahk                # tray menu builder
    accents.ahk             # accent maps + input hook
    settings_gui.ahk        # settings window
.github/workflows/
  ci.yml                    # compile-check on push/PR
  release.yml               # build + publish on v*.*.* tag
```
