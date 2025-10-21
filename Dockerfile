FROM node:18-bullseye

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y \
    curl \
    tar \
    git \
    make \
    bzip2 \
    && rm -rf /var/lib/apt/lists/*

ENV JITSI_VERSION=stable-10532

RUN echo "Downloading Jitsi Meet version ${JITSI_VERSION}" && \
    curl -fSL https://github.com/jitsi/jitsi-meet/archive/refs/tags/${JITSI_VERSION}.tar.gz -o jitsi.tar.gz && \
    tar -xzf jitsi.tar.gz --strip-components=1 && \
    rm jitsi.tar.gz

RUN npm install

ENV JITSI_APP_ID=your_app_id_here
ENV JITSI_APP_SECRET=your_secret_here
ENV NODE_ENV=production

RUN npm run build

EXPOSE 3000
CMD ["npm", "start"]