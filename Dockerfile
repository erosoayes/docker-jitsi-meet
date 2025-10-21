FROM nginx:alpine

WORKDIR /usr/share/nginx/html

RUN apk add --no-cache curl tar

# Download from official Jitsi CDN instead of GitHub
RUN curl -L https://download.jitsi.org/jitsi-meet/stable/jitsi-meet_8719.tar.bz2 -o jitsi.tar.bz2 \
    && tar -xjf jitsi.tar.bz2 --strip-components=1 \
    && rm jitsi.tar.bz2

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

