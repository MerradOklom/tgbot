FROM adolphnov/chatgpt-telegram-workers:latest

WORKDIR /app
EXPOSE 8787

# Install curl
RUN apk add --no-cache curl && \
    apk add --no-cache busybox && \
    ls -l /app

# Copy entrypoint script
COPY entrypoint.sh /app/entrypoint.sh

# Ensure Unix line endings, make executable, and verify
RUN sed -i 's/\r$//' /app/entrypoint.sh && \
    chmod +x /app/entrypoint.sh && \
    ls -l /app/entrypoint.sh && \
    cat /app/entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]
