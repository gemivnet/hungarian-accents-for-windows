; Inno Setup installer for HungarianAccents.
; Compiled by ISCC.exe in CI. AppVersion is overridden via /DAppVersion=X.Y.Z.

#ifndef AppVersion
  #define AppVersion "0.0.0-dev"
#endif

#define AppName       "HungarianAccents"
#define AppPublisher  "gemivnet"
#define AppExeName    "AutoHotkey64.exe"
#define AppScript     "src\main.ahk"
#define AppURL        "https://github.com/gemivnet/hungarian-accents-for-windows"

[Setup]
AppId={{7195D9C4-60C3-4C94-BD47-AA468BDE7582}
AppName={#AppName}
AppVersion={#AppVersion}
AppVerName={#AppName} {#AppVersion}
AppPublisher={#AppPublisher}
AppPublisherURL={#AppURL}
AppSupportURL={#AppURL}/issues
AppUpdatesURL={#AppURL}/releases
DefaultDirName={userpf}\{#AppName}
DefaultGroupName={#AppName}
DisableProgramGroupPage=yes
DisableDirPage=yes
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
OutputBaseFilename=HungarianAccentsSetup
Compression=lzma
SolidCompression=yes
WizardStyle=modern
ArchitecturesInstallIn64BitMode=x64compatible
UninstallDisplayName={#AppName}
UninstallDisplayIcon={app}\{#AppExeName}
AppMutex=Global\HungarianAccents-7195D9C4
#if FileExists(AddBackslash(SourcePath) + "..\assets\icon.ico")
SetupIconFile=..\assets\icon.ico
#endif
CloseApplications=force
RestartApplications=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Create a &desktop shortcut"; GroupDescription: "Additional shortcuts:"; Flags: unchecked
Name: "startupicon"; Description: "Start {#AppName} when Windows starts"; GroupDescription: "Autostart:"

[Files]
; AHK v2 runtime — extracted by CI into ../ahk/ before iscc runs.
Source: "..\ahk\AutoHotkey64.exe"; DestDir: "{app}"; Flags: ignoreversion
; App source. Compiled-at-install metadata (version string) is already injected
; by the release workflow before the installer is built.
Source: "..\src\*"; DestDir: "{app}\src"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\LICENSE"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\README.md"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExeName}"; Parameters: """{app}\{#AppScript}"""; WorkingDir: "{app}"; IconFilename: "{app}\{#AppExeName}"
Name: "{group}\Uninstall {#AppName}"; Filename: "{uninstallexe}"
Name: "{userdesktop}\{#AppName}"; Filename: "{app}\{#AppExeName}"; Parameters: """{app}\{#AppScript}"""; WorkingDir: "{app}"; IconFilename: "{app}\{#AppExeName}"; Tasks: desktopicon

[Registry]
; Autostart entry. Mirrors the in-app tray toggle so both write the same key.
Root: HKCU; Subkey: "Software\Microsoft\Windows\CurrentVersion\Run"; ValueType: string; ValueName: "{#AppName}"; ValueData: """{app}\{#AppExeName}"" ""{app}\{#AppScript}"""; Flags: uninsdeletevalue; Tasks: startupicon

[Run]
Filename: "{app}\{#AppExeName}"; Parameters: """{app}\{#AppScript}"""; WorkingDir: "{app}"; Description: "Launch {#AppName}"; Flags: nowait postinstall skipifsilent
