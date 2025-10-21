# Stage 1: Build Jitsi Meet
FROM node:18-alpine AS builder

# Install necessary build tools
RUN apk add --no-cache git bash make g++ autoconf automake libtool

WORKDIR /app

# Clone Jitsi Meet repository
RUN git clone https://github.com/jitsi/jitsi-meet.git .

# Install dependencies and build
RUN npm install && make

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy built Jitsi files from the builder stage
COPY --from=builder /app /usr/share/nginx/html

# Optional: custom Nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]