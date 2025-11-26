#!/bin/bash

echo "🔄 Restarting Production Environment..."

./stop_prod.sh
sleep 2
./start_prod.sh