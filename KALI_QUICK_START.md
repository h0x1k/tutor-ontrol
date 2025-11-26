# 🐧 Kali Linux - Quick Start

## ⚡ Fastest Way to Get Running

```bash
# 1. Install Docker (one-time setup)
sudo apt update && sudo apt install -y docker.io docker-compose

# 2. Start Docker
sudo systemctl start docker
sudo systemctl enable docker

# 3. Add yourself to docker group (optional, avoids sudo)
sudo usermod -aG docker $USER
newgrp docker  # Or logout/login

# 4. Navigate to project
cd tutor-ontrol-dev/dev

# 5. Run setup script
chmod +x start-kali.sh
./start-kali.sh
```

That's it! The script will:
- ✅ Check Docker is installed and running
- ✅ Generate SSL certificates if needed
- ✅ Handle port conflicts automatically
- ✅ Start all containers
- ✅ Test the endpoints

## 🌐 Access

After running the script, access at:

- **HTTP:** http://localhost:8080 (or http://localhost if port 80 is free)
- **HTTPS:** https://localhost:8443 (or https://localhost)
- **Backend:** http://localhost:8000/api/
- **Version Control:** http://localhost:8001/health

## 🔧 Manual Setup (If Script Doesn't Work)

```bash
# 1. Generate SSL certificates
cd tutor-ontrol-dev
mkdir -p nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout nginx/ssl/key.pem \
    -out nginx/ssl/cert.pem \
    -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"

# 2. Start with port 8080 (avoids permission issues)
cd dev
docker-compose -f docker-compose.yml -f docker-compose.kali.yml up -d

# 3. Check status
docker-compose ps

# 4. Test
curl http://localhost:8080/
```

## 🆘 Common Issues

### "Permission denied" on port 80

**Solution:** Use port 8080 instead
```bash
docker-compose -f docker-compose.yml -f docker-compose.kali.yml up -d
# Access at http://localhost:8080
```

### "Cannot connect to Docker daemon"

**Solution:**
```bash
sudo systemctl start docker
sudo usermod -aG docker $USER
newgrp docker  # Or logout/login
```

### Port already in use

**Solution:**
```bash
# Find what's using the port
sudo lsof -i :8080
sudo netstat -tulpn | grep :8080

# Stop conflicting service or use different port
```

## 📝 Quick Commands

```bash
# Start
docker-compose up -d
# Or with port 8080:
docker-compose -f docker-compose.yml -f docker-compose.kali.yml up -d

# Stop
docker-compose down

# Logs
docker-compose logs -f frontend

# Restart
docker-compose restart

# Rebuild
docker-compose up -d --build
```

## ✅ Success!

When working, you should see:
- ✅ `docker-compose ps` shows all containers "Up"
- ✅ `curl http://localhost:8080/` returns HTML
- ✅ Browser shows the application

See `KALI_SETUP.md` for detailed troubleshooting.

