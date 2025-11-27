#!/bin/bash
# Quick Jenkins Webhook Setup Helper

set -e

echo "🔧 Jenkins Webhook Setup Helper"
echo "================================"
echo ""

# Check if Jenkins is running
if ! docker ps | grep -q jenkins; then
    echo "❌ Jenkins is not running!"
    echo "   Start it with: docker start jenkins"
    exit 1
fi

echo "✅ Jenkins is running"
echo ""

# Get Jenkins URL
JENKINS_URL="http://localhost:8081"
echo "📋 Jenkins URL: $JENKINS_URL"
echo ""

# Check for ngrok
if command -v ngrok &> /dev/null; then
    echo "✅ ngrok is installed"
    echo "   Run: ngrok http 8081"
    echo "   Then use the ngrok URL in GitHub webhook"
else
    echo "⚠️  ngrok not found"
    echo "   Install: https://ngrok.com/download"
    echo "   Or use your public IP"
fi

echo ""
echo "📚 Next Steps:"
echo "=============="
echo ""
echo "1. Install Jenkins Plugins:"
echo "   - Go to: $JENKINS_URL/pluginManager/available"
echo "   - Install: GitHub plugin, GitHub Branch Source Plugin"
echo ""
echo "2. Create Pipeline Jobs:"
echo "   - Job name: tutor-ontrol-dev"
echo "   - Script Path: dev/Jenkinsfile"
echo "   - Enable: 'GitHub hook trigger for GITScm polling'"
echo ""
echo "3. Configure GitHub Webhook:"
echo "   - URL: http://YOUR_IP:8081/github-webhook/"
echo "   - Or use ngrok URL"
echo "   - Events: Just the push event"
echo ""
echo "4. Test:"
echo "   git commit --allow-empty -m 'Test webhook'"
echo "   git push origin master"
echo ""
echo "📖 Full guide: docs/JENKINS_WEBHOOK_SETUP.md"
echo ""

