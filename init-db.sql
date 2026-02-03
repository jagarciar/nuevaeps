-- ============================================================================
-- NUEVAEPS DATABASE INITIALIZATION SCRIPT
-- ============================================================================
-- Este script crea todas las tablas necesarias para la aplicación NuevaEPS
-- Se ejecuta automáticamente cuando PostgreSQL se inicia por primera vez
-- ============================================================================

-- ============================================================================
-- TABLA: USUARIOS
-- ============================================================================
-- Almacena información de los usuarios del sistema
-- Incluye: id, username, password

CREATE TABLE IF NOT EXISTS usuarios (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- Índice para búsquedas rápidas por username
CREATE INDEX IF NOT EXISTS idx_usuarios_username ON usuarios(username);

-- ============================================================================
-- TABLA: MEDICAMENTOS
-- ============================================================================
-- Catálogo de medicamentos disponibles
-- Incluye: id, nombre

CREATE TABLE IF NOT EXISTS medicamentos (
    id BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

-- Índice para búsquedas por nombre
CREATE INDEX IF NOT EXISTS idx_medicamentos_nombre ON medicamentos(nombre);

-- ============================================================================
-- TABLA: SOLICITUDES_MEDICAMENTOS
-- ============================================================================
-- Registro de solicitudes de medicamentos realizadas por los usuarios
-- Incluye: medicamento_id, usuario_id, numero_orden, direccion, telefono, correo_electronico

CREATE TABLE IF NOT EXISTS solicitudes_medicamentos (
    id BIGSERIAL PRIMARY KEY,
    medicamento_id BIGINT NOT NULL,
    usuario_id BIGINT NOT NULL,
    numero_orden VARCHAR(255) NOT NULL UNIQUE,
    direccion VARCHAR(500) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    correo_electronico VARCHAR(255) NOT NULL,
    CONSTRAINT fk_solicitud_medicamento 
        FOREIGN KEY (medicamento_id) 
        REFERENCES medicamentos(id) ON DELETE CASCADE,
    CONSTRAINT fk_solicitud_usuario 
        FOREIGN KEY (usuario_id) 
        REFERENCES usuarios(id) ON DELETE CASCADE
);

-- Índices para búsquedas rápidas
CREATE INDEX IF NOT EXISTS idx_solicitudes_medicamento ON solicitudes_medicamentos(medicamento_id);
CREATE INDEX IF NOT EXISTS idx_solicitudes_usuario ON solicitudes_medicamentos(usuario_id);
CREATE INDEX IF NOT EXISTS idx_solicitudes_numero_orden ON solicitudes_medicamentos(numero_orden);

-- ============================================================================
-- TABLA: ROLES
-- ============================================================================
-- Catálogo de roles del sistema
-- Incluye: id, nombre

CREATE TABLE IF NOT EXISTS roles (
    id BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

-- ============================================================================
-- TABLA: USUARIO_ROLES (Tabla intermedia Many-to-Many)
-- ============================================================================
-- Relación entre usuarios y roles

CREATE TABLE IF NOT EXISTS usuario_roles (
    usuario_id BIGINT NOT NULL,
    rol_id BIGINT NOT NULL,
    PRIMARY KEY (usuario_id, rol_id),
    CONSTRAINT fk_usuario_roles_usuario 
        FOREIGN KEY (usuario_id) 
        REFERENCES usuarios(id) ON DELETE CASCADE,
    CONSTRAINT fk_usuario_roles_rol 
        FOREIGN KEY (rol_id) 
        REFERENCES roles(id) ON DELETE CASCADE
);

-- Índices para búsquedas rápidas
CREATE INDEX IF NOT EXISTS idx_usuario_roles_usuario ON usuario_roles(usuario_id);
CREATE INDEX IF NOT EXISTS idx_usuario_roles_rol ON usuario_roles(rol_id);

-- ============================================================================
-- DATOS INICIALES
-- ============================================================================

-- Roles del Sistema
INSERT INTO roles (nombre) VALUES ('USER') ON CONFLICT (nombre) DO NOTHING;
INSERT INTO roles (nombre) VALUES ('ADMIN') ON CONFLICT (nombre) DO NOTHING;
INSERT INTO roles (nombre) VALUES ('MODERATOR') ON CONFLICT (nombre) DO NOTHING;

-- Usuario Administrador
-- Contraseña: admin (hash bcrypt: $2a$10$dXJ3SW6G7P50eS4XW0JUXOUm8i8FGOy8sAWw3R.6yVl0vVnvVvI3y)
INSERT INTO usuarios (username, password)
VALUES ('admin', '$2a$10$dXJ3SW6G7P50eS4XW0JUXOUm8i8FGOy8sAWw3R.6yVl0vVnvVvI3y')
ON CONFLICT (username) DO NOTHING;

-- Usuario de Prueba
-- Contraseña: admin (mismo hash bcrypt)
INSERT INTO usuarios (username, password)
VALUES ('usuario_test', '$2a$10$dXJ3SW6G7P50eS4XW0JUXOUm8i8FGOy8sAWw3R.6yVl0vVnvVvI3y')
ON CONFLICT (username) DO NOTHING;

-- Medicamentos de Ejemplo
INSERT INTO medicamentos (nombre)
VALUES 
    ('Paracetamol'),
    ('Ibuprofeno'),
    ('Amoxicilina'),
    ('Metformina')
ON CONFLICT DO NOTHING;

-- ============================================================================
-- ASIGNACIÓN DE ROLES A USUARIOS
-- ============================================================================

-- Asignar rol ADMIN al usuario admin
INSERT INTO usuario_roles (usuario_id, rol_id)
SELECT u.id, r.id 
FROM usuarios u, roles r 
WHERE u.username = 'admin' AND r.nombre = 'ADMIN'
ON CONFLICT DO NOTHING;

-- Asignar rol USER al usuario admin (también tiene permisos de usuario)
INSERT INTO usuario_roles (usuario_id, rol_id)
SELECT u.id, r.id 
FROM usuarios u, roles r 
WHERE u.username = 'admin' AND r.nombre = 'USER'
ON CONFLICT DO NOTHING;

-- Asignar rol USER al usuario de prueba
INSERT INTO usuario_roles (usuario_id, rol_id)
SELECT u.id, r.id 
FROM usuarios u, roles r 
WHERE u.username = 'usuario_test' AND r.nombre = 'USER'
ON CONFLICT DO NOTHING;