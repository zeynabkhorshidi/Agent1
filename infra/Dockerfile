# syntax=docker/dockerfile:1
FROM node:22.21.1-bookworm-slim AS web
WORKDIR /web
COPY apps/web/package*.json ./
RUN --mount=type=secret,id=proxy_ca,target=/run/proxy_ca \
    if [ -f /run/proxy_ca ]; then export NODE_EXTRA_CA_CERTS=/run/proxy_ca; fi; npm ci --ignore-scripts
COPY apps/web ./
RUN npm run build
FROM python:3.12.12-slim-bookworm AS app
WORKDIR /app
COPY requirements.lock ./
RUN --mount=type=secret,id=proxy_ca,target=/run/proxy_ca \
    if [ -f /run/proxy_ca ]; then export PIP_CERT=/run/proxy_ca; fi; pip install --no-cache-dir --timeout 180 --retries 8 --require-hashes -r requirements.lock
COPY packages ./packages
COPY services ./services
COPY infra/migrations ./infra/migrations
COPY alembic.ini ./
COPY vendor/multi-agent-marketplace/packages/magentic-marketplace/src/magentic_marketplace/marketplace/actions/messaging.py ./vendor/multi-agent-marketplace/packages/magentic-marketplace/src/magentic_marketplace/marketplace/actions/messaging.py
COPY --from=web /web/dist ./apps/web/dist
RUN useradd --uid 10001 --create-home app && chown -R app:app /app
USER app
EXPOSE 8000
CMD ["uvicorn","services.api.main:app","--host","0.0.0.0","--port","8000"]
