# Use a standard Ubuntu image
FROM ubuntu:22.04

# Avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Enable 32-bit architecture and install Wine + dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
    wine \
    wine32 \
    wine64 \
    libvulkan1 \
    libvulkan1:i386 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy your server files into the container
COPY ./Server /app

# Expose Port 443 for Chromebook compatibility
EXPOSE 443

# Start the server in "Null" mode to prevent it from trying to open a window
# We add -nullrhi and -nosplash to keep it headless
CMD ["wine64", "MultisakenServer.exe", "-log", "-WebSocketPort=443", "-nullrhi", "-nosplash", "-noverifygc"]