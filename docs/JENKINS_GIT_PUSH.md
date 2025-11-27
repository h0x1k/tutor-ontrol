# Jenkins Git Push Configuration

This guide explains how to configure Jenkins to push build information and tags back to your Git repository.

## Overview

The Jenkins pipelines now include a **"Push to Git Repository"** stage that:
- Creates build information files
- Tags successful builds (`dev-build-{NUMBER}` or `prod-build-{NUMBER}`)
- Commits and pushes changes back to the repository

## Configuration Options

### Option 1: Using HTTPS with Credentials (Recommended)

1. **Create a Personal Access Token (GitHub/GitLab)**:
   - GitHub: Settings → Developer settings → Personal access tokens → Generate new token
   - GitLab: User Settings → Access Tokens → Create personal access token
   - Required scopes: `repo` (full control of private repositories)

2. **Add Credentials in Jenkins**:
   - Go to Jenkins → Manage Jenkins → Credentials
   - Click "Add Credentials"
   - Kind: `Username with password`
   - Username: Your Git username
   - Password: Your personal access token
   - ID: `git-credentials` (must match the Jenkinsfile)
   - Description: "Git credentials for CI/CD"

3. **Verify**:
   - The pipeline will automatically use these credentials
   - Builds will push tags and build info files

### Option 2: Using SSH Keys

1. **Generate SSH Key** (if not exists):
   ```bash
   ssh-keygen -t ed25519 -C "jenkins@ci.local" -f ~/.ssh/jenkins_key
   ```

2. **Add Public Key to Git Provider**:
   - Copy public key: `cat ~/.ssh/jenkins_key.pub`
   - GitHub: Settings → SSH and GPG keys → New SSH key
   - GitLab: User Settings → SSH Keys → Add SSH key

3. **Configure Jenkins User SSH**:
   ```bash
   # As jenkins user
   sudo su - jenkins
   mkdir -p ~/.ssh
   cp /path/to/jenkins_key ~/.ssh/id_ed25519
   chmod 600 ~/.ssh/id_ed25519
   ssh-keyscan github.com >> ~/.ssh/known_hosts  # or gitlab.com
   ```

4. **Verify**:
   - The pipeline will automatically use SSH if credentials are not configured
   - Test: `sudo su - jenkins -c "ssh -T git@github.com"`

### Option 3: Skip Git Push (Optional)

If you don't want Jenkins to push to Git, you can comment out or remove the "Push to Git Repository" stage in the Jenkinsfile.

## What Gets Pushed

### Build Information File (`build-info.txt`)
```
Build Number: 42
Build Version: build-42
Build Date: 2024-01-15 10:30:00 UTC
Git Commit: abc123def456
Git Branch: origin/main
```

### Git Tags
- Dev builds: `dev-build-{BUILD_NUMBER}`
- Prod builds: `prod-build-{BUILD_NUMBER}`
- Example: `dev-build-42`, `prod-build-42`

## Testing Git Push

1. **Run a Jenkins build**:
   ```bash
   # Trigger a build manually or via webhook
   ```

2. **Check Git repository**:
   ```bash
   git fetch --tags
   git tag | grep build
   git log --oneline | head -5
   ```

3. **Verify build-info.txt**:
   ```bash
   cat build-info.txt
   ```

## Troubleshooting

### Error: "Credentials not found"
- Ensure credentials ID is exactly `git-credentials`
- Check that credentials are added in Jenkins

### Error: "Permission denied (publickey)"
- SSH key not configured for Jenkins user
- Public key not added to Git provider
- Run: `sudo su - jenkins -c "ssh -T git@github.com"`

### Error: "Push skipped"
- No changes to commit (normal if build-info.txt unchanged)
- No access configured (check credentials or SSH)

### Tags not appearing
- Check if tag push succeeded in build logs
- Run: `git fetch --tags` to pull tags from remote

## Security Best Practices

1. **Use Personal Access Tokens** (not passwords)
2. **Limit token scope** to minimum required (`repo` scope)
3. **Rotate tokens regularly**
4. **Use SSH keys** for better security in production
5. **Store credentials securely** in Jenkins credential store

## Example Build Output

```
📤 Pushing build information to Git...
✅ Git push completed!
```

Or if credentials not configured:
```
⚠️ Credentials not configured, trying SSH...
✅ Git push completed (or skipped if no access configured)
```

## Next Steps

1. Configure credentials or SSH keys
2. Run a test build
3. Verify tags and commits appear in repository
4. Set up webhooks to trigger builds automatically

