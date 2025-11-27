#!/bin/bash
# Jenkins Pipeline Test Script

set -e

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "🧪 Testing Jenkins Pipeline Components..."
echo "=========================================="
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test 1: Docker Registry
echo "1️⃣ Testing Docker Registry..."
if curl -f http://localhost:5001/v2/ > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Registry is accessible${NC}"
else
    echo -e "${YELLOW}⚠️  Registry not accessible - starting it...${NC}"
    cd "$SCRIPT_DIR/dev" && docker-compose up -d registry && cd "$SCRIPT_DIR"
    sleep 3
    if curl -f http://localhost:5001/v2/ > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Registry started successfully${NC}"
    else
        echo -e "${RED}❌ Registry failed to start${NC}"
    fi
fi
echo ""

# Test 2: Docker access
echo "2️⃣ Testing Docker access..."
if docker ps > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Docker is accessible${NC}"
else
    echo -e "${RED}❌ Docker not accessible${NC}"
fi
echo ""

# Test 3: Build context
echo "3️⃣ Testing build context..."
cd "$SCRIPT_DIR/dev"
if [ -f "Dockerfile.backend" ] && [ -f "Dockerfile.nginx" ] && [ -f "docker-compose.yml" ]; then
    echo -e "${GREEN}✅ All required files exist${NC}"
else
    echo -e "${RED}❌ Missing required files${NC}"
fi
cd "$SCRIPT_DIR"
echo ""

# Test 4: Backend image build
echo "4️⃣ Testing backend image build..."
cd "$SCRIPT_DIR/dev"
if docker build -f Dockerfile.backend -t test-backend:test . > /tmp/build-backend.log 2>&1; then
    echo -e "${GREEN}✅ Backend image builds successfully${NC}"
    docker rmi test-backend:test > /dev/null 2>&1 || true
else
    echo -e "${RED}❌ Backend image build failed${NC}"
    echo "   Check /tmp/build-backend.log for details"
fi
cd "$SCRIPT_DIR"
echo ""

# Test 5: Nginx image build
echo "5️⃣ Testing nginx image build..."
cd "$SCRIPT_DIR/dev"
if docker build -f Dockerfile.nginx -t test-nginx:test . > /tmp/build-nginx.log 2>&1; then
    echo -e "${GREEN}✅ Nginx image builds successfully${NC}"
    docker rmi test-nginx:test > /dev/null 2>&1 || true
else
    echo -e "${RED}❌ Nginx image build failed${NC}"
    echo "   Check /tmp/build-nginx.log for details"
fi
cd "$SCRIPT_DIR"
echo ""

# Test 6: Version control image build
echo "6️⃣ Testing version control image build..."
cd "$SCRIPT_DIR/dev/version_control"
if docker build -t test-versioncontrol:test . > /tmp/build-versioncontrol.log 2>&1; then
    echo -e "${GREEN}✅ Version control image builds successfully${NC}"
    docker rmi test-versioncontrol:test > /dev/null 2>&1 || true
else
    echo -e "${RED}❌ Version control image build failed${NC}"
    echo "   Check /tmp/build-versioncontrol.log for details"
fi
cd "$SCRIPT_DIR"
echo ""

# Test 7: Registry push (skip if registry not running)
echo "7️⃣ Testing registry push..."
if curl -f http://localhost:5001/v2/ > /dev/null 2>&1; then
    cd "$SCRIPT_DIR/dev"
    docker build -f Dockerfile.backend -t localhost:5001/test:test . > /dev/null 2>&1
    if docker push localhost:5001/test:test > /tmp/push-test.log 2>&1; then
        echo -e "${GREEN}✅ Can push to registry${NC}"
        docker rmi localhost:5001/test:test > /dev/null 2>&1 || true
    else
        echo -e "${RED}❌ Cannot push to registry${NC}"
        echo "   Check /tmp/push-test.log for details"
    fi
    cd "$SCRIPT_DIR"
else
    echo -e "${YELLOW}⚠️  Skipping registry push test (registry not running)${NC}"
fi
echo ""

# Test 8: Docker Compose
echo "8️⃣ Testing docker-compose..."
cd "$SCRIPT_DIR/dev"
if docker-compose config > /dev/null 2>&1; then
    echo -e "${GREEN}✅ docker-compose.yml is valid${NC}"
else
    echo -e "${RED}❌ docker-compose.yml has errors${NC}"
fi
cd "$SCRIPT_DIR"
echo ""

# Test 9: Application endpoints
echo "9️⃣ Testing application endpoints..."
if curl -f http://localhost/api/ > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Backend API is accessible${NC}"
else
    echo -e "${YELLOW}⚠️  Backend API not accessible (may not be running)${NC}"
fi

if curl -f http://localhost/version-control/health > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Version control is accessible${NC}"
else
    echo -e "${YELLOW}⚠️  Version control not accessible (may not be running)${NC}"
fi
echo ""

# Test 10: Registry catalog
echo "🔟 Testing registry catalog..."
if curl -f http://localhost:5001/v2/ > /dev/null 2>&1; then
    CATALOG=$(curl -s http://localhost:5001/v2/_catalog 2>&1)
    if [ -n "$CATALOG" ] && [ "$CATALOG" != "" ]; then
        echo -e "${GREEN}✅ Registry catalog accessible${NC}"
        echo "   Catalog: $CATALOG"
    else
        echo -e "${YELLOW}⚠️  Registry catalog empty or not accessible${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Registry not running - cannot test catalog${NC}"
fi
echo ""

# Test 11: Jenkins installation
echo "1️⃣1️⃣ Testing Jenkins installation..."
if systemctl is-active --quiet jenkins 2>/dev/null || pgrep -f jenkins > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Jenkins is running${NC}"
elif curl -f http://localhost:8080 > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Jenkins is accessible on port 8080${NC}"
else
    echo -e "${YELLOW}⚠️  Jenkins is not installed or not running${NC}"
    echo "   Install with: sudo apt install jenkins"
fi
echo ""

echo "=========================================="
echo "✅ Jenkins Pipeline Testing Complete!"
echo ""
echo "📋 Summary:"
echo "   - All components tested"
echo "   - Check results above for any failures"
echo "   - If all tests pass, Jenkins pipeline should work"
echo ""
