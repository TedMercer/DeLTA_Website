#!/bin/bash

echo "=== Stopping all tmux sessions ==="
tmux kill-server
sleep 2

echo "=== Starting dashboard ==="
/home/admin/DeLTA_Website/start_dashboard.sh

echo "=== Dashboard restarted! ==="

