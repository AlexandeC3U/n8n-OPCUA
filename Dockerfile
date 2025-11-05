FROM n8nio/n8n:latest

USER root

# Install the OPC UA community node at startup
RUN apk add --no-cache bash && \
    mkdir -p /docker-entrypoint.d

# Create startup script to install the plugin
RUN echo '#!/bin/bash' > /docker-entrypoint.d/50-install-opcua.sh && \
    echo 'echo "Installing OPC UA plugin..."' >> /docker-entrypoint.d/50-install-opcua.sh && \
    echo 'npm install -g @fiqch/n8n-nodes-fiq-opcua' >> /docker-entrypoint.d/50-install-opcua.sh && \
    echo 'echo "OPC UA plugin installed successfully"' >> /docker-entrypoint.d/50-install-opcua.sh && \
    chmod +x /docker-entrypoint.d/50-install-opcua.sh

USER node

# Expose n8n port
EXPOSE 5678

# Health check endpoint
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD wget --spider -q http://localhost:5678/healthz || exit 1

# Start n8n (entrypoint will run the install script first)
CMD ["n8n"]

