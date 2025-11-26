#!/bin/bash

echo "🚀 Starting Development Environment..."

# Проверка наличия Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Проверка наличия docker-compose
if ! command -v docker-compose &> /dev/null && ! command -v docker compose &> /dev/null; then
    echo "❌ docker-compose is not installed. Please install docker-compose first."
    exit 1
fi

# Определяем команду docker-compose
DOCKER_COMPOSE_CMD="docker-compose"
if command -v docker &> /dev/null && docker compose version &> /dev/null; then
    DOCKER_COMPOSE_CMD="docker compose"
fi

# Переходим в папку dev
cd dev

echo "📦 Building and starting development containers..."
$DOCKER_COMPOSE_CMD down
$DOCKER_COMPOSE_CMD build --no-cache
$DOCKER_COMPOSE_CMD up -d

echo "⏳ Waiting for services to start..."
sleep 10

# Проверяем статус контейнеров
echo "🔍 Checking container status..."
$DOCKER_COMPOSE_CMD ps

# Проверяем доступность приложения
echo "🔗 Testing application accessibility..."
if curl -f http://localhost:8080 > /dev/null 2>&1; then
    echo "✅ Development environment is running successfully!"
    echo "🌐 Frontend: http://localhost:8080"
    echo "🔧 Backend API: http://localhost:8080/api/"
else
    echo "⚠️  Application is starting... Please wait a moment and check http://localhost:8080"
fi

echo ""
echo "📝 Useful commands:"
echo "   docker logs tutor-backend-dev    # Backend logs"
echo "   docker logs tutor-nginx-dev      # Nginx logs"
echo "   docker-compose down              # Stop development environment"