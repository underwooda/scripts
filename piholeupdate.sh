#!/bin/bash

#Add a cron job to run this script automatically. Eg:
#sudo cron -e
#0 3 */2 * * /path/to/piholeupdate.sh

# Update Pi-hole block list
pihole -g

# Wait for 5 minutes
sleep 5m

# Update Pi-hole application
pihole -up
