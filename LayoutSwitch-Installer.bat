@echo off
chcp 65001 >nul
echo ================================================
echo    Layout Switch - Hebrew/English Fix
echo    לחץ F8 על טקסט מסומן להמרת שפה
echo ================================================
echo.

:: Check if AutoHotkey is installed
if exist "%LOCALAPPDATA%\Programs\AutoHotkey\v2\AutoHotkey64.exe" (
    echo AutoHotkey found!
    goto :install
)

echo Installing AutoHotkey...
winget install --id=AutoHotkey.AutoHotkey -e --accept-source-agreements --accept-package-agreements --silent
if errorlevel 1 (
    echo ERROR: Failed to install AutoHotkey.
    echo Please install manually from https://www.autohotkey.com
    pause
    exit /b 1
)
echo AutoHotkey installed!

:install
echo.
echo Installing Layout Switch...

:: Copy script to Documents
copy /Y "%~dp0LayoutSwitch.ahk" "%USERPROFILE%\Documents\LayoutSwitch.ahk" >nul

:: Add to Startup
copy /Y "%~dp0LayoutSwitch.ahk" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\LayoutSwitch.ahk" >nul

:: Launch now
start "" "%LOCALAPPDATA%\Programs\AutoHotkey\v2\AutoHotkey64.exe" "%USERPROFILE%\Documents\LayoutSwitch.ahk"

echo.
echo ================================================
echo    Installation complete!
echo    F8 = Fix selected text language
echo    Starts automatically with Windows
echo ================================================
echo.
pause
