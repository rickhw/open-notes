#!/bin/bash

# Check if vm_ips.txt exists
if [ ! -f "vm_ips.txt" ]; then
    echo "Error: vm_ips.txt not found in the current directory."
    exit 1
fi

echo "Starting VM updates..."

# Read IPs from vm_ips.txt and process them in parallel
while IFS= read -r ip; do
    if [ -n "$ip" ]; then
        echo "Connecting to $ip for update..."
        # Execute commands on the remote VM in the background
        ssh -o ConnectTimeout=5 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "ubuntu@$ip" "sudo apt update && sudo apt upgrade -y && sudo apt autoremove --purge && sudo apt clean" > "/tmp/update_log_$ip.txt" 2>&1 &
        echo "Update process for $ip started in background. Log: /tmp/update_log_$ip.txt"
    fi
done < "vm_ips.txt"

# Wait for all background processes to complete
echo "Waiting for all VM update processes to complete..."
wait

echo "All VM update processes finished. Check logs in /tmp/update_log_*.txt for details."
