# -------------------------------
# Working Jitsi Meet Frontend Image
# -------------------------------
FROM nginx:alpine

# Install curl
RUN apk add --no-cache curl

# Download a stable prebuilt version of Jitsi Meet
WORKDIR /usr/share/nginx/html
RUN curl -L https://download.jitsi.org/jitsi-meet/src/jitsi-meet-5765-1.tar.bz2 -o jitsi.tar.bz2 \
    && tar -xjf jitsi.tar.bz2 --strip-components=1 \
    && rm jitsi.tar.bz2

# Copy nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
