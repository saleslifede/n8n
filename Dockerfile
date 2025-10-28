# n8n + FFmpeg + Montserrat (für Caption-Render mit drawtext)
FROM n8nio/n8n:latest

USER root

RUN apt-get update  && apt-get install -y --no-install-recommends ffmpeg fontconfig wget ca-certificates  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/share/fonts/truetype/montserrat &&     cd /usr/share/fonts/truetype/montserrat &&     wget -q https://github.com/google/fonts/raw/main/ofl/montserrat/Montserrat-Regular.ttf &&     wget -q https://github.com/google/fonts/raw/main/ofl/montserrat/Montserrat-Bold.ttf &&     fc-cache -f -v

ENV GENERIC_TIMEZONE=Europe/Berlin

USER node

CMD ["tini", "--", "n8n"]
