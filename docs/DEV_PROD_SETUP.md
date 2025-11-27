# Dev/Prod Folder Structure - Setup Guide

## 📁 Structure Overview

The repository is now organized into separate `dev/` and `prod/` folders with automatic synchronization.

```
tutor-ontrol/
├── dev/                    # Development environment
│   ├── backend/            # Django backend
│   ├── frontend/           # Vue.js frontend
│   ├── nginx/              # Nginx configuration
│   ├── docker-compose.yml  # Dev services
│   ├── Dockerfile.backend  # Backend container
│   ├── Dockerfile.nginx    # Frontend container
│   └── Jenkinsfile        # Dev CI/CD pipeline
│
├── prod/                   # Production environment
│   ├── backend/            # Django backend (auto-synced from dev)
│   ├── frontend/           # Vue.js frontend (auto-synced from dev)
│   ├── nginx/              # Nginx configuration (auto-synced from dev)
│   ├── docker-compose.yml  # Prod services
│   ├── Dockerfile.backend  # Backend container
│   ├── Dockerfile.nginx    # Frontend container
│   └── Jenkinsfile        # Prod CI/CD pipeline
│
├── version_control/        # Version control service (shared)
├── tutor/                  # Django app module (shared)
└── .github/workflows/      # GitHub Actions
    └── sync-dev-to-prod.yml # Auto-sync workflow
```

## 🔄 Auto-Sync Workflow

### How It Works

1. **Developer makes changes** in `dev/` folder
2. **Commits and pushes** to repository
3. **GitHub Actions** detects changes in `dev/`
4. **Automatically copies** files from `dev/` to `prod/`
5. **Commits and pushes** the synced changes

### Trigger Conditions

The sync workflow triggers when:
- Push to `main` branch
- Changes in `dev/**` paths
- Changes in `version_control/**` paths
- Changes in `tutor/**` paths
- Manual trigger via `workflow_dispatch`

### What Gets Synced

- ✅ `dev/backend/` → `prod/backend/`
- ✅ `dev/frontend/` → `prod/frontend/`
- ✅ `dev/nginx/` → `prod/nginx/`
- ✅ `dev/Dockerfile.backend` → `prod/Dockerfile.backend`
- ✅ `dev/Dockerfile.nginx` → `prod/Dockerfile.nginx`
- ❌ `dev/Jenkinsfile` → NOT synced (keeps prod-specific config)

## 🚀 Usage

### Development Workflow

1. **Work in dev folder:**
   ```bash
   cd dev
   # Make changes to backend/, frontend/, nginx/
   ```

2. **Test in dev environment:**
   ```bash
   cd dev
   docker-compose up -d --build
   # Test at http://localhost
   ```

3. **Commit and push:**
   ```bash
   git add dev/
   git commit -m "Update dev environment"
   git push origin main
   ```

4. **Auto-sync happens:**
   - GitHub Actions runs automatically
   - Files copied to `prod/`
   - Changes committed automatically

### Production Deployment

1. **After sync, deploy prod:**
   ```bash
   cd prod
   docker-compose up -d --build
   ```

2. **Or use Jenkins:**
   - Run prod pipeline
   - Automatically builds and deploys

## 🐳 Running Both Environments

### Option 1: Different Ports

Modify `prod/docker-compose.yml` to use different ports:

```yaml
services:
  nginx:
    ports:
      - "8080:80"  # Prod on 8080
  backend:
    ports:
      - "8001:8000"  # Prod backend on 8001
```

### Option 2: Different Machines

- Run dev on development machine
- Run prod on production server

### Option 3: One at a Time

```bash
# Start dev
cd dev && docker-compose up -d

# Stop dev, start prod
cd dev && docker-compose down
cd prod && docker-compose up -d
```

## 🔧 Manual Sync (if needed)

If auto-sync doesn't work:

