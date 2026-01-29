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
-- Los roles se almacenan en la tabla usuario_roles (@ElementCollection)

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
-- DATOS INICIALES
-- ============================================================================

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
-- COMENTARIOS Y DOCUMENTACIÓN
-- ============================================================================
--
-- ESTRUCTURA DE TABLAS (ALINEADAS CON ENTIDADES JPA)
-- 
-- USUARIOS: Almacena información básica de los usuarios
--   - id: Identificador único (BIGSERIAL)
--   - username: Nombre único del usuario (VARCHAR, UNIQUE)
--   - password: Contraseña hasheada con bcrypt (VARCHAR)
--
-- MEDICAMENTOS: Catálogo de medicamentos disponibles
--   - id: Identificador único (BIGSERIAL)
--   - nombre: Nombre del medicamento (VARCHAR)
--
-- SOLICITUDES_MEDICAMENTOS: Registro de solicitudes de medicamentos
--   - id: Identificador único (BIGSERIAL)
--   - medicamento_id: Referencia a medicamentos(id)
--   - usuario_id: Referencia a usuarios(id)
--   - numero_orden: Número de orden único (VARCHAR)
--   - direccion: Dirección de entrega (VARCHAR)
--   - telefono: Número de teléfono (VARCHAR)
--   - correo_electronico: Correo electrónico de contacto (VARCHAR)
--
-- RELACIONES
--   - Un usuario puede tener múltiples solicitudes (1:N)
--   - Un medicamento puede tener múltiples solicitudes (1:N)
--   - Eliminar un usuario elimina sus solicitudes (CASCADE)
--   - Eliminar un medicamento elimina sus solicitudes (CASCADE)
--
-- USUARIOS POR DEFECTO
--   - username: admin, password: admin (hash bcrypt)
--   - username: usuario_test, password: admin (hash bcrypt)
-- 
-- NOTA: No existen roles de usuario en este sistema
-- ============================================================================
