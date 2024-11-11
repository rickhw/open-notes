



https://github.com/meilisearch/meilisearch


```bash
docker run -it --rm \
  -p 7700:7700 \
  -e MEILI_MASTER_KEY='MASTER_KEY'\
  -v $(pwd)/meili_data:/meili_data \
  getmeili/meilisearch:v1.11

```


```
curl \
  -X POST 'http://localhost:7700/indexes' \
  -H 'Content-Type: application/json' \
  --data-binary '{
    "uid": "movies",
    "primaryKey": "id"
  }'
```


---

## Prompt (Not Ready)

我想用寫個 docker compose 當作基本的 log 分析用途，把 java / springboot 的 log 送到 meilisearch，最後在 grafana 上劃出 metric.

1. 幫我寫一個 docker-compose, 內容主要有 meilisearch, grafana 而且使用最新版 (指定版本，而不是 latest)，同時完成兩者的串接。
  - meilisearch 請指定好 MEILI_MASTER_KEY
  - grafana 請告訴我如何安裝好 JSON API pluging, 指定好 admin password
  - 這個 compose 先不要使用 volume
2. 情提供我如何配置 grafana 以 meilisearch 為 datasource 的指引。
3. 同時提供一個 script, 用來模擬把 log ship to meilisearch, 這個 script 每次執行就送出 500 行 log, log 包含 date time, level, message



## ChatGPT

以下是針對您的需求提供的解決方案，包括 `docker-compose.yaml`、Grafana 設定指引和模擬 log ship 的 script。

---

### 1. `docker-compose.yaml`
我們將使用最新版本的 Meilisearch 和 Grafana，並指定 Meilisearch 的 `MEILI_MASTER_KEY` 和 Grafana 的 `admin` 密碼。

```yaml
version: '3.8'

services:
  meilisearch:
    image: getmeili/meilisearch:v1.1.1 # 使用 Meilisearch 最新版，請依實際最新版本調整
    environment:
      MEILI_MASTER_KEY: "your_master_key" # 設定 Meilisearch 的主密鑰
    ports:
      - "7700:7700"

  grafana:
    image: grafana/grafana:10.1.0 # 使用 Grafana 最新版，請依實際最新版本調整
    environment:
      GF_SECURITY_ADMIN_PASSWORD: "admin_password" # 設定 Grafana 管理員密碼
    ports:
      - "3000:3000"
    depends_on:
      - meilisearch
```

---

### 2. 安裝 JSON API Plugin 及 Grafana 設定指引
在 Grafana 中配置 Meilisearch 需要安裝 [JSON API Plugin](https://grafana.com/grafana/plugins/marcusolsson-json-datasource/)。
以下是詳細步驟：

1. **安裝 JSON API Plugin**
   - 可以在啟動 Grafana 後的管理員面板中安裝：
     - 登入 Grafana (`http://localhost:3000`)，預設帳號為 `admin`，密碼為您在 `docker-compose.yaml` 中指定的密碼。
     - 到 **Configuration** > **Plugins**，搜尋 `JSON API` 插件並安裝。
   - 或者您可以直接用 `GF_INSTALL_PLUGINS` 參數來安裝，在 docker-compose.yaml 中加入：
     ```yaml
     environment:
       - GF_INSTALL_PLUGINS=marcusolsson-json-datasource
     ```

2. **新增 Meilisearch Data Source**
   - 在 Grafana 管理員面板，前往 **Configuration** > **Data Sources**。
   - 選擇 JSON API Plugin，並設定 URL 為 `http://meilisearch:7700`。
   - 在 Headers 中新增 `Authorization`，值設為 `Bearer your_master_key`（這與 `docker-compose.yaml` 中的 `MEILI_MASTER_KEY` 一致）。

3. **創建 Dashboard**
   - 到 Grafana Dashboard 創建頁面，選擇新建的 JSON API Data Source。
   - 在 Queries 中，可以根據您在 Meilisearch 儲存的資料設定搜尋條件與 metrics。

---

### 3. Log Ship Script

以下是一個 Python script，用來模擬 log data 發送至 Meilisearch。此 script 每次執行時會產生並發送 500 筆 log，每筆 log 包含 `date_time`、`level` 和 `message`。

#### `ship_logs.py`

```python
import requests
import random
from datetime import datetime, timedelta

# Meilisearch API 設定
meilisearch_url = "http://localhost:7700/indexes/logs/documents"
headers = {
    "Authorization": "Bearer your_master_key",
    "Content-Type": "application/json"
}

# 隨機產生 log data
def generate_logs(num_logs=500):
    levels = ["INFO", "WARN", "ERROR", "DEBUG"]
    logs = []
    current_time = datetime.now()

    for _ in range(num_logs):
        log_entry = {
            "date_time": (current_time - timedelta(seconds=random.randint(0, 10000))).strftime('%Y-%m-%d %H:%M:%S'),
            "level": random.choice(levels),
            "message": f"Sample log message {_}"
        }
        logs.append(log_entry)

    return logs

# 發送 log data 到 Meilisearch
def send_logs_to_meilisearch(logs):
    response = requests.post(meilisearch_url, headers=headers, json=logs)
    if response.status_code == 202:
        print("Logs successfully sent to Meilisearch.")
    else:
        print("Failed to send logs:", response.text)

# 生成並發送 logs
logs = generate_logs(500)
send_logs_to_meilisearch(logs)
```

#### 使用說明
1. 將 `ship_logs.py` 保存於您的專案中。
2. 在執行此 script 前，確認 Meilisearch 已經啟動，並在其中創建一個名為 `logs` 的索引（或在 Meilisearch 中開啟自動索引創建）。
3. 執行以下命令來運行 script：
   ```bash
   python3 ship_logs.py
   ```

這個 script 會自動產生 500 筆 log，並透過 `POST` 請求將資料發送到 Meilisearch。