#!/bin/bash

# Set the threshold for the available space (in GB)
THRESHOLD=5

# Get the available space in GB (use df command and filter output)
AVAILABLE_SPACE=$(df -BG --output=avail / | tail -n 1 | sed 's/G//')

# Calculate the available space as a percentage
TOTAL_SPACE=$(df -BG --output=size / | tail -n 1 | sed 's/G//')
PERCENTAGE=$((100 * (TOTAL_SPACE - AVAILABLE_SPACE) / TOTAL_SPACE))

# NTFY server URL and topic
NTFY_SERVER="https://ntfy.sh"
TOPIC="whatever"
AUTH_TOKEN="tk_qwerty"

HOSTNAME=$(hostname)

# Send a notification if the available space is below the threshold
if [ "$AVAILABLE_SPACE" -lt "$THRESHOLD" ]; then
    MESSAGE="Warning: Only $AVAILABLE_SPACE GB ($PERCENTAGE%) of disk space remaining on $HOSTNAME"
    curl -X POST -H "Authorization: Bearer $AUTH_TOKEN" -d "$MESSAGE" "$NTFY_SERVER/$TOPIC"
fi

