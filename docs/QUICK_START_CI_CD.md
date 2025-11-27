# 🚀 Quick Start: CI/CD with Separate Repositories

## ✅ What's Set Up

You have **two separate repositories**, each with CI/CD:

1. **tutor-ontrol-dev** - Development repository
2. **tutor-ontrol-prod** - Production repository

## 🔄 How It Works

### Automatic Flow (When you push to dev):

```
You push to tutor-ontrol-dev/main
    ↓
GitHub Actions triggers automatically
    ↓
Dev CI/CD runs:
  - Builds Docker images
  - Runs tests
  - Validates code
    ↓
Auto-Sync to Prod:
  - Copies files to prod repo
  - Commits to prod/main
  - Triggers prod CI/CD
    ↓
Jenkins (if configured):
  - Builds images
  - Deploys to dev server
  - Health checks
```

### Production Flow (When you push to prod):

```
You push to tutor-ontrol-prod/main
    ↓
GitHub Actions triggers automatically
    ↓
Prod CI/CD runs:
  - Builds production images
  - Runs tests
  - Validates code
    ↓
Jenkins (if configured):
  - Builds images
  - Deploys to production
  - Health checks
```

## 📋 Setup Instructions

### GitHub Actions (Automatic - Already Working!)

**Nothing to do!** GitHub Actions will automatically:
- ✅ Run on every push to `main` in both repos
- ✅ Build and test your code
- ✅ Validate Docker images

**To view:**
1. Go to your GitHub repository
2. Click "Actions" tab
3. See workflows running automatically

**Repositories:**
- Dev: `https://github.com/YOUR_USERNAME/tutor-ontrol-dev/actions`
- Prod: `https://github.com/YOUR_USERNAME/tutor-ontrol-prod/actions`

### Jenkins (Optional - Requires Jenkins Server)

**If you have Jenkins:**

1. **Create Pipeline Jobs:**

   **Dev Job:**
   - Job name: "Dev CI/CD"
   - Type: Pipeline
   - Script Path: `tutor-ontrol-dev/Jenkinsfile`
   - Trigger: On push to `main` branch
   
   **Prod Job:**
   - Job name: "Production Deployment"
   - Type: Pipeline
   - Script Path: `tutor-ontrol-prod/Jenkinsfile`
   - Trigger: Manual (recommended for production)

2. **Configure Webhooks** (optional):
   - In GitHub repo → Settings → Webhooks
   - Add Jenkins webhook URL

## 🧪 Testing the Setup

### Test Dev Repository:

```bash
# Make a small change
cd tutor-ontrol-dev
echo "# Test CI/CD" >> README.md
git add README.md
git commit -m "Test CI/CD pipeline"
git push origin main

# Check GitHub Actions tab - should see workflow running!
```

### Test Prod Repository:

```bash
# Make a small change
cd tutor-ontrol-prod
echo "# Test CI/CD" >> README.md
git add README.md
git commit -m "Test production pipeline"
git push origin main

# Check GitHub Actions tab - should see workflow running!
```

## 📊 What Happens on Push

### Dev Repository (`tutor-ontrol-dev`):

**GitHub Actions (Automatic):**
- ✅ Builds backend Docker image
- ✅ Builds frontend Docker image
- ✅ Runs backend tests
- ✅ Verifies images

**Jenkins (if configured):**
- ✅ Builds images
- ✅ Runs tests
- ✅ Deploys to dev server
- ✅ Health checks
- ✅ Dev live at `http://localhost`

### Prod Repository (`tutor-ontrol-prod`):

**GitHub Actions (Automatic):**
- ✅ Builds production backend image
- ✅ Builds production frontend image
- ✅ Runs production tests
- ✅ Verifies images

**Jenkins (if configured):**
- ✅ Builds production images
- ✅ Runs tests
- ✅ Deploys to production server
- ✅ Health checks
- ✅ Production live at `http://localhost`

## 🔄 Daily Workflow

### Development:

```bash
# 1. Work in dev repository
cd tutor-ontrol-dev

# 2. Make changes
# Edit files in backend/ or nginx/

# 3. Test locally
docker-compose up -d
# Test at http://localhost

# 4. Commit and push
git add .
git commit -m "New feature"
git push origin main

# 5. GitHub Actions validates automatically
# 6. Jenkins deploys automatically (if configured)
```

### Production:

```bash
# 1. Copy tested code to prod
cd tutor-ontrol-prod

# Copy files from dev
cp -r ../tutor-ontrol-dev/backend/* ./backend/
cp -r ../tutor-ontrol-dev/nginx/* ./nginx/

# 2. Review changes
git diff

# 3. Commit and push
git add .
git commit -m "Deploy: Release v1.0.0"
git push origin main

# 4. GitHub Actions validates automatically
# 5. Deploy manually or use Jenkins
docker-compose up -d
```

## ✅ Summary

**You have:**
- ✅ Two separate repositories
- ✅ Independent CI/CD for each
- ✅ GitHub Actions (automatic validation)
- ✅ **Auto-merge from dev to prod**
- ✅ Jenkins support (actual deployment)
- ✅ Full control over deployment timing

**Workflow:**
1. Develop in `tutor-ontrol-dev`
2. Push to dev → **Auto-syncs to prod**
3. Test in dev environment
4. Deploy to production when ready

**Automatic syncing** - dev changes automatically merge into prod!
