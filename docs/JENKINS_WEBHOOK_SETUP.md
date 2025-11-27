# Jenkins GitHub Webhook Setup Guide

This guide will help you configure Jenkins to automatically trigger builds when you push to GitHub.

## Prerequisites

- Jenkins running at http://localhost:8081
- GitHub repository: https://github.com/h0x1k/tutor-ontrol
- Jenkins plugins installed (see Step 1)

## Step 1: Install Required Jenkins Plugins

1. Open Jenkins: http://localhost:8081
2. Go to: **Manage Jenkins** → **Manage Plugins**
3. Click **Available** tab
4. Search and install:
   - ✅ **GitHub plugin**
   - ✅ **GitHub Branch Source Plugin**
   - ✅ **Build Authorization Token Root Plugin**
5. Click **Install without restart** (or restart Jenkins if needed)

## Step 2: Configure Jenkins GitHub Integration

1. In Jenkins: **Manage Jenkins** → **Configure System**
2. Scroll to **GitHub** section
3. Click **Add GitHub Server**
4. Configure:
   - **Name**: `github`
   - **API URL**: `https://api.github.com`
   - **Credentials**: (Optional - only needed for private repos)
     - Click **Add** → **Jenkins**
     - Kind: **Secret text**
     - Secret: Your GitHub Personal Access Token
     - ID: `github-token`
5. Check: **Manage hooks** (if you have credentials)
6. Click **Test connection** (if credentials added)
7. Click **Save**

## Step 3: Create Jenkins Pipeline Jobs

### Create Dev Pipeline Job

1. **New Item** → **Pipeline**
2. **Name**: `tutor-ontrol-dev`
3. Click **OK**
4. Configure:
   - **General**:
     - ✅ Check **GitHub project**
     - **Project url**: `https://github.com/h0x1k/tutor-ontrol`
   - **Build Triggers**:
     - ✅ **GitHub hook trigger for GITScm polling**
   - **Pipeline**:
     - **Definition**: **Pipeline script from SCM**
     - **SCM**: **Git**
     - **Repository URL**: `https://github.com/h0x1k/tutor-ontrol.git`
     - **Credentials**: (Leave empty for public repo, or add for private)
     - **Branches to build**: `*/master` (or your branch name)
     - **Script Path**: `dev/Jenkinsfile`
5. Click **Save**

### Create Prod Pipeline Job

1. **New Item** → **Pipeline**
2. **Name**: `tutor-ontrol-prod`
3. Click **OK**
4. Configure:
   - **Pipeline**:
     - **Definition**: **Pipeline script from SCM**
     - **SCM**: **Git**
     - **Repository URL**: `https://github.com/h0x1k/tutor-ontrol.git`
     - **Branches to build**: `*/master`
     - **Script Path**: `prod/Jenkinsfile`
5. Click **Save**

## Step 4: Get Your Jenkins Webhook URL

You need to make Jenkins accessible from GitHub. Choose one option:

### Option A: Use ngrok (Recommended for Testing)

1. Install ngrok: https://ngrok.com/download
2. Run: `ngrok http 8081`
3. Copy the forwarding URL (e.g., `https://abc123.ngrok.io`)
4. Your webhook URL: `https://abc123.ngrok.io/github-webhook/`

### Option B: Use Your Public IP (For Local Network)

1. Find your IP: `ifconfig | grep "inet "` (macOS/Linux)
2. If Jenkins is accessible from internet, use: `http://YOUR_IP:8081/github-webhook/`
3. **Note**: Port 8081 must be open in firewall

### Option C: Use GitHub Actions (Alternative)

If webhooks are difficult, you can trigger Jenkins via GitHub Actions or use polling.

## Step 5: Configure GitHub Webhook

1. Go to: https://github.com/h0x1k/tutor-ontrol/settings/hooks
2. Click **Add webhook**
3. Configure:
   - **Payload URL**: `http://YOUR_IP:8081/github-webhook/` or ngrok URL
   - **Content type**: `application/json`
   - **Secret**: (Optional - leave empty for now)
   - **Which events**: Select **Just the push event**
   - ✅ **Active**
4. Click **Add webhook**

## Step 6: Test the Setup

1. Make a test change:
   ```bash
   echo "# Test" >> README.md
   git add README.md
   git commit -m "Test Jenkins webhook"
   git push origin master
   ```

2. Check Jenkins:
   - Go to http://localhost:8081
   - You should see a new build starting automatically in `tutor-ontrol-dev`

3. Check GitHub webhook:
   - Go to: https://github.com/h0x1k/tutor-ontrol/settings/hooks
   - Click on your webhook
   - Check **Recent Deliveries** - should show successful delivery

## Troubleshooting

### Webhook Not Triggering

1. **Check Jenkins logs**:
   ```bash
   docker logs jenkins | grep -i webhook
   ```

2. **Check webhook delivery in GitHub**:
   - Go to webhook settings → Recent Deliveries
   - Check response codes (should be 200)

3. **Verify Jenkins is accessible**:
   ```bash
   curl http://localhost:8081/github-webhook/
   ```

### Build Not Starting

1. **Check job configuration**:
   - Ensure "GitHub hook trigger" is checked
   - Verify Script Path is correct (`dev/Jenkinsfile` or `prod/Jenkinsfile`)

2. **Check Jenkins logs**:
   ```bash
   docker logs jenkins --tail 50
   ```

### Connection Refused

- If using localhost, GitHub can't reach it
- Use ngrok or configure port forwarding
- Or use polling instead (see Alternative below)

## Alternative: Use Polling (Simpler, No Webhook)

If webhooks are too complex, you can use polling:

1. In Jenkinsfile, keep `pollSCM('H/2 * * * *')` (polls every 2 minutes)
2. In Jenkins job, check **Poll SCM** instead of webhook trigger
3. Schedule: `H/2 * * * *` (every 2 minutes)

This is simpler but less efficient (checks even when no changes).

## Quick Commands

```bash
# Check Jenkins status
docker ps | grep jenkins

# View Jenkins logs
docker logs jenkins --tail 100

# Restart Jenkins
docker restart jenkins

# Get Jenkins admin password
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

## Next Steps

Once webhooks are working:
1. Push changes to GitHub
2. Jenkins automatically builds
3. Dev pipeline triggers prod pipeline on success
4. Both environments update automatically

## Security Notes

- For production, use HTTPS with proper certificates
- Add webhook secret for authentication
- Use GitHub Personal Access Token for private repos
- Consider using Jenkins credentials for sensitive data

