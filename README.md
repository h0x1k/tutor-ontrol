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

## 🐳 Docker Services

### Dev Environment
- **Backend:** `localhost:5001/backend-dev:latest`
- **Nginx:** `localhost:5001/nginx-dev:latest`
- **Version Control:** `localhost:5001/versioncontrol-dev:latest`
- **Registry:** Port `5001` (changed from 5000 to avoid macOS AirPlay conflict)
- **Network:** `dev-network`

### Prod Environment
- **Backend:** `localhost:5001/backend-prod:latest`
- **Nginx:** `localhost:5001/nginx-prod:latest`
- **Version Control:** `localhost:5001/versioncontrol-prod:latest`
- **Registry:** Port `5001`
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

## 🧪 Testing

### Test Jenkins Pipeline Components

```bash
./test-jenkins.sh
```

This will test:
- ✅ Docker Registry (port 5001)
- ✅ Docker builds
- ✅ Registry push/pull
- ✅ Application endpoints
- ⚠️ Jenkins installation

### Install Jenkins

**For macOS:**
```bash
# Option 1: Docker (Recommended)
docker run -d -p 8080:8080 -p 50000:50000 --name jenkins jenkins/jenkins:lts

# Option 2: Homebrew
brew install jenkins-lts
brew services start jenkins-lts
```

**For Linux:**
```bash
./INSTALL_JENKINS.sh
```

## 📚 Documentation

- **Dev:** See `dev/README.md`
- **Prod:** See `prod/README.md`
- **Setup Guide:** See `docs/DEV_PROD_SETUP.md`
- **Jenkins Setup:** See `docs/JENKINS_SETUP.md` (if exists)
- **All Docs:** See `docs/` folder

## ✅ Lab Requirements

- ✅ Multi-container application (dev and prod)
- ✅ Self-contained dev and prod folders
- ✅ Docker Registry for versioning (port 5001)
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
