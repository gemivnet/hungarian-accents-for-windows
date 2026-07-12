# Icon

Drop a Windows `.ico` file here named `icon.ico` and the Inno Setup build will
use it as the installer's icon (`SetupIconFile` in `installer/HungarianAccents.iss`).
If absent, the installer falls back to Inno Setup's default icon.

Recommended: a 256×256 ICO with multiple embedded sizes (16, 32, 48, 256).
