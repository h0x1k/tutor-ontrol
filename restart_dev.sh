#!/bin/bash

echo "🔄 Restarting Development Environment..."

./stop_dev.sh
sleep 2
./start_dev.sh  