#!/bin/bash

# Script para inicializar pgAdmin con la conexión a PostgreSQL

# Archivo de configuración de contraseñas
PGPASS_FILE="/tmp/pgpass"

# Crear archivo .pgpass con las credenciales
cat > $PGPASS_FILE << EOF
postgres:5432:*:postgres:${DB_PASSWORD:-postgres}
EOF

# Asignar permisos correctos
chmod 600 $PGPASS_FILE

# Iniciar pgAdmin
/entrypoint.sh
