FROM n8nio/n8n:latest
USER root

# ffmpeg + Fonts installieren (funktioniert für Debian- UND Alpine-basierte n8n Images)
RUN if command -v apk >/dev/null 2>&1; then \
      apk add --no-cache ffmpeg fontconfig ttf-dejavu ttf-liberation ttf-freefont wget ca-certificates && \
      update-ca-certificates; \
    else \
      apt-get update && \
      apt-get install -y --no-install-recommends ffmpeg fontconfig fonts-dejavu fonts-liberation fonts-freefont-ttf wget ca-certificates && \
      rm -rf /var/lib/apt/lists/*; \
    fi && \
    mkdir -p /usr/share/fonts/truetype/montserrat && \
    cd /usr/share/fonts/truetype/montserrat && \
    wget -q https://github.com/google/fonts/raw/main/ofl/montserrat/Montserrat-Regular.ttf && \
    wget -q https://github.com/google/fonts/raw/main/ofl/montserrat/Montserrat-Bold.ttf && \
    fc-cache -f -v

ENV FFMPEG_PATH=/usr/bin/ffmpeg
USER node
