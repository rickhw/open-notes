在 Ubuntu 24.04 上安裝 Prometheus 的 Node Exporter，可以按照以下步驟操作，這會讓你收集該機器的硬體資源（CPU、memory、disk、network）等資訊，供 Prometheus 抓取。

---

### 🧾 安裝步驟：Node Exporter on Ubuntu 24.04

#### 1️⃣ 建立使用者（非必要，但建議）

```bash
useradd --no-create-home --shell /usr/sbin/nologin node_exporter
```

---

#### 2️⃣ 下載 Node Exporter 最新版本

前往 Prometheus 官網或 GitHub Releases 查找最新版本。這邊以 v1.9.1 為例（未來可自行替換成最新版）：

```bash
cd /tmp
wget https://github.com/prometheus/node_exporter/releases/download/v1.9.1/node_exporter-1.9.1.linux-amd64.tar.gz
```

---

#### 3️⃣ 解壓縮並移動執行檔

```bash
tar xvf node_exporter-1.9.1.linux-amd64.tar.gz
mv node_exporter-1.9.1.linux-amd64/node_exporter /usr/local/bin/
```

確認可執行權限：

```bash
chmod +x /usr/local/bin/node_exporter
```

---

#### 4️⃣ 建立 Systemd 服務單元檔案

```bash
vi /etc/systemd/system/node_exporter.service
```

填入以下內容：

```ini
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=default.target
```

---

#### 5️⃣ 啟動並設定開機啟動

```bash
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter
```

確認是否成功啟動：

```bash
systemctl status node_exporter
```

---

#### 6️⃣ 驗證是否可存取（預設 port 9100）

從本機或其他機器使用 curl 或瀏覽器打開：

```bash
curl http://localhost:9100/metrics
```

如果你希望從遠端抓取，請開啟防火牆或確認對外網路是否允許 port `9100`。

---

### ✅ Prometheus 設定範例（加進 `prometheus.yml`）

```yaml
  - job_name: "node_exporter"
    static_configs:
      - targets: ["192.168.1.100:9100"]
```

---

如果你要搭配 Grafana 使用，可以導入官方的 dashboard：

* [Node Exporter Full - Grafana Dashboard](https://grafana.com/grafana/dashboards/1860-node-exporter-full/)

---

是否需要我幫你做成 `.deb` 安裝、或用 Docker 跑？也可以提供完整 Prometheus + Grafana 的整合流程。
