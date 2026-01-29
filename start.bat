@echo off
REM Script para iniciar los servicios de NuevaEPS con Docker Compose
REM Uso: start.bat [comando]

setlocal enabledelayedexpansion

set COMMAND=%1

if "%COMMAND%"=="" (
    set COMMAND=up
)

echo.
echo ======================================
echo     NuevaEPS - Docker Compose Manager
echo ======================================
echo.

if "%COMMAND%"=="up" (
    echo Iniciando servicios...
    docker-compose --env-file .env.dev up -d
    echo.
    echo [OK] Servicios iniciados exitosamente
    echo.
    echo Acceso a los servicios:
    echo   - Backend API: http://localhost:8080
    echo   - Swagger UI: http://localhost:8080/swagger-ui.html
    echo   - pgAdmin DB: http://localhost:5050
    echo   - Email: admin@nuevaeps.com
    echo   - Contraseña: admin
    echo.
    goto end
)

if "%COMMAND%"=="down" (
    echo Deteniendo servicios...
    docker-compose down
    echo [OK] Servicios detenidos
    goto end
)

if "%COMMAND%"=="logs" (
    docker-compose logs -f
    goto end
)

if "%COMMAND%"=="build" (
    echo Construyendo imagen del backend...
    docker-compose build backend
    echo [OK] Imagen construida
    goto end
)

if "%COMMAND%"=="clean" (
    echo Eliminando contenedores, volumenes e imagenes...
    docker-compose down -v
    echo [OK] Limpieza completada
    goto end
)

if "%COMMAND%"=="status" (
    echo Estado actual de los servicios:
    docker-compose ps
    goto end
)

if "%COMMAND%"=="help" (
    echo Comandos disponibles:
    echo   up      - Inicia los servicios
    echo   down    - Detiene los servicios
    echo   logs    - Muestra los logs en tiempo real
    echo   build   - Construye la imagen del backend
    echo   clean   - Elimina contenedores, volumenes e imagenes
    echo   status  - Muestra estado de los servicios
    echo   help    - Muestra esta ayuda
    goto end
)

echo Comando no reconocido: %COMMAND%
echo Usa "start.bat help" para ver los comandos disponibles

:end
endlocal
