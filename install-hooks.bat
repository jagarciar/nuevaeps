@echo off
echo Instalando Git hooks...

REM Copiar el hook pre-commit
copy /Y hooks\pre-commit .git\hooks\pre-commit

echo Git hooks instalados correctamente.
pause
