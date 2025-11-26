# 🚀 Simple Setup: Two Separate Folders

## Overview

You have **two separate folders** - one for dev, one for prod. Each becomes its own repository.

## 📁 Structure

```
web/
├── tutor-ontrol-dev/      ← Copy 1: Dev repository
│   ├── backend/
│   ├── nginx/
│   ├── docker-compose.yml
│   └── ...
│
└── tutor-ontrol-prod/     ← Copy 2: Prod repository
    ├── backend/
    ├── nginx/
    ├── docker-compose.yml
    └── ...
```

## 🔧 Setup Steps

### Step 1: Copy Folder for Dev

```bash
cd /Users/h0x/Desktop/fl/ci_cd_docker_luba_25-11-25/web/

# Copy entire folder
cp -r tutor-ontrol tutor-ontrol-dev

cd tutor-ontrol-dev

# Remove prod folder (not needed in dev repo)
rm -rf prod

# Initialize as new git repo
git init
git add .
git commit -m "Initial commit: Dev environment"

# Create GitHub repo: tutor-ontrol-dev
# Then push:
git remote add origin https://github.com/YOUR_USERNAME/tutor-ontrol-dev.git
git branch -M main
git push -u origin main
```

### Step 2: Copy Folder for Prod

```bash
cd /Users/h0x/Desktop/fl/ci_cd_docker_luba_25-11-25/web/

# Copy entire folder
cp -r tutor-ontrol tutor-ontrol-prod

cd tutor-ontrol-prod

# Remove dev folder (not needed in prod repo)
rm -rf dev

# Initialize as new git repo
git init
git add .
git commit -m "Initial commit: Prod environment"

# Create GitHub repo: tutor-ontrol-prod
# Then push:
git remote add origin https://github.com/YOUR_USERNAME/tutor-ontrol-prod.git
git branch -M main
git push -u origin main
```

## ⚙️ What's Different

### Dev Repository (`tutor-ontrol-dev`):
- Port: `80` (frontend)
- Port: `8000` (backend)
- Port: `8001` (versioncontrol)
- DEBUG: `True`
- Container names: `-dev`
- Network: `dev-network`
- Volumes: `dev_db_data`

### Prod Repository (`tutor-ontrol-prod`):
- Port: `80` (nginx)
- DEBUG: `False`
- Container names: `-prod`
- Network: `prod-network`
- Volumes: `prod_db_data`, `prod_static_volume`

## 🎯 How to Use

### Dev Environment

```bash
cd tutor-ontrol-dev
docker-compose up -d

# Access at:
# - Frontend: http://localhost
# - Backend: http://localhost:8000
# - Version Control: http://localhost:8001
```

### Prod Environment

```bash
cd tutor-ontrol-prod
docker-compose up -d

# Access at:
# - Frontend: http://localhost
# - Backend: http://localhost/api
# - Version Control: http://localhost/version-control
```

## 📝 Workflow

### Development

1. **Work in dev folder:**
   ```bash
   cd tutor-ontrol-dev
   # Make changes
   git add .
   git commit -m "New feature"
   git push origin main
   ```

2. **Test in dev:**
   ```bash
   docker-compose up -d
   # Test at http://localhost
   ```

### Production

**Option 1: Auto-Merge (Recommended)**
- Changes automatically sync from dev to prod
- Just push to dev, prod updates automatically
- See `SETUP_AUTO_MERGE.md` for setup

**Option 2: Manual Copy**
1. **Copy tested code to prod:**
   ```bash
   cd tutor-ontrol-prod
   # Copy files from dev
   cp -r ../tutor-ontrol-dev/backend/* ./backend/
   cp -r ../tutor-ontrol-dev/nginx/* ./nginx/
   git add .
   git commit -m "Deploy to production"
   git push origin main
   ```

2. **Deploy to prod:**
   ```bash
   docker-compose up -d
   # Live at http://localhost
   ```

## 🔄 CI/CD

Each repository has its own CI/CD:

- **Dev Repo:** 
  - `.github/workflows/ci-cd.yml` (builds and tests)
  - `.github/workflows/sync-to-prod.yml` (auto-merges to prod)
  - `Jenkinsfile` (deploys)
- **Prod Repo:** 
  - `.github/workflows/deploy.yml` (builds and tests)
  - `Jenkinsfile` (deploys)

**Auto-Merge Feature:**
- Changes in dev automatically merge into prod
- See `SETUP_AUTO_MERGE.md` for setup instructions
- See `HOW_CI_CD_WORKS.md` for details

## ✅ Benefits

- ✅ **Simple**: Just copy the folder
- ✅ **Independent**: Each repo is separate
- ✅ **No conflicts**: Different ports, containers, networks
- ✅ **Easy to manage**: Clear separation
- ✅ **Different GitHub repos**: Independent version control
- ✅ **Separate CI/CD**: Each repo has its own pipelines

## 🎉 That's It!

You now have:
- `tutor-ontrol-dev` - Development repository
- `tutor-ontrol-prod` - Production repository
- Each with its own GitHub repo
- Each with its own Docker setup
- Each with its own CI/CD
- No conflicts between them
