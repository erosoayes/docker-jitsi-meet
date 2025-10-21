FROM nginx:alpine

RUN apk add --no-cache curl

WORKDIR /usr/share/nginx/html

# Download latest prebuilt Jitsi Meet frontend
RUN curl -L https://download.jitsi.org/jitsi-meet/latest.tar.bz2 -o jitsi.tar.bz2 \
    && tar -xjf jitsi.tar.bz2 --strip-components=1 \
    && rm jitsi.tar.bz2

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

