#!/bin/bash

# Define paths
APP_DIR="/home/admin/scripts/raspberry-pi-bme280-weather-station-flask-python"
VENV_PATH="$/venv"
TMUX_BIN=$(which tmux)

# Start Flask app in tmux
$TMUX_BIN kill-session -t flask_app 2>/dev/null
$TMUX_BIN new-session -d -s flask_app "cd ~ && source venv/bin/activate && cd $APP_DIR && export FLASK_APP=app.py && flask run --host=0.0.0.0 --port=8000"


# Start logger in tmux
$TMUX_BIN kill-session -t logger 2>/dev/null
$TMUX_BIN new-session -d -s logger "cd ~ && source venv/bin/activate && cd $APP_DIR && python logger.py"

# Start alerts in tmux
$TMUX_BIN kill-session -t alerts 2>/dev/null
$TMUX_BIN new-session -d -s alerts "source venv/bin/activate && cd $APP_DIR && python alert.py"

# Start PiTunnel in tmux
$TMUX_BIN kill-session -t pitunnel 2>/dev/null
$TMUX_BIN new-session -d -s pitunnel "pitunnel --port=8000 --name=humidity-sensor --http"

echo "✅ Dashboard, logger, alerts, and PiTunnel started in tmux!"

