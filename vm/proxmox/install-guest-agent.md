
https://pve.proxmox.com/wiki/Qemu-guest-agent

步驟：

1. sudo apt install qemu-guest-agent
2. qm set 100 --agent enabled=1
3. qm shutdown 301; qm start 301 (不是 reboot)


sudo systemctl enable qemu-guest-agent
sudo systemctl start qemu-guest-agent
sudo systemctl status qemu-guest-agent


---
你遇到的訊息是：

```
The unit files have no installation config... not meant to be enabled or disabled using systemctl.
```

這是因為 **`qemu-guest-agent.service` 是設計成手動啟動或由虛擬化平台動態啟動的 service**，而非使用 `systemctl enable` 方式在開機自動啟動。

---

## ✅ 正確的做法

你不需要 `enable`，而是該用：

```bash
sudo systemctl start qemu-guest-agent
```

並確保它 **持續執行中**：

```bash
sudo systemctl status qemu-guest-agent
```

---

## 🔍 為什麼不能 `enable`？

該服務的 `.service` 檔案（通常位於 `/lib/systemd/system/qemu-guest-agent.service`）**缺少 `[Install]` 區塊**，代表它不是預期要用 `systemctl enable` 來設成開機自動啟動的服務。

但實際上，**QEMU / Proxmox 會在 VM 啟動時自動叫用它**，只要 service 在 VM 裡可用、可啟動，就能運作。

---

## ✅ 確認安裝與功能

### 1. 安裝（Ubuntu）

```bash
sudo apt update
sudo apt install qemu-guest-agent
```

### 2. 啟動

```bash
sudo systemctl start qemu-guest-agent
```

### 3. 檢查狀態

```bash
sudo systemctl status qemu-guest-agent
```

應該看到類似：

```
● qemu-guest-agent.service - QEMU Guest Agent
   Loaded: loaded (/lib/systemd/system/qemu-guest-agent.service; static)
   Active: active (running)
```

---

## 🧪 在 Proxmox 驗證是否正常

1. 在 VM 設定裡確認「**QEMU Guest Agent**」已啟用（`Options → QEMU Guest Agent → Enabled`）。
2. 回到 Proxmox 主介面，查看：

   * IP 位址欄是否能自動顯示 VM 的內部 IP
   * 使用 `qm agent 100 ping` 測試 VM 的 Guest Agent 回應（假設 VM ID 是 100）

---

## 💡 若仍想開機自動啟動（雖不建議）

你也可以自己建立 symlink，但這通常沒必要：

```bash
sudo systemctl edit qemu-guest-agent
```

然後手動加入：

```ini
[Install]
WantedBy=multi-user.target
```

儲存後再執行：

```bash
sudo systemctl enable qemu-guest-agent
```

---

## 📌 結論

| 行為             | 建議                                |
| -------------- | --------------------------------- |
| 安裝 guest agent | ✅ 使用 apt 安裝                       |
| 開機啟動           | ⚠️ 不需要 `enable`，只要 `start`        |
| 驗證             | ✅ Proxmox 顯示 IP、自動互動              |
| 若要強制 enable    | 可用 `systemctl edit` 加 `[Install]` |

需要我幫你寫一個 Proxmox + cloud-init + guest-agent 自動化建 VM 的 script 嗎？



---

ubuntu@gtapp301:~$ sudo systemctl status qemu-guest-agent
[sudo] password for ubuntu:
○ qemu-guest-agent.service - QEMU Guest Agent
     Loaded: loaded (/usr/lib/systemd/system/qemu-guest-agent.service; enabled; preset: enabled)
    Drop-In: /etc/systemd/system/qemu-guest-agent.service.d
             └─override.conf
     Active: inactive (dead)

Jul 12 23:48:10 gtapp301 systemd[1]: Dependency failed for qemu-guest-agent.service - QEMU Guest Agent.
Jul 12 23:48:10 gtapp301 systemd[1]: qemu-guest-agent.service: Job qemu-guest-agent.service/start failed with result 'dependency'.




---

你目前的狀況是：

```
qemu-guest-agent.service: Job ... failed with result 'dependency'.
Active: inactive (dead)
```

這代表 **guest agent service 仍然找不到所需的 virtio 裝置 `/dev/virtio-ports/org.qemu.guest_agent.0`**，所以無法啟動。

這是 VM 設定層的問題，請依照以下步驟確認與修復。

---

## ✅ 解法總整理：讓 qemu-guest-agent 成功啟動的最小必要條件

---

### ✅ 1. 【在 Proxmox 中啟用 guest agent】

執行以下指令（假設 VM ID 是 `301`）：

```bash
qm set 301 --agent enabled=1
```

這會在 VM 的 QEMU 設定中加上：

* `-device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0`
* `-chardev socket,id=qga0,path=/var/run/qemu-server/301.qga,server,nowait`

這是 Ubuntu guest 內部會找的裝置。

---

### ✅ 2. 【關機再開機】（⚠️ 必須關機，不是 reboot）

```bash
qm shutdown 301
qm start 301
```

**原因：QEMU 裝置需要在冷開機階段才會掛載到 `/dev/virtio-ports/`**

---

### ✅ 3. 【進入 VM，重新啟動 guest agent】

```bash
sudo systemctl restart qemu-guest-agent
sudo systemctl status qemu-guest-agent
```

預期你會看到：

```
Active: active (running)
```

---

### 🔍 4. 【驗證 guest agent 與 Proxmox 溝通】

```bash
qm agent 301 ping
```

應該會有成功回應。

---

## 🧪 驗證 `/dev/virtio-ports/org.qemu.guest_agent.0` 是否存在

在 VM 中執行：

```bash
ls -l /dev/virtio-ports/
```

應該會看到：

```
crw------- 1 root root  245, 0 Jul 12 23:57 org.qemu.guest_agent.0
```

如果這個裝置不存在，代表 **Proxmox 還沒正確提供給 VM** → 請重檢 `qm set ... --agent enabled=1` 並確保是從「關機 → 再開機」。

---

## 🔁 如果你有覆寫過 systemd 的 override.conf

你的訊息中顯示有：

```
Drop-In: /etc/systemd/system/qemu-guest-agent.service.d/override.conf
```

建議檢查它內容是否阻擋啟動：

```bash
cat /etc/systemd/system/qemu-guest-agent.service.d/override.conf
```

如果有奇怪的 `Requires=` 或 `ConditionPathExists=` 等設定，可以先備份後移除：

```bash
sudo mv /etc/systemd/system/qemu-guest-agent.service.d/override.conf ~/override.bak
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl restart qemu-guest-agent
```

---

## ✅ 總結檢查清單

| 項目                                                   | 狀態 |
| ---------------------------------------------------- | -- |
| Proxmox 啟用 guest agent `qm set ID --agent enabled=1` | ✅  |
| VM 完整「關機 → 開機」                                       | ✅  |
| VM 中出現 `/dev/virtio-ports/org.qemu.guest_agent.0`    | ✅  |
| `qemu-guest-agent.service` 為 `active (running)`      | ✅  |
| 無覆蓋異常的 systemd override.conf                         | ✅  |

---

完成以上步驟後，問題應該會解決。如果你希望我幫你寫一個 Proxmox + Cloud-Init + Guest Agent 自動化 VM 建置腳本，也可以告訴我 VM 設定需求（IP、用戶、映像等），我可以幫你整合。
