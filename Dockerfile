FROM node:18-alpine as build

# Install required tools for Jitsi build
RUN apk add --no-cache git python3 make g++ bash

WORKDIR /app

# Clone Jitsi Meet
RUN git clone https://github.com/jitsi/jitsi-meet.git .

# Install dependencies
RUN npm install

# Build Jitsi Meet
RUN make

# -------------------
# Stage 2 - Serve with Nginx
# -------------------
FROM nginx:alpine

COPY --from=build /app /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

