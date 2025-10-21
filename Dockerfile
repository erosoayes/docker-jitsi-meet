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
    && rm -rf /var/lib/apt/lists/*

# ------------------------------
# ✅ Download the latest stable Jitsi Meet release
# (Automatically fetches the latest version tag)
# ------------------------------
RUN LATEST_VERSION=$(curl -s https://download.jitsi.org/jitsi-meet/releases/stable.txt) && \
    echo "Downloading version: $LATEST_VERSION" && \
    curl -L https://github.com/jitsi/jitsi-meet/archive/refs/tags/${LATEST_VERSION}.tar.gz -o jitsi.tar.gz && \
    tar -xzf jitsi.tar.gz --strip-components=1 && \
    rm jitsi.tar.gz

# ------------------------------
# ✅ Install NPM dependencies
# ------------------------------
RUN npm install

# ------------------------------
# ✅ Build Jitsi Meet (with env variables)
# ------------------------------
ENV JITSI_APP_ID=your_app_id_here
ENV JITSI_APP_SECRET=your_secret_here
ENV NODE_ENV=production

RUN npm run build

# ------------------------------
# ✅ Expose port & start server
# ------------------------------
EXPOSE 3000

CMD ["npm", "start"]
