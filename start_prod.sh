#!/bin/bash

echo "🚀 Starting Production Environment..."

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

# Переходим в папку prod
cd prod

echo "📦 Building and starting production containers..."
$DOCKER_COMPOSE_CMD down
$DOCKER_COMPOSE_CMD build --no-cache
$DOCKER_COMPOSE_CMD up -d

echo "⏳ Waiting for services to start..."
sleep 15

# Проверяем статус контейнеров
echo "🔍 Checking container status..."
$DOCKER_COMPOSE_CMD ps

# Проверяем доступность приложения
echo "🔗 Testing application accessibility..."
if curl -f http://localhost:80 > /dev/null 2>&1; then
    echo "✅ Production environment is running successfully!"
    echo "🌐 Application: http://localhost"
    echo "🔧 Backend API: http://localhost/api/"
else
    echo "⚠️  Application is starting... Please wait a moment and check http://localhost"
fi

echo ""
echo "📝 Useful commands:"
echo "   docker logs tutor-backend-prod    # Backend logs"
echo "   docker logs tutor-nginx-prod      # Nginx logs"
echo "   docker-compose down              # Stop production environment"
echo "   docker-compose logs -f           # Follow all logs"