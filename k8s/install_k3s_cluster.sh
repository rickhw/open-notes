#!/bin/bash

# K3s Cluster Installation Script
# This script automates the installation of a K3s Kubernetes cluster with HA master.
#
# Prerequisites:
# 1. SSH key-based authentication is set up for the 'ubuntu' user on all VMs.
# 2. The 'ubuntu' user has sudo NOPASSWD privileges on all VMs.
# 3. All VMs can communicate with each other on the necessary K3s ports (default: 6443, 8472, 10250).

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
        exit 1
    fi
}

# --- Main Installation Steps ---

log_info "Starting K3s cluster installation..."

# 1. Install K3s on the Primary Master Node
log_info "Installing K3s on Primary Master: ${PRIMARY_MASTER_IP}"
execute_remote "${PRIMARY_MASTER_IP}" \
    "curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=${K3S_VERSION} sh -s - server --cluster-init"

# Give K3s some time to initialize
log_info "Waiting for K3s to initialize on Primary Master..."
sleep 30

# 2. Get K3s Token from Primary Master
log_info "Retrieving K3s token from Primary Master: ${PRIMARY_MASTER_IP}"
K3S_TOKEN=$(ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${SSH_USER}@${PRIMARY_MASTER_IP}" "sudo cat /var/lib/rancher/k3s/server/node-token")

if [ -z "${K3S_TOKEN}" ]; then
    log_error "Failed to retrieve K3s token. Exiting."
    exit 1
fi
log_info "K3s Token retrieved successfully."

# 3. Install K3s on the HA Master Node
log_info "Installing K3s on HA Master: ${HA_MASTER_IP}"
execute_remote "${HA_MASTER_IP}" \
    "curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=${K3S_VERSION} K3S_TOKEN=${K3S_TOKEN} K3S_URL=https://${PRIMARY_MASTER_IP}:6443 sh -s - server"

# Give K3s some time to initialize on HA master
log_info "Waiting for K3s to initialize on HA Master..."
sleep 30

# 4. Install K3s on Worker Nodes
log_info "Installing K3s on Worker Nodes..."
for WORKER_IP in "${WORKER_IPS[@]}"; do
    log_info "Installing K3s on Worker: ${WORKER_IP}"
    execute_remote "${WORKER_IP}" \
        "curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=${K3S_VERSION} K3S_TOKEN=${K3S_TOKEN} K3S_URL=https://${PRIMARY_MASTER_IP}:6443 sh -s - agent"
    sleep 10 # Give some time between worker installations
done

log_info "K3s cluster installation script finished."
log_info "You can now connect to your cluster from the primary master node (${PRIMARY_MASTER_IP}) or any machine with kubectl configured."
log_info "To check cluster status, SSH to ${PRIMARY_MASTER_IP} and run: sudo kubectl get nodes"
log_info "Or, copy the kubeconfig file to your local machine:"
log_info "scp ${SSH_USER}@${PRIMARY_MASTER_IP}:/etc/rancher/k3s/k3s.yaml ~/.kube/config"
log_info "Then, modify ~/.kube/config to replace 127.0.0.1 with ${PRIMARY_MASTER_IP}"
log_info "And set permissions: chmod 600 ~/.kube/config"
log_info "Then run: kubectl get nodes"
