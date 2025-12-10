@echo off
echo ========================================
echo   Copiando archivos al CDN
echo ========================================
echo.

echo Creando estructura de carpetas...
if not exist "cdn\asset" mkdir "cdn\asset"
if not exist "cdn\asset\music" mkdir "cdn\asset\music"
if not exist "cdn\images" mkdir "cdn\images"

echo.
echo Copiando archivos SWF...
xcopy /E /I /Y "Servidor-ON\app\client\asset\*.swf" "cdn\asset\" >nul
if %ERRORLEVEL% EQU 0 (
    echo [OK] Archivos SWF copiados correctamente
) else (
    echo [ERROR] No se pudieron copiar los archivos SWF
)

echo.
echo Copiando archivos de musica...
xcopy /E /I /Y "Servidor-ON\app\client\asset\music\*.*" "cdn\asset\music\" >nul
if %ERRORLEVEL% EQU 0 (
    echo [OK] Archivos de musica copiados correctamente
) else (
    echo [ERROR] No se pudieron copiar los archivos de musica
)

echo.
echo Copiando imagenes de sprites y terrenos...
xcopy /E /I /Y "Servidor-ON\app\client\images\*.*" "cdn\images\" >nul
if %ERRORLEVEL% EQU 0 (
    echo [OK] Imagenes copiadas correctamente
) else (
    echo [ERROR] No se pudieron copiar las imagenes
)

echo.
echo ========================================
echo   Proceso completado!
echo ========================================
echo.
echo Archivos copiados:
echo   - SWF a: cdn\asset\
echo   - Musica a: cdn\asset\music\
echo   - Imagenes a: cdn\images\
echo.
pause
