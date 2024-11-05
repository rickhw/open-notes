
要讓 Elasticsearch 和 Kibana 透過 `systemctl` 啟動，我們可以建立自定義的 Systemd 服務。以下是在 Ubuntu 20.04 上進行設定的步驟。

### 1. 創建 Elasticsearch 的 Systemd 服務

1. 首先，找到 Elasticsearch 的解壓路徑。假設是 `/path/to/elasticsearch-<version>`。
   
2. 創建一個 Systemd 服務單元文件：

   ```bash
   sudo nano 
   ```

3. 將以下內容加入到 `elasticsearch.service` 中：

   ```ini
   [Unit]
   Description=Elasticsearch
   Documentation=https://www.elastic.co
   Wants=network-online.target
   After=network-online.target

   [Service]
   Type=simple
   User=<your_user>                    # 請替換為您的使用者名稱
   Group=<your_user>
   ExecStart=/path/to/elasticsearch-<version>/bin/elasticsearch
   Restart=on-failure
   RestartSec=5s
   LimitNOFILE=65535
   Environment=JAVA_HOME=/path/to/java  # 請替換為您的 JAVA_HOME 路徑

   [Install]
   WantedBy=multi-user.target
   ```

   **注意：**
   - 將 `<your_user>` 替換為實際的使用者名稱。
   - 將 `/path/to/elasticsearch-<version>` 替換為 Elasticsearch 安裝目錄。
   - 將 `JAVA_HOME` 設置為您 Java 17 的路徑，例如 `/usr/lib/jvm/java-17-openjdk`.

4. 重新載入 Systemd 來使新服務可用：

   ```bash
   sudo systemctl daemon-reload
   ```

5. 啟動並設定 Elasticsearch 服務為開機啟動：

   ```bash
   sudo systemctl start elasticsearch
   sudo systemctl enable elasticsearch
   ```

6. 驗證服務狀態：

   ```bash
   sudo systemctl status elasticsearch
   ```

### 2. 創建 Kibana 的 Systemd 服務

1. 找到 Kibana 的解壓路徑，例如 `/path/to/kibana-<version>`。

2. 創建一個 Systemd 服務單元文件：

   ```bash
   sudo nano /etc/systemd/system/kibana.service
   ```

3. 將以下內容加入到 `kibana.service` 中：

   ```ini
   [Unit]
   Description=Kibana
   Documentation=https://www.elastic.co
   Wants=network-online.target
   After=network-online.target

   [Service]
   Type=simple
   User=<your_user>                     # 替換為您的使用者名稱
   Group=<your_user>
   ExecStart=/path/to/kibana-<version>/bin/kibana
   Restart=on-failure
   RestartSec=5s
   LimitNOFILE=65535

   [Install]
   WantedBy=multi-user.target
   ```

   **注意：**
   - 同樣地，將 `<your_user>` 替換為實際的使用者名稱。
   - 將 `/path/to/kibana-<version>` 替換為 Kibana 安裝目錄。

4. 重新載入 Systemd：

   ```bash
   sudo systemctl daemon-reload
   ```

5. 啟動並設定 Kibana 服務為開機啟動：

   ```bash
   sudo systemctl start kibana
   sudo systemctl enable kibana
   ```

6. 驗證服務狀態：

   ```bash
   sudo systemctl status kibana
   ```

完成後，Elasticsearch 和 Kibana 應會在系統啟動時自動啟動，並可透過 `systemctl` 指令來管理。