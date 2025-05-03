FROM adolphnov/chatgpt-telegram-workers:latest

WORKDIR /app
EXPOSE 8787

# Install curl
RUN apk add --no-cache curl

# Set entrypoint to ensure /app directory, download configs, and run the application
ENTRYPOINT ["/bin/sh", "-c", "\
    cd /app && \
    if [ -n \"$CONFIG_JSON\" ]; then \
        echo \"Downloading config.json from $CONFIG_JSON\"; \
        curl -L -o /app/config.json \"$CONFIG_JSON\" || { echo \"Failed to download config.json\"; exit 1; }; \
    else \
        echo \"CONFIG_JSON environment variable not set\"; \
        exit 1; \
    fi && \
    if [ -n \"$CONFIG_TOML\" ]; then \
        echo \"Downloading config.toml from $CONFIG_TOML\"; \
        curl -L -o /app/config.toml \"$CONFIG_TOML\" || { echo \"Failed to download config.toml\"; exit 1; }; \
    else \
        echo \"CONFIG_TOML environment variable not set\"; \
        exit 1; \
    fi && \
    echo \"Available npm scripts:\" && \
    npm run || true && \
    echo \"Starting application in $(pwd)...\"; \
    if npm run start:dist >/dev/null 2>&1; then \
        exec npm run start:dist; \
    else \
        echo \"start:dist not found, falling back to node dist/index.js\"; \
        exec node dist/index.js; \
    fi"]
