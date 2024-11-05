
以下是使用 tar.gz 檔案在 Ubuntu 20.04 安裝單一 Elasticsearch 節點和 Kibana 的步驟，適用於 Java 17。

### 1. 安裝前準備

首先，確保 Java 17 已安裝，並且 `JAVA_HOME` 已設置正確。

```bash
java -version
```

確認輸出包含 `openjdk version "17"` 或相應版本。

### 2. 下載 Elasticsearch 和 Kibana

到 [Elastic 官方網站](https://www.elastic.co/downloads) 下載最新的 Elasticsearch 和 Kibana tar.gz 檔案。

```bash
# 下載 Elasticsearch
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-<version>-linux-x86_64.tar.gz

# 下載 Kibana
wget https://artifacts.elastic.co/downloads/kibana/kibana-<version>-linux-x86_64.tar.gz
```

請將 `<version>` 替換為最新版本號。

### 3. 解壓縮

```bash
# 解壓 Elasticsearch
tar -xzf elasticsearch-<version>-linux-x86_64.tar.gz

# 解壓 Kibana
tar -xzf kibana-<version>-linux-x86_64.tar.gz
```

### 4. 設定 Elasticsearch

進入解壓後的 Elasticsearch 目錄，進行基本配置：

```bash
cd elasticsearch-<version>
```

打開並編輯 `config/elasticsearch.yml` 文件，設置單一節點模式：

```yaml
# config/elasticsearch.yml
cluster.name: "my-elasticsearch-cluster"
node.name: "node-1"
network.host: "0.0.0.0"     # 允許外部連線
discovery.type: single-node  # 單一節點模式
```

### 5. 啟動 Elasticsearch

在 Elasticsearch 目錄中執行以下命令：

```bash
./bin/elasticsearch
```

請確認 Elasticsearch 已正常運行，並在瀏覽器中訪問 `http://localhost:9200`，應看到 Elasticsearch 的 JSON 歡迎頁。

### 6. 設定 Kibana

進入解壓後的 Kibana 目錄並設定基本配置：

```bash
cd kibana-<version>
```

打開並編輯 `config/kibana.yml` 文件，設定 Elasticsearch 連線位址：

```yaml
# config/kibana.yml
server.host: "0.0.0.0"
elasticsearch.hosts: ["http://localhost:9200"]
```

### 7. 啟動 Kibana

在 Kibana 目錄中執行以下命令：

```bash
./bin/kibana
```

接著，打開瀏覽器並訪問 `http://localhost:5601`，應能看到 Kibana 的介面。

### 8. 設定開機啟動 (可選)

如需開機自動啟動，可以考慮設置開機服務，或將命令加入到啟動腳本中。

