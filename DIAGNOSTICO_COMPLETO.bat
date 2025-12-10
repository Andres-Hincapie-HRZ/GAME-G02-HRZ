@echo off
title Diagnostico Completo del Sistema
color 0B

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║                                                                ║
echo ║              DIAGNOSTICO COMPLETO DEL SISTEMA                  ║
echo ║                                                                ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

echo [1/5] Verificando puertos...
echo.

REM Verificar MongoDB
netstat -ano | findstr ":27017 " >nul
if %ERRORLEVEL% EQU 0 (
    echo   [OK] MongoDB corriendo en puerto 27017
) else (
    echo   [ERROR] MongoDB NO esta corriendo en puerto 27017
)

REM Verificar Backend
netstat -ano | findstr ":9090 " >nul
if %ERRORLEVEL% EQU 0 (
    echo   [OK] Backend corriendo en puerto 9090
) else (
    echo   [ERROR] Backend NO esta corriendo en puerto 9090
)

netstat -ano | findstr ":5050 " >nul
if %ERRORLEVEL% EQU 0 (
    echo   [OK] Backend Socket corriendo en puerto 5050
) else (
    echo   [ERROR] Backend Socket NO esta corriendo en puerto 5050
)

REM Verificar Frontend
netstat -ano | findstr ":1000 " >nul
if %ERRORLEVEL% EQU 0 (
    echo   [OK] Frontend corriendo en puerto 1000
) else (
    echo   [ERROR] Frontend NO esta corriendo en puerto 1000
)

REM Verificar CDN
netstat -ano | findstr ":7000 " >nul
if %ERRORLEVEL% EQU 0 (
    echo   [OK] CDN corriendo en puerto 7000
) else (
    echo   [ERROR] CDN NO esta corriendo en puerto 7000
)

REM Verificar Cliente Flash
netstat -ano | findstr ":8080 " >nul
if %ERRORLEVEL% EQU 0 (
    echo   [OK] Cliente Flash corriendo en puerto 8080
) else (
    echo   [ERROR] Cliente Flash NO esta corriendo en puerto 8080
)

echo.
echo [2/5] Verificando archivos del Cliente Flash...
echo.

if exist "Servidor-ON\app\client\PreLoader.swf" (
    echo   [OK] PreLoader.swf
) else (
    echo   [ERROR] PreLoader.swf NO encontrado
)

if exist "Servidor-ON\app\client\config.xml" (
    echo   [OK] config.xml (raiz)
) else (
    echo   [ERROR] config.xml (raiz) NO encontrado
)

if exist "Servidor-ON\app\client\data\config.xml" (
    echo   [OK] config.xml (data/)
) else (
    echo   [ERROR] config.xml (data/) NO encontrado
)

if exist "Servidor-ON\app\client\index.html" (
    echo   [OK] index.html
) else (
    echo   [ERROR] index.html NO encontrado
)

echo.
echo [3/5] Verificando archivos del CDN...
echo.

if exist "cdn\asset\0058Client.swf" (
    echo   [OK] CDN: Archivos SWF
) else (
    echo   [ERROR] CDN: Archivos SWF NO encontrados
)

if exist "cdn\images\sprites.png" (
    echo   [OK] CDN: Imagenes
) else (
    echo   [ERROR] CDN: Imagenes NO encontradas
)

if exist "cdn\asset\music\galaxy.mp3" (
    echo   [OK] CDN: Musica
) else (
    echo   [ERROR] CDN: Musica NO encontrada
)

echo.
echo [4/5] Probando URLs...
echo.

echo   Intenta abrir estas URLs en tu navegador:
echo.
echo   • Frontend:      http://localhost:1000
echo   • Cliente Flash: http://localhost:8080
echo   • CDN:           http://localhost:7000
echo   • Backend API:   http://localhost:9090/actuator/health
echo.
echo   • Test PreLoader:    http://localhost:8080/PreLoader.swf
echo   • Test Config:       http://localhost:8080/config.xml
echo   • Test Sprites:      http://localhost:8080/images/sprites.png
echo   • Test CDN Sprites:  http://localhost:7000/images/sprites.png
echo.

echo [5/5] Recomendaciones...
echo.

netstat -ano | findstr ":8080 " >nul
if %ERRORLEVEL% NEQ 0 (
    echo   [!] El Cliente Flash NO esta corriendo
    echo       Ejecuta: REINICIAR_CLIENTE_FLASH.bat
    echo.
)

if not exist "cdn\images\sprites.png" (
    echo   [!] Faltan imagenes en el CDN
    echo       Ejecuta: COPIAR_ARCHIVOS_CDN.bat
    echo.
)

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║                                                                ║
echo ║              DIAGNOSTICO COMPLETADO                            ║
echo ║                                                                ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

pause


