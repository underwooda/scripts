#!/bin/bash

# Set the Telegram bot API token and chat ID
TELEGRAM_BOT_TOKEN="YOUR_BOT_TOKEN"
TELEGRAM_CHAT_ID="YOUR_CHAT_ID"

# Set the log file path
LOG_FILE="/path/to/ip_change.log"

# Initialize a variable to store the previous IP addresses
previous_cname_ip=""
previous_public_ip=""

#Domain Variable
domain=

# Function to send a message to the Telegram channel or group
send_telegram_message() {
    local message="$1"
    curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" -d "chat_id=$TELEGRAM_CHAT_ID&text=$message"
}

# Function to resolve the CNAME and get the IP address
resolve_cname() {
    cname_ip=$(dig +short +noquestion $domain)
    echo "$cname_ip"
}

# Function to get the public IP address
get_public_ip() {
    public_ip=$(curl -s -4 icanhazip.com)
    echo "$public_ip"
}

# Function to get the current timestamp
get_timestamp() {
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "$timestamp"
}

# Initial resolves to set the previous IPs
previous_cname_ip=$(resolve_cname)
previous_public_ip=$(get_public_ip)
echo "$(get_timestamp) - Initial CNAME IP: $previous_cname_ip" >> "$LOG_FILE"
echo "$(get_timestamp) - Initial Public IP: $previous_public_ip" >> "$LOG_FILE"

# Continuously monitor for IP changes
while true; do
    current_cname_ip=$(resolve_cname)
    current_public_ip=$(get_public_ip)

    if [ "$current_cname_ip" != "$previous_cname_ip" ]; then
        timestamp=$(get_timestamp)
        cname_message="CNAME IP changed from $previous_cname_ip to $current_cname_ip at $timestamp for $domain"
        echo "$cname_message" >> "$LOG_FILE"
        send_telegram_message "$cname_message"
        previous_cname_ip="$current_cname_ip"
    fi

    if [ "$current_public_ip" != "$previous_public_ip" ]; then
        timestamp=$(get_timestamp)
        public_ip_message="Public IP changed from $previous_public_ip to $current_public_ip at $timestamp"
        echo "$public_ip_message" >> "$LOG_FILE"
        send_telegram_message "$public_ip_message"
        previous_public_ip="$current_public_ip"
    fi

    # Sleep for a while before checking again (e.g., every hour)
    sleep 3600
done
