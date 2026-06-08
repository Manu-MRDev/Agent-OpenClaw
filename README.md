# Estudio OpenClaw

Instancia de estudio y pruebas de OpenClaw, un orquestador de agentes AI con soporte para Telegram, dashboard web, sub-agentes y memoria persistente.

## Requisitos

- Docker + Docker Compose
- Una API key de un proveedor de modelos (Gemini, OpenRouter, Groq, etc.)
- (Opcional) Un bot de Telegram y su token

## Configuracion inicial

1. Clona el repositorio:
   ```bash
   git clone <repo-url>
   cd EstudioOpenCode
   ```

2. Copia el archivo de entorno y editalo con tus claves:
   ```bash
   cp .env.example .env
   nano .env
   ```

   Variables requeridas en `.env`:
   - `GEMINI_API_KEY` (o la del proveedor que uses)
   - `OPENCLAW_GATEWAY_TOKEN` (token para autenticar contra el gateway, puedes dejarlo como `estudio_token`)
   - `TELEGRAM_BOT_TOKEN` (opcional, deja vacio si no usas Telegram)
   - `PUBLIC_IP` (opcional, para acceder al dashboard desde otros dispositivos)

3. Verifica el entorno:
   ```bash
   bash setup.sh
   ```

4. Inicia el contenedor:
   ```bash
   docker compose up -d
   ```

   Los logs se ven con:
   ```bash
   docker compose logs -f
   ```

## Acceso

| Componente | URL |
|---|---|
| Dashboard web | http://localhost:18789/#token=estudio_token |
| Telegram | @Estudio_OpenClaw_bot (si configuraste el token) |

El token de acceso al dashboard es el que definiste en `OPENCLAW_GATEWAY_TOKEN`.

## Estructura del proyecto

```
.
├── .env                    # Variables de entorno (no se sube al repo)
├── .env.example            # Plantilla del .env
├── .gitignore              # Archivos ignorados por git
├── docker-compose.yml      # Servicio de OpenClaw con inyeccion de secretos
├── openclaw.json           # Configuracion del gateway y agente
├── setup.sh                # Script de verificacion de entorno
├── workspace/              # Persistencia del agente (memoria, identidad, logs)
│   ├── SOUL.md             # Personalidad y principios del agente
│   ├── IDENTITY.md         # Identidad del agente
│   ├── AGENTS.md           # Instrucciones de orquestacion de sub-agentes
│   ├── USER.md             # Contexto del usuario
│   ├── HEARTBEAT.md        # Tareas periodicas del agente
│   └── TOOLS.md            # Notas locales de herramientas
└── README.md
```

## Seguridad

- Los secretos (API keys, tokens) se inyectan desde `.env` en tiempo de ejecucion via `docker-compose.yml`. No estan hardcodeados en `openclaw.json`.
- `.env` esta en `.gitignore` — no se sube al repositorio.
- `openclaw.json` tiene los campos sensibles vacios (`"botToken": ""`, `"token": ""`); el script de arranque los completa desde las variables de entorno.
- Los datos de ejecucion de OpenClaw (`workspace/.openclaw/`) tambien estan ignorados por git.

## Comandos utiles

```bash
# Iniciar
docker compose up -d

# Ver logs en tiempo real
docker compose logs -f

# Detener
docker compose down

# Acceder al contenedor
docker exec -it estudio-openclaw sh
```
