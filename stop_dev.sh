#!/bin/bash

echo "🛑 Stopping Development Environment..."

cd dev

# Определяем команду docker-compose
DOCKER_COMPOSE_CMD="docker-compose"
if command -v docker &> /dev/null && docker compose version &> /dev/null; then
    DOCKER_COMPOSE_CMD="docker compose"
fi

$DOCKER_COMPOSE_CMD down

echo "✅ Development environment stopped"