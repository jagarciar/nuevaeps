# Pre-commit hook para ejecutar pruebas del backend
Write-Host "Ejecutando pruebas del backend..." -ForegroundColor Yellow

# Navegar al directorio del backend y ejecutar las pruebas
Set-Location nuevaeps-backend

# Ejecutar las pruebas de Maven
& mvn test -q

# Capturar el código de salida
$testResult = $LASTEXITCODE

# Volver al directorio raíz
Set-Location ..

# Si las pruebas fallan, abortar el commit
if ($testResult -ne 0) {
    Write-Host "❌ Las pruebas del backend fallaron. Commit abortado." -ForegroundColor Red
    exit 1
}

Write-Host "✅ Todas las pruebas del backend pasaron correctamente." -ForegroundColor Green
exit 0
