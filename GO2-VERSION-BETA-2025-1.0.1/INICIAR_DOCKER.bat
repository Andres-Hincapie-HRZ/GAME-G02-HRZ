@echo off
title Space Conflict - Docker MongoDB
color 0A

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║                                                                ║
echo ║            SPACE CONFLICT - DOCKER MONGODB                     ║
echo ║                                                                ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

REM Verificar si Docker está instalado
docker --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Docker no esta instalado!
    echo Por favor instala Docker Desktop desde: https://www.docker.com/products/docker-desktop
    pause
    exit /b 1
)

REM Verificar si Docker está corriendo
docker info >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Docker no esta corriendo!
    echo Por favor inicia Docker Desktop y vuelve a ejecutar este script.
    pause
    exit /b 1
)

echo [1/3] Docker detectado correctamente
echo.

REM Ir a la carpeta del docker-compose
cd /d "%~dp0supergo2-server-closed-alpha"

REM Iniciar los contenedores
echo [2/3] Iniciando MongoDB con Docker Compose...
echo      (Esto puede tomar unos minutos la primera vez)
echo.
docker-compose up -d

if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Fallo al iniciar Docker Compose
    pause
    exit /b 1
)

echo.
echo [3/3] Esperando que MongoDB este listo...
timeout /t 10 >nul

REM Verificar que MongoDB está corriendo
docker ps | findstr "go2super-mongodb" >nul
if %ERRORLEVEL% EQU 0 (
    echo.
    echo ╔════════════════════════════════════════════════════════════════╗
    echo ║                                                                ║
    echo ║              ¡MONGODB INICIADO CORRECTAMENTE!                  ║
    echo ║                                                                ║
    echo ╚════════════════════════════════════════════════════════════════╝
    echo.
    echo Servicios disponibles:
    echo   • MongoDB:       localhost:27017
    echo   • Mongo Express: http://localhost:8081
    echo     Usuario: admin
    echo     Password: admin123
    echo.
    echo Para detener: docker-compose down
    echo.
) else (
    echo [ERROR] MongoDB no se inicio correctamente
    echo Revisa los logs con: docker-compose logs
)

pause
