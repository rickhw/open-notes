在 Proxmox VE 中使用 **Cloud-Init** 是一種有效的方法，讓你在建立 VM 時快速完成以下初始化工作：

* 設定 hostname
* 設定 root 密碼
* 設定 SSH 公鑰
* 設定靜態 IP（或 DHCP）
* 執行開機初始化 script（User-Data）

---

## ✅ 前提條件

1. **Proxmox VE 版本 ≥ 5.2**（已內建 Cloud-Init 支援）
2. 使用支援 Cloud-Init 的映像檔（如 Ubuntu Cloud Image、AlmaLinux、Debian Cloud 等）

---

## 📦 步驟：使用 Cloud-Init 快速建立 VM

### 1️⃣ 下載 Cloud-Init 映像檔

你可以直接從 Ubuntu 或 Debian 官方網站下載 `.img` 檔：

```bash
# 以 Ubuntu 22.04 為例
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
```

---

### 2️⃣ 將映像檔轉換為 Proxmox 支援格式（QCOW2 → VM 磁碟）

```bash
# 假設要建立 VM ID 9000
qm create 9000 --name ubuntu-cloud --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0

# 將 image 匯入為 VM 的磁碟
qm importdisk 9000 jammy-server-cloudimg-amd64.img local-lvm

# 將該磁碟指定為 boot disk
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0
qm set 9000 --boot c --bootdisk scsi0
```

---

### 3️⃣ 加入 Cloud-Init 裝置

```bash
qm set 9000 --ide2 local-lvm:cloudinit
qm set 9000 --serial0 socket --vga serial0
```

---

### 4️⃣ 設定 Cloud-Init 參數

```bash
qm set 9000 --ciuser rick --cipassword mypassword
qm set 9000 --sshkey ~/.ssh/id_rsa.pub
qm set 9000 --ipconfig0 ip=192.168.100.100/24,gw=192.168.100.1
```

你也可以指定 DHCP：

```bash
qm set 9000 --ipconfig0 ip=dhcp
```

---

### 5️⃣ 建立 Template（可重複 clone 使用）

```bash
qm template 9000
```

這會將 VM 9000 設為模板，你接下來可以快速用這個模板建立新的 VM。

---

### 6️⃣ 用模板 clone 快速建 VM

```bash
qm clone 9000 9100 --name test-vm --full true
qm set 9100 --ipconfig0 ip=192.168.100.101/24,gw=192.168.100.1
qm start 9100
```

這樣 VM 開機後會自動執行 Cloud-Init，把設定套入。

---

## 🧠 延伸用途：設定 User-Data 自定初始化

如果你想要在 VM 啟動後執行 script（例如安裝套件）：

```bash
qm set 9000 --cicustom "user=local:snippets/user-data.yaml"
```

`user-data.yaml` 範例如下：

```yaml
#cloud-config
package_update: true
packages:
  - nginx
runcmd:
  - echo "Hello from Cloud-Init" > /etc/motd
```

---

## 📌 總結

| 步驟               | 說明                                           |
| ---------------- | -------------------------------------------- |
| 下載 Cloud Image   | 官方 QCOW2 檔案（Ubuntu、Debian...）                |
| 匯入磁碟並建立 VM       | 使用 `qm importdisk` 和 `qm create`             |
| 加入 Cloud-Init 裝置 | 使用 `--ide2` 與 `--serial0`                    |
| 設定參數             | 使用 `--ciuser`、`--cipassword`、`--ipconfig0` 等 |
| 建立模板             | `qm template`                                |
| 快速建 VM           | `qm clone` + `qm set` + `qm start`           |
| 進階設定             | 透過 `--cicustom` 指定 user-data script          |

---

如果你希望我幫你產出一個完整範例 script 或 Proxmox GUI 操作說明（附圖），我也可以幫你補上。需要嗎？
