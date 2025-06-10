#!/bin/bash

echo "=== TMUX Sessions ==="
tmux ls 2>/dev/null || echo "No tmux sessions running."

echo ""
echo "=== Flask App Status ==="
tmux has-session -t flask_app 2>/dev/null && echo "✅ flask_app running" || echo "❌ flask_app NOT running"

echo ""
echo "=== Alerts Status ==="
tmux has-session -t alerts 2>/dev/null && echo "✅ alerts running" || echo "❌ alerts NOT running"

echo ""
echo "=== PiTunnel Status ==="
tmux has-session -t pitunnel 2>/dev/null && echo "✅ pitunnel running" || echo "❌ pitunnel NOT running"

echo ""
echo "=== Check complete ==="

