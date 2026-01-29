# 📐 Arquitectura de NuevaEPS

## 🏗️ Diagrama General

```
┌─────────────────────────────────────────────────────────┐
│                     INTERNET                            │
└─────────────────┬───────────────────────────────────────┘
                  │
        ┌─────────▼──────────┐
        │  Frontend (React)  │  (Puerto 80)
        │  - TypeScript      │
        │  - Vite            │
        │  - Nginx           │
        └────────┬───────────┘
                 │ (Proxy http://backend:8080/api)
        ┌────────▼────────────────────────┐
        │    Backend (Spring Boot 3.2)    │  (Puerto 8080)
        │    - Java 21                    │
        │    - JWT Auth                   │
        │    - REST API + Swagger         │
        └────────┬────────────────────────┘
                 │
        ┌────────▼────────────┐
        │   PostgreSQL 16     │  (Puerto 5432)
        │   - nuevaeps_db     │
        │   - Usuarios        │
        │   - Medicamentos    │
        │   - Solicitudes     │
        └─────────────────────┘

    ┌──────────────────────────┐
    │  pgAdmin                 │  (Puerto 5050)
    │  (Gestión BD)            │
    └──────────────────────────┘
```

---

## 🔌 **Servicios Docker**

### 1. **PostgreSQL** (Database)
- **Imagen**: `postgres:16-alpine`
- **Puerto**: 5432
- **Usuario**: postgres
- **Base de datos**: nuevaeps_db
- **Volúmenes**: postgres_data
- **Healthcheck**: pg_isready

### 2. **Backend API** (Spring Boot)
- **Imagen**: Custom (Dockerfile multietapa)
- **Puerto**: 8080
- **Java**: 21 LTS
- **Base**: eclipse-temurin:21-jre-alpine
- **Dependencias clave**:
  - Spring Boot 3.2.1
  - Spring Data JPA
  - Spring Security + JWT
  - Spring Doc OpenAPI (Swagger)
  - PostgreSQL Driver
  - Actuator (health checks)
- **Perfil**: `dev` (configurable)
- **Healthcheck**: java -version (simple check)

### 3. **Frontend** (React + Nginx)
- **Imagen**: Custom (Dockerfile multietapa)
- **Puerto**: 80
- **Build**: Vite
- **Proxy**: Nginx → Backend API
- **Volúmenes**: Código del frontend
- **Healthcheck**: wget http://localhost/ (root)
- **Variables de entorno**:
  - REACT_APP_API_URL: http://backend:8080

### 4. **pgAdmin** (Database Management)
- **Imagen**: Custom (Dockerfile.pgadmin)
- **Puerto**: 5050
- **Rol**: Interfaz visual para PostgreSQL

---

## 📊 **Base de Datos - Schema**

### Tabla: usuarios
```sql
├── id (PK, UUID)
├── username (UNIQUE)
├── email (UNIQUE)
├── password (bcrypt)
├── created_at
└── updated_at
```

### Tabla: medicamentos
```sql
├── id (PK, UUID)
├── nombre
├── descripcion
├── dosis
├── presentacion
├── stock
└── precio
```

### Tabla: solicitud_medicamento
```sql
├── id (PK, UUID)
├── usuario_id (FK → usuarios)
├── medicamento_id (FK → medicamentos)
├── cantidad_solicitada
├── estado (PENDIENTE/APROBADO/RECHAZADO)
├── fecha_solicitud
└── observaciones
```

---

## 🔐 **Flujo de Autenticación**

### 1. **Registro**
```
POST /api/auth/register
├── Body: { username, email, password, confirmPassword }
├── Validación: password == confirmPassword
├── Hash: bcrypt (força 10)
├── Response: { id, username, email, token }
└── Token: JWT con expiración
```

### 2. **Login**
```
POST /api/auth/login
├── Body: { username, password }
├── Validación: credenciales en BD
├── Token JWT: { sub: username, exp: +24h, iat: now }
├── Response: { token, username }
└── Frontend: localStorage.setItem('token')
```

### 3. **Acceso a Recursos Protegidos**
```
GET /api/medicamentos
├── Header: Authorization: Bearer <JWT>
├── Filtro: AuthTokenFilter extrae token
├── Validación: JWT válido + no expirado
├── Response: [medicamentos] o 401 Unauthorized
└── Frontend: axios interceptor agrega header automáticamente
```

