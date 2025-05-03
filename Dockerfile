FROM adolphnov/chatgpt-telegram-workers:latest

WORKDIR /app
EXPOSE 8787

# Install curl and ensure sh is available
RUN apk add --no-cache curl busybox && \
    ls -l /app && \
    which sh && \
    ln -sf /bin/busybox /bin/sh || true

# Copy entrypoint script
COPY entrypoint.sh /app/entrypoint.sh

# Ensure Unix line endings, make executable, and verify
RUN sed -i 's/\r$//' /app/entrypoint.sh && \
    chmod +x /app/entrypoint.sh && \
    ls -l /app/entrypoint.sh && \
    cat /app/entrypoint.sh

# Alternative ENTRYPOINT to ensure shell
ENTRYPOINT ["/bin/sh", "/app/entrypoint.sh"]
