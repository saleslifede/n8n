FROM n8nio/n8n:latest

USER root

# Install ffmpeg + fonts + locales
RUN apt-get update && \
    apt-get install -y ffmpeg fonts-dejavu fonts-freefont-ttf fonts-liberation fonts-roboto && \
    rm -rf /var/lib/apt/lists/*

# Add Montserrat font
RUN mkdir -p /usr/share/fonts/truetype/montserrat && \
    cd /usr/share/fonts/truetype/montserrat && \
    wget https://github.com/google/fonts/raw/main/ofl/montserrat/Montserrat-Regular.ttf && \
    wget https://github.com/google/fonts/raw/main/ofl/montserrat/Montserrat-Bold.ttf && \
    fc-cache -f -v

USER node
