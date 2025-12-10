@echo off
title Verificacion de Archivos del Cliente Flash
color 0E

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║                                                                ║
echo ║         VERIFICACION DE ARCHIVOS DEL CLIENTE FLASH             ║
echo ║                                                                ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

set ERRORES=0

echo [1/4] Verificando archivos criticos...
echo.

REM Verificar PreLoader.swf
if exist "Servidor-ON\app\client\PreLoader.swf" (
    echo   [OK] PreLoader.swf encontrado
) else (
    echo   [ERROR] PreLoader.swf NO encontrado
    set /a ERRORES+=1
)

REM Verificar config.xml en raiz
if exist "Servidor-ON\app\client\config.xml" (
    echo   [OK] config.xml encontrado en raiz
) else (
    echo   [ERROR] config.xml NO encontrado en raiz
    set /a ERRORES+=1
)

REM Verificar config.xml en data/
if exist "Servidor-ON\app\client\data\config.xml" (
    echo   [OK] config.xml encontrado en data/
) else (
    echo   [ERROR] config.xml NO encontrado en data/
    set /a ERRORES+=1
)

REM Verificar index.html
if exist "Servidor-ON\app\client\index.html" (
    echo   [OK] index.html encontrado
) else (
    echo   [ERROR] index.html NO encontrado
    set /a ERRORES+=1
)

echo.
echo [2/4] Verificando archivos SWF en asset/...
echo.

if exist "Servidor-ON\app\client\asset\0058Client.swf" (
    echo   [OK] 0058Client.swf encontrado
) else (
    echo   [ERROR] 0058Client.swf NO encontrado
    set /a ERRORES+=1
)

if exist "Servidor-ON\app\client\asset\0518map_asset.swf" (
    echo   [OK] 0518map_asset.swf encontrado
) else (
    echo   [ERROR] 0518map_asset.swf NO encontrado
    set /a ERRORES+=1
)

if exist "Servidor-ON\app\client\asset\0048GameRes.swf" (
    echo   [OK] 0048GameRes.swf encontrado
) else (
    echo   [ERROR] 0048GameRes.swf NO encontrado
    set /a ERRORES+=1
)

echo.
echo [3/4] Verificando imagenes...
echo.

if exist "Servidor-ON\app\client\images\sprites.png" (
    echo   [OK] sprites.png encontrado
) else (
    echo   [ERROR] sprites.png NO encontrado
    set /a ERRORES+=1
)

if exist "Servidor-ON\app\client\images\bg_game.jpg" (
    echo   [OK] bg_game.jpg encontrado
) else (
    echo   [ERROR] bg_game.jpg NO encontrado
    set /a ERRORES+=1
)

echo.
echo [4/4] Verificando CDN...
echo.

if exist "cdn\asset\0058Client.swf" (
    echo   [OK] CDN: 0058Client.swf encontrado
) else (
    echo   [ERROR] CDN: 0058Client.swf NO encontrado
    set /a ERRORES+=1
)

if exist "cdn\images\sprites.png" (
    echo   [OK] CDN: sprites.png encontrado
) else (
    echo   [ERROR] CDN: sprites.png NO encontrado
    set /a ERRORES+=1
)

echo.
echo ╔════════════════════════════════════════════════════════════════╗

if %ERRORES% EQU 0 (
    echo ║                                                                ║
    echo ║              ✓ TODOS LOS ARCHIVOS CORRECTOS                    ║
    echo ║                                                                ║
) else (
    echo ║                                                                ║
    echo ║              ✗ ERRORES ENCONTRADOS: %ERRORES%                         ║
    echo ║                                                                ║
)

echo ╚════════════════════════════════════════════════════════════════╝
echo.

if %ERRORES% GTR 0 (
    echo Ejecuta COPIAR_ARCHIVOS_CDN.bat para corregir los errores
    echo.
)

pause


