#!/bin/bash
# LayoutSwitch Installer for macOS
# Installs Hammerspoon + LayoutSwitch

echo "================================================"
echo "   LayoutSwitch — Hebrew/English Fix for Mac"
echo "   Press F8 on selected text to fix language"
echo "================================================"
echo ""

# Check if Hammerspoon is installed
if [ -d "/Applications/Hammerspoon.app" ] || [ -d "$HOME/Applications/Hammerspoon.app" ]; then
    echo "✅ Hammerspoon found"
else
    echo "📦 Installing Hammerspoon..."
    if command -v brew &> /dev/null; then
        brew install --cask hammerspoon
    else
        echo ""
        echo "❌ Homebrew not found."
        echo "   Please install Hammerspoon manually:"
        echo "   https://www.hammerspoon.org/"
        echo ""
        echo "   After installing, run this script again."
        exit 1
    fi
    echo "✅ Hammerspoon installed"
fi

# Create Hammerspoon config directory
mkdir -p "$HOME/.hammerspoon"

# Check if init.lua exists and has content
if [ -s "$HOME/.hammerspoon/init.lua" ]; then
    # Append to existing config
    echo "" >> "$HOME/.hammerspoon/init.lua"
    echo "-- LayoutSwitch: Hebrew/English keyboard fix" >> "$HOME/.hammerspoon/init.lua"
    echo "dofile(hs.configdir .. '/layout-switch.lua')" >> "$HOME/.hammerspoon/init.lua"
    echo "✅ Added LayoutSwitch to existing Hammerspoon config"
else
    # Create new config
    echo "-- LayoutSwitch: Hebrew/English keyboard fix" > "$HOME/.hammerspoon/init.lua"
    echo "dofile(hs.configdir .. '/layout-switch.lua')" >> "$HOME/.hammerspoon/init.lua"
    echo "✅ Created Hammerspoon config"
fi

# Copy the script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cp "$SCRIPT_DIR/LayoutSwitch.lua" "$HOME/.hammerspoon/layout-switch.lua"
echo "✅ LayoutSwitch script installed"

# Open Hammerspoon
open -a Hammerspoon 2>/dev/null

echo ""
echo "================================================"
echo "   ✅ Installation complete!"
echo "   F8 = Fix selected text language"
echo ""
echo "   Make sure Hammerspoon is running (menu bar)"
echo "   and has Accessibility permissions enabled:"
echo "   System Settings → Privacy → Accessibility"
echo "================================================"
echo ""
