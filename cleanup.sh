#!/bin/bash

echo "🧹 Cleaning up Docker environment..."

echo "🛑 Stopping all containers..."
sudo docker stop $(sudo docker ps -aq) 2>/dev/null || echo "No containers to stop"

echo "🗑️ Removing all containers..."
sudo docker rm $(sudo docker ps -aq) 2>/dev/null || echo "No containers to remove"

echo "🧽 Pruning system..."
sudo docker system prune -af

echo "🔍 Verifying cleanup:"
echo "Containers:"
sudo docker ps -a
echo ""
echo "Port check:"
sudo ss -tulpn | grep -E "(8000|8080)" || echo "✅ Ports 8000 and 8080 are free"

echo "✅ Cleanup complete!"