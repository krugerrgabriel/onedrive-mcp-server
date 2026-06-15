FROM python:3.11-slim

WORKDIR /app

# git é necessário porque o pacote é instalado direto do GitHub
RUN apt-get update && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    git+https://github.com/MrFixit96/onedrive-mcp-server.git

ENV ONEDRIVE_MCP_PORT=3001 \
    ONEDRIVE_MCP_LOG_LEVEL=INFO

EXPOSE 3001

CMD ["onedrive-mcp", "--http"]
