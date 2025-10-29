#!/usr/bin/env sh
set -e

echo "[ffmpeg-install] Ensuring /data/bin..."
D=/data/bin
mkdir -p "$D"

F="$D/ffmpeg"
P="$D/ffprobe"

if [ ! -x "$F" ]; then
  echo "[ffmpeg-install] Downloading ffmpeg..."
  curl -fsSL -o "$F" https://cdn.jsdelivr.net/gh/eugeneware/ffmpeg-static@binaries-for-v6.1/ffmpeg-linux-x64     || wget -qO "$F" https://cdn.jsdelivr.net/gh/eugeneware/ffmpeg-static@binaries-for-v6.1/ffmpeg-linux-x64
  chmod +x "$F"
else
  echo "[ffmpeg-install] ffmpeg already installed."
fi

if [ ! -x "$P" ]; then
  echo "[ffmpeg-install] Downloading ffprobe..."
  curl -fsSL -o "$P" https://cdn.jsdelivr.net/gh/eugeneware/ffprobe-static@v6.1/ffprobe-linux-x64     || wget -qO "$P" https://cdn.jsdelivr.net/gh/eugeneware/ffprobe-static@v6.1/ffprobe-linux-x64
  chmod +x "$P"
else
  echo "[ffmpeg-install] ffprobe already installed."
fi

echo "[ffmpeg-install] Done. Versions:"
"$F" -version | head -n1 || true
"$P" -version | head -n1 || true
