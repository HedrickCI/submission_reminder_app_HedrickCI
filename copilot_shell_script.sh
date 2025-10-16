#!/bin/bash

echo "--- Configuration Update and Rerun Script ---"

read -p "Enter the application root directory name (e.g., submission_reminder_LeBronJames): " APP_DIR

if [ ! -d "$APP_DIR" ]; then
    echo "Error: Application directory '$APP_DIR' not found. Please run create_environment.sh first."
    exit 1
fi

CONFIG_FILE="${APP_DIR}/config/config.env"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Configuration file '$CONFIG_FILE' not found. Structure may be incorrect."
    exit 1
fi

read -p "Enter the new assignment name to check (e.g., 'LP Summative'): " NEW_ASSIGNMENT

if [ -z "$NEW_ASSIGNMENT" ]; then
    echo "Error: Assignment name cannot be empty. Aborting update."
    exit 1
fi


sed -i "s|^ASSIGNMENT=\".*\"|ASSIGNMENT=\"${NEW_ASSIGNMENT}\"|" "$CONFIG_FILE"

if [ $? -eq 0 ]; then
    echo "Successfully updated assignment name in $CONFIG_FILE."
    echo "New configuration line: $(grep 'ASSIGNMENT=' "$CONFIG_FILE")"
    echo ""
    echo "--- Rerunning Application with New Assignment ---"
    
    STARTUP_SCRIPT="${APP_DIR}/startup.sh"
    if [ -x "$STARTUP_SCRIPT" ]; then
        "$STARTUP_SCRIPT"
    else
        echo "Error: startup.sh is not executable. Please check permissions in $APP_DIR."
    fi
else
    echo "Error: Failed to update config file using sed."
fi
