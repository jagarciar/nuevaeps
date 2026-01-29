#!/bin/bash

# Script para iniciar los servicios de NuevaEPS con Docker Compose
# Uso: ./start.sh [comando]

COMMAND="${1:-up}"

echo ""
echo "╔════════════════════════════════════════╗"
echo "║    NuevaEPS - Docker Compose Manager   ║"
echo "╚════════════════════════════════════════╝"
echo ""

case "$COMMAND" in
  up)
    echo "Iniciando servicios..."
    docker-compose --env-file .env.dev up -d
    echo ""
    echo "✅ Servicios iniciados exitosamente"
    echo ""
    echo "Acceso a los servicios:"
    echo "  - Backend (API):    http://localhost:8080"
    echo "  - Swagger UI:       http://localhost:8080/swagger-ui.html"
    echo "  - pgAdmin (DB):     http://localhost:5050"
    echo "    - Email: admin@nuevaeps.com"
    echo "    - Contraseña: admin"
    echo ""
    ;;
  down)
    echo "Deteniendo servicios..."
    docker-compose down
    echo "✅ Servicios detenidos"
    ;;
  logs)
    docker-compose logs -f
    ;;
  build)
    echo "Construyendo imagen del backend..."
    docker-compose build backend
    echo "✅ Imagen construida"
    ;;
  clean)
    echo "Eliminando contenedores, volúmenes e imágenes..."
    docker-compose down -v
    echo "✅ Limpieza completada"
    ;;
  status)
    echo "Estado actual de los servicios:"
    docker-compose ps
    ;;
  help)
    echo "Comandos disponibles:"
    echo "  up      - Inicia los servicios"
    echo "  down    - Detiene los servicios"
    echo "  logs    - Muestra los logs en tiempo real"
    echo "  build   - Construye la imagen del backend"
    echo "  clean   - Elimina contenedores, volúmenes e imágenes"
    echo "  status  - Muestra estado de los servicios"
    echo "  help    - Muestra esta ayuda"
    ;;
  *)
    echo "Comando no reconocido: $COMMAND"
    echo "Usa './start.sh help' para ver los comandos disponibles"
    ;;
esac
