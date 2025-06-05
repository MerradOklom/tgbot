FROM adolphnov/chatgpt-telegram-workers:latest

WORKDIR /app
EXPOSE 8787

# Install curl, python3, and uv
RUN apk add --no-cache curl python3 && \
    curl -LsSf https://astral.sh/uv/install.sh | sh

# Copy dummy HTTP server script
COPY dummy-server.js /app/dummy-server.js

# Set entrypoint to ensure /app directory, download configs, run dummy server, and run the application
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
    echo \"Starting dummy HTTP server on port 8787 in background...\"; \
    node /app/dummy-server.js & \
    echo \"Starting main application in $(pwd)...\"; \
    exec node /app/index.js"]
