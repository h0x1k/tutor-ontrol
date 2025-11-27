# 🔄 How CI/CD Works with Separate Repositories

## 📊 Overview

You have **TWO separate repositories**, each with its own CI/CD:

1. **tutor-ontrol-dev** - Development repository
2. **tutor-ontrol-prod** - Production repository

**Key Feature:** Changes in dev **automatically merge** into prod!

Each repository has its own:
- GitHub repository
- CI/CD pipelines
- Docker setup
- Deployment process

---

## 🏗️ Repository Structure

```
web/
├── tutor-ontrol-dev/          ← Dev Repository (GitHub)
│   ├── backend/
│   ├── nginx/
│   ├── docker-compose.yml
│   └── .github/workflows/
│       ├── ci-cd.yml
│       └── sync-to-prod.yml  ← Auto-syncs to prod!
│
└── tutor-ontrol-prod/          ← Prod Repository (GitHub)
    ├── backend/
    ├── nginx/
    ├── docker-compose.yml
    └── .github/workflows/
        └── deploy.yml
```

**Key Difference:**
- ❌ **No more** `dev/` and `prod/` subfolders
- ✅ **Each folder IS the environment** (dev or prod)
- ✅ **Each has its own GitHub repo**
- ✅ **Each has its own CI/CD**
- ✅ **Auto-merge from dev to prod**

---

## 🎯 The Flow (With Auto-Merge)

### Development Workflow

```
You work in tutor-ontrol-dev/
    ↓
Make changes to backend/ or nginx/
    ↓
git push origin main
    ↓
┌─────────────────────────────┐
│  GitHub Actions (Dev Repo)  │
└──────────┬──────────────────┘
           │
    ┌──────┴──────┐
    │             │
    ▼             ▼
┌────────┐   ┌──────────────┐
│ Build  │   │ Auto-Sync    │
│ Test   │   │ to Prod      │
└───┬────┘   └──────┬───────┘
    │               │
    │               ▼
    │        ┌──────────────┐
    │        │ Prod Repo    │
    │        │ Updated      │
    │        └──────┬───────┘
    │               │
    └───────┬───────┘
            │
            ▼
    ┌──────────────┐
    │ Prod CI/CD   │
    │ Triggers     │
    └──────────────┘
```

**What happens automatically:**

1. **Dev CI/CD runs:**
   - Builds Docker images
   - Runs tests
   - Validates code

2. **Auto-Sync to Prod:**
   - Copies files from dev to prod repo
   - Commits to prod repository
   - Triggers prod CI/CD

3. **Prod CI/CD runs:**
   - Builds production images
   - Runs production tests
   - Ready for deployment

---

## 🔵 GitHub Actions

### Dev Repository (`tutor-ontrol-dev`)

#### 1. Dev CI/CD Pipeline (`.github/workflows/ci-cd.yml`)

**When it triggers:**
- ✅ Push to `main` branch
- ✅ Pull request to `main` branch

**What it does:**
- Builds backend Docker image
- Builds frontend Docker image
- Runs backend tests
- Verifies Docker images

#### 2. Auto-Sync to Prod (`.github/workflows/sync-to-prod.yml`)

**When it triggers:**
- ✅ Push to `main` branch (automatic)
- ✅ Manual trigger via GitHub UI

**What it does:**

```yaml
Step 1: Checkout Dev Repository
   ↓
Step 2: Checkout Prod Repository
   ↓
Step 3: Sync Backend Files
   - Copies dev-repo/backend/* → prod-repo/backend/
   ↓
Step 4: Sync Frontend Files
   - Copies dev-repo/nginx/frontend/* → prod-repo/nginx/frontend/
   ↓
Step 5: Sync Version Control (if exists)
   - Copies version_control files
   ↓
Step 6: Commit and Push to Prod
   - Commits changes to prod repo
   - Pushes to prod/main branch
   ↓
Step 7: Summary
   - Shows what was synced
```

**This automatically merges dev changes into prod!**

### Prod Repository (`tutor-ontrol-prod`)

#### Production Deployment (`.github/workflows/deploy.yml`)

**When it triggers:**
- ✅ Push to `main` branch (triggered by auto-sync)
- ✅ Manual trigger via GitHub UI

**What it does:**
- Builds production backend Docker image
- Builds production frontend Docker image
- Runs production tests
- Verifies Docker images

---

## 🟠 Jenkins (Each Repository)

### Dev Repository Jenkinsfile

**Location:** `tutor-ontrol-dev/Jenkinsfile`

**When it triggers:**
- ✅ Push to `main` branch (if webhook configured)
- ✅ Manual trigger

**What it does:**
- Builds images
- Runs tests
- Deploys to dev server
- Health checks

### Prod Repository Jenkinsfile

**Location:** `tutor-ontrol-prod/Jenkinsfile`

**When it triggers:**
- ✅ Push to `main` branch (after auto-sync)
- ✅ Manual trigger (recommended for production)

**What it does:**
- Builds production images
- Runs tests
- Deploys to production server
- Health checks

---

## 🔄 Complete Workflow Example

### Scenario: Adding a new feature

#### Step 1: Development

```bash
# Work in dev repository
cd tutor-ontrol-dev

# Make changes
# Edit backend/models.py
# Edit nginx/frontend/src/App.vue

# Commit and push
git add .
git commit -m "Add new feature"
git push origin main
```

**What happens automatically:**

1. **Dev CI/CD Pipeline:**
   ```
   ✅ Builds backend image
   ✅ Builds frontend image
   ✅ Runs tests
   ✅ Verifies everything works
   ```

