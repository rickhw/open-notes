
# create

```bash
# 1. 建立 VM 基本資訊（VM ID 9000）
qm create 9000 --name ubuntu-cloudinit \
  --memory 2048 --cores 2 \
  --net0 virtio,bridge=vmbr0

# 2. 匯入 cloud image 成為 VM 磁碟
qm importdisk 9000 noble-server-cloudimg-amd64.img local-lvm

# 3. 設定 VM 使用該磁碟並加入 Cloud-Init 裝置
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0
qm set 9000 --ide2 local-lvm:cloudinit
qm set 9000 --boot c --bootdisk scsi0

# 4. 啟用 QEMU Guest Agent（建議）
qm set 9000 --agent enabled=1

# 5. 設定 Cloud-Init 參數
qm set 9000 \
  --ciuser=ubuntu \
  --cipassword='medusa' \
  --sshkey ~/.ssh/RickdeMBP.pub \
  --ipconfig0 ip=192.168.5.100/24,gw=192.168.5.1 \
  --nameserver 8.8.8.8 \
  --cicustom "user=local:snippets/u2404.yaml"

qm set 9000 \
  --ciuser=ubuntu \
  --cipassword='medusa' \
  --ipconfig0 ip=192.168.5.100/24,gw=192.168.5.1 \
  --nameserver 8.8.8.8 \
  --cicustom "user=local:snippets/u2404.yaml"


qm set 9000 --cicustom "user=local:snippets/u2404.yaml"
```

# stop

qm stop 9000
qm shutdown 9000

# start

~# qm start 9000
generating cloud-init ISO


# destory

root@gtinfra03:/var/lib/vz/snippets# qm destroy 9000
  Logical volume "vm-9000-cloudinit" successfully removed.
  Logical volume "vm-9000-disk-0" successfully removed.