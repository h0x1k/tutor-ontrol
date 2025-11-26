#!/bin/bash

echo "🔄 Complete system restart..."

# Останавливаем все
sudo docker compose -f dev/docker-compose.yml down 2>/dev/null || true
sudo docker rm -f tutor-backend-dev tutor-nginx-dev 2>/dev/null || true
sudo docker volume rm -f dev_db_data 2>/dev/null || true
sudo docker network rm tutor-ontrol_dev-network 2>/dev/null || true

# Удаляем старые образы
sudo docker rmi -f tutor-ontrol-backend tutor-ontrol-nginx 2>/dev/null || true

# Создаем статические файлы
echo "📁 Creating static files..."
./create_static_files.sh

# Даем правильные права
echo "🔧 Setting permissions..."
find dev/ -type f -name "*.py" -exec chmod 644 {} \;
find dev/ -type f -name "*.html" -exec chmod 644 {} \;
find dev/ -type f -name "*.css" -exec chmod 644 {} \;
chmod +x dev/backend/manage.py
chmod -R 755 dev/backend/static/

cd dev

echo "🐳 Building backend..."
sudo docker compose build backend

echo "🚀 Starting backend..."
sudo docker compose up backend -d

echo "⏳ Waiting for backend to be ready..."
for i in {1..30}; do
    if curl -s http://localhost:8000/ > /dev/null; then
        echo "✅ Backend is ready!"
        break
    fi
    echo "⏱️ Waiting for backend... ($i/30)"
    sleep 2
done

# Собираем статические файлы через Django
echo "📦 Collecting Django static files..."
sudo docker compose exec backend python manage.py collectstatic --noinput

echo "🐳 Building nginx..."
sudo docker compose build nginx

echo "🚀 Starting nginx..."
sudo docker compose up -d nginx

echo "⏳ Waiting for nginx..."
sleep 5

echo "🔍 Final status check:"
sudo docker compose ps

echo ""
echo "🌐 Testing endpoints:"
echo "Backend direct:    http://localhost:8000/"
echo "Nginx proxy:       http://localhost:8080/"
echo "Health check:      http://localhost:8080/health"
echo "Static files:      http://localhost:8080/static/"
echo "Django admin:      http://localhost:8080/admin/"

echo ""
echo "📋 Testing connectivity..."
curl -s -o /dev/null -w "Backend direct: %{http_code}\n" http://localhost:8000/
curl -s -o /dev/null -w "Nginx proxy:    %{http_code}\n" http://localhost:8080/
curl -s -o /dev/null -w "Health check:   %{http_code}\n" http://localhost:8080/health
curl -s -o /dev/null -w "Static files:   %{http_code}\n" http://localhost:8080/static/

echo ""
echo "📜 Logs:"
sudo docker compose logs --tail=10