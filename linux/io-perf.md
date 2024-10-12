在 Linux 中，有多種工具可用來測試 I/O 效能，包括 **IOPS**（每秒輸入/輸出操作數量）和 **Throughput**（吞吐量）。以下是常見的工具與範例：

### 1. **Fio (Flexible I/O Tester)**

**Fio** 是一個非常強大的 I/O 性能測試工具，能夠測試 IOPS、吞吐量、延遲等多種 I/O 指標。以下是一些使用範例。

#### 安裝 Fio

```bash
sudo apt-get install fio    # Ubuntu / Debian
sudo yum install fio        # CentOS / RHEL
```

#### 測試 IOPS 和 Throughput
Fio 可以模擬多種 I/O 工作負載，並生成詳細的 IOPS 和 Throughput 數據。

##### 隨機讀寫 IOPS 測試（4K 隨機讀寫，使用 8 個執行緒）
```bash
fio --name=random_rw --rw=randrw --size=1G --bs=4k --numjobs=8 --time_based --runtime=60 --group_reporting --iodepth=16
```

- **`--rw=randrw`**：隨機讀寫操作
- **`--size=1G`**：測試檔案大小 1GB
- **`--bs=4k`**：區塊大小（4KB）
- **`--numjobs=8`**：使用 8 個並行工作
- **`--time_based --runtime=60`**：持續測試 60 秒
- **`--iodepth=16`**：指定 I/O 深度

輸出會包括 IOPS 和吞吐量的數據。

##### 順序讀寫 Throughput 測試（1M 順序讀寫）
```bash
fio --name=seq_rw --rw=write --size=1G --bs=1M --numjobs=8 --time_based --runtime=60 --group_reporting
```

- **`--rw=write`**：順序寫入操作
- **`--bs=1M`**：區塊大小（1MB）
- **`--numjobs=8`**：使用 8 個並行工作
- **`--time_based --runtime=60`**：持續測試 60 秒

這個測試會生成大區塊的寫入操作，適合測試吞吐量。

### 2. **Iostat (Input/Output Statistics)**

**iostat** 是一個從 `sysstat` 套件中提取的工具，用來監控系統的 I/O 使用情況，包括硬碟的吞吐量和 IOPS。

#### 安裝 iostat

```bash
sudo apt-get install sysstat    # Ubuntu / Debian
sudo yum install sysstat        # CentOS / RHEL
```

#### 使用範例

```bash
iostat -xz 1 5
```

- **`-x`**：顯示詳細模式，包含 I/O 效能數據
- **`-z`**：當 I/O 活動為零時隱藏設備數據
- **`1 5`**：每 1 秒收集一次數據，總共 5 次

輸出會顯示 IOPS（`tps` 欄位）和吞吐量（`kB_read/s` 和 `kB_wrtn/s` 欄位）。

### 3. **Dd (Data Duplicator)**

**dd** 是一個簡單的工具，用來進行大區塊讀寫操作。可以用來粗略測試磁碟的吞吐量。

#### 順序寫入測試
```bash
dd if=/dev/zero of=testfile bs=1M count=1024 oflag=direct
```

- **`if=/dev/zero`**：讀取空數據（全 0）
- **`of=testfile`**：寫入 `testfile`
- **`bs=1M`**：每次寫入 1MB 大小的區塊
- **`count=1024`**：寫入 1024 個區塊，共 1GB
- **`oflag=direct`**：直接寫入，不使用緩存

輸出結果會顯示實際的 Throughput。

#### 順序讀取測試
```bash
dd if=testfile of=/dev/null bs=1M count=1024 iflag=direct
```

這將從磁碟讀取數據，並輸出讀取速度。

### 4. **Bonnie++**

**Bonnie++** 是一個用來測試磁碟效能的工具，可以測量 IOPS 和吞吐量等多項指標。

#### 安裝 Bonnie++
```bash
sudo apt-get install bonnie++    # Ubuntu / Debian
sudo yum install bonnie++        # CentOS / RHEL
```

#### 使用範例

```bash
bonnie++ -d /path/to/test -r 16000 -s 32000 -n 0 -f -b
```

- **`-d /path/to/test`**：指定測試的目錄
- **`-r 16000`**：指定系統的記憶體大小為 16GB
- **`-s 32000`**：創建一個 32GB 的測試檔案（確保比記憶體大）
- **`-n 0`**：不測試文件創建性能
- **`-f -b`**：強制覆寫舊的測試檔案並啟用直接 I/O

這會執行一個大範圍的磁碟效能測試，包含隨機讀寫和順序讀寫。

### 總結
- **Fio** 是最靈活和強大的工具，能夠進行全面的 IOPS 和 Throughput 測試，適合用於各種工作負載模擬。
- **Iostat** 更適合用於持續監控系統的 I/O 活動，適合查看系統運行時的 I/O 效能。
- **Dd** 提供了一個簡單的測試方法，主要用於順序讀寫的吞吐量測試。
- **Bonnie++** 提供了一個更高層次的磁碟效能測試，包括隨機讀寫和順序讀寫測試。

你可以根據自己的需求，選擇合適的工具來測試 Linux 系統中的 I/O 效能。