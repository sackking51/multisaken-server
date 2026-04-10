# Use a standard Ubuntu image
FROM ubuntu:22.04

# Avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install Wine and necessary dependencies
RUN apt-get update && apt-get install -y \
    wine \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy your server files into the container
COPY ./Server /app

# Expose Port 443 for Chromebook compatibility
EXPOSE 443

# Start the server with the WebSocket port flag
# Using 'wine64' since Unreal builds are typically 64-bit
CMD ["wine64", "MultisakenServer.exe", "-log", "-WebSocketPort=443"]