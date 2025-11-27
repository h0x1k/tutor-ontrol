# Git Commands Reference

## Basic Git Commands

### Check Status
```bash
git status
git log --oneline -10
git branch -a
```

### Commit Changes
```bash
# Stage all changes
git add .

# Stage specific files
git add dev/Jenkinsfile prod/Jenkinsfile

# Commit
git commit -m "Update Jenkins pipelines with Git push functionality"

# Commit with detailed message
git commit -m "feat: Add Git push to Jenkins pipelines

- Added Git push stage to dev and prod Jenkinsfiles
- Supports both HTTPS credentials and SSH keys
- Creates build tags and build-info.txt files"
```

### Push to Repository
```bash
# Push to origin/master
git push origin master

# Push to origin/main (if using main branch)
git push origin main

# Push with tags
git push origin master --tags

# Force push (use with caution!)
git push origin master --force
```

### Working with Branches
```bash
# Create new branch
git checkout -b feature/jenkins-git-push

# Switch branch
git checkout master
git checkout dev

# Merge branch
git merge feature/jenkins-git-push

# Delete branch
git branch -d feature/jenkins-git-push
```

### Tagging (for Jenkins builds)
```bash
# Create annotated tag
git tag -a v1.0.0 -m "Release version 1.0.0"

# Create lightweight tag
git tag v1.0.0

# List tags
git tag

# Push tags
git push origin --tags

# Delete tag
git tag -d v1.0.0
git push origin :refs/tags/v1.0.0
```

### Remote Operations
```bash
# View remotes
git remote -v

# Add remote
git remote add upstream https://github.com/user/repo.git

# Fetch from remote
git fetch origin
git fetch upstream

# Pull changes
git pull origin master

# Push to specific remote
git push origin master
git push upstream master
```

### Undo Changes
```bash
# Unstage files
git reset HEAD <file>

# Discard changes in working directory
git checkout -- <file>

# Discard all changes
git reset --hard HEAD

# Undo last commit (keep changes)
git reset --soft HEAD~1

# Undo last commit (discard changes)
git reset --hard HEAD~1
```

## Project-Specific Commands

### Commit Dev Changes
```bash
cd /Users/h0x/Desktop/fl/ci_cd_docker_luba_25-11-25/web/tutor-ontrol
git add dev/
git commit -m "Update dev environment"
git push origin master
```

### Commit Prod Changes
```bash
cd /Users/h0x/Desktop/fl/ci_cd_docker_luba_25-11-25/web/tutor-ontrol
git add prod/
git commit -m "Update prod environment"
git push origin master
```

### Commit Both Environments
```bash
cd /Users/h0x/Desktop/fl/ci_cd_docker_luba_25-11-25/web/tutor-ontrol
git add dev/ prod/
git commit -m "Update both dev and prod environments"
git push origin master
```

### Quick Commit & Push
```bash
# One-liner for quick commits
git add . && git commit -m "Your message" && git push origin master
```

## Jenkins Integration

### For Jenkins to Push (requires credentials)
Jenkins will automatically:
- Create tags: `dev-build-{NUMBER}` or `prod-build-{NUMBER}`
- Create `build-info.txt` file
- Commit and push changes

### Manual Tag Creation (if Jenkins not configured)
```bash
# Create dev build tag
git tag -a dev-build-42 -m "Dev build 42"

# Create prod build tag
git tag -a prod-build-42 -m "Prod build 42"

# Push tags
git push origin --tags
```

## Current Repository Info

- **Git Executable**: `/usr/bin/git`
- **Current Branch**: `master`
- **Origin**: `https://github.com/h0x1k/tutor-ontrol.git`
- **Upstream**: `https://github.com/Himatora/tutor-ontrol`

## Quick Reference

```bash
# Most common workflow
git status                    # Check what changed
git add .                     # Stage all changes
git commit -m "Message"       # Commit changes
git push origin master        # Push to remote
```

