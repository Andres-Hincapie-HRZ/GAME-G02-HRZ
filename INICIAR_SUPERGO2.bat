@echo off
title SuperGO2 - Iniciador
color 0A

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║                                                                ║
echo ║                    SUPERGO2 - INICIADOR                        ║
echo ║                                                                ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

REM Verificar si MongoDB esta corriendo
echo [1/5] Verificando MongoDB...
netstat -ano | findstr ":27017 " >nul
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] MongoDB NO esta corriendo!
    echo.
    echo Por favor inicia MongoDB primero:
    echo   1. Abre una ventana CMD como Administrador
    echo   2. Ejecuta: mongod
    echo   3. Deja esa ventana abierta
    echo   4. Vuelve a ejecutar este script
    echo.
    pause
    exit /b 1
)
echo      ✓ MongoDB corriendo en puerto 27017
timeout /t 1 >nul

REM Iniciar CDN
echo.
echo [2/5] Iniciando CDN (puerto 7000)...
start "CDN - Puerto 7000" cmd /k "cd cdn && http-server -p 7000 -a 0.0.0.0 --cors"
timeout /t 3 >nul
echo      ✓ CDN iniciado

REM Iniciar Backend
echo.
echo [3/5] Iniciando Backend (puertos 9090 y 5050)...
echo      (Esto puede tomar 15-20 segundos...)
start "Backend - Puertos 9090/5050" cmd /k "cd supergo2-server-closed-alpha && mvnw spring-boot:run"
timeout /t 15 >nul
echo      ✓ Backend iniciado

REM Iniciar Frontend
echo.
echo [4/5] Iniciando Frontend (puerto 1000)...
start "Frontend - Puerto 1000" cmd /k "cd website && npm start"
timeout /t 5 >nul
echo      ✓ Frontend iniciado

REM Iniciar Cliente Flash
echo.
echo [5/5] Iniciando Cliente Flash (puerto 8080)...
start "Cliente Flash - Puerto 8080" cmd /k "cd Servidor-ON\app\client && http-server -p 8080 --cors"
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
echo ╔════════════════════════════════════════════════════════════════╗
echo ║                     COMO JUGAR:                                ║
echo ║                                                                ║
echo ║  1. Abre Flash Browser                                         ║
echo ║  2. Ve a: http://localhost:1000                                ║
echo ║  3. Inicia sesion o crea una cuenta                            ║
echo ║  4. Crea un planeta                                            ║
echo ║  5. ¡El juego se abrira automaticamente!                       ║
echo ║                                                                ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.
echo NOTA: Se abrieron 4 ventanas CMD. NO las cierres.
echo       Para detener todo, cierra todas las ventanas CMD.
echo.
pause
