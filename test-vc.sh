#!/bin/bash
echo "Testing Version Control Service..."
docker-compose -f docker-compose.dev.yml exec vc-tester python tests/test_versioncontrol.py