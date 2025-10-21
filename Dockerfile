# Use a base image with Node.js for building
FROM node:18-alpine as builder

# Install dependencies
RUN apk add --no-cache \
    git \
    python3 \
    make \
    g++ \
    curl

# Clone and build Jitsi Meet - FIXED: Use master branch and specific version
WORKDIR /app
RUN git clone https://github.com/jitsi/jitsi-meet.git . \
    && git checkout master

# Install dependencies and build
RUN npm install \
    && npm run build

# Production stage
FROM nginx:alpine

# Install curl for health checks
RUN apk add --no-cache curl

# Copy built files to nginx
COPY --from=builder /app /usr/share/nginx/html

# Copy nginx configuration for Jitsi
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]