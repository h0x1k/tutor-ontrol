# 🐧 Setup on Kali Linux

Complete guide to run the application on Kali Linux.

## 📋 Prerequisites

### 1. Install Docker

```bash
# Update system
sudo apt update

# Install Docker
sudo apt install -y docker.io docker-compose

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add your user to docker group (optional, to avoid sudo)
sudo usermod -aG docker $USER
# Log out and back in for this to take effect

# Verify installation
docker --version
docker-compose --version
```

### 2. Install Required Tools

```bash
# Install git (if not already installed)
sudo apt install -y git

# Install openssl (for SSL certificates)
sudo apt install -y openssl
```

## 🚀 Setup Steps

### Step 1: Copy Project to Kali

```bash
# Option 1: If you have the project files
# Copy the entire tutor-ontrol folder to Kali

# Option 2: Clone from GitHub (if you have it there)
git clone https://github.com/YOUR_USERNAME/tutor-ontrol-dev.git
cd tutor-ontrol-dev
```

### Step 2: Generate SSL Certificates

```bash
cd tutor-ontrol-dev

# Make script executable
chmod +x nginx/generate-ssl.sh

# Generate certificates
./nginx/generate-ssl.sh
```

### Step 3: Start Services

```bash
# Navigate to dev folder
cd dev

# Start all services
docker-compose up -d

# Check status
docker-compose ps
```

### Step 4: Verify It's Working

```bash
# Test HTTP
curl http://localhost/

# Test HTTPS (will show certificate warning)
curl -k https://localhost/

# Check logs if issues
docker-compose logs frontend
```

## 🔧 Common Issues on Kali

### Issue: Port 80 Permission Denied

**Error:** `bind: permission denied`

**Solution:**
```bash
# Option 1: Use port 8080 instead
# Edit docker-compose.yml:
ports:
  - "8080:80"  # Instead of "80:80"

# Option 2: Run with sudo (not recommended)
sudo docker-compose up -d

# Option 3: Use setcap (better)
sudo setcap 'cap_net_bind_service=+ep' /usr/bin/docker-compose
```

### Issue: Docker Permission Denied

**Error:** `permission denied while trying to connect to Docker daemon`

**Solution:**
```bash
# Add user to docker group
sudo usermod -aG docker $USER

# Log out and back in, or:
newgrp docker

# Verify
docker ps
```

### Issue: Firewall Blocking

**Solution:**
```bash
# Check firewall status
sudo ufw status

# Allow ports (if using ufw)
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 8000/tcp
sudo ufw allow 8001/tcp

# Or disable firewall temporarily (not recommended)
sudo ufw disable
```

### Issue: SELinux Issues

**Solution:**
```bash
# Check SELinux status
getenforce

# If enforcing, set to permissive (temporary)
sudo setenforce 0

# Or configure SELinux for Docker
sudo setsebool -P container_manage_cgroup on
```

## 📝 Quick Start Script

Create this script to make it easier:

```bash
#!/bin/bash
# save as: start-dev.sh

cd "$(dirname "$0")/dev"

echo "🐳 Starting Docker containers..."
docker-compose up -d

echo "⏳ Waiting for services to start..."
sleep 5

echo "✅ Services started!"
echo ""
echo "📋 Status:"
docker-compose ps

echo ""
echo "🌐 Access:"
echo "  - HTTP:  http://localhost"
echo "  - HTTPS: https://localhost"
echo "  - Backend: http://localhost:8000/api/"
echo ""
echo "📝 View logs: docker-compose logs -f"
```

Make it executable:
```bash
chmod +x start-dev.sh
./start-dev.sh
```

## 🔍 Verification

### Check Everything is Running

```bash
# Check containers
docker-compose ps

# Should show:
# - tutor-backend-dev (Up)
# - tutor-frontend-dev (Up)
# - tutor-versioncontrol-dev (Up)

# Check ports
sudo netstat -tulpn | grep -E "80|443|8000|8001"

# Test endpoints
curl http://localhost/
curl http://localhost:8000/api/
curl http://localhost:8001/health
```

### Check Logs

```bash
# All services
docker-compose logs

# Specific service
docker-compose logs frontend
docker-compose logs backend
docker-compose logs versioncontrol

# Follow logs
docker-compose logs -f frontend
```

## 🛠️ Troubleshooting

### Containers Won't Start

```bash
# Check Docker is running
sudo systemctl status docker

# Check disk space
df -h

# Check Docker logs
sudo journalctl -u docker.service

# Rebuild containers
docker-compose down
docker-compose up -d --build
```

### Port Already in Use

```bash
# Find what's using the port
sudo lsof -i :80
sudo netstat -tulpn | grep :80

# Stop conflicting service
sudo systemctl stop apache2  # If Apache is running
sudo systemctl stop nginx     # If system nginx is running

# Or change port in docker-compose.yml
```

### SSL Certificate Issues

```bash
# Regenerate certificates
rm -rf nginx/ssl/*
./nginx/generate-ssl.sh

# Restart frontend
docker-compose restart frontend
```

## 📋 Complete Setup Checklist

- [ ] Docker installed
- [ ] Docker Compose installed
- [ ] Docker service running
- [ ] User in docker group (optional)
- [ ] Project files copied to Kali
- [ ] SSL certificates generated
- [ ] Ports 80, 443, 8000, 8001 available
- [ ] Firewall configured (if needed)
- [ ] Containers started: `docker-compose up -d`
- [ ] Services accessible: `curl http://localhost/`

## 🎯 Quick Commands Reference

```bash
# Start
cd dev && docker-compose up -d

# Stop
docker-compose down

# Restart
docker-compose restart

# View logs
docker-compose logs -f

# Rebuild
docker-compose up -d --build

# Check status
docker-compose ps

# Access
http://localhost
https://localhost
```

## ✅ Success Indicators

When everything is working:

```bash
# This should return HTML
curl http://localhost/

# This should return 200
curl -I http://localhost/

# Containers should all be "Up"
docker-compose ps
```

## 🔒 Security Notes for Kali

- **Firewall:** Configure properly for production
- **Ports:** Only expose necessary ports
- **SSL:** Use real certificates for production
- **Docker:** Keep Docker updated
- **Permissions:** Don't run Docker as root if possible

