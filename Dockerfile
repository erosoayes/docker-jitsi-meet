# Use the official Jitsi Web image
FROM jitsi/web:latest

# Install any additional packages if needed
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy custom configuration
COPY .env /defaults/

# Expose ports
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Start the service
CMD ["/init"]