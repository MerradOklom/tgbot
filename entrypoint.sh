#!/bin/bash
set -e

# Download config.json if CONFIG_JSON URL is provided
if [ -n "$CONFIG_JSON" ]; then
    echo "Downloading config.json from $CONFIG_JSON"
    curl -L -o /app/config.json "$CONFIG_JSON"
else
    echo "CONFIG_JSON environment variable not set"
    exit 1
fi

# Download config.toml if CONFIG_TOML URL is provided
if [ -n "$CONFIG_TOML" ]; then
    echo "Downloading config.toml from $CONFIG_TOML"
    curl -L -o /app/config.toml "$CONFIG_TOML"
else
    echo "CONFIG_TOML environment variable not set"
    exit 1
fi

# Execute the start command
exec npm run start:dist
