FROM python:3.11-slim

RUN apt-get update && apt-get install -y --no-install-recommends git socat \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    git+https://github.com/MrFixit96/onedrive-mcp-server.git

ENV ONEDRIVE_MCP_PORT=3001 \
    ONEDRIVE_MCP_LOG_LEVEL=INFO

EXPOSE 9000

# servidor interno em 127.0.0.1:3001, socat publica em 0.0.0.0:9000
CMD sh -c "onedrive-mcp --http & exec socat TCP-LISTEN:9000,fork,reuseaddr TCP:127.0.0.1:3001"
