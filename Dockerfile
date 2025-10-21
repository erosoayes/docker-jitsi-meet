FROM nginx:alpine

RUN apk add --no-cache git

WORKDIR /usr/share/nginx/html

# Clone Jitsi Meet into a temporary folder, then move contents
RUN git clone https://github.com/jitsi/jitsi-meet.git /tmp/jitsi-meet \
    && rm -rf ./* \
    && mv /tmp/jitsi-meet/* . \
    && mv /tmp/jitsi-meet/.* . 2>/dev/null || true \
    && rm -rf /tmp/jitsi-meet

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
