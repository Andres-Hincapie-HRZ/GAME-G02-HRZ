@echo off
setlocal enabledelayedexpansion

echo ========================================
echo   Verificador de Configuracion
echo   SuperGO2 - Sistema de Diagnostico
echo ========================================
echo.

set "ERRORES=0"
set "ADVERTENCIAS=0"

REM ============================================
REM VERIFICAR REQUISITOS DEL SISTEMA
REM ============================================

echo [1/7] Verificando requisitos del sistema...
echo.

REM Verificar Node.js
where node >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo   [OK] Node.js instalado
    node --version
) else (
    echo   [ERROR] Node.js NO esta instalado
    set /a ERRORES+=1
)

REM Verificar Java
where java >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo   [OK] Java instalado
    java -version 2>&1 | findstr "version"
) else (
    echo   [ERROR] Java NO esta instalado
    set /a ERRORES+=1
)

REM Verificar http-server
where http-server >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo   [OK] http-server instalado
) else (
    echo   [ADVERTENCIA] http-server NO esta instalado
    echo                 Instala con: npm install -g http-server
    set /a ADVERTENCIAS+=1
)

echo.

REM ============================================
REM VERIFICAR ARCHIVOS DE CONFIGURACION
REM ============================================

echo [2/7] Verificando archivos de configuracion...
echo.

REM Verificar application.yml
if exist "supergo2-server-closed-alpha\src\main\resources\application.yml" (
    findstr /C:"resources-url: http://localhost:7000/" "supergo2-server-closed-alpha\src\main\resources\application.yml" >nul
    if !ERRORLEVEL! EQU 0 (
        echo   [OK] application.yml configurado correctamente
    ) else (
        echo   [ERROR] application.yml NO tiene la URL correcta
        echo          Debe ser: resources-url: http://localhost:7000/
        set /a ERRORES+=1
    )
) else (
    echo   [ERROR] application.yml NO encontrado
    set /a ERRORES+=1
)

REM Verificar index.html
if exist "Servidor-ON\app\client\index.html" (
    findstr /C:"127.0.0.1" "Servidor-ON\app\client\index.html" >nul
    if !ERRORLEVEL! EQU 0 (
        echo   [OK] index.html configurado correctamente
    ) else (
        echo   [ERROR] index.html NO tiene la IP correcta
        echo          Debe tener: sessionIp = "127.0.0.1"
        set /a ERRORES+=1
    )
) else (
    echo   [ERROR] index.html NO encontrado
    set /a ERRORES+=1
)

REM Verificar config.xml
if exist "Servidor-ON\app\client\data\config.xml" (
    findstr /C:"http://localhost:7000/" "Servidor-ON\app\client\data\config.xml" >nul
    if !ERRORLEVEL! EQU 0 (
        echo   [OK] config.xml configurado correctamente
    ) else (
        echo   [ERROR] config.xml NO tiene la URL correcta
        echo          Debe tener: path="http://localhost:7000/"
        set /a ERRORES+=1
    )
) else (
    echo   [ERROR] config.xml NO encontrado
    set /a ERRORES+=1
)

echo.

REM ============================================
REM VERIFICAR ARCHIVOS SWF EN CDN
REM ============================================

echo [3/7] Verificando archivos SWF en CDN...
echo.

if exist "cdn\asset" (
    dir /b "cdn\asset\*.swf" >nul 2>nul
    if !ERRORLEVEL! EQU 0 (
        for /f %%i in ('dir /b "cdn\asset\*.swf" ^| find /c /v ""') do set COUNT=%%i
        echo   [OK] Encontrados !COUNT! archivos SWF en cdn\asset\
    ) else (
        echo   [ERROR] NO hay archivos SWF en cdn\asset\
        echo          Ejecuta: COPIAR_ARCHIVOS_CDN.bat
        set /a ERRORES+=1
    )
) else (
    echo   [ERROR] Carpeta cdn\asset\ NO existe
    echo          Ejecuta: COPIAR_ARCHIVOS_CDN.bat
    set /a ERRORES+=1
)

echo.

REM ============================================
REM VERIFICAR ARCHIVOS DE MUSICA
REM ============================================

echo [4/7] Verificando archivos de musica...
echo.

if exist "cdn\asset\music" (
    dir /b "cdn\asset\music\*.mp3" >nul 2>nul
    if !ERRORLEVEL! EQU 0 (
        for /f %%i in ('dir /b "cdn\asset\music\*.mp3" ^| find /c /v ""') do set COUNT=%%i
        echo   [OK] Encontrados !COUNT! archivos de musica
    ) else (
        echo   [ADVERTENCIA] NO hay archivos de musica
        echo                 El juego funcionara pero sin sonido
        set /a ADVERTENCIAS+=1
    )
) else (
    echo   [ADVERTENCIA] Carpeta cdn\asset\music\ NO existe
    echo                 El juego funcionara pero sin sonido
    set /a ADVERTENCIAS+=1
)

