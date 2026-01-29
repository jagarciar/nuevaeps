# 🏥 NuevaEPS - Sistema de Gestión de Medicamentos

Sistema completo de gestión de solicitudes de medicamentos con **Frontend React**, **Backend Spring Boot**, **Base de datos PostgreSQL** y **completamente dockerizado**.

**Versión**: 1.0.0 | **Estado**: ✅ Completamente funcional

---

## Tabla de Contenidos

1. [Introducción](#introducción)
2. [Estructura de Repositorios](#-estructura-de-repositorios)
3. [Inicio Rápido](#-inicio-rápido-30-segundos)
4. [Servicios Disponibles](#-servicios-disponibles)
5. [Estructura del Proyecto](#-estructura-del-proyecto)
6. [Tecnologías](#-tecnologías)
7. [Requisitos](#requisitos)
8. [Instalación](#instalación)
9. [Comandos](#-comandos-y-operaciones)
10. [Base de Datos](#-configuración-de-base-de-datos)
11. [pgAdmin](#-configuración-de-pgadmin)
12. [Desarrollo](#-desarrollo)
13. [Solución de Problemas](#-solución-de-problemas)

---

## Introducción

**NuevaEPS** es un sistema completo con:

- ✅ **Backend API REST** - Spring Boot 3.2.1 con JWT
- ✅ **Frontend** - React 18 con TypeScript y Vite
- ✅ **Base de datos** - PostgreSQL 16 Alpine
- ✅ **Gestor de BD** - pgAdmin
- ✅ **Completamente Dockerizado** - Deploy listo para producción
- ✅ **Autenticación segura** - JWT integrado
- ✅ **API documentada** - Swagger/OpenAPI automático

---

## 📦 Estructura de Repositorios

Este proyecto utiliza una **arquitectura de múltiples repositorios**:

| Repositorio | Contenido | Descripción |
|------------|-----------|-------------|
| **nuevaeps** (este repo) | Configuración Docker, documentación, scripts | Repositorio principal con orquestación |
| **nuevaeps-backend** | API REST Spring Boot | Repositorio independiente del backend |
| **nuevaeps-frontend** | Aplicación React | Repositorio independiente del frontend |

### Clonar el Proyecto Completo

Ver [CLONE.md](CLONE.md) para instrucciones detalladas sobre cómo clonar todos los repositorios.

**Resumen rápido:**
```bash
# 1. Clonar repositorio principal
git clone <url-principal> nuevaeps
cd nuevaeps

# 2. Clonar backend y frontend
git clone <url-backend> nuevaeps-backend
git clone <url-frontend> nuevaeps-frontend
```

---

## 🚀 Inicio Rápido (30 segundos)

### Windows
```bash
start.bat up
```

### Linux/Mac
```bash
chmod +x start.sh
./start.sh up
```

### Docker Compose directo
```bash
docker-compose --env-file .env.dev up -d
```

### ✨ Listo! Accede a:

| Servicio | URL |
|----------|-----|
| **Frontend** | http://localhost |
| **API REST** | http://localhost:8080/api/v1 |
| **Swagger UI** | http://localhost:8080/swagger-ui.html |
| **pgAdmin** | http://localhost:5050 |

**Credenciales por defecto:**
- PostgreSQL: `postgres` / `postgres`
- pgAdmin: `admin@nuevaeps.com` / `admin`

---

## 🌐 Servicios Disponibles

### Frontend (React + Nginx)
- **Puerto**: 80
- **URL**: http://localhost
- **Características**:
  - SPA (Single Page Application)
  - Autenticación con JWT
  - React Router para navegación
  - TypeScript para seguridad de tipos
  - Interfaz responsiva

### Backend API (Spring Boot)
- **Puerto**: 8080
- **URL**: http://localhost:8080
- **Swagger**: http://localhost:8080/swagger-ui.html
- **Health Check**: http://localhost:8080/actuator/health
- **Características**:
  - API REST RESTful
  - Spring Security + JWT
  - Documentación Swagger automática
  - JPA/Hibernate ORM

### PostgreSQL (Base de Datos)
- **Puerto**: 5432
- **Usuario**: postgres
- **Contraseña**: postgres
- **Base de datos**: nuevaeps_db
- **Características**:
  - Volumen persistente
  - Health checks automáticos
  - Inicialización automática con init-db.sql

### pgAdmin (Gestor de BD)
- **Puerto**: 5050
- **URL**: http://localhost:5050
- **Email**: admin@nuevaeps.com
- **Contraseña**: admin
- **Características**:
  - Interfaz web profesional
  - Gestión completa de PostgreSQL
  - Crear/modificar tablas
  - Ejecutar consultas SQL
  - Importar/exportar datos

---

## 📁 Estructura del Proyecto

```
nuevaeps/
├── nuevaeps-backend/                    # Backend API (Spring Boot)
│   ├── src/
│   │   ├── main/java/com/nuevaeps/api/
│   │   │   ├── config/                  # Configuración OpenAPI
│   │   │   ├── controller/              # Controladores REST
│   │   │   ├── dto/                     # Data Transfer Objects
│   │   │   ├── model/                   # Entidades JPA
│   │   │   ├── repository/              # Acceso a datos
│   │   │   ├── security/                # JWT y autenticación
│   │   │   └── service/                 # Lógica de negocio
│   │   ├── resources/application.properties
│   │   └── test/
│   ├── Dockerfile                       # Imagen Docker multi-etapa
│   ├── pom.xml                          # Dependencias Maven
│   └── README.md                        # Documentación backend
│
├── nuevaeps-frontend/                   # Frontend (React + TypeScript)
│   ├── src/
│   │   ├── components/                  # Componentes React
│   │   ├── pages/                       # Páginas de la aplicación
│   │   ├── services/                    # Llamadas a API
│   │   ├── types/                       # Interfaces TypeScript
│   │   ├── App.tsx                      # Componente raíz
│   │   └── main.tsx                     # Punto de entrada
│   ├── Dockerfile                       # Imagen Docker multi-etapa
│   ├── nginx.conf                       # Configuración Nginx
│   ├── vite.config.ts                   # Configuración Vite
│   ├── tsconfig.json                    # Configuración TypeScript
│   ├── package.json                     # Dependencias npm
│   └── README.md                        # Documentación frontend
│
├── docker-compose.yml                   # Orquestación de contenedores
├── init-db.sql                          # Script de inicialización BD
├── pgadmin-servers.json                 # Configuración pgAdmin
│
├── .env.example                         # Variables de entorno (plantilla)
├── .env.dev                             # Variables de entorno (desarrollo)
├── .env.prod                            # Variables de entorno (producción)
│
├── start.bat                            # Script de inicio (Windows)
└── start.sh                             # Script de inicio (Linux/Mac)
│
├── README.md                            # Este archivo (documentación completa)
└── 00-START-HERE.txt                    # Guía visual de inicio
```

---

## 🛠️ Tecnologías

### Backend
- **Java**: 21 LTS (OpenJDK)
- **Spring Boot**: 3.2.1
- **Spring Security**: JWT
- **JPA/Hibernate**: ORM
- **PostgreSQL**: 16 Alpine (Base de datos)
- **Maven**: Gestor de dependencias
- **Swagger/OpenAPI**: Documentación API

### Frontend
- **React**: 18.2.0
- **TypeScript**: 5.2.2
- **Vite**: 5.0.8 (build tool)
- **React Router**: 6.20.0 (routing)
- **Axios**: 1.6.2 (HTTP client)
- **Nginx**: Alpine (servidor web)

### DevOps
- **Docker**: Containerización
- **Docker Compose**: Orquestación
- **Makefile**: Automatización

---

## Requisitos

### Software Mínimo

- **Docker**: versión 20.10 o superior
- **Docker Compose**: versión 2.0 o superior
- **Git**: (opcional)

### Verificar Instalación

```bash
docker --version
docker-compose --version
```

---

## Instalación

### 1. Clonar Repositorio

```bash
git clone <url-del-repositorio>
cd nuevaeps
```

### 2. Variables de Entorno

El archivo `.env.dev` ya está incluido con valores por defecto.

Para cambiar credenciales, edita `.env.dev`:
```bash
DB_HOST=postgres
DB_PORT=5432
DB_NAME=nuevaeps_db
DB_USER=postgres
DB_PASSWORD=postgres
SPRING_PROFILES_ACTIVE=dev
```

### 3. Iniciar Servicios

**Opción 1** (Recomendado):
```bash
start.bat up          # Windows
./start.sh up         # Linux/Mac
```

**Opción 2** (Docker Compose directo):
```bash
docker-compose up -d
```

### 4. Verificar Estado

```bash
docker-compose ps
```

Esperado:
```
NAME                    STATUS
nuevaeps_postgres       Healthy
nuevaeps_pgadmin        Running
nuevaeps_backend        Healthy
nuevaeps_frontend       Running
```

---

## 🎯 Comandos y Operaciones

### Scripts de Inicio

#### Windows (start.bat)
```bash
start.bat up         # Iniciar servicios
start.bat down       # Detener servicios
start.bat logs       # Ver logs en vivo
start.bat build      # Reconstruir imágenes
start.bat status     # Ver estado
start.bat clean      # Limpiar todo
start.bat help       # Ver ayuda
```

#### Linux/Mac (start.sh)
```bash
./start.sh up        # Iniciar servicios
./start.sh down      # Detener servicios
./start.sh logs      # Ver logs en vivo
./start.sh build     # Reconstruir imágenes
./start.sh status    # Ver estado
./start.sh clean     # Limpiar todo
./start.sh help      # Ver ayuda
```

### Docker Compose Directo

```bash
# Ver estado
docker-compose ps

# Ver logs en vivo
docker-compose logs -f

# Ver logs de un servicio específico
docker-compose logs -f backend
docker-compose logs -f frontend
docker-compose logs -f postgres

# Ver logs últimas N líneas
docker-compose logs --tail=100

# Detener servicios
docker-compose down

# Detener y eliminar volúmenes (BORRA DATOS)
docker-compose down -v

# Reconstruir imágenes
docker-compose build

# Reconstruir sin caché
docker-compose build --no-cache

# Reiniciar servicios
docker-compose restart
```

### Comandos en Contenedores

```bash
# Ejecutar comando en backend
docker-compose exec backend java -version

# Abrir shell en backend
docker-compose exec backend /bin/sh

# Acceder a PostgreSQL
docker-compose exec postgres psql -U postgres -d nuevaeps_db
```

---

## 💾 Configuración de Base de Datos

### Inicialización Automática

El archivo `init-db.sql` se ejecuta automáticamente cuando se crea el contenedor de PostgreSQL por primera vez.

### Tablas Creadas

#### USUARIOS
Almacena información de usuarios del sistema.

**Campos principales:**
- `id` - Identificador único
- `username` - Nombre de usuario (único)
- `email` - Correo electrónico (único)
- `password` - Contraseña hasheada
- `nombre_completo` - Nombre completo
- `rol` - Rol (ADMIN, USER, MODERATOR)
- `activo` - Estado del usuario
- `fecha_creacion` - Fecha de creación
- `fecha_actualizacion` - Última actualización

#### MEDICAMENTOS
Catálogo de medicamentos disponibles.

**Campos principales:**
- `id` - Identificador único
- `nombre` - Nombre del medicamento
- `descripcion` - Descripción detallada
- `principio_activo` - Componente activo
- `dosis` - Dosis recomendada
- `presentacion` - Forma (tableta, cápsula, etc.)
- `laboratorio` - Laboratorio fabricante
- `codigo_referencia` - Código de inventario
- `precio` - Precio unitario
- `stock` - Cantidad disponible
- `stock_minimo` - Umbral de alerta
- `activo` - Disponibilidad

#### SOLICITUDES
Registro de solicitudes de medicamentos.

**Campos principales:**
- `id` - Identificador único
- `usuario_id` - Referencia al usuario
- `medicamento_id` - Referencia al medicamento
- `cantidad_solicitada` - Cantidad
- `estado` - Estado de la solicitud
- `motivo` - Motivo de la solicitud
- `diagnostico` - Diagnóstico médico
- `fecha_solicitud` - Fecha de solicitud
- `fecha_resolucion` - Fecha de resolución
- `observaciones` - Comentarios

### Conexión desde Host

```bash
psql -h localhost -U postgres -d nuevaeps_db
```

### Credenciales PostgreSQL

```
Host: localhost (o "postgres" desde contenedor)
Puerto: 5432
Usuario: postgres
Contraseña: postgres
Base de datos: nuevaeps_db
```

### Backup y Restauración

**Hacer backup:**
```bash
docker-compose exec postgres pg_dump -U postgres nuevaeps_db > backup.sql
```

**Restaurar backup:**
```bash
docker-compose exec -T postgres psql -U postgres nuevaeps_db < backup.sql
```

---

## ⚙️ Configuración de pgAdmin

### Acceso a pgAdmin

1. Abre: **http://localhost:5050**
2. Email: `admin@nuevaeps.com`
3. Contraseña: `admin`

### Conexión a PostgreSQL

#### Opción 1: Servidor Ya Configurado

Si todo funciona correctamente, pgAdmin debe mostrar "PostgreSQL NuevaEPS" ya configurado.

#### Opción 2: Agregar Manualmente

1. Click derecho en "Servers" → "Register" → "Server"

2. **Pestaña General:**
   - Name: `PostgreSQL NuevaEPS`

3. **Pestaña Connection:**
   - Host: `postgres` (IMPORTANTE: No `localhost`)
   - Port: `5432`
   - Maintenance database: `postgres`
   - Username: `postgres`
   - Password: `postgres`
   - Save password: ✅ Marcar

4. Click en "Save"

### Características

- Crear/modificar tablas
- Ejecutar consultas SQL
- Importar/exportar datos
- Gestión de usuarios
- Visualizar estructura de BD
- Backups y restauración

### Solución de Problemas pgAdmin

**Error: "Host and port do not receive TCP connections"**
- Usa `postgres` como hostname (nombre del servicio Docker)
- NO uses `localhost`, `127.0.0.1` ni IP del contenedor

**Error: "password authentication failed"**
- Verifica credenciales en `.env.dev`
- Asegúrate que PostgreSQL está corriendo: `docker-compose ps`

---

## 💻 Desarrollo

### Desarrollo Local (Sin Docker)

#### Backend
```bash
cd nuevaeps-backend
mvn spring-boot:run
```

#### Frontend
```bash
cd nuevaeps-frontend
npm install
npm run dev
```

### Modificar Código en Docker

#### Backend
1. Edita código en `nuevaeps-backend/src/`
2. Reconstruye:
   ```bash
   docker-compose build backend
   ```
3. Reinicia:
   ```bash
   docker-compose up -d backend
   ```

#### Frontend
1. Edita código en `nuevaeps-frontend/src/`
2. Reconstruye:
   ```bash
   docker-compose build frontend
   docker-compose up -d frontend
   ```

### Validar Cambios

```bash
# Backend
cd nuevaeps-backend
mvn clean compile
mvn test

# Frontend
cd nuevaeps-frontend
npm run lint
npm run build
```

### Git Hooks - Pruebas Automáticas en Pre-Commit

El proyecto incluye un hook de Git que ejecuta automáticamente las pruebas del backend antes de cada commit. Esto asegura que solo se commitee código que pasa todas las pruebas.

#### Características

- ✅ Ejecuta `mvn test` automáticamente antes de cada commit
- ✅ Aborta el commit si alguna prueba falla
- ✅ Muestra mensajes claros sobre el resultado
- ✅ Funciona en Windows, Linux y Mac

#### Instalación del Hook (Primera vez)

El hook ya está instalado en `.git/hooks/pre-commit`. Si necesitas reinstalarlo:

**Windows:**
```bash
install-hooks.bat
```

**Linux/Mac:**
```bash
chmod +x hooks/pre-commit
cp hooks/pre-commit .git/hooks/pre-commit
```

#### Cómo Funciona

1. Haces un commit: `git commit -m "mensaje"`
2. El hook ejecuta automáticamente las pruebas del backend
3. Si las pruebas pasan ✅ → el commit se completa
4. Si alguna prueba falla ❌ → el commit se aborta

#### Saltar el Hook (No Recomendado)

En casos excepcionales, puedes saltar el hook:
```bash
git commit -m "mensaje" --no-verify
```

⚠️ **No recomendado**: Solo úsalo si estás seguro de que tu código funciona.

### Acceder a Contenedores para Debugging

```bash
# Shell en backend
docker-compose exec backend /bin/sh

# psql en PostgreSQL
docker-compose exec postgres psql -U postgres -d nuevaeps_db

# Ver archivos
ls -la

# Ver logs de aplicación
tail -f /var/log/app.log
```

---

## 🔍 Solución de Problemas

### Puerto ya en uso

**Error**: "Port is already allocated"

**Solución**:
```bash
# Windows: encontrar proceso en puerto 8080
netstat -ano | findstr :8080

# Mac/Linux: encontrar proceso en puerto 8080
lsof -i :8080

# Cambiar puertos en docker-compose.yml o usar diferentes
docker-compose down
docker-compose up -d
```

### Contenedor no inicia

```bash
# Ver logs detallados
docker-compose logs backend

# Reconstruir sin caché
docker-compose build --no-cache backend

# Reiniciar
docker-compose restart backend

# Limpiar y empezar de cero
docker-compose down -v
docker-compose up -d
```

### Backend no se conecta a PostgreSQL

```bash
# Verificar que PostgreSQL está corriendo
docker-compose ps

# Ver logs de PostgreSQL
docker-compose logs postgres

# Reiniciar PostgreSQL
docker-compose restart postgres

# Reiniciar backend después
docker-compose restart backend
```

### Frontend no carga

```bash
# Ver logs
docker-compose logs frontend

# Verificar salud
curl http://localhost/health

# Reconstruir
docker-compose build frontend
docker-compose restart frontend
```

### Problemas de permisos en Linux

```bash
# Agregar usuario al grupo docker
sudo usermod -aG docker $USER

# Activar cambio (sin reiniciar)
newgrp docker

# Probar
docker run hello-world
```

### Volúmenes de datos no persisten

```bash
# Verificar volúmenes
docker volume ls

# Inspeccionar volumen
docker volume inspect nuevaeps_postgres_data

# Asegurar que el volumen esté en docker-compose.yml
```

### Limpiar todo y empezar de cero

```bash
# Detener todo
docker-compose down -v

# Eliminar imágenes
docker rmi $(docker images -q)

# Eliminar volúmenes
docker volume prune -a

# Inicio limpio
docker-compose build
docker-compose up -d
```

### Error: "init-db.sql not found"

```bash
# Asegúrate que init-db.sql existe en la raíz del proyecto
ls init-db.sql

# Limpiar volumen de datos y reiniciar
docker-compose down -v
docker-compose up -d
```

---

## 📚 Documentación Adicional

- **[00-START-HERE.txt](00-START-HERE.txt)** - Guía visual de inicio
- **[nuevaeps-backend/README.md](nuevaeps-backend/README.md)** - Documentación backend
- **[nuevaeps-frontend/README.md](nuevaeps-frontend/README.md)** - Documentación frontend

---

## ✨ Estado del Proyecto

✅ Backend API completamente funcional  
✅ Frontend React implementado  
✅ Base de datos PostgreSQL configurada  
✅ Docker Compose listo  
✅ Scripts de inicio automatizados  
✅ Documentación completa  
✅ Healthchecks implementados  
✅ Variables de entorno configurables  

---

## 🎯 Próximos Pasos

1. **Inicia los servicios**:
   ```bash
   start.bat up     # Windows
   ./start.sh up    # Linux/Mac
   make up          # Cualquier OS
   ```

2. **Espera 30 segundos** a que todo esté listo

3. **Accede a la aplicación**: http://localhost

4. **Explora los servicios**:
   - Frontend: http://localhost
   - API Docs: http://localhost:8080/swagger-ui.html
   - BD Manager: http://localhost:5050

---

**Versión**: 1.0.0 | **Última actualización**: 28 de enero de 2026 | **Estado**: ✅ Listo para usar
