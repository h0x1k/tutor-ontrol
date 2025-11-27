# 🔄 Setup: Auto-Merge from Dev to Prod

This guide shows you how to set up automatic merging from `tutor-ontrol-dev` to `tutor-ontrol-prod`.

## 🎯 What It Does

When you push code to the **dev repository**, it automatically:
1. ✅ Copies files to the **prod repository**
2. ✅ Commits changes to prod
3. ✅ Triggers prod CI/CD pipeline

## 📋 Prerequisites

- Two separate GitHub repositories:
  - `tutor-ontrol-dev`
  - `tutor-ontrol-prod`
- GitHub Personal Access Token (PAT)

## 🔧 Step-by-Step Setup

### Step 1: Create Personal Access Token

1. Go to GitHub → **Settings** → **Developer settings**
2. Click **Personal access tokens** → **Tokens (classic)**
3. Click **Generate new token (classic)**
4. Configure:
   - **Note:** `tutor-ontrol-prod-sync`
   - **Expiration:** Choose your preference
   - **Scopes:** Check `repo` (Full control of private repositories)
5. Click **Generate token**
6. **Copy the token** (you won't see it again!)

### Step 2: Add Secrets to Dev Repository

1. Go to your **dev repository** on GitHub
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**

#### Add Secret 1: PROD_REPO

- **Name:** `PROD_REPO`
- **Value:** `YOUR_USERNAME/tutor-ontrol-prod`
  - Example: `h0x1k/tutor-ontrol-prod`
- Click **Add secret**

#### Add Secret 2: PROD_REPO_TOKEN

- **Name:** `PROD_REPO_TOKEN`
- **Value:** Paste your Personal Access Token from Step 1
- Click **Add secret**

### Step 3: Verify Workflow File

Make sure the workflow file exists in your dev repository:

**File:** `.github/workflows/sync-to-prod.yml`

If it doesn't exist, create it with the content from the main documentation.

### Step 4: Test the Setup

1. Make a small change in dev repository:
   ```bash
   cd tutor-ontrol-dev
   echo "# Test auto-sync" >> README.md
   git add README.md
   git commit -m "Test auto-sync"
   git push origin main
   ```

2. Check Actions tab in dev repo:
   - Go to **Actions** tab
   - You should see "Auto-Sync Dev to Prod" workflow running

3. Check Actions tab in prod repo:
   - Go to **Actions** tab
   - You should see "Production Deployment" workflow triggered
   - Check the commit history - should see auto-merge commit

4. Verify files were synced:
   ```bash
   cd tutor-ontrol-prod
   git pull origin main
   # Check if files match dev repository
   ```

## ✅ Verification Checklist

- [ ] Personal Access Token created
- [ ] `PROD_REPO` secret added to dev repo
- [ ] `PROD_REPO_TOKEN` secret added to dev repo
- [ ] Workflow file exists: `.github/workflows/sync-to-prod.yml`
- [ ] Test push to dev triggers sync
- [ ] Prod repository receives updates
- [ ] Prod CI/CD pipeline triggers

## 🔍 Troubleshooting

### Issue: Workflow fails with "Permission denied"

**Solution:**
- Check that `PROD_REPO_TOKEN` has `repo` scope
- Verify token is not expired
- Make sure token has access to prod repository

### Issue: "Repository not found"

**Solution:**
- Check `PROD_REPO` secret value
- Format should be: `USERNAME/REPO-NAME`
- Make sure prod repository exists
- Verify token has access to prod repo

### Issue: "No changes to commit"

**Solution:**
- This is normal if files are identical
- Make a real change in dev to test
- Check that file paths match between repos

### Issue: Workflow doesn't trigger

**Solution:**
- Check workflow file is in `.github/workflows/`
- Verify file name is `sync-to-prod.yml`
- Check workflow syntax is correct
- Make sure you're pushing to `main` branch

## 📝 How It Works

1. **You push to dev:**
   ```bash
   git push origin main
   ```

2. **GitHub Actions triggers:**
   - Checks out dev repository
   - Checks out prod repository (using token)
   - Copies files from dev to prod
   - Commits and pushes to prod

3. **Prod repository updates:**
   - New commit appears in prod repo
   - Prod CI/CD pipeline triggers
   - Production code is ready

## 🎯 Usage

After setup, just work normally:

```bash
# Work in dev
cd tutor-ontrol-dev
# Make changes
git add .
git commit -m "New feature"
git push origin main

# That's it! Prod is automatically updated.
```

## 🔒 Security Notes

- **Token Security:**
  - Never commit tokens to code
  - Use GitHub Secrets only
  - Rotate tokens periodically
  - Use fine-grained tokens if possible

- **Repository Access:**
  - Token only needs access to prod repo
  - Can be scoped to specific repositories
  - Consider using GitHub Apps for better security

## 📚 Additional Resources

- [GitHub Personal Access Tokens](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
- [GitHub Actions Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [GitHub Actions Workflow Syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)

