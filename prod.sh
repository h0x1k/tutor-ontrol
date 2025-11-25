#!/bin/bash
echo "Starting production environment..."
docker-compose up --build -d
echo "Production services started:"
echo "  - Frontend: http://localhost"
echo "  - Tutor App API: http://localhost:8000"
echo "  - Version Control API: http://localhost:8001"