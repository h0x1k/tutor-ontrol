# Fixes Applied

## ✅ Fixed Issues

### 1. Docker Registry Port Conflict

**Problem:** Port 5000 was in use by macOS AirPlay

**Solution:** Changed registry port from 5000 to 5001

**Files Updated:**
- `dev/docker-compose.yml` - Registry port changed to 5001
- `prod/docker-compose.yml` - Registry port changed to 5001
- `dev/Jenkinsfile` - DOCKER_REGISTRY changed to localhost:5001
- `prod/Jenkinsfile` - DOCKER_REGISTRY changed to localhost:5001
- `test-jenkins.sh` - Updated to test port 5001

**Verification:**
```bash
# Registry should now be accessible
curl http://localhost:5001/v2/

# Start registry
cd dev && docker-compose up -d registry
```

### 2. Test Script Improvements

**Updated:** `test-jenkins.sh`
- Fixed path issues
- Updated to use port 5001
- Added Jenkins installation check
- Improved error handling

## 📋 Remaining Steps

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

### Configure Jenkins

1. Access Jenkins: http://localhost:8080
2. Get initial password (if using Docker):
   ```bash
   docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
   ```
3. Install suggested plugins
4. Create admin user
5. Add Jenkins to docker group (Linux):
   ```bash
   sudo usermod -aG docker jenkins
   sudo systemctl restart jenkins
   ```

### Create Pipeline Jobs

1. **Dev Pipeline:**
   - New Item → Pipeline
   - Name: `tutor-control-dev-pipeline`
   - Pipeline script from SCM
   - Script Path: `dev/Jenkinsfile`

2. **Prod Pipeline:**
   - New Item → Pipeline
   - Name: `tutor-control-prod-pipeline`
   - Pipeline script from SCM
   - Script Path: `prod/Jenkinsfile`

## ✅ Current Status

- ✅ Registry port fixed (5001)
- ✅ All Docker builds working
- ✅ Application running
- ✅ Test script updated
- ⚠️ Jenkins needs installation (use INSTALL_JENKINS.sh or Docker)

## 🧪 Test Results

Run the test script to verify:
```bash
./test-jenkins.sh
```

All components should now pass except Jenkins installation.

