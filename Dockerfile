FROM nginx:alpine

RUN apk add --no-cache git

WORKDIR /usr/share/nginx/html

# Clone official Jitsi Meet repo
RUN git clone https://github.com/jitsi/jitsi-meet.git . && rm -rf .git

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


