@echo off
title Super Galaxy Online II
cd /d "%~dp0"

REM Abrir con perfil portable (guarda historial)
start "" "browser\FlashBrowser.exe" --user-data-dir="%~dp0browser\UserData" "http://localhost:1000/"
exit
