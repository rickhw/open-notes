#!/bin/bash

# K3s Cluster Configuration
# This file contains the IP addresses and SSH user for the K3s cluster nodes.
# It is sourced by both install_k3s_cluster.sh and uninstall_k3s_cluster.sh.

PRIMARY_MASTER_IP="192.168.5.36"
HA_MASTER_IP="192.168.5.28"
WORKER_IPS=("192.168.5.243" "192.168.5.56" "192.168.5.121")
SSH_USER="ubuntu"

# K3s version (can be changed if needed)
K3S_VERSION="v1.29.4+k3s1"
