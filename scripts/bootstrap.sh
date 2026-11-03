#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
command -v docker >/dev/null || { echo 'Docker 24+ و Compose v2 لازم است'; exit 1; }
docker info >/dev/null
docker compose version
if [ ! -f .env ]; then
  umask 077
  cp .env.example .env
  printf '\nDB_PASSWORD=%s\n' "$(od -An -N24 -tx1 /dev/urandom | tr -d ' \n')" >> .env
fi
docker compose build api
docker compose up -d --no-build --wait api worker web
printf '\nدمو آماده است. حساب امن بسازید:\ndocker compose exec api python -m packages.domain.seed --user admin\nسپس مرورگر را روی پورت محلی 8080 باز کنید.\n'
