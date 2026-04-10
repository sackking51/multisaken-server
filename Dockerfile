FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
# This sets a fake display for Wine
ENV DISPLAY=:99

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
    wine \
    wine32 \
    wine64 \
    xvfb \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY ./Server /app

EXPOSE 443

# We wrap the command in Xvfb to provide the virtual display
CMD ["sh", "-c", "Xvfb :99 -screen 0 1024x768x16 & sleep 2 && wine64 MultisakenServer.exe -log -WebSocketPort=443 -nullrhi -nosplash -noverifygc -server"]