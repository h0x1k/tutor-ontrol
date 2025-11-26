#!/bin/bash

echo "🔍 Verifying project structure..."

echo "📁 Checking dev/backend structure:"
ls -la dev/backend/

echo ""
echo "📋 Checking required files:"
required_files=(
    "dev/backend/requirements.txt"
    "dev/backend/manage.py" 
    "dev/backend/backend/__init__.py"
    "dev/backend/backend/settings.py"
    "dev/backend/backend/urls.py"
    "dev/backend/backend/wsgi.py"
    "dev/backend/management/commands/start_system.py"
    "dev/backend/Dockerfile"
    "dev/docker-compose.yml"
    "dev/nginx/Dockerfile"
    "dev/nginx/nginx.conf"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ $file - MISSING"
    fi
done

echo ""
echo "🐳 Testing Docker build..."
cd dev/backend
if sudo docker build -t tutor-backend-test .; then
    echo "✅ Docker build successful!"
else
    echo "❌ Docker build failed"
fi

cd ../../