---

## 🌐 **Arquitectura Frontend**

### Estructura de Directorios
```
src/
├── pages/
│   ├── auth/              # Autenticación
│   │   ├── LoginPage.tsx
│   │   ├── RegisterPage.tsx
│   │   └── AuthForms.css
│   ├── dashboard/         # Panel principal
│   ├── medicamentos/      # Catálogo
│   └── solicitudes/       # Mis solicitudes
├── components/
│   ├── common/            # Componentes reutilizables
│   │   └── PrivateRoute.tsx
│   └── layout/            # Layout principal
│       ├── Layout.tsx
│       └── Layout.test.tsx
├── services/
│   ├── api/
│   │   ├── client.ts      # Axios + JWT
│   │   └── client.test.ts
│   └── hooks/             # Custom hooks (preparado)
├── store/                 # Estado global (preparado)
├── styles/                # CSS global
├── types/                 # TypeScript types
├── utils/                 # Utilidades
└── test/                  # Configuración Vitest
```

### Path Aliases
```typescript
@/           → src/
@components/ → src/components/
@pages/      → src/pages/
@services/   → src/services/
@styles/     → src/styles/
@types/      → src/types/
```

---

## ⚙️ **Arquitectura Backend - Spring Boot**

### Estructura de Paquetes
```
com.nuevaeps.api/
├── NuevaepsApiApplication.java
├── config/
│   ├── OpenApiConfig.java      # Swagger/OpenAPI
│   ├── SecurityConfig.java     # Spring Security + JWT
│   └── CorsConfig.java
├── controller/
│   ├── AuthController.java     # /api/auth
│   ├── MedicamentoController   # /api/medicamentos
│   └── SolicitudController     # /api/solicitudes
├── dto/
│   ├── LoginRequest
│   ├── RegisterRequest
│   ├── JwtResponse
│   └── ErrorResponse
├── model/                       # Entidades JPA
│   ├── Usuario
│   ├── Medicamento
│   └── SolicitudMedicamento
├── repository/                  # Spring Data JPA
│   ├── UsuarioRepository
│   ├── MedicamentoRepository
│   └── SolicitudRepository
├── security/
│   ├── JwtTokenProvider.java    # Generación/validación JWT
│   ├── AuthTokenFilter.java     # Filtro de autenticación
│   └── CustomUserDetailsService
└── service/                     # Lógica de negocio
    ├── AuthService
    ├── MedicamentoService
    └── SolicitudService
```

### Stack Técnico Backend
- **Framework**: Spring Boot 3.2.1
- **Build**: Maven 3.9.6
- **JDK**: Java 21 LTS
- **ORM**: Hibernate 6.4 + Spring Data JPA
- **Base de datos**: PostgreSQL 16
- **Autenticación**: JWT + Spring Security
- **API Doc**: SpringDoc OpenAPI (Swagger 3.0)
- **Actuator**: Health checks + endpoints monitoreo

---

## 🔗 **Endpoints API**

### Autenticación
```
POST   /api/auth/register    # Crear usuario
POST   /api/auth/login       # Obtener JWT
GET    /actuator/health      # Health check
```

### Medicamentos
```
GET    /api/medicamentos     # Listar todos
GET    /api/medicamentos/:id # Detalle
POST   /api/medicamentos     # Crear (admin)
PUT    /api/medicamentos/:id # Actualizar (admin)
DELETE /api/medicamentos/:id # Eliminar (admin)
```

### Solicitudes
```
GET    /api/solicitudes          # Mis solicitudes
GET    /api/solicitudes/:id      # Detalle
POST   /api/solicitudes          # Crear solicitud
PUT    /api/solicitudes/:id      # Actualizar (admin)
```

### Swagger
```
GET    /swagger-ui.html          # UI Swagger
GET    /v3/api-docs              # OpenAPI JSON
```

---

## 🔄 **Flujo de Solicitud HTTP**

### Ejemplo: POST /api/medicamentos/solicitar

