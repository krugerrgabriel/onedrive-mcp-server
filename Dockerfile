FROM python:3.11-slim

RUN apt-get update && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Instala o código DESTE repositório (o fork com o patch), não o original via pip.
COPY . /app
RUN pip install --no-cache-dir /app

ENV ONEDRIVE_MCP_PORT=3001 \
    ONEDRIVE_MCP_HOST=0.0.0.0 \
    ONEDRIVE_MCP_LOG_LEVEL=INFO

EXPOSE 3001

# Com ONEDRIVE_MCP_HOST=0.0.0.0 o servidor já escuta em todas as interfaces.
# socat não é mais necessário.
CMD ["onedrive-mcp", "--http"]
