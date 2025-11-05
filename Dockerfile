FROM n8nio/n8n:latest

USER root

# Install the OPC UA plugin
RUN cd /usr/local/lib/node_modules/n8n && \
    npm install @fiqch/n8n-nodes-fiq-opcua && \
    chown -R node:node /usr/local/lib/node_modules/n8n

USER node

# Set working directory
WORKDIR /home/node

# Expose n8n port
EXPOSE 5678

# Health check endpoint
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD wget --spider -q http://localhost:5678/healthz || exit 1

# Start n8n
CMD ["n8n"]

