# Instrucciones para Clonar el Proyecto Completo

Este es un proyecto monorepo que contiene múltiples repositorios independientes.

## Estructura de Repositorios

- **Repositorio Principal** (`nuevaeps`): Configuración Docker, documentación y scripts
- **Backend** (`nuevaeps-backend`): API REST con Spring Boot
- **Frontend** (`nuevaeps-frontend`): Aplicación React

## Clonar el Proyecto Completo

### Opción 1: Clonar todos los repositorios manualmente

```bash
# 1. Clonar el repositorio principal
git clone <url-repositorio-principal> nuevaeps
cd nuevaeps

# 2. Clonar el backend
git clone <url-repositorio-backend> nuevaeps-backend

# 3. Clonar el frontend
git clone <url-repositorio-frontend> nuevaeps-frontend
```

### Opción 2: Usar Git Submodules (Recomendado)

Si decides convertir los repositorios en submódulos:

```bash
# 1. Clonar el repositorio principal
git clone <url-repositorio-principal> nuevaeps
cd nuevaeps

# 2. Agregar submódulos
git submodule add <url-repositorio-backend> nuevaeps-backend
git submodule add <url-repositorio-frontend> nuevaeps-frontend

# 3. Commit los submódulos
git add .gitmodules nuevaeps-backend nuevaeps-frontend
git commit -m "Agregar submódulos backend y frontend"
git push
```

#### Clonar proyecto con submódulos:

```bash
# Clonar incluyendo submódulos
git clone --recurse-submodules <url-repositorio-principal>

# O si ya clonaste sin submódulos:
git submodule update --init --recursive
```

## URLs de Repositorios

- **Principal**: `<url-repositorio-principal>`
- **Backend**: `<url-repositorio-backend>`
- **Frontend**: `<url-repositorio-frontend>`

## Iniciar el Proyecto

Una vez clonados todos los repositorios:

```bash
# Windows
start.bat up

# Linux/Mac
./start.sh up
```

Visita: http://localhost