```bash
# Copy backend
rm -rf prod/backend
cp -r dev/backend prod/backend

# Copy frontend
rm -rf prod/frontend
cp -r dev/frontend prod/frontend

# Copy nginx
rm -rf prod/nginx
cp -r dev/nginx prod/nginx

# Copy Dockerfiles
cp dev/Dockerfile.* prod/

# Commit changes
git add prod/
git commit -m "Manual sync from dev"
git push
```

## 📝 Differences Between Dev and Prod

### Environment Variables

**Dev (`dev/docker-compose.yml`):**
```yaml
environment:
  - DEBUG=True
  - DB_PATH=/app/data/dev_db.sqlite3
```

**Prod (`prod/docker-compose.yml`):**
```yaml
environment:
  - DEBUG=False
  - DB_PATH=/app/data/prod_db.sqlite3
```

### Container Names

**Dev:**
- `tutor-backend-dev`
- `tutor-nginx-dev`
- `tutor-versioncontrol-dev`
- `docker-registry-dev`

**Prod:**
- `tutor-backend-prod`
- `tutor-nginx-prod`
- `tutor-versioncontrol-prod`
- `docker-registry-prod`

### Image Tags

**Dev:**
- `localhost:5000/backend-dev:latest`
- `localhost:5000/nginx-dev:latest`
- `localhost:5000/versioncontrol-dev:latest`

**Prod:**
- `localhost:5000/backend-prod:latest`
- `localhost:5000/nginx-prod:latest`
- `localhost:5000/versioncontrol-prod:latest`

### Networks and Volumes

**Dev:**
- Network: `dev-network`
- Volumes: `db_data_dev`, `static_volume_dev`, `registry_data_dev`

**Prod:**
- Network: `prod-network`
- Volumes: `db_data_prod`, `static_volume_prod`, `registry_data_prod`

## 🔍 Verifying Auto-Sync

### Check GitHub Actions

1. Go to your repository on GitHub
2. Click **"Actions"** tab
3. Look for **"Sync Dev to Prod"** workflow
4. Check if it ran after your push

### Check Sync Status

```bash
# Check if prod was updated
git log --oneline -10

# Should see commits like:
# "🔄 Auto-sync from dev to prod (Build X)"
```

### Manual Verification

```bash
# Compare dev and prod
diff -r dev/backend prod/backend
diff -r dev/frontend prod/frontend
```

## 🐛 Troubleshooting

### Issue: Auto-sync not working

1. **Check GitHub Actions:**
   - Go to repository → Actions
   - Check if workflow ran
   - Check for errors

2. **Check workflow file:**
   - Verify `.github/workflows/sync-dev-to-prod.yml` exists
   - Check trigger conditions

3. **Check permissions:**
   - Ensure `GITHUB_TOKEN` has write access
   - Check repository settings

### Issue: Conflicts during sync

If there are conflicts:
1. Manually resolve in `prod/`
2. Commit the resolution
3. Next sync will overwrite with dev

### Issue: Prod not updating

1. **Check if changes were actually made in dev:**
   ```bash
   git diff dev/
   ```

2. **Check if workflow triggered:**
   - Look at GitHub Actions logs
   - Verify paths match trigger conditions

3. **Manually trigger:**
   - Go to Actions → Sync Dev to Prod
   - Click "Run workflow"

## ✅ Best Practices

1. **Always work in dev first**
   - Make changes in `dev/`
   - Test in dev environment
   - Then push to trigger sync

2. **Review prod changes**
   - Check what was synced
   - Verify prod-specific configs weren't overwritten

3. **Use separate databases**
   - Dev and prod have separate SQLite databases
   - No data conflicts

4. **Keep prod Jenkinsfile separate**
   - Prod Jenkinsfile is NOT synced
   - Maintain prod-specific pipeline configs

## 🎯 Summary

- ✅ Separate `dev/` and `prod/` folders
- ✅ Automatic sync from dev to prod via GitHub Actions
- ✅ Separate Docker networks and volumes
- ✅ Separate container names and image tags
- ✅ Separate Jenkins pipelines
- ✅ Same codebase, different configurations

---

**Setup Complete!** 🎉

