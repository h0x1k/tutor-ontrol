# Tutor Control - Multi-Container CI/CD Lab

This project demonstrates a complete containerized multi-service application with CI/CD pipeline using Jenkins and Docker Registry.

## 📁 Project Structure

```
tutor-ontrol/
├── dev/                    # Development environment (SELF-CONTAINED)
│   ├── backend/            # Django backend
│   ├── frontend/           # Vue.js frontend
│   ├── nginx/              # Nginx configuration
│   ├── version_control/    # Version control service
│   ├── tutor/              # Django app module
│   ├── docker-compose.yml  # Dev services
│   ├── Dockerfile.backend  # Backend container
│   ├── Dockerfile.nginx    # Frontend container
│   ├── Jenkinsfile         # Dev CI/CD pipeline
│   └── README.md           # Dev documentation
│
├── prod/                   # Production environment (SELF-CONTAINED)
│   ├── backend/            # Django backend (auto-synced from dev)
│   ├── frontend/           # Vue.js frontend (auto-synced from dev)
│   ├── nginx/              # Nginx configuration (auto-synced from dev)
│   ├── version_control/    # Version control service
│   ├── tutor/              # Django app module
│   ├── docker-compose.yml  # Prod services
│   ├── Dockerfile.backend  # Backend container
│   ├── Dockerfile.nginx    # Frontend container
│   ├── Jenkinsfile         # Prod CI/CD pipeline
│   └── README.md           # Prod documentation
│
├── docs/                   # Documentation
├── .github/workflows/      # GitHub Actions
│   └── sync-dev-to-prod.yml # Auto-sync workflow
└── README.md               # This file
```

## 🔄 Dev to Prod Auto-Sync

**Automatic synchronization:** When you push changes to `dev/` folder, GitHub Actions automatically syncs them to `prod/`.

### How It Works

1. **Make changes in `dev/`** folder
2. **Commit and push** to repository
3. **GitHub Actions** detects changes in `dev/`
4. **Automatically copies** files from `dev/` to `prod/`
5. **Commits and pushes** the synced changes

## 🚀 Quick Start

### Development Environment (Self-Contained)

```bash
cd dev
docker-compose up -d --build
```

Access at: http://localhost

**Note:** The `dev/` folder is completely self-contained. You can run it independently.

### Production Environment (Self-Contained)

```bash
cd prod
docker-compose up -d --build
```

Access at: http://localhost

**Note:** The `prod/` folder is completely self-contained. You can run it independently.

## ✅ Self-Contained Folders

Both `dev/` and `prod/` folders are **completely independent**:

- ✅ All code files included
- ✅ All Dockerfiles included
- ✅ All configuration files included
- ✅ Can run independently with `docker-compose up`
- ✅ No need to reference parent directories
- ✅ Each folder has its own README.md

## 🐳 Docker Services

### Dev Environment
- **Backend:** `localhost:5000/backend-dev:latest`
- **Nginx:** `localhost:5000/nginx-dev:latest`
- **Version Control:** `localhost:5000/versioncontrol-dev:latest`
- **Registry:** Port `5000`
- **Network:** `dev-network`

### Prod Environment
- **Backend:** `localhost:5000/backend-prod:latest`
- **Nginx:** `localhost:5000/nginx-prod:latest`
- **Version Control:** `localhost:5000/versioncontrol-prod:latest`
- **Registry:** Port `5000`
- **Network:** `prod-network`

## 🔄 CI/CD Pipeline

### Dev Pipeline (`dev/Jenkinsfile`)
- Builds dev images
- Runs tests
- Deploys to dev environment
- Tags images as `backend-dev`, `nginx-dev`, etc.

### Prod Pipeline (`prod/Jenkinsfile`)
- Builds prod images
- Runs tests
- Deploys to prod environment
- Tags images as `backend-prod`, `nginx-prod`, etc.

## 📚 Documentation

- **Dev:** See `dev/README.md`
- **Prod:** See `prod/README.md`
- **Setup Guide:** See `docs/DEV_PROD_SETUP.md`
- **All Docs:** See `docs/` folder

## ✅ Lab Requirements

- ✅ Multi-container application (dev and prod)
- ✅ Self-contained dev and prod folders
- ✅ Docker Registry for versioning
- ✅ Jenkins CI/CD pipeline (separate for dev/prod)
- ✅ Image versioning (build-XX)
- ✅ Containerized testing
- ✅ Automatic deployment
- ✅ Auto-sync from dev to prod

## 🎯 Workflow

1. **Develop** in `dev/` folder (self-contained)
2. **Test** in dev environment
3. **Push** to repository
4. **Auto-sync** to `prod/` via GitHub Actions
5. **Deploy** prod when ready (self-contained)

---

**Lab Complete!** 🎉
