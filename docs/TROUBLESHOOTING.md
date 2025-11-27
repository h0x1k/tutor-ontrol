# 🔧 Troubleshooting Guide

## Common Issues and Solutions

### Issue: Port 80 Not Accessible

**Symptoms:**
- `curl localhost` fails
- Browser can't connect to port 80
- Connection refused error

**Possible Causes:**
1. **Port 80 redirects to HTTPS** - HTTP redirects to HTTPS, but browser blocks self-signed certificate
2. **Another service using port 80** - Apache, another nginx, etc.
3. **Firewall blocking port 80**
4. **Accessing from different machine** - Need to use host IP instead of localhost

**Solutions:**

#### Solution 1: Use HTTP Without Redirect (Development)

The config has been updated to allow HTTP access without redirect:

```bash
cd tutor-ontrol-dev
docker-compose restart frontend
```

Now you can access:
- **HTTP:** http://localhost (works without redirect)
- **HTTPS:** https://localhost (optional)

#### Solution 2: Check What's Using Port 80

```bash
# Linux
sudo lsof -i :80
sudo netstat -tulpn | grep :80

# Check for other containers
docker ps | grep 80
```

#### Solution 3: Use Different Port

If port 80 is in use, change it in `docker-compose.yml`:

```yaml
ports:
  - "8080:80"  # Use 8080 instead of 80
```

Then access: http://localhost:8080

#### Solution 4: Access from Different Machine

If accessing from another machine:

```bash
# Find your IP
ip addr show  # Linux
ifconfig      # macOS/Linux

# Access from another machine
http://YOUR_IP_ADDRESS
```

### Issue: Browser Doesn't Respond

**Symptoms:**
- Browser shows "This site can't be reached"
- Page loads forever
- Connection timeout

**Possible Causes:**
1. **HTTPS redirect with self-signed certificate** - Browser blocks it
2. **Firewall blocking connection**
3. **Wrong URL** - Using https:// when HTTP is needed

**Solutions:**

#### Solution 1: Use HTTP (Not HTTPS)

```bash
# Use HTTP, not HTTPS
http://localhost
# NOT https://localhost (unless you accept the certificate)
```

#### Solution 2: Accept Self-Signed Certificate

If using HTTPS:
1. Click "Advanced" in browser
2. Click "Proceed to localhost (unsafe)"
3. Accept the security warning

#### Solution 3: Check Container Status

```bash
docker-compose ps
# All containers should show "Up"
```

### Issue: "unknown docker command: compose frontend"

**Error:**
```
unknown docker command: "compose frontend"
```

**Cause:** Wrong command syntax

**Solution:**

```bash
# Wrong:
docker compose frontend

# Correct:
docker-compose logs frontend
docker-compose restart frontend
docker-compose stop frontend

# Or with newer Docker:
docker compose logs frontend
docker compose restart frontend
```

### Issue: Port 8080 Works But Port 80 Doesn't

**Symptoms:**
- `curl localhost:8080` works
- `curl localhost` fails
- Port 8080 returns HTML

**Cause:** Another service is running on port 8080, or containers are using different ports

**Solution:**

```bash
# Check what's on port 8080
docker ps | grep 8080
sudo lsof -i :8080

# Check your docker-compose.yml ports
cat docker-compose.yml | grep -A 2 ports

# Restart with correct ports
docker-compose down
docker-compose up -d
```

### Issue: SSL Certificate Errors

**Symptoms:**
- Browser shows "Not Secure" or certificate warning
- SSL handshake errors in logs

**Solution:**

For development, use HTTP instead of HTTPS, or accept the self-signed certificate.

To regenerate certificates:

```bash
cd tutor-ontrol-dev
rm -rf nginx/ssl/*
./nginx/generate-ssl.sh
docker-compose restart frontend
```

### Issue: Container Won't Start

**Symptoms:**
- `docker-compose up` fails
- Container exits immediately

**Solution:**

```bash
# Check logs
docker-compose logs

# Check specific service
docker-compose logs frontend

# Rebuild
docker-compose down
docker-compose up -d --build

# Check for port conflicts
docker-compose ps
```

### Issue: Accessing from Different Machine/VM

**Symptoms:**
- Works on host machine
- Doesn't work from VM or another machine

**Solution:**

1. **Find host IP:**
   ```bash
   # On host machine
   ip addr show
   # Look for your network interface IP (e.g., 192.168.1.100)
   ```

2. **Access from VM:**
   ```bash
   # From VM or other machine
   http://HOST_IP_ADDRESS
   ```

3. **Check Docker binding:**
   - Make sure ports are bound to `0.0.0.0`, not `127.0.0.1`
   - Check `docker-compose.yml` has: `"0.0.0.0:80:80"` (default)

### Quick Diagnostic Commands

```bash
# Check container status
docker-compose ps

# Check logs
docker-compose logs frontend
docker-compose logs backend

# Test HTTP
curl http://localhost/

# Test HTTPS
curl -k https://localhost/

# Check ports
docker port tutor-frontend-dev

# Restart everything
docker-compose restart

# Rebuild and restart
docker-compose down
docker-compose up -d --build
```

## Current Configuration

**HTTP Access:** Enabled (no redirect)
- Access: http://localhost
- Port: 80

**HTTPS Access:** Optional
- Access: https://localhost
- Port: 443
- Certificate: Self-signed (development)

**To switch back to HTTPS redirect:**
```bash
cd tutor-ontrol-dev
cp nginx/frontend/nginx.conf.https nginx/frontend/nginx.conf
docker-compose restart frontend
```

