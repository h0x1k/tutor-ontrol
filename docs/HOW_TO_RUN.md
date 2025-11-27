# 🚀 How to Run the Application

Quick guide on how to run the development and production environments.

## 📋 Prerequisites

- Docker installed
- Docker Compose installed
- Git (if cloning from repository)

## 🔵 Development Environment

### Step 1: Navigate to Dev Folder

```bash
cd tutor-ontrol-dev
```

### Step 2: Start Services

```bash
docker-compose up -d
```

This will:
- Build Docker images (first time only)
- Start backend container
- Start frontend container
- Start version control container

### Step 3: Check Status

```bash
docker-compose ps
```

You should see:
```
NAME                      STATUS
tutor-backend-dev         Up
tutor-frontend-dev        Up
tutor-versioncontrol-dev  Up
```

### Step 4: Access the Application

- **Frontend:** http://localhost
- **Backend API:** http://localhost:8000/api/
- **Version Control:** http://localhost:8001/health

### View Logs

```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f backend
docker-compose logs -f frontend
docker-compose logs -f versioncontrol
```

### Stop Services

```bash
docker-compose down
```

### Stop and Remove Volumes

```bash
docker-compose down -v
```

---

## 🟢 Production Environment

### Step 1: Navigate to Prod Folder

```bash
cd tutor-ontrol-prod
```

### Step 2: Start Services

```bash
docker-compose up -d
```

This will:
- Build Docker images (first time only)
- Start backend container
- Start nginx container (frontend + reverse proxy)

### Step 3: Check Status

```bash
docker-compose ps
```

You should see:
```
NAME                  STATUS
tutor-backend-prod    Up
tutor-nginx-prod      Up
```

### Step 4: Access the Application

- **Frontend:** http://localhost
- **Backend API:** http://localhost/api/
- **Version Control:** http://localhost/version-control/health

### View Logs

```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f backend
docker-compose logs -f nginx
```

### Stop Services

```bash
docker-compose down
```

---

## 🔄 Quick Commands

### Development

```bash
# Start
cd tutor-ontrol-dev && docker-compose up -d

# Stop
docker-compose down

# Restart
docker-compose restart

# Rebuild (after code changes)
docker-compose up -d --build

# View logs
docker-compose logs -f
```

### Production

```bash
# Start
cd tutor-ontrol-prod && docker-compose up -d

# Stop
docker-compose down

# Restart
docker-compose restart

# Rebuild (after code changes)
docker-compose up -d --build

# View logs
docker-compose logs -f
```

---

## 🐛 Troubleshooting

### Port Already in Use

**Error:** `port is already allocated`

**Solution:**
```bash
# Check what's using the port
lsof -i :80
lsof -i :8000

# Stop conflicting containers
docker ps
docker stop <container-name>

# Or change port in docker-compose.yml
```

### Container Won't Start

**Check logs:**
```bash
docker-compose logs <service-name>
```

**Rebuild:**
```bash
docker-compose up -d --build --force-recreate
```

### Database Issues

**Reset database:**
```bash
# Dev
cd tutor-ontrol-dev
docker-compose down -v
docker-compose up -d

# Prod
cd tutor-ontrol-prod
docker-compose down -v
docker-compose up -d
```

### Images Not Building

**Clean and rebuild:**
```bash
docker-compose down
docker system prune -a
docker-compose up -d --build
```

---

## 📊 Health Checks

### Development

```bash
# Frontend
curl http://localhost/

# Backend
curl http://localhost:8000/api/

# Version Control
curl http://localhost:8001/health
```

### Production

```bash
# Frontend
curl http://localhost/

# Backend
curl http://localhost/api/

# Version Control
curl http://localhost/version-control/health
```

---

## 🔧 First Time Setup

### 1. Clone Repositories

```bash
# Dev
git clone https://github.com/YOUR_USERNAME/tutor-ontrol-dev.git
cd tutor-ontrol-dev

# Prod
git clone https://github.com/YOUR_USERNAME/tutor-ontrol-prod.git
cd tutor-ontrol-prod
```

### 2. Build and Start

```bash
# Dev
docker-compose up -d --build

# Prod
docker-compose up -d --build
```

### 3. Verify

```bash
# Check containers
docker-compose ps

# Check logs
docker-compose logs

# Test endpoints
curl http://localhost/
```

---

## 📝 Common Workflows

### Daily Development

```bash
# 1. Start dev environment
cd tutor-ontrol-dev
docker-compose up -d

# 2. Make code changes
# Edit files in backend/ or nginx/frontend/

# 3. Rebuild if needed
docker-compose up -d --build

# 4. Test
# Visit http://localhost

# 5. Stop when done
docker-compose down
```

### Testing Production Locally

```bash
# 1. Start prod environment
cd tutor-ontrol-prod
docker-compose up -d

# 2. Test production build
# Visit http://localhost

# 3. Stop when done
docker-compose down
```

### Running Both (Different Ports)

**Note:** Both can't use port 80 on the same machine. Options:

1. **Use different ports:**
   - Dev: Keep on port 80
   - Prod: Change to port 8080 in `prod/docker-compose.yml`

2. **Run on different machines:**
   - Dev on one machine
   - Prod on another

3. **Stop one before starting the other:**
   ```bash
   # Stop dev
   cd tutor-ontrol-dev && docker-compose down
   
   # Start prod
   cd tutor-ontrol-prod && docker-compose up -d
   ```

---

## ✅ Quick Start Checklist

- [ ] Docker installed
- [ ] Docker Compose installed
- [ ] Navigate to dev or prod folder
- [ ] Run `docker-compose up -d`
- [ ] Check `docker-compose ps`
- [ ] Visit http://localhost
- [ ] Check logs if issues: `docker-compose logs -f`

---

## 🎯 Summary

**Dev Environment:**
```bash
cd tutor-ontrol-dev
docker-compose up -d
# Access: http://localhost
```

**Prod Environment:**
```bash
cd tutor-ontrol-prod
docker-compose up -d
# Access: http://localhost
```

**Both use port 80** - only run one at a time on the same machine!

