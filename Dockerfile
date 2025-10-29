FROM n8nio/n8n:latest

USER root

# ffmpeg + ein paar Fonts
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ffmpeg \
      fonts-dejavu fonts-freefont-ttf fonts-liberation fonts-roboto && \
    rm -rf /var/lib/apt/lists/*

# Montserrat hinzufügen
RUN mkdir -p /usr/share/fonts/truetype/montserrat && \
    cd /usr/share/fonts/truetype/montserrat && \
    wget -q https://github.com/google/fonts/raw/main/ofl/montserrat/Montserrat-Regular.ttf && \
    wget -q https://github.com/google/fonts/raw/main/ofl/montserrat/Montserrat-Bold.ttf && \
    fc-cache -f -v

USER node
