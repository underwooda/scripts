#!/bin/bash

# Check if the script is run with root/sudo privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run with root/sudo privileges. Aborting."
    exit 1
fi

# Function to start Wireguard
function start_wireguard() {
    echo "Starting Wireguard..."
    wg-quick up wg1
}

# Function to stop Wireguard
function stop_wireguard() {
    echo "Stopping Wireguard..."
    wg-quick down wg1
}

# Funtion to show Wireguard status
function show_wireguard() {
    echo "Showing Wireguard status..."
    wg show
}

# Main script
echo "Wireguard Control Script"
echo "------------------------"
echo "1. Start Wireguard"
echo "2. Stop Wireguard"
echo "3. Show Wireguard Status"
echo "4. Cancel"

read -p "Enter your choice (1/2/3/4): " choice

case "$choice" in
    1)
        start_wireguard
        ;;
    2)
        stop_wireguard
        ;;
    3)
        show_wireguard
        ;;
    4)
        echo "Operation cancelled."
        ;;
    *)
        echo "Invalid choice. Please select 1, 2, 3, or 4."
        ;;
esac
