# CI/CD Pipeline Documentation

This project uses **both Jenkins and GitHub Actions** for CI/CD automation.

## 🚀 Workflow Overview

### Development Flow
1. **Developer** makes changes in `dev` branch
2. **Push to dev** triggers:
   - Jenkins pipeline (if Jenkins is configured)
   - GitHub Actions workflow
3. **Dev environment** is automatically built and deployed
4. **Tests** are run automatically

### Production Flow
1. **When dev branch is updated**, production pipeline:
   - Syncs files from `dev/` to `prod/`
   - Runs production tests
   - Builds production Docker images
   - Deploys to production
   - Updates `main` branch with prod changes

## 📋 Jenkins Setup

### Prerequisites
- Jenkins server running
- Docker installed on Jenkins agent
- Jenkins credentials configured (if using Docker registry)

### Jenkins Pipelines

#### Dev Pipeline (`dev/Jenkinsfile`)
**Triggers:** Push to `dev` branch

**Stages:**
1. Checkout code
2. Build Frontend Docker image
3. Build Backend Docker image
4. Build Version Control Docker image
5. Run tests
6. Deploy to dev environment
7. Health checks

**To use:**
```bash
# In Jenkins, create a new pipeline job
# Point it to: dev/Jenkinsfile
# Configure to trigger on push to dev branch
```

#### Prod Pipeline (`prod/Jenkinsfile`)
**Triggers:** Manual or scheduled

**Stages:**
1. Checkout code
2. Sync dev to prod (copy files)
3. Run production tests
4. Build production images
5. Tag and push images
6. Deploy to production
7. Production health checks
8. Update main branch

**To use:**
```bash
# In Jenkins, create a new pipeline job
# Point it to: prod/Jenkinsfile
# Can be triggered manually or on schedule
```

## 🔄 GitHub Actions Setup

### Workflows

#### Dev CI/CD (`.github/workflows/dev-ci.yml`)
**Triggers:**
- Push to `dev` branch
- Pull requests to `dev` branch

**What it does:**
- Builds all Docker images
- Runs tests
- Deploys to dev environment (on push only)
- Runs health checks

#### Production Deployment (`.github/workflows/prod-deploy.yml`)
**Triggers:**
- Push to `dev` branch (when files in `dev/` or `version_control/` change)
- Manual trigger via GitHub UI

**What it does:**
- Syncs files from `dev/` to `prod/`
- Runs production tests
- Builds production images
- Deploys to production
- Updates `main` branch

## 🔧 Configuration

### Environment Variables

**Jenkins:**
- `DOCKER_REGISTRY` - Docker registry URL (default: `localhost:5000`)
- `BACKEND_IMAGE` - Backend image name
- `FRONTEND_IMAGE` - Frontend image name
- `VERSIONCONTROL_IMAGE` - Version control image name

**GitHub Actions:**
- Uses GitHub Actions environment by default
- Can be configured in repository settings → Secrets

### Docker Compose Files

- **Dev:** `dev/docker-compose.yml`
- **Prod:** `prod/docker-compose.yml`

## 📝 How to Use

### Automatic Deployment (Recommended)

1. **Make changes** in `dev` branch
2. **Commit and push:**
   ```bash
   git add .
   git commit -m "Your changes"
   git push origin dev
   ```
3. **Automatic triggers:**
   - GitHub Actions will run automatically
   - Jenkins will run if configured to watch the repo

### Manual Production Deployment

**Via GitHub:**
1. Go to Actions tab
2. Select "Production Deployment"
3. Click "Run workflow"

**Via Jenkins:**
1. Open Jenkins dashboard
2. Find "Production Deployment" job
3. Click "Build Now"

## 🧪 Testing

### Local Testing
```bash
# Test dev environment
cd dev
docker-compose up -d

# Test prod environment
cd prod
docker-compose up -d
```

### Health Checks
- Dev Frontend: `http://localhost:8080/`
- Dev Version Control: `http://localhost:8001/health`
- Prod: `http://localhost/version-control/health`

## 🔍 Monitoring

### Jenkins
- Check Jenkins console output
- View build history
- Check build logs

### GitHub Actions
- Go to repository → Actions tab
- View workflow runs
- Check logs for each step

## 🐛 Troubleshooting

### Jenkins Issues
- Check Jenkins agent has Docker installed
- Verify Docker registry credentials
- Check Jenkins logs: `docker logs <jenkins-container>`

### GitHub Actions Issues
- Check workflow logs in Actions tab
- Verify repository secrets are set
- Ensure GitHub Actions is enabled for the repository

### Deployment Issues
- Check Docker containers: `docker ps`
- View container logs: `docker logs <container-name>`
- Check docker-compose: `docker-compose ps`

## 📚 Additional Resources

- [Jenkins Pipeline Documentation](https://www.jenkins.io/doc/book/pipeline/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Compose Documentation](https://docs.docker.com/compose/)

