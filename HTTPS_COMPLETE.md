# 🔒 HTTPS Configuration Complete

Everything is now accessible via HTTPS!

## ✅ What's Configured

### Development Environment

- **HTTP → HTTPS Redirect:** All HTTP requests automatically redirect to HTTPS
- **HTTPS Frontend:** https://localhost
- **HTTPS Backend API:** https://localhost/api/ (proxied through nginx)
- **HTTPS Version Control:** https://localhost/version-control/ (proxied through nginx)
- **SSL Certificates:** Self-signed certificates for development
- **Security Headers:** HSTS, X-Frame-Options, etc.

### Production Environment

- **HTTP → HTTPS Redirect:** All HTTP requests automatically redirect to HTTPS
- **HTTPS Frontend:** https://localhost
- **HTTPS Backend API:** https://localhost/api/ (proxied through nginx)
- **HTTPS Version Control:** https://localhost/version-control/ (proxied through nginx)
- **SSL Certificates:** Self-signed (replace with real certificates for production)

## 🌐 Access URLs

### Development

- **Frontend:** https://localhost
- **Backend API:** https://localhost/api/
- **Version Control:** https://localhost/version-control/health
- **HTTP (redirects):** http://localhost → automatically redirects to HTTPS

### Production

- **Frontend:** https://localhost
- **Backend API:** https://localhost/api/
- **Version Control:** https://localhost/version-control/health
- **HTTP (redirects):** http://localhost → automatically redirects to HTTPS

## 🔧 Changes Made

### 1. Nginx Configuration

**Dev:** `dev/nginx/frontend/nginx.conf`
- HTTP server redirects to HTTPS
- HTTPS server serves frontend
- Proxies `/api/` to backend
- Proxies `/version-control/` to version control service

**Prod:** `prod/nginx/nginx.conf`
- Already had HTTPS redirect
- Proxies `/api/` to backend
- Proxies `/version-control/` to version control service

### 2. Frontend Code

**Updated all Vue components to use relative paths:**
- Changed from: `axios.defaults.baseURL = 'http://localhost:8000'`
- Changed to: `axios.defaults.baseURL = ''` (relative paths)

**Files updated:**
- `dev/nginx/frontend/src/views/Home.vue`
- `dev/nginx/frontend/src/views/CategoryPage.vue`
- `dev/nginx/frontend/src/views/LessonList.vue`
- `dev/nginx/frontend/src/views/StudentLessons.vue`
- `dev/nginx/frontend/src/components/StudentManagement.vue`
- `dev/nginx/frontend/src/components/LessonManagement.vue`
- `dev/nginx/frontend/src/components/JournalManagement.vue`
- Same files in `prod/nginx/frontend/src/`

### 3. Docker Compose

- Port 443 exposed for HTTPS
- SSL certificates mounted as volumes
- All services accessible via HTTPS

## 🧪 Testing

### Test HTTP Redirect

```bash
# Should redirect to HTTPS
curl -I http://localhost/
# Response: HTTP/1.1 301 Moved Permanently
# Location: https://localhost/
```

### Test HTTPS Frontend

```bash
# Should return HTML
curl -k https://localhost/
```

### Test HTTPS Backend API

```bash
# Should return API endpoints
curl -k https://localhost/api/
```

### Test HTTPS Version Control

```bash
# Should return health status
curl -k https://localhost/version-control/health
```

## ⚠️ Browser Certificate Warning

Since we're using **self-signed certificates**, browsers will show a security warning:

1. **Chrome/Edge:** Click "Advanced" → "Proceed to localhost (unsafe)"
2. **Firefox:** Click "Advanced" → "Accept the Risk and Continue"
3. **Safari:** Click "Show Details" → "visit this website"

This is **normal for development**. For production, use real SSL certificates.

## 🔐 Using Real Certificates (Production)

### Option 1: Let's Encrypt (Free)

```bash
# Install certbot
sudo apt install certbot

# Get certificate
sudo certbot certonly --standalone -d yourdomain.com

# Copy to prod/nginx/ssl/
sudo cp /etc/letsencrypt/live/yourdomain.com/fullchain.pem prod/nginx/ssl/cert.pem
sudo cp /etc/letsencrypt/live/yourdomain.com/privkey.pem prod/nginx/ssl/key.pem
```

### Option 2: Your CA

1. Get certificates from your Certificate Authority
2. Place in `prod/nginx/ssl/`:
   - `cert.pem` - Certificate
   - `key.pem` - Private key
3. Restart containers

## 📋 Summary

✅ **HTTP redirects to HTTPS**
✅ **Frontend accessible via HTTPS**
✅ **Backend API accessible via HTTPS** (proxied)
✅ **Version Control accessible via HTTPS** (proxied)
✅ **All frontend API calls use relative paths** (work over HTTPS)
✅ **Security headers configured**
✅ **Self-signed certificates for development**

## 🎯 Access

**Everything is now accessible via HTTPS:**
- https://localhost (Frontend)
- https://localhost/api/ (Backend)
- https://localhost/version-control/ (Version Control)

**HTTP automatically redirects to HTTPS!**

