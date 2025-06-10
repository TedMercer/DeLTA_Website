#!/bin/bash

# Config
VENV_PATH="/home/admin/venv"
APP_DIR="/home/admin/scripts/raspberry-pi-bme280-weather-station-flask-python"
TMUX_BIN=$(which tmux)

# Infinite loop
while true
do
    echo "=== Watchdog running: $(date) ==="

    # Check Flask
    $TMUX_BIN has-session -t flask_app 2>/dev/null
    if [ $? != 0 ]; then
        echo "⚠️ Flask not running — restarting..."
        $TMUX_BIN new-session -d -s flask_app "source $VENV_PATH/bin/activate && cd $APP_DIR && python app.py"
    else
        echo "✅ Flask running."
    fi

    # Check alerts
    $TMUX_BIN has-session -t alerts 2>/dev/null
    if [ $? != 0 ]; then
        echo "⚠️ Alerts not running — restarting..."
        $TMUX_BIN new-session -d -s alerts "source $VENV_PATH/bin/activate && cd $APP_DIR && python alert.py"
    else
        echo "✅ Alerts running."
    fi

    # Check pitunnel
    $TMUX_BIN has-session -t pitunnel 2>/dev/null
    if [ $? != 0 ]; then
        echo "⚠️ Pitunnel not running — restarting..."
        $TMUX_BIN new-session -d -s pitunnel "pitunnel --port=8000 --name=humidity-sensor --http"
    else
        echo "✅ Pitunnel running."
    fi

    echo "=== Watchdog sleeping 60 sec ==="
    sleep 60
done

