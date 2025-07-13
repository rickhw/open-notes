當你使用 Proxmox **template** 克隆 Ubuntu 24.04 虛擬機時，網路介面的 MAC 位址可能相同，導致 DHCP 伺服器分配相同的 IP，或者 Ubuntu 內部的 DHCP 記錄沒有更新，導致 IP 衝突。你可以透過以下方式來 **renew IP** 並確保每個 VM 都獲得獨立的 IP。

---

## **1. 釋放並重新請求 DHCP IP**
在 **Ubuntu 24.04 Guest OS** 中執行：
```bash
sudo apt update
sudo apt install isc-dhcp-client -y

sudo dhclient -r
sudo dhclient
```
這將強制釋放當前的 DHCP 設定並請求新的 IP。

如果使用 `systemd-networkd`（適用於 Ubuntu Server），可使用：
```bash
sudo systemctl restart systemd-networkd
```

---

## **2. 確保 `/etc/machine-id` 唯一**
當你從 **Proxmox Template Clone** 時，`/etc/machine-id` 可能與模板相同，導致 DHCP 伺服器認為是相同機器，因此分配相同的 IP。

### **步驟**
1. **清除舊的 `machine-id`**
   ```bash
   sudo rm -f /etc/machine-id
   sudo systemd-machine-id-setup
   ```
2. **重新啟動 VM**
   ```bash
   sudo reboot
   ```

這樣 Ubuntu 會重新生成一個獨特的 `machine-id`，確保 DHCP 正確分配 IP。

---

## **3. 刪除舊的 DHCP Lease 記錄**
如果你的 VM 仍然拿到相同 IP，可能是因為 DHCP 記錄仍然記得舊的 MAC 地址。

### **手動刪除 DHCP lease**
```bash
sudo rm -f /var/lib/dhcp/dhclient*.lease
sudo systemctl restart networking
```

如果你的網路使用 `netplan`，請執行：
```bash
sudo netplan apply
```

---

## **4. 檢查並修改 MAC 位址**
如果克隆的 VM 仍然獲得相同的 IP，你可能需要確保每個 VM **有唯一的 MAC 地址**。在 **Proxmox Web UI**：
1. **進入 VM 設定**
2. **選擇「Hardware」**
3. **找到「Network Device」並編輯**
4. **選擇「Generate Random MAC」**（或手動輸入一個新的 MAC 位址）
5. **保存並重新啟動 VM**

在 **Ubuntu 內部** 也可以手動更改：
```bash
sudo ip link set eth0 down
sudo ip link set eth0 address 00:16:3E:xx:xx:xx
sudo ip link set eth0 up
```
**注意**：`00:16:3E` 是 Xen 虛擬 MAC 地址範圍，可改為其他值。

---

## **5. 重建 `netplan` 設定**
如果仍然無法獲得新 IP，試試這個方式：
```bash
sudo rm -f /etc/netplan/50-cloud-init.yaml
sudo netplan generate
sudo netplan apply
```

---

### **總結**
1. **釋放並重新請求 DHCP IP**
2. **確保 `/etc/machine-id` 唯一**
3. **刪除舊的 DHCP Lease 記錄**
4. **檢查 & 變更 MAC 位址**
5. **重新生成 `netplan` 設定**

這樣應該能夠確保你的克隆 VM 獲得新的 IP 🎯🚀


sudo hostnamectl set-hostname gtapp301