2. **Auto-Sync to Prod:**
   ```
   ✅ Copies backend files to prod repo
   ✅ Copies frontend files to prod repo
   ✅ Commits to prod repository
   ✅ Pushes to prod/main branch
   ```

3. **Prod CI/CD Pipeline (auto-triggered):**
   ```
   ✅ Builds production backend image
   ✅ Builds production frontend image
   ✅ Runs production tests
   ✅ Verifies everything works
   ```

4. **Jenkins (if configured):**
   ```
   Dev: ✅ Deploys to dev server
   Prod: ✅ Ready to deploy (manual trigger recommended)
   ```

#### Step 2: Testing

```bash
# Test in dev environment
cd tutor-ontrol-dev
docker-compose up -d

# Access at http://localhost
# Test your new feature
```

#### Step 3: Production Deployment

```bash
# Prod code is already updated via auto-sync!
# Just deploy when ready

cd tutor-ontrol-prod

# Option 1: Use Jenkins
# - Go to Jenkins dashboard
# - Click "Production Deployment"
# - Click "Build Now"

# Option 2: Manual deployment
docker-compose up -d
# Production is live at http://localhost
```

---

## 🔧 Setup Instructions

### Step 1: Configure GitHub Secrets

In your **dev repository** (`tutor-ontrol-dev`), go to:
**Settings → Secrets and variables → Actions**

Add these secrets:

1. **PROD_REPO** (Repository Secret)
   - Value: `YOUR_USERNAME/tutor-ontrol-prod`
   - Example: `h0x1k/tutor-ontrol-prod`

2. **PROD_REPO_TOKEN** (Repository Secret)
   - Value: Your Personal Access Token (PAT)
   - How to create:
     1. Go to GitHub → Settings → Developer settings
     2. Personal access tokens → Tokens (classic)
     3. Generate new token
     4. Scopes needed: `repo` (full control)
     5. Copy the token and add as secret

### Step 2: Verify Workflow

1. Push a change to dev repository
2. Check Actions tab in dev repo
3. You should see "Auto-Sync Dev to Prod" workflow
4. Check Actions tab in prod repo
5. You should see "Production Deployment" workflow triggered

---

## 📋 Key Features

| Feature | Description |
|---------|-------------|
| **Auto-Merge** | Dev changes automatically sync to prod |
| **Independent Repos** | Each repo is separate |
| **CI/CD** | Separate pipelines for each repo |
| **Deployment** | Manual control over production |
| **Testing** | Test in dev before auto-sync |

---

## 🎯 How to Use

### Daily Development

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
git commit -m "My changes"
git push origin main

# 5. Automatic:
#    - Dev CI/CD validates ✅
#    - Auto-syncs to prod ✅
#    - Prod CI/CD validates ✅
#    - Jenkins deploys dev (if configured) ✅
```

### Production Deployment

```bash
# Prod code is already updated via auto-sync!
# Just deploy when ready

cd tutor-ontrol-prod

# Review what was synced
git log --oneline -5

# Deploy
docker-compose up -d
# Or use Jenkins for automated deployment
```

---

## ⚠️ Important Notes

1. **Automatic Syncing:**
   - Every push to dev automatically syncs to prod
   - Prod repository is updated automatically
   - You still control when to deploy to production

2. **GitHub Token Required:**
   - You need a Personal Access Token
   - Token needs `repo` scope
   - Add it as `PROD_REPO_TOKEN` secret

3. **Deployment Control:**
   - Auto-sync updates prod code
   - You control when to deploy
   - Use Jenkins manual trigger for production

4. **Testing:**
   - Always test in dev first
   - Auto-sync happens after dev push
   - Review prod changes before deploying

---

## 📊 Visual Flow

```
┌─────────────────────────┐
│  tutor-ontrol-dev/      │
│  (GitHub Repo)          │
│                         │
│  You: git push main     │
└──────────┬──────────────┘
           │
    ┌──────┴──────┐
    │             │
    ▼             ▼
┌────────┐   ┌──────────────┐
│ Dev    │   │ Auto-Sync    │
│ CI/CD  │   │ Workflow     │
└───┬────┘   └──────┬───────┘
    │               │
    │               ▼
    │        ┌──────────────┐
    │        │ tutor-ontrol-│
    │        │ prod/         │
    │        │ Updated       │
    │        └──────┬───────┘
    │               │
    └───────┬───────┘
            │
            ▼
    ┌──────────────┐
    │ Prod CI/CD   │
    │ Triggers     │
    └──────┬───────┘
           │
           ▼
    ┌──────────────┐
    │ Deploy Prod  │
    │ (Manual)     │
    └──────────────┘
```

---

## ✅ Summary

**Two Separate Repositories with Auto-Merge:**

1. **tutor-ontrol-dev:**
   - Development code
   - Dev CI/CD pipeline
   - Auto-syncs to prod
   - Deploys to dev server (port 80)

2. **tutor-ontrol-prod:**
   - Production code (auto-updated from dev)
   - Prod CI/CD pipeline
   - Deploys to prod server (port 80)
   - Manual deployment control

**Workflow:**
1. Develop in `tutor-ontrol-dev`
2. Push to dev → Auto-syncs to prod
3. Test in dev environment
4. Deploy to production when ready

**CI/CD:**
- GitHub Actions: Validates and auto-syncs
- Jenkins: Actually deploys
- Each repository has its own pipelines

**Automatic Syncing:**
- Dev changes automatically merge into prod
- No manual copying needed
- Full control over deployment timing
