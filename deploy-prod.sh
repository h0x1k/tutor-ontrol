#!/bin/bash
set -e

echo "🚀 Starting production deployment..."

# Pull latest images
docker-compose -f docker-compose.prod.yml pull

# Stop and remove old containers
docker-compose -f docker-compose.prod.yml down

# Start new containers
docker-compose -f docker-compose.prod.yml up -d

# Run database migrations if needed
docker-compose -f docker-compose.prod.yml exec tutor-app python migrate.py || true

echo "✅ Production deployment completed!"