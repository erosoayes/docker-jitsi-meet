# Stage 1: Build Jitsi Meet
FROM node:18-alpine as builder

RUN apk add --no-cache git bash

WORKDIR /app

# Clone source
RUN git clone https://github.com/jitsi/jitsi-meet.git .

# Install dependencies and build
RUN npm install && make

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy built files from builder
COPY --from=builder /app /usr/share/nginx/html

# Copy your custom nginx.conf if needed
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]




