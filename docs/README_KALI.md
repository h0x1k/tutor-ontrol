# 🐧 Quick Start for Kali Linux

## 🚀 Fast Setup

```bash
# 1. Install Docker (if not installed)
sudo apt update
sudo apt install -y docker.io docker-compose

# 2. Start Docker
sudo systemctl start docker
sudo systemctl enable docker

# 3. Navigate to project
cd tutor-ontrol-dev/dev

# 4. Run setup script
chmod +x ../start-kali.sh
../start-kali.sh

# Or manually:
docker-compose up -d
```

## ✅ Verify It Works

```bash
# Check containers
docker-compose ps

# Test HTTP
curl http://localhost/

# Open in browser
# http://localhost
```

## 🔧 If Port 80 Doesn't Work

### Option 1: Use Port 8080

Edit `docker-compose.yml`:
```yaml
ports:
  - "8080:80"  # Change from "80:80"
```

Then access: `http://localhost:8080`

### Option 2: Fix Port 80 Permissions

```bash
# Allow non-root to bind to port 80
sudo setcap 'cap_net_bind_service=+ep' /usr/bin/docker-compose

# Or use authbind
sudo apt install authbind
sudo touch /etc/authbind/byport/80
sudo chmod 500 /etc/authbind/byport/80
sudo chown $USER /etc/authbind/byport/80
```

## 📝 Common Commands

```bash
# Start
docker-compose up -d

# Stop
docker-compose down

# Logs
docker-compose logs -f frontend

# Restart
docker-compose restart
```

## 🆘 Troubleshooting

**Can't connect to localhost:80**
- Check: `docker-compose ps` - containers running?
- Check: `sudo lsof -i :80` - port in use?
- Try: Use port 8080 instead

**Permission denied**
- Run: `sudo usermod -aG docker $USER` then logout/login
- Or use: `sudo docker-compose up -d`

**Firewall blocking**
- Run: `sudo ufw allow 80/tcp`

See `KALI_SETUP.md` for detailed troubleshooting.

