# Tutor Control - Multi-Container CI/CD Lab

This project demonstrates a complete containerized multi-service application with CI/CD pipeline using Jenkins and Docker Registry.

## 🚀 Quick Start

### Start All Services

```bash
docker-compose up -d --build
```

### Access the Application

- **Frontend:** http://localhost
- **Backend API:** http://localhost/api/
- **Version Control:** http://localhost/version-control/
- **Docker Registry:** http://localhost:5000/v2/

## 📁 Project Structure

```
tutor-ontrol/
├── backend/                 # Django backend application
├── frontend/               # Vue.js frontend application
├── nginx/                  # Nginx configuration
├── version_control/         # Version control service (FastAPI)
├── tutor/                  # Django app module
├── docs/                   # Documentation files
├── Dockerfile.backend       # Backend container build
├── Dockerfile.nginx        # Nginx container build
├── docker-compose.yml      # Multi-container orchestration
├── Jenkinsfile             # CI/CD pipeline configuration
└── README.md               # This file
```

## 📚 Documentation

All documentation is available in the [`docs/`](./docs/) folder:

- **[LAB_SETUP.md](./docs/LAB_SETUP.md)** - Lab setup and requirements
- **[HOW_TO_RUN.md](./docs/HOW_TO_RUN.md)** - Detailed run instructions
- **[HOW_CI_CD_WORKS.md](./docs/HOW_CI_CD_WORKS.md)** - CI/CD pipeline explanation
- **[CI_CD_README.md](./docs/CI_CD_README.md)** - CI/CD documentation
- **[TROUBLESHOOTING.md](./docs/TROUBLESHOOTING.md)** - Common issues and solutions

## 🔄 CI/CD Pipeline (Jenkins)

The Jenkins pipeline automatically:
1. Checks out code from repository
2. Builds Docker images with version tags (build-XX)
3. Runs containerized tests
4. Pushes images to local registry
5. Deploys the application
6. Merges fix branch to main (if applicable)

See [Jenkinsfile](./Jenkinsfile) for pipeline configuration.

## 🐳 Docker Services

- **Backend** - Django application (port 8000)
- **Nginx** - Frontend + Reverse Proxy (port 80)
- **Registry** - Docker Registry for image versioning (port 5000)
- **Version Control** - FastAPI service (port 8001)

## 📦 Image Versioning

Images are automatically tagged with:
- `build-{BUILD_NUMBER}` - Specific build version
- `latest` - Most recent build

All images stored in local Docker Registry at `localhost:5000`.

## ✅ Lab Requirements

- ✅ Multi-container application
- ✅ Docker Registry for versioning
- ✅ Jenkins CI/CD pipeline
- ✅ Image versioning (build-XX)
- ✅ Containerized testing
- ✅ Automatic deployment
- ✅ Branch merging automation

## 📖 More Information

For detailed documentation, see the [docs/](./docs/) folder.

---

**Lab Complete!** 🎉
