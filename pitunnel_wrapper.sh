#!/bin/bash

# Wait for port 8000 to be ready
echo "⏳ Waiting for Flask to be ready on port 8000..."
while ! nc -z 127.0.0.1 8000; do
    sleep 2
done

echo "✅ Flask is ready! Starting PiTunnel..."
pitunnel --port=8000 --name=humidity-sensor --http --accept-terms

