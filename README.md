# Scripts

This is a collection of scripts that I have been putting together. Work in progress.

## Wireguard Control

`wireguard_control.sh` can check for the status of an existing Wireguard connection, bring it up or take it down.

Change the `wg1` interface to the one that you have set/are using.

## IP Address Monitor

`ipaddresschange.sh`checks for public IP address changes for a CNAME value (ie, one pointed at a DDNS value) and for the local network.

It can be configured to send alerts via Telegram by changing the relevant variables. 

