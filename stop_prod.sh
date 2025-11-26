#!/bin/bash

echo "🛑 Stopping Production Environment..."

cd prod

# Определяем команду docker-compose
DOCKER_COMPOSE_CMD="docker-compose"
if command -v docker &> /dev/null && docker compose version &> /dev/null; then
    DOCKER_COMPOSE_CMD="docker compose"
fi

$DOCKER_COMPOSE_CMD down

echo "✅ Production environment stopped"