# ---- Base: Debian Slim mit Node 20 ----
FROM node:20-bookworm-slim

USER root

# ffmpeg + Fontconfig + Tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    fontconfig \
    wget \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Montserrat-Fonts hinzufügen
RUN mkdir -p /usr/share/fonts/truetype/montserrat && \
    cd /usr/share/fonts/truetype/montserrat && \
    wget -q https://github.com/google/fonts/raw/main/ofl/montserrat/Montserrat-Regular.ttf && \
    wget -q https://github.com/google/fonts/raw/main/ofl/montserrat/Montserrat-Bold.ttf && \
    fc-cache -f -v

# n8n global installieren
RUN npm install -g --omit=dev n8n

# App-Verzeichnis und User
WORKDIR /usr/local/n8n
RUN useradd -ms /bin/bash n8n && chown -R n8n:n8n /usr/local/n8n
USER n8n

# n8n Default-Port
ENV N8N_PORT=5678
EXPOSE 5678

# Healthcheck (Render zeigt dann „Healthy“)
HEALTHCHECK --interval=30s --timeout=5s --retries=5 \
  CMD curl -fsS http://localhost:5678/healthz || exit 1

# Start
CMD ["n8n", "start"]
