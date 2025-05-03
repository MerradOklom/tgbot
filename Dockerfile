FROM adolphnov/chatgpt-telegram-workers:latest

WORKDIR /app
EXPOSE 8787

# Install curl
RUN apk add --no-cache curl && \
    apk add --no-cache busybox && \
    ls -l /app

# Copy entrypoint script
COPY start.sh /app/start.sh

# Ensure Unix line endings, make executable, and verify
RUN sed -i 's/\r$//' /app/start.sh && \
    chmod +x /app/start.sh && \
    ls -l /app/start.sh && \
    cat /app/start.sh

# Set entrypoint
CMD ["/usr/bash", "/app/start.sh"]
