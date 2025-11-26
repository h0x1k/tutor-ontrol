# 🌐 Accessing from Kali Linux

If you're on a **Kali Linux machine** trying to access containers running on a **different machine** (macOS), you need to:

## 🔍 Situation

You're on **Kali Linux** but the containers are running on **macOS**. You can't access `localhost` on Kali because the containers aren't running there.

## ✅ Solutions

### Option 1: Access from Kali to macOS Host (Recommended)

1. **Find macOS IP address:**
   ```bash
   # On macOS host machine
   ifconfig | grep "inet " | grep -v 127.0.0.1
   # Or
   ipconfig getifaddr en0
   # Example output: 192.168.1.100
   ```

2. **Access from Kali:**
   ```bash
   # Replace with actual macOS IP
   curl http://192.168.1.100/
   
   # Or in browser
   http://192.168.1.100
   ```

3. **Make sure macOS firewall allows connections:**
   ```bash
   # On macOS
   sudo pfctl -d  # Temporarily disable firewall (not recommended)
   # Or configure firewall to allow port 80
   ```

### Option 2: Run Containers on Kali

If you want to run containers directly on Kali:

```bash
# On Kali machine
cd /home/.../Desktop/fl/tutor-ontrol/dev

# Make sure Docker is running
sudo systemctl start docker
sudo systemctl enable docker

# Start containers
docker-compose up -d

# Check status
docker-compose ps

# Now access
curl http://localhost/
```

### Option 3: Use SSH Tunnel

If you can't access directly:

```bash
# On Kali, create SSH tunnel
ssh -L 8080:localhost:80 user@macos-host-ip

# Then access
curl http://localhost:8080/
```

## 🔧 Quick Check Commands

### On Kali Machine:

```bash
# Check if Docker is running
sudo systemctl status docker

# Check if containers are running
docker ps

# Check if port 80 is in use
sudo netstat -tulpn | grep :80
sudo lsof -i :80

# Try accessing with host IP (if known)
curl http://MACOS_IP_ADDRESS/
```

### On macOS Host:

```bash
# Check containers are running
cd tutor-ontrol/dev
docker-compose ps

# Check what IP to use
ifconfig | grep "inet "

# Test locally
curl http://localhost/
```

## 🎯 Most Likely Solution

Since you're on Kali and containers are on macOS:

1. **Find macOS IP:**
   ```bash
   # On macOS
   ifconfig en0 | grep inet
   ```

2. **Access from Kali:**
   ```bash
   # On Kali
   curl http://MACOS_IP_ADDRESS/
   ```

3. **If still can't connect:**
   - Check macOS firewall
   - Make sure both machines are on same network
   - Try ping: `ping MACOS_IP_ADDRESS`

## 📝 Docker Commands Reference

```bash
# Check status
docker-compose ps

# View logs
docker-compose logs frontend
docker-compose logs backend

# Start services
docker-compose up -d

# Stop services
docker-compose down

# Restart
docker-compose restart

# Rebuild
docker-compose up -d --build
```

