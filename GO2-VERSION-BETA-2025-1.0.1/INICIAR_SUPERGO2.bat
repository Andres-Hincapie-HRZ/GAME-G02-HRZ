@echo off
title Space Conflict - Iniciador
color 0A

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║                                                                ║
echo ║                  SPACE CONFLICT - INICIADOR                    ║
echo ║                                                                ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

REM Crear carpeta de datos de MongoDB si no existe
if not exist "C:\data\db" mkdir "C:\data\db"

REM Iniciar MongoDB
echo [1/5] Iniciando MongoDB...
netstat -ano | findstr ":27017 " >nul
if %ERRORLEVEL% NEQ 0 (
    echo      Iniciando MongoDB en segundo plano...
    start "MongoDB" "C:\Program Files\MongoDB\Server\8.2\bin\mongod.exe" --dbpath=C:\data\db
    timeout /t 5 >nul
)
echo      ✓ MongoDB iniciado en puerto 27017

REM Iniciar CDN
echo.
echo [2/5] Iniciando CDN (puerto 7000)...
start "CDN - Puerto 7000" cmd /k "cd /d %~dp0cdn && http-server -p 7000 -a 0.0.0.0 --cors"
timeout /t 3 >nul
echo      ✓ CDN iniciado

REM Iniciar Backend con JAVA_HOME correcto
echo.
echo [3/5] Iniciando Backend (puertos 9090 y 5050)...
echo      (Esto puede tomar 15-20 segundos...)
start "Backend - Puertos 9090/5050" cmd /k "set "JAVA_HOME=C:\Program Files\Java\jdk-17" && cd /d %~dp0supergo2-server-closed-alpha && mvnw clean spring-boot:run -Dspring-boot.run.profiles=dev"
timeout /t 15 >nul
echo      ✓ Backend iniciado

REM Iniciar Frontend (sin abrir navegador)
echo.
echo [4/5] Iniciando Frontend (puerto 1000)...
start "Frontend - Puerto 1000" cmd /k "set BROWSER=none && cd /d %~dp0website && npm start"
timeout /t 5 >nul
echo      ✓ Frontend iniciado

REM Iniciar Cliente Flash
echo.
echo [5/5] Iniciando Cliente Flash (puerto 8080)...
start "Cliente Flash - Puerto 8080" cmd /k "cd /d %~dp0Servidor-ON\app\client && http-server -p 8080 --cors"
timeout /t 2 >nul
echo      ✓ Cliente Flash iniciado

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║                                                                ║
echo ║              ¡TODOS LOS SERVICIOS INICIADOS!                   ║
echo ║                                                                ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.
echo URLs de acceso:
echo   • Frontend:      http://localhost:1000
echo   • Cliente Flash: http://localhost:8080
echo   • CDN:           http://localhost:7000
echo   • Backend API:   http://localhost:9090
echo.
echo Para jugar ejecuta: supergo2-app\SuperGo2.bat
echo.
echo NOTA: Se abrieron varias ventanas CMD. NO las cierres.
echo.
pause
