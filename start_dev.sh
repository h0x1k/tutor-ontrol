#!/bin/bash

echo "🚀 Starting Development Environment (Simple Version)..."

# Проверка Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed"
    exit 1
fi

# Используем docker compose
DOCKER_COMPOSE_CMD="docker compose"
if ! command -v docker &> /dev/null || ! docker compose version &> /dev/null; then
    DOCKER_COMPOSE_CMD="docker-compose"
fi

echo "📁 Checking dev directory..."
if [ ! -d "dev" ]; then
    echo "❌ dev directory not found. Running migration..."
    chmod +x migrate_structure.sh
    ./migrate_structure.sh
fi

cd dev

echo "🔧 Building containers..."
$DOCKER_COMPOSE_CMD build

echo "🚀 Starting services..."
$DOCKER_COMPOSE_CMD up -d

echo "⏳ Waiting for startup..."
sleep 15

echo "🔍 Checking status..."
$DOCKER_COMPOSE_CMD ps

echo "📋 Container logs:"
$DOCKER_COMPOSE_CMD logs