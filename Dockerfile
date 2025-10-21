# ------------------------------
# ✅ Base Image
# ------------------------------
FROM node:18-bullseye

# ------------------------------
# ✅ Set working directory
# ------------------------------
WORKDIR /usr/src/app

# ------------------------------
# ✅ Install dependencies
# ------------------------------
RUN apt-get update && apt-get install -y \
    curl \
    bzip2 \
    git \
    make \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------
# ✅ Download Jitsi Meet (specific stable version)
# ------------------------------
ENV JITSI_VERSION=stable-8719

RUN echo "Downloading Jitsi Meet version ${JITSI_VERSION}" && \
    curl -L https://github.com/jitsi/jitsi-meet/archive/refs/tags/${JITSI_VERSION}.tar.gz -o jitsi.tar.gz && \
    tar -xzf jitsi.tar.gz --strip-components=1 && \
    rm jitsi.tar.gz

# ------------------------------
# ✅ Install NPM dependencies
# ------------------------------
RUN npm install

# ------------------------------
# ✅ Environment Variables
# ------------------------------
ENV JITSI_APP_ID=your_app_id_here
ENV JITSI_APP_SECRET=your_secret_here
ENV NODE_ENV=production

# ------------------------------
# ✅ Build the app
# ------------------------------
RUN npm run build

# ------------------------------
# ✅ Expose port & start
# ------------------------------
EXPOSE 3000
CMD ["npm", "start"]

