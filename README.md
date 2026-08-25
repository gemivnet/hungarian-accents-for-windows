# hungarian-accents-for-windows

macOS-style accent input for Hungarian characters on Windows. Hold `Alt + e/u/j`, then a letter, to type `á é í ó ú ö ü ő ű`. Distributed as an Inno Setup installer (`.exe`) that bundles the AutoHotkey v2 runtime and scripts — no separate AutoHotkey install required.

## Install

1. Grab `HungarianAccentsSetup.exe` from the [Releases page](https://github.com/gemivnet/hungarian-accents-for-windows/releases).
2. Double-click to run. The installer is per-user — no admin prompt.
3. SmartScreen will warn (the build is unsigned) — click **More info → Run anyway**.
4. Pick whether to add a desktop shortcut and whether to start with Windows. Click **Install**.

The app installs to `%LOCALAPPDATA%\Programs\HungarianAccents\` and registers in **Settings → Apps → Installed apps** for clean uninstall. A tray icon appears once running — right-click it for Settings, autostart toggle, update check, and exit.

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

On launch and via the tray menu, the app polls GitHub Releases. If a newer build is published, you're prompted with the release notes; clicking **Yes** downloads the new installer and runs it silently — files are replaced, the uninstaller registration stays in sync with the installed version, and the app relaunches automatically.

## Building from source

Requires Windows + [Inno Setup 6](https://jrsoftware.org/isinfo.php). The build downloads the AutoHotkey v2 runtime and packages it with the scripts into an installer — it does not compile a standalone `.exe`. Mirror the CI flow (see `.github/workflows/ci.yml`):

```powershell
# 1. Fetch the AutoHotkey v2 runtime into ahk\
$ahkVersion = "2.0.18"
Invoke-WebRequest -Uri "https://github.com/AutoHotkey/AutoHotkey/releases/download/v$ahkVersion/AutoHotkey_$ahkVersion.zip" -OutFile ahk.zip
Expand-Archive -Path ahk.zip -DestinationPath ahk -Force

# 2. Build the installer with Inno Setup
$version = (Get-Content VERSION -Raw).Trim()
& "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" /DAppVersion=$version /Odist installer\HungarianAccents.iss
```

This produces `dist\HungarianAccentsSetup.exe`. Both CI and the release build share the composite action in `.github/actions/build-installer/`, which also runs `AutoHotkey64.exe /validate` over `src\main.ahk` so a syntax error fails the build instead of shipping.

CI builds the installer on every push and uploads it as the `HungarianAccents-preview` artifact. To publish, push a `vX.Y` or `vX.Y.Z` tag — the release build injects the version and attaches the installer to GitHub Releases.

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
  ci.yml                    # validate + build installer on push/PR
  release.yml               # build + publish on v* tag
.github/actions/
  build-installer/          # shared runtime fetch + validate + compile
```
