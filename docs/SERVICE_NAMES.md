# 📋 Docker Compose Service Names

## 🔵 Development Environment (`tutor-ontrol-dev`)

**Service Names:**
- `backend` - Backend Django service
- `frontend` - Frontend Nginx service
- `versioncontrol` - Version control service

**Commands:**
```bash
cd tutor-ontrol-dev

# View logs
docker-compose logs frontend
docker-compose logs backend
docker-compose logs versioncontrol

# Restart services
docker-compose restart frontend
docker-compose restart backend
docker-compose restart versioncontrol

# Stop services
docker-compose stop frontend
docker-compose stop backend
```

## 🟢 Production Environment (`tutor-ontrol-prod`)

**Service Names:**
- `backend` - Backend Django service
- `nginx` - Frontend Nginx service (NOT "frontend"!)

**Commands:**
```bash
cd tutor-ontrol-prod

# View logs
docker-compose logs nginx      # ← Use "nginx" not "frontend"
docker-compose logs backend

# Restart services
docker-compose restart nginx   # ← Use "nginx" not "frontend"
docker-compose restart backend

# Stop services
docker-compose stop nginx      # ← Use "nginx" not "frontend"
```

## ⚠️ Common Error

**Error:** `no such service: frontend`

**Cause:** You're in the **prod** directory, but using the **dev** service name.

**Solution:**
- In **dev**: Use `frontend`
- In **prod**: Use `nginx`

## ✅ Quick Reference

| Environment | Frontend Service Name |
|-------------|---------------------|
| Dev         | `frontend`          |
| Prod        | `nginx`             |

## 🔍 Check Service Names

```bash
# List all services in current directory
docker-compose config --services
```

