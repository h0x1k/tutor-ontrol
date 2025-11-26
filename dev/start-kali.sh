#!/bin/bash

# Quick start script for Kali Linux

set -e

echo "🐧 Kali Linux Setup Script"
echo "=========================="
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed!"
    echo ""
    echo "Install with:"
    echo "  sudo apt update"
    echo "  sudo apt install -y docker.io docker-compose"
    exit 1
fi

# Check if Docker is running
if ! sudo systemctl is-active --quiet docker; then
    echo "⚠️  Docker is not running. Starting..."
    sudo systemctl start docker
    sleep 2
fi

# Check if we're in the right directory
if [ ! -f "docker-compose.yml" ]; then
    echo "❌ docker-compose.yml not found!"
    echo "Please run this script from the dev/ directory"
    exit 1
fi

# Check if user is in docker group
if ! groups | grep -q docker; then
    echo "⚠️  You're not in the docker group."
    echo "Adding you to docker group (requires logout/login)..."
    sudo usermod -aG docker $USER
    echo "💡 You may need to logout and login, or run: newgrp docker"
fi

# Generate SSL certificates if needed
if [ ! -f "../nginx/ssl/cert.pem" ] || [ ! -f "../nginx/ssl/key.pem" ]; then
    echo "🔐 Generating SSL certificates..."
    cd ..
    mkdir -p nginx/ssl
    if command -v openssl &> /dev/null; then
        openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
            -keyout nginx/ssl/key.pem \
            -out nginx/ssl/cert.pem \
            -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost" 2>/dev/null
        echo "✅ Certificates generated"
    else
        echo "⚠️  OpenSSL not found. Installing..."
        sudo apt install -y openssl
        openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
            -keyout nginx/ssl/key.pem \
            -out nginx/ssl/cert.pem \
            -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"
    fi
    cd dev
fi

# Check for port conflicts
echo "🔍 Checking for port conflicts..."
CONFLICTS=0

if sudo lsof -i :80 &> /dev/null 2>&1; then
    echo "⚠️  Port 80 is in use"
    CONFLICTS=1
fi

if sudo lsof -i :8080 &> /dev/null 2>&1; then
    echo "⚠️  Port 8080 is in use"
    CONFLICTS=1
fi

if [ $CONFLICTS -eq 1 ]; then
    echo "💡 Using docker-compose.kali.yml (port 8080 instead of 80)"
    COMPOSE_FILE="-f docker-compose.yml -f docker-compose.kali.yml"
    PORT_INFO="Port 8080"
else
    COMPOSE_FILE=""
    PORT_INFO="Port 80"
fi

# Start containers
echo ""
echo "🐳 Starting Docker containers..."
if [ -n "$COMPOSE_FILE" ]; then
    docker-compose $COMPOSE_FILE up -d
else
    docker-compose up -d
fi

# Wait for services
echo "⏳ Waiting for services to start..."
sleep 5

# Check status
echo ""
echo "📋 Container Status:"
if [ -n "$COMPOSE_FILE" ]; then
    docker-compose $COMPOSE_FILE ps
else
    docker-compose ps
fi

# Test endpoints
echo ""
echo "🧪 Testing endpoints..."

if [ -n "$COMPOSE_FILE" ]; then
    TEST_PORT=8080
    TEST_URL="http://localhost:8080"
else
    TEST_PORT=80
    TEST_URL="http://localhost"
fi

if curl -s $TEST_URL > /dev/null 2>&1; then
    echo "✅ HTTP ($PORT_INFO): Working"
else
    echo "❌ HTTP ($PORT_INFO): Failed - check logs: docker-compose logs frontend"
fi

if curl -s -k https://localhost:8443/ > /dev/null 2>&1 || curl -s -k https://localhost/ > /dev/null 2>&1; then
    echo "✅ HTTPS: Working"
else
    echo "⚠️  HTTPS: May need certificate acceptance"
fi

# Show access info
echo ""
echo "✅ Setup complete!"
echo ""
echo "🌐 Access URLs:"
if [ -n "$COMPOSE_FILE" ]; then
    echo "  - HTTP:  http://localhost:8080"
    echo "  - HTTPS: https://localhost:8443 (self-signed cert)"
else
    echo "  - HTTP:  http://localhost"
    echo "  - HTTPS: https://localhost (self-signed cert)"
fi
echo "  - Backend API: http://localhost:8000/api/"
echo "  - Version Control: http://localhost:8001/health"
echo ""
echo "📝 Useful commands:"
if [ -n "$COMPOSE_FILE" ]; then
    echo "  - View logs: docker-compose $COMPOSE_FILE logs -f"
    echo "  - Stop: docker-compose $COMPOSE_FILE down"
    echo "  - Restart: docker-compose $COMPOSE_FILE restart"
else
    echo "  - View logs: docker-compose logs -f"
    echo "  - Stop: docker-compose down"
    echo "  - Restart: docker-compose restart"
fi
echo ""