echo.

REM ============================================
REM VERIFICAR CROSSDOMAIN.XML
REM ============================================

echo [5/7] Verificando crossdomain.xml...
echo.

if exist "cdn\crossdomain.xml" (
    echo   [OK] crossdomain.xml existe en CDN
) else (
    echo   [ERROR] crossdomain.xml NO existe en CDN
    echo          Este archivo es CRITICO para Flash
    set /a ERRORES+=1
)

if exist "Servidor-ON\app\client\crossdomain.xml" (
    echo   [OK] crossdomain.xml existe en cliente
) else (
    echo   [ADVERTENCIA] crossdomain.xml NO existe en cliente
    set /a ADVERTENCIAS+=1
)

echo.

REM ============================================
REM VERIFICAR PUERTOS DISPONIBLES
REM ============================================

echo [6/7] Verificando puertos disponibles...
echo.

netstat -ano | findstr ":1000 " >nul
if %ERRORLEVEL% EQU 0 (
    echo   [ADVERTENCIA] Puerto 1000 ya esta en uso
    set /a ADVERTENCIAS+=1
) else (
    echo   [OK] Puerto 1000 disponible
)

netstat -ano | findstr ":5050 " >nul
if %ERRORLEVEL% EQU 0 (
    echo   [ADVERTENCIA] Puerto 5050 ya esta en uso
    set /a ADVERTENCIAS+=1
) else (
    echo   [OK] Puerto 5050 disponible
)

netstat -ano | findstr ":7000 " >nul
if %ERRORLEVEL% EQU 0 (
    echo   [ADVERTENCIA] Puerto 7000 ya esta en uso
    set /a ADVERTENCIAS+=1
) else (
    echo   [OK] Puerto 7000 disponible
)

netstat -ano | findstr ":8080 " >nul
if %ERRORLEVEL% EQU 0 (
    echo   [ADVERTENCIA] Puerto 8080 ya esta en uso
    set /a ADVERTENCIAS+=1
) else (
    echo   [OK] Puerto 8080 disponible
)

netstat -ano | findstr ":9090 " >nul
if %ERRORLEVEL% EQU 0 (
    echo   [ADVERTENCIA] Puerto 9090 ya esta en uso
    set /a ADVERTENCIAS+=1
) else (
    echo   [OK] Puerto 9090 disponible
)

echo.

REM ============================================
REM VERIFICAR MONGODB
REM ============================================

echo [7/7] Verificando MongoDB...
echo.

netstat -ano | findstr ":27017 " >nul
if %ERRORLEVEL% EQU 0 (
    echo   [OK] MongoDB parece estar corriendo (puerto 27017 en uso)
) else (
    echo   [ADVERTENCIA] MongoDB NO parece estar corriendo
    echo                 Inicia MongoDB antes de continuar
    set /a ADVERTENCIAS+=1
)

echo.
echo ========================================
echo   RESUMEN DE VERIFICACION
echo ========================================
echo.

if %ERRORES% EQU 0 (
    if %ADVERTENCIAS% EQU 0 (
        echo   [EXCELENTE] Todo esta configurado correctamente!
        echo.
        echo   Puedes ejecutar: iniciar_todo.bat
        echo.
    ) else (
        echo   [BIEN] Configuracion basica correcta
        echo   Advertencias encontradas: %ADVERTENCIAS%
        echo.
        echo   Puedes continuar, pero revisa las advertencias arriba.
        echo.
    )
) else (
    echo   [ERROR] Se encontraron %ERRORES% errores criticos
    echo   Advertencias: %ADVERTENCIAS%
    echo.
    echo   Por favor corrige los errores antes de continuar.
    echo.
)

echo ========================================
echo.

if %ERRORES% GTR 0 (
    echo ACCIONES RECOMENDADAS:
    echo.
    echo 1. Si faltan archivos SWF:
    echo    Ejecuta: COPIAR_ARCHIVOS_CDN.bat
    echo.
    echo 2. Si las configuraciones son incorrectas:
    echo    Revisa: SOLUCION_PROBLEMA_CLIENTE_FLASH.md
    echo.
    echo 3. Si faltan requisitos del sistema:
    echo    Instala Node.js, Java 17, MongoDB y http-server
    echo.
)

pause
