@echo off
title Reiniciar Cliente Flash
color 0C

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║                                                                ║
echo ║              REINICIAR CLIENTE FLASH (Puerto 8080)             ║
echo ║                                                                ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

echo [1/3] Deteniendo servidor en puerto 8080...
echo.

REM Buscar y matar proceso en puerto 8080
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8080 "') do (
    echo      Matando proceso PID: %%a
    taskkill /F /PID %%a >nul 2>&1
)

timeout /t 2 >nul
echo      ✓ Puerto 8080 liberado
echo.

echo [2/3] Verificando archivos...
echo.

if not exist "Servidor-ON\app\client\PreLoader.swf" (
    echo      [ERROR] PreLoader.swf NO encontrado!
    pause
    exit /b 1
)

if not exist "Servidor-ON\app\client\config.xml" (
    echo      [ERROR] config.xml NO encontrado!
    pause
    exit /b 1
)

echo      ✓ Archivos verificados
echo.

echo [3/3] Iniciando Cliente Flash...
echo.

cd Servidor-ON\app\client
start "Cliente Flash - Puerto 8080" cmd /k "http-server -p 8080 --cors -a 0.0.0.0"

timeout /t 3 >nul

echo      ✓ Cliente Flash iniciado en puerto 8080
echo.

echo ╔════════════════════════════════════════════════════════════════╗
echo ║                                                                ║
echo ║              ✓ CLIENTE FLASH REINICIADO                        ║
echo ║                                                                ║
echo ║  URL: http://localhost:8080                                    ║
echo ║                                                                ║
echo ║  Prueba cargar:                                                ║
echo ║  • http://localhost:8080/PreLoader.swf                         ║
echo ║  • http://localhost:8080/config.xml                            ║
echo ║  • http://localhost:8080/images/sprites.png                    ║
echo ║                                                                ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

pause


