# 🚀 Quick Start: CI/CD Setup

## ✅ What's Been Set Up

### 1. **Jenkins Pipelines**
- ✅ `dev/Jenkinsfile` - Dev environment CI/CD
- ✅ `prod/Jenkinsfile` - Production deployment pipeline

### 2. **GitHub Actions**
- ✅ `.github/workflows/dev-ci.yml` - Dev CI/CD workflow
- ✅ `.github/workflows/prod-deploy.yml` - Production deployment workflow

## 🔄 How It Works

### Automatic Flow (When you push to `dev`):

```
You push to dev branch
    ↓
GitHub Actions triggers automatically
    ↓
Dev CI/CD runs:
  - Builds Docker images
  - Runs tests
  - Deploys to dev
    ↓
Production Deployment triggers:
  - Syncs dev → prod
  - Builds prod images
  - Deploys to production
  - Updates main branch
```

## 📋 Setup Instructions

### GitHub Actions (Automatic - Already Working!)

**Nothing to do!** GitHub Actions will automatically:
- ✅ Run on every push to `dev`
- ✅ Build and test your code
- ✅ Deploy to production when dev changes

**To view:**
1. Go to your GitHub repository
2. Click "Actions" tab
3. See workflows running automatically

### Jenkins (Optional - Requires Jenkins Server)

**If you have Jenkins:**

1. **Install Jenkins** (if not already installed)
2. **Create Pipeline Jobs:**
   - Job 1: "Dev CI/CD"
     - Type: Pipeline
     - Script Path: `dev/Jenkinsfile`
     - Trigger: On push to `dev` branch
   
   - Job 2: "Production Deployment"
     - Type: Pipeline
     - Script Path: `prod/Jenkinsfile`
     - Trigger: Manual or scheduled

3. **Configure Webhook** (optional):
   - In GitHub repo → Settings → Webhooks
   - Add Jenkins webhook URL

## 🧪 Testing the Setup

### Test GitHub Actions:
```bash
# Make a small change
echo "# Test CI/CD" >> README.md
git add README.md
git commit -m "Test CI/CD pipeline"
git push origin dev

# Check GitHub Actions tab - should see workflow running!
```

### Test Jenkins (if configured):
```bash
# Push to dev
git push origin dev

# Check Jenkins dashboard - should see build triggered
```

## 📊 What Happens on Push to Dev

### GitHub Actions (Automatic):
1. ✅ **Dev CI/CD** workflow runs:
   - Builds frontend, backend, versioncontrol
   - Runs tests
   - Deploys to dev environment

2. ✅ **Production Deployment** workflow runs:
   - Syncs files: `dev/` → `prod/`
   - Builds production images
   - Deploys to production
   - Updates `main` branch

### Jenkins (If configured):
1. ✅ **Dev Pipeline** runs:
   - Same as GitHub Actions dev workflow
   - Deploys to dev environment

2. ✅ **Prod Pipeline** (can be triggered):
   - Syncs dev to prod
   - Deploys to production

## 🎯 Key Features

- ✅ **Automatic** - No manual steps needed
- ✅ **Dual CI/CD** - Both Jenkins and GitHub Actions
- ✅ **Testing** - Automatic test runs
- ✅ **Health Checks** - Automatic health verification
- ✅ **Production Sync** - Automatic dev → prod sync

## 📝 Next Steps

1. **Push to dev** - Everything happens automatically!
2. **Monitor** - Check GitHub Actions or Jenkins
3. **Verify** - Check deployed environments

## 🔍 Monitoring

### GitHub Actions:
- Repository → Actions tab
- See all workflow runs
- View logs for each step

### Jenkins:
- Jenkins dashboard
- View build history
- Check console output

## ❓ FAQ

**Q: Do I need both Jenkins and GitHub Actions?**  
A: No! GitHub Actions works automatically. Jenkins is optional.

**Q: How do I trigger production deployment?**  
A: Just push to `dev` - it happens automatically!

**Q: Can I deploy manually?**  
A: Yes! In GitHub Actions, use "Run workflow" button.

**Q: What if something fails?**  
A: Check the logs in GitHub Actions or Jenkins. Fix the issue and push again.

