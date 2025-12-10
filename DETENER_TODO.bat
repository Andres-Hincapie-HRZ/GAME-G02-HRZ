@echo off
title SuperGO2 - Detener Servicios
color 0C

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║                                                                ║
echo ║              SUPERGO2 - DETENER SERVICIOS                      ║
echo ║                                                                ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

echo Deteniendo servicios...
echo.

REM Detener procesos en puertos especificos
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":1000 "') do (
    echo Deteniendo Frontend (puerto 1000)...
    taskkill /PID %%a /F >nul 2>nul
)

for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":5050 "') do (
    echo Deteniendo Backend Socket (puerto 5050)...
    taskkill /PID %%a /F >nul 2>nul
)

for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":7000 "') do (
    echo Deteniendo CDN (puerto 7000)...
    taskkill /PID %%a /F >nul 2>nul
)

for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8080 "') do (
    echo Deteniendo Cliente Flash (puerto 8080)...
    taskkill /PID %%a /F >nul 2>nul
)

for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":9090 "') do (
    echo Deteniendo Backend API (puerto 9090)...
    taskkill /PID %%a /F >nul 2>nul
)

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║                                                                ║
echo ║              ¡TODOS LOS SERVICIOS DETENIDOS!                   ║
echo ║                                                                ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.
echo NOTA: MongoDB NO fue detenido. Si quieres detenerlo:
echo       1. Ve a la ventana CMD donde esta corriendo
echo       2. Presiona Ctrl+C
echo.
pause
