

API_TOKEN=""
USER_NAME="root@pam"
HOST_NAME=""


curl -s -k -X POST "https://${HOST_NAME}:8006/api2/json/access/ticket" \
     -d "username=${USER_NAME}" -d "password=${API_TOKEN}" | jq .


curl -s -k -X POST "https://192.168.0.1:8006/api2/json/nodes/node1/qemu" \
     -H "Authorization: PVEAuthCookie=PVE:xxxxx" \
     -H "CSRFPreventionToken: yyyyy" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -d "vmid=100" \
     -d "name=test-vm" \
     -d "memory=2048" \
     -d "cores=2" \
     -d "sockets=1" \
     -d "net0=virtio,bridge=vmbr0" \
     -d "ostype=l26" \
     -d "ide0=local:iso/ubuntu-22.04.iso,media=cdrom" \
     -d "scsihw=virtio-scsi-pci" \
     -d "ide2=local-lvm:32,format=qcow2"
