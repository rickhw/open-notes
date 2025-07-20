#!/bin/bash

# K3s Cluster Uninstallation Script
# This script automates the uninstallation of a K3s Kubernetes cluster.
#
# Prerequisites:
# 1. SSH key-based authentication is set up for the 'ubuntu' user on all VMs.
# 2. The 'ubuntu' user has sudo NOPASSWD privileges on all VMs.

# --- Configuration ---
# Source the cluster configuration
source "$(dirname "$0")/k3s_cluster_config.sh"

# --- Functions ---
log_info() {
    echo "[INFO] $(date +'%Y-%m-%d %H:%M:%S') $1"
}

log_error() {
    echo "[ERROR] $(date +'%Y-%m-%d %H:%M:%S') $1" >&2
}

execute_remote() {
    local ip=$1
    local command=$2
    log_info "Executing on $ip: $command"
    ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${SSH_USER}@${ip}" "${command}"
    if [ $? -ne 0 ]; then
        log_error "Command failed on ${ip}: ${command}"
        # Do not exit for uninstallation, try to clean up as much as possible
    fi
}

# --- Main Uninstallation Steps ---

log_info "Starting K3s cluster uninstallation..."

# 1. Uninstall K3s on Worker Nodes
log_info "Uninstalling K3s on Worker Nodes..."
for WORKER_IP in "${WORKER_IPS[@]}"; do
    log_info "Uninstalling K3s on Worker: ${WORKER_IP}"
    execute_remote "${WORKER_IP}" "sudo /usr/local/bin/k3s-agent-uninstall.sh"
    sleep 5 # Give some time between worker uninstallations
done

# 2. Uninstall K3s on HA Master Node
log_info "Uninstalling K3s on HA Master: ${HA_MASTER_IP}"
execute_remote "${HA_MASTER_IP}" "sudo /usr/local/bin/k3s-uninstall.sh"
sleep 10

# 3. Uninstall K3s on Primary Master Node
log_info "Uninstalling K3s on Primary Master: ${PRIMARY_MASTER_IP}"
execute_remote "${PRIMARY_MASTER_IP}" "sudo /usr/local/bin/k3s-uninstall.sh"
sleep 10

log_info "K3s cluster uninstallation script finished."
log_info "All K3s components should now be removed from the specified nodes."
