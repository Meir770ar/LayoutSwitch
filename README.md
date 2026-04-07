# LayoutSwitch ⌨️

**Fix text typed in the wrong keyboard layout — instantly.**

Typed a whole sentence and realized you were in the wrong language? Select the text, press **F8**, and it's fixed. One key, works everywhere.

![Demo](https://img.shields.io/badge/Press_F8-Fix_Layout-blue?style=for-the-badge)

## The Problem

Every bilingual typist knows this pain:

```
You type:  akuo
You meant: שלום
```

Windows has **no built-in fix** for this. Until now.

## The Solution

1. Select the mistyped text
2. Press **F8**
3. Done ✅

| Before | After |
|--------|-------|
| `akuo` | `שלום` |
| `שלום` | `akuo` |
| `vpua yh akr` | `הודע לי שלח` |

## Features

- 🔑 **One key** — just F8, no Ctrl+Shift combos
- 🌍 **Works everywhere** — Word, Chrome, VS Code, WhatsApp, Outlook, Excel, Notepad, any app
- 🪶 **Tiny** — 2KB script, zero UI, zero tray icons, zero bloat
- 🚀 **Auto-start** — launches with Windows silently
- 🔄 **Auto-detect** — knows if your text is Hebrew or English
- 🔓 **Open source** — read the code, modify it, trust it

## Supported Layouts

- **English (US/QWERTY) ↔ Hebrew (Standard Israeli)**

> Want to add another language pair? PRs welcome! See [Contributing](#contributing).

## Installation

### Option 1: One-Click Installer (Recommended)

1. Download the [latest release](../../releases/latest)
2. Extract the ZIP
3. Run `LayoutSwitch-Installer.bat`
4. Done — F8 works immediately

The installer will:
- Install AutoHotkey v2 if needed (via winget)
- Copy the script to your Documents folder
- Add it to Windows Startup

### Option 2: Manual

1. Install [AutoHotkey v2](https://www.autohotkey.com/)
2. Download `LayoutSwitch.ahk`
3. Double-click to run
4. (Optional) Copy to `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\` for auto-start

## How It Works

The script maps each physical key position between English and Hebrew keyboard layouts. When you press F8:

1. Copies selected text to clipboard
2. Detects if the text is Hebrew or English (by Unicode range)
3. Converts each character using the keyboard position map
4. Pastes the corrected text back

No AI, no internet, no API calls. Pure local character mapping.

## Uninstall

Delete this file:
```
%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\LayoutSwitch.ahk
```

## Requirements

- Windows 10/11
- AutoHotkey v2 (auto-installed by the installer)

## Why Not Just Use...

| Alternative | Problem |
|------------|---------|
| **Langover** | Heavy install, tray icon, shareware |
| **KEset** | Chrome extension only — doesn't work in Word, WhatsApp, etc. |
| **Online converters** | Copy → paste → convert → copy → paste back. Tedious. |
| **Windows built-in** | Doesn't exist ❌ |
| **LayoutSwitch** | One key. Every app. 2KB. Free. ✅ |

## Contributing

Want to add support for another language pair (Russian, Arabic, French, etc.)?

1. Fork this repo
2. Add a new `Map()` in `LayoutSwitch.ahk` with the key mappings
3. Submit a PR

## License

MIT — do whatever you want with it.

## Author

Built by **Meir Arad** | [M Digital](https://mehubarim.org.il)

---

*If this saved you time, give it a ⭐*
