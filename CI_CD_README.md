# CI/CD Pipeline Documentation - Separate Repositories

This project uses **separate repositories** for development and production, each with its own CI/CD automation.

## 🏗️ Repository Structure

```
web/
├── tutor-ontrol-dev/          ← Development Repository
│   ├── backend/
│   ├── nginx/
│   ├── docker-compose.yml
│   ├── Jenkinsfile
│   └── .github/workflows/
│
└── tutor-ontrol-prod/          ← Production Repository
    ├── backend/
    ├── nginx/
    ├── docker-compose.yml
    ├── Jenkinsfile
    └── .github/workflows/
```

## 🚀 Workflow Overview

### Development Flow

1. **Developer** works in `tutor-ontrol-dev` repository
2. **Push to main** triggers:
   - GitHub Actions workflow (automatic)
   - Jenkins pipeline (if configured)
3. **Dev environment** is automatically built, tested, and deployed
4. **Tests** are run automatically

### Production Flow

1. **Copy tested code** from dev to `tutor-ontrol-prod` repository
2. **Push to main** triggers:
   - GitHub Actions workflow (automatic)
   - Jenkins pipeline (manual trigger recommended)
3. **Production environment** is built, tested, and deployed
4. **Health checks** verify deployment

## 📋 GitHub Actions Setup

### Dev Repository Workflow

**File:** `tutor-ontrol-dev/.github/workflows/ci-cd.yml`

**Triggers:**
- Push to `main` branch
- Pull requests to `main` branch

**What it does:**
- Builds backend Docker image
- Builds frontend Docker image
- Runs backend tests
- Verifies Docker images

**Note:** This validates code but does NOT deploy automatically.

### Prod Repository Workflow

**File:** `tutor-ontrol-prod/.github/workflows/deploy.yml`

**Triggers:**
- Push to `main` branch
- Manual trigger via GitHub UI

**What it does:**
- Builds production backend Docker image
- Builds production frontend Docker image
- Runs production tests
- Verifies Docker images

**Note:** This validates code but does NOT deploy automatically.

## 🔧 Jenkins Setup

### Prerequisites
- Jenkins server running
- Docker installed on Jenkins agent
- Jenkins credentials configured (if using Docker registry)

### Dev Repository Pipeline

**File:** `tutor-ontrol-dev/Jenkinsfile`

**Triggers:**
- Push to `main` branch (if webhook configured)
- Manual trigger

**Stages:**
1. Checkout code from `tutor-ontrol-dev` repo
2. Build Frontend Docker image
3. Build Backend Docker image
4. Run tests
5. Deploy to dev environment
6. Health checks

**To use:**
```bash
# In Jenkins, create a new pipeline job
# Point it to: tutor-ontrol-dev/Jenkinsfile
# Configure to trigger on push to main branch
```

### Prod Repository Pipeline

**File:** `tutor-ontrol-prod/Jenkinsfile`

**Triggers:**
- Manual trigger (recommended for production)
- Scheduled (if configured)

**Stages:**
1. Checkout code from `tutor-ontrol-prod` repo
2. Build Frontend Docker image
3. Build Backend Docker image
4. Run tests
5. Deploy to production environment
6. Production health checks

**To use:**
```bash
# In Jenkins, create a new pipeline job
# Point it to: tutor-ontrol-prod/Jenkinsfile
# Set to manual trigger for safety
```

## 📝 How to Use

### Development Workflow

1. **Work in dev repository:**
   ```bash
   cd tutor-ontrol-dev
   # Make changes to backend/ or nginx/
   ```

2. **Test locally:**
   ```bash
   docker-compose up -d
   # Test at http://localhost
   ```

3. **Commit and push:**
   ```bash
   git add .
   git commit -m "Your changes"
   git push origin main
   ```

4. **Automatic triggers:**
   - GitHub Actions will run automatically
   - Jenkins will deploy if configured

### Production Deployment

1. **Copy tested code to prod:**
   ```bash
   cd tutor-ontrol-prod
   # Copy files from dev (or use your preferred method)
   cp -r ../tutor-ontrol-dev/backend/* ./backend/
   cp -r ../tutor-ontrol-dev/nginx/* ./nginx/
   ```

2. **Review and commit:**
   ```bash
   git add .
   git commit -m "Deploy: Release v1.0.0"
   git push origin main
   ```

3. **Deploy:**
   - **Via Jenkins:** Click "Build Now" in Jenkins dashboard
   - **Manual:** `docker-compose up -d` in prod folder

## 🧪 Testing

### Local Testing

**Dev Environment:**
```bash
cd tutor-ontrol-dev
docker-compose up -d
# Access at http://localhost
```

**Prod Environment:**
```bash
cd tutor-ontrol-prod
docker-compose up -d
# Access at http://localhost
```

### Health Checks

- **Dev Frontend:** `http://localhost/`
- **Dev Backend:** `http://localhost:8000/api/`
- **Prod Frontend:** `http://localhost/`
- **Prod Backend:** `http://localhost/api/`

## 🔍 Monitoring

### GitHub Actions
- **Dev Repo:** `https://github.com/YOUR_USERNAME/tutor-ontrol-dev/actions`
- **Prod Repo:** `https://github.com/YOUR_USERNAME/tutor-ontrol-prod/actions`
- View workflow runs and logs

### Jenkins
- Check Jenkins console output
- View build history
- Check build logs

## 🔄 Key Differences from Monorepo

| Feature | Monorepo | Separate Repos |
|---------|----------|----------------|
| **Structure** | `dev/` and `prod/` folders | Two separate folders |
| **Repositories** | 1 GitHub repo | 2 GitHub repos |
| **CI/CD** | Shared workflows | Separate workflows |
| **Syncing** | Auto-sync dev→prod | **Auto-merge dev→prod** |
| **Independence** | Shared codebase | Separate with auto-sync |

## ⚠️ Important Notes

1. **Automatic Syncing:**
   - Changes in dev automatically merge into prod
   - No manual copying needed
   - Full control over when to deploy to production
   - See `SETUP_AUTO_MERGE.md` for setup instructions

2. **Separate GitHub Repos:**
   - Each repository has its own GitHub Actions
   - Each repository can have its own Jenkins job
   - No conflicts between dev and prod

3. **Deployment:**
   - GitHub Actions validates but doesn't deploy
   - Jenkins actually deploys to servers
   - You can use both or just one

4. **Ports:**
   - Dev: `80` (frontend), `8000` (backend)
   - Prod: `80` (nginx), backend proxied through nginx

## 🐛 Troubleshooting

### GitHub Actions Issues
- Check workflow logs in Actions tab
- Verify repository secrets are set
- Ensure GitHub Actions is enabled for the repository

### Jenkins Issues
- Check Jenkins agent has Docker installed
- Verify Docker registry credentials
- Check Jenkins logs: `docker logs <jenkins-container>`

### Deployment Issues
- Check Docker containers: `docker ps`
- View container logs: `docker logs <container-name>`
- Check docker-compose: `docker-compose ps`

## 📚 Additional Resources

- [Jenkins Pipeline Documentation](https://www.jenkins.io/doc/book/pipeline/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
