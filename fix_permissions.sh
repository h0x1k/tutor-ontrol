#!/bin/bash

echo "🔧 Fixing permissions..."

# Даем права на выполнение всех скриптов
chmod +x *.sh
chmod +x scripts/*.sh 2>/dev/null || true

# Даем права на чтение/запись всем файлам
find . -type f -name "*.py" -exec chmod 644 {} \;
find . -type f -name "*.txt" -exec chmod 644 {} \;
find . -type f -name "*.conf" -exec chmod 644 {} \;
find . -type f -name "*.yml" -exec chmod 644 {} \;
find . -type f -name "Dockerfile" -exec chmod 644 {} \;

# Даем права на выполнение manage.py
find . -name "manage.py" -exec chmod +x {} \;

# Даем права на папки
find . -type d -exec chmod 755 {} \;

echo "✅ Permissions fixed"