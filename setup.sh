#!/bin/bash
set -e

echo "🚀 Preparando entorno Estudio OpenClaw..."

# Crear directorios si no existen
mkdir -p workspace

# Verificar .env
if [ ! -f .env ]; then
    echo "❌ No existe .env. Copia desde .env.example y configura tus keys."
    exit 1
fi

# Verificar que GEMINI_API_KEY no esté vacía
source .env
if [ -z "$GEMINI_API_KEY" ] || [ "$GEMINI_API_KEY" = "tu_gemini_api_key_aqui" ]; then
    echo "⚠️  GEMINI_API_KEY no configurada en .env"
    echo "   Edita .env y pon tu key de https://aistudio.google.com/apikey"
    exit 1
fi

echo "✅ Entorno listo."
echo ""
echo "Para iniciar:  docker compose up -d"
echo "Para ver logs: docker compose logs -f"
echo "Dashboard:     http://localhost:$HOST_PORT"
echo "Detener:       docker compose down"
