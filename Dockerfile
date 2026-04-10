# Use an image that has Wine installed
FROM ghcr.io/vanypro/wine-alpine:latest

# Set the working directory
WORKDIR /app

# Copy your server files into the container
COPY ./Server /app

# Expose Port 443 for Chromebook compatibility
EXPOSE 443

# Start the server with the WebSocket port flag and logging
CMD ["wine", "MultisakenServer.exe", "-log", "-WebSocketPort=443"]