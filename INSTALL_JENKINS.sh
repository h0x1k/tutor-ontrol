#!/bin/bash
# Jenkins Installation Script

set -e

echo "🔧 Installing Jenkins..."
echo "========================"
echo ""

# Check if running on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "⚠️  macOS detected. Jenkins installation requires Homebrew or manual setup."
    echo ""
    echo "Option 1: Install via Homebrew"
    echo "  brew install jenkins-lts"
    echo "  brew services start jenkins-lts"
    echo ""
    echo "Option 2: Use Docker (Recommended for macOS)"
    echo "  docker run -d -p 8080:8080 -p 50000:50000 --name jenkins jenkins/jenkins:lts"
    echo ""
    echo "Option 3: Manual installation"
    echo "  Download from: https://www.jenkins.io/download/"
    echo ""
    exit 0
fi

# For Linux (Ubuntu/Debian)
echo "📦 Installing Java..."
sudo apt update
sudo apt install -y openjdk-17-jdk

echo ""
echo "📦 Adding Jenkins repository..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

echo ""
echo "📦 Installing Jenkins..."
sudo apt update
sudo apt install -y jenkins

echo ""
echo "🚀 Starting Jenkins..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

echo ""
echo "🔐 Getting initial admin password..."
INITIAL_PASSWORD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
echo "   Initial password: $INITIAL_PASSWORD"
echo "   (Save this password!)"

echo ""
echo "🐳 Adding Jenkins user to docker group..."
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins

echo ""
echo "✅ Jenkins installation complete!"
echo ""
echo "📋 Next steps:"
echo "1. Open browser: http://localhost:8080"
echo "2. Enter initial password: $INITIAL_PASSWORD"
echo "3. Install suggested plugins"
echo "4. Create admin user"
echo "5. Configure Jenkins URL"
echo ""
echo "🔧 Configure pipeline:"
echo "1. Go to Manage Jenkins → Manage Plugins"
echo "2. Install: Docker Pipeline, Docker, Git"
echo "3. Create pipeline job pointing to dev/Jenkinsfile"
echo ""