```
1. FRONTEND (React)
   └─ apiCall('POST', '/medicamentos/solicitar', { medicamento_id, cantidad })
      └─ Services/api/client.ts
         └─ Axios interceptor agrega: Authorization: Bearer <JWT>

2. NGINX (Proxy)
   └─ Recibe en puerto 80
   └─ Proxy_pass → http://backend:8080/api/medicamentos/solicitar

3. BACKEND (Spring Boot)
   └─ AuthTokenFilter extrae JWT
   └─ JwtTokenProvider valida token
   └─ SecurityConfig permite acceso
   └─ SolicitudController.crearSolicitud()
      └─ Service.crearSolicitud()
         └─ Repository.save() a PostgreSQL

4. RESPUESTA (JSON)
   └─ Frontend recibe: { id, status, fecha_creacion }
   └─ Estado actualizado en UI
```

---

## 📦 **Volúmenes Docker**

| Volumen | Contenedor | Uso |
|---------|-----------|-----|
| postgres_data | PostgreSQL | Persistencia de datos |
| pgadmin_data | pgAdmin | Configuración + preferences |

---

## 🌍 **Red Docker**

- **Nombre**: nuevaeps_network
- **Driver**: bridge
- **Propósito**: Comunicación entre contenedores
- **DNS interno**: Hostname = nombre del servicio
  - backend → http://backend:8080
  - postgres → postgres:5432

---

## 🚀 **Ciclo de Vida Startup**

1. **PostgreSQL** inicia y espera health check
2. **pgAdmin** inicia cuando PostgreSQL está "healthy"
3. **Backend** inicia cuando PostgreSQL está "healthy"
   - Ejecuta migrations
   - Conecta a BD
   - Carga credenciales de seguridad
4. **Frontend** inicia cuando Backend está disponible
   - Build con Vite
   - Nginx inicia con proxy hacia Backend
5. **Toda la aplicación** está lista

---

## 📋 **Variables de Entorno**

### Base de datos
```
DB_HOST=postgres
DB_PORT=5432
DB_NAME=nuevaeps_db
DB_USER=postgres
DB_PASSWORD=postgres
```

### Spring Boot
```
SPRING_PROFILES_ACTIVE=dev
SPRING_DATASOURCE_URL=jdbc:postgresql://postgres:5432/nuevaeps_db
SPRING_DATASOURCE_USERNAME=postgres
SPRING_DATASOURCE_PASSWORD=postgres
```

### pgAdmin
```
PGADMIN_DEFAULT_EMAIL=admin@nuevaeps.com
PGADMIN_DEFAULT_PASSWORD=admin
```

### Frontend
```
REACT_APP_API_URL=http://backend:8080
VITE_API_URL=http://backend:8080 (development)
```

---

## ✅ **Health Checks**

- **PostgreSQL**: `pg_isready -U postgres`
- **Backend**: `java -version` (verificar proceso vivo)
- **Frontend**: `wget http://localhost/` (verificar Nginx)
- **pgAdmin**: Sin health check (opcional)

---

## 📊 **Monitoreo y Logging**

### Backend
- **Logs**: `docker-compose logs backend -f`
- **Actuator endpoint**: http://localhost:8080/actuator/health
- **Métricas**: Disponibles en /actuator/metrics

### Frontend
- **Logs**: `docker-compose logs frontend -f`
- **Browser DevTools**: Consola y Network

### PostgreSQL
- **Logs**: `docker-compose logs postgres -f`
- **pgAdmin**: http://localhost:5050

---

## 🔒 **Seguridad**

### CORS
- Configurado en SecurityConfig.java
- Frontend en http://localhost
- Backend API en http://localhost:8080

### JWT
- **Algoritmo**: HS512
- **Expiración**: 24 horas
- **Claims**: username, roles, iat, exp
- **Storage**: localStorage (Frontend)

### Contraseñas
- **Encriptación**: BCrypt (fuerza 10)
- **No se almacenan en texto plano**

### Datos Sensibles
- **No commitear** archivos .env en producción
- **Variables de entorno** por archivo .env.local
- **Secretos** en gestor de secretos (vault, etc.)

---

## 🚀 **Deployment - Notas para Producción**

### Cambios necesarios
1. Cambiar SPRING_PROFILES_ACTIVE a `prod`
2. Cambiar contraseña de BD
3. Cambiar contraseña de pgAdmin
4. Usar HTTPS en lugar de HTTP
5. Agregar certificados SSL
6. Cambiar CORS allowed origins
7. Usar base de datos gestionada (RDS, Cloud SQL, etc.)
8. Agregar CDN para assets estáticos
9. Implementar backup automático
10. Configurar alertas y monitoreo

