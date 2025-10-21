# Use lightweight Nginx image
FROM nginx:alpine

# Set working directory
WORKDIR /usr/share/nginx/html

# Install curl to fetch prebuilt Jitsi Meet
RUN apk add --no-cache curl

# Download the latest *stable prebuilt* Jitsi Meet release
RUN curl -L https://github.com/jitsi/jitsi-meet/archive/refs/tags/stable-8719.tar.gz -o jitsi.tar.gz \
    && tar -xzf jitsi.tar.gz --strip-components=1 \
    && rm jitsi.tar.gz

# Optional: your custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 for web access
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
