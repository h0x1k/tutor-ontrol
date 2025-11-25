#!/bin/bash
echo "Starting development environment..."
docker-compose -f docker-compose.dev.yml up --build -d
echo "Development services started:"
echo "  - Tutor App: http://localhost:8000"
echo "  - Version Control: http://localhost:8001"
echo "  - VC Tester container ready for testing"