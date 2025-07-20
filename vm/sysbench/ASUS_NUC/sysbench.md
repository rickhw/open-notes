

## CPU

```bash
root@gtinfra01:~# sysbench --threads=8 --time=60 cpu run
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

Running the test with following options:
Number of threads: 8
Initializing random number generator from current time


Prime numbers limit: 10000

Initializing worker threads...

Threads started!


CPU speed:
    events per second: 29223.81

General statistics:
    total time:                          60.0004s
    total number of events:              1753472

Latency (ms):
         min:                                    0.26
         avg:                                    0.27
         max:                                    2.07
         95th percentile:                        0.31
         sum:                               479821.72

Threads fairness:
    events (avg/stddev):           219184.0000/9081.29
    execution time (avg/stddev):   59.9777/0.00
```


## Memory Read

```bash
root@gtinfra01:~# sysbench --threads=8 --time=60 memory run
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

Running the test with following options:
Number of threads: 8
Initializing random number generator from current time


Running memory speed test with the following options:
  block size: 1KiB
  total size: 102400MiB
  operation: write
  scope: global

Initializing worker threads...

Threads started!

Total operations: 104857600 (13322052.08 per second)

102400.00 MiB transferred (13009.82 MiB/sec)


General statistics:
    total time:                          7.8700s
    total number of events:              104857600

Latency (ms):
         min:                                    0.00
         avg:                                    0.00
         max:                                    0.56
         95th percentile:                        0.00
         sum:                                51229.51

Threads fairness:
    events (avg/stddev):           13107200.0000/0.00
    execution time (avg/stddev):   6.4037/0.11
```

這份報告是使用 `sysbench` 進行 **記憶體效能測試** 的結果，主要是測量 **記憶體寫入速度（write throughput）**。以下是詳細說明與摘要：

---

## 🧾 測試指令解析

```bash
sysbench --threads=8 --time=60 memory run
```

* `--threads=8`：使用 8 條執行緒進行測試（模擬 8 核心）
* `--time=60`：最大執行時間設定為 60 秒，但實際完成在 7.87 秒內
* `memory run`：執行記憶體測試（預設為寫入 `write`）

---

## 📌 測試設定細節

```
block size: 1KiB
total size: 102400MiB
operation: write
scope: global
```

| 項目         | 說明                           |
| ---------- | ---------------------------- |
| block size | 每次操作寫入 1 KiB 的資料             |
| total size | 總寫入資料量 102400 MiB（= 100 GiB） |
| operation  | 寫入測試（非讀取）                    |
| scope      | 全域測試，所有執行緒共享記憶體區塊            |

---

## 📈 測試結果重點

### ✅ 記憶體吞吐量

```
Total operations: 104857600 (13322052.08 per second)
102400.00 MiB transferred (13009.82 MiB/sec)
```

* **總寫入次數**：104,857,600 次，每次 1 KiB，共約 100 GiB 資料
* **每秒處理事件數**：13,322,052 次（= 13M IOPS 級別）
* **實際寫入速率**：**13,009.82 MiB/s** ≈ **13 GB/s**

> 🔥 這表示你的記憶體（或記憶體與 CPU 的資料通道）每秒可以持續寫入超過 **13 GB** 的資料，屬於非常高的水準，適合大型資料處理或高頻資料移動需求。

---

### ⏱️ Latency（延遲）

```
min: 0.00 ms
avg: 0.00 ms
max: 0.56 ms
95th percentile: 0.00 ms
sum: 51229.51 ms
```

* 幾乎所有的記憶體寫入延遲都小於 1 毫秒，**平均為 0 ms**
* 最大延遲 0.56 ms，極為穩定

> 🔍 延遲接近「零」，代表系統記憶體對寫入的即時反應能力極高。

---

### 👥 Threads Fairness（多執行緒公平性）

```
events (avg/stddev): 13107200.0000/0.00
execution time (avg/stddev): 6.4037/0.11
```

| 項目       | 說明                       |
| -------- | ------------------------ |
| 每個執行緒事件數 | 每條執行緒平均完成 13,107,200 次寫入 |
| 執行時間     | 平均每條執行緒大約執行了 6.4 秒       |
| 標準差極小    | 顯示 8 執行緒工作量分配非常平均，沒有明顯瓶頸 |

---

## 🧠 總結評估

| 指標類別    | 結果              | 說明                        |
| ------- | --------------- | ------------------------- |
| 記憶體吞吐量  | 💪 13 GB/s      | 相當於 DDR5 / LPDDR5 高速記憶體級別 |
| 延遲表現    | 👍 極低延遲，幾乎 0 ms | 適合即時運算、低延遲應用場景            |
| 多執行緒均衡性 | ✅ 完全平均          | 無明顯核心爭用或偏差                |
| 整體效能    | 🔥 非常強大         | 輕鬆應付多執行緒高速資料處理需求          |

---

## 🧪 想進一步？

你可以：

* 改成 `--memory-oper=read` 測試記憶體讀取速度
* 增加 `--memory-block-size=64K` 模擬大區塊 I/O 應用
* 使用 `--memory-access-mode=rnd` 模擬隨機存取模式（更接近真實工作負載）

---

需要我幫你產生 read/write 綜合測試腳本？還是與其他機器做對比分析？




## Memeory Write

```bash
root@gtinfra01:~# sysbench --threads=8 --time=60 memory --memory-oper=write run
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

Running the test with following options:
Number of threads: 8
Initializing random number generator from current time


Running memory speed test with the following options:
  block size: 1KiB
  total size: 102400MiB
  operation: write
  scope: global

Initializing worker threads...

Threads started!

Total operations: 104857600 (13147783.71 per second)

102400.00 MiB transferred (12839.63 MiB/sec)


General statistics:
    total time:                          7.9745s
    total number of events:              104857600

Latency (ms):
         min:                                    0.00
         avg:                                    0.00
         max:                                    0.47
         95th percentile:                        0.00
         sum:                                51999.66

Threads fairness:
    events (avg/stddev):           13107200.0000/0.00
    execution time (avg/stddev):   6.5000/0.11
```


## I/O create

```bash
root@gtinfra01:~# sysbench --threads=8 --time=60 --file-total-size=5G fileio prepare
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

128 files, 40960Kb each, 5120Mb total
Creating files for the test...
Extra file open flags: (none)
Creating file test_file.0
Creating file test_file.1
Creating file test_file.2
Creating file test_file.3
Creating file test_file.4
Creating file test_file.5
Creating file test_file.6
Creating file test_file.7
Creating file test_file.8
Creating file test_file.9
Creating file test_file.10
Creating file test_file.11
Creating file test_file.12
Creating file test_file.13
Creating file test_file.14
Creating file test_file.15
Creating file test_file.16
Creating file test_file.17
Creating file test_file.18
Creating file test_file.19
Creating file test_file.20
Creating file test_file.21
Creating file test_file.22
Creating file test_file.23
Creating file test_file.24
Creating file test_file.25
Creating file test_file.26
Creating file test_file.27
Creating file test_file.28
Creating file test_file.29
Creating file test_file.30
Creating file test_file.31
Creating file test_file.32
Creating file test_file.33
Creating file test_file.34
Creating file test_file.35
Creating file test_file.36
Creating file test_file.37
Creating file test_file.38
Creating file test_file.39
Creating file test_file.40
Creating file test_file.41
Creating file test_file.42
Creating file test_file.43
Creating file test_file.44
Creating file test_file.45
Creating file test_file.46
Creating file test_file.47
Creating file test_file.48
Creating file test_file.49
Creating file test_file.50
Creating file test_file.51
Creating file test_file.52
Creating file test_file.53
Creating file test_file.54
Creating file test_file.55
Creating file test_file.56
Creating file test_file.57
Creating file test_file.58
Creating file test_file.59
Creating file test_file.60
Creating file test_file.61
Creating file test_file.62
Creating file test_file.63
Creating file test_file.64
Creating file test_file.65
Creating file test_file.66
Creating file test_file.67
Creating file test_file.68
Creating file test_file.69
Creating file test_file.70
Creating file test_file.71
Creating file test_file.72
Creating file test_file.73
Creating file test_file.74
Creating file test_file.75
Creating file test_file.76
Creating file test_file.77
Creating file test_file.78
Creating file test_file.79
Creating file test_file.80
Creating file test_file.81
Creating file test_file.82
Creating file test_file.83
Creating file test_file.84
Creating file test_file.85
Creating file test_file.86
Creating file test_file.87
Creating file test_file.88
Creating file test_file.89
Creating file test_file.90
Creating file test_file.91
Creating file test_file.92
Creating file test_file.93
Creating file test_file.94
Creating file test_file.95
Creating file test_file.96
Creating file test_file.97
Creating file test_file.98
Creating file test_file.99
Creating file test_file.100
Creating file test_file.101
Creating file test_file.102
Creating file test_file.103
Creating file test_file.104
Creating file test_file.105
Creating file test_file.106
Creating file test_file.107
Creating file test_file.108
Creating file test_file.109
Creating file test_file.110
Creating file test_file.111
Creating file test_file.112
Creating file test_file.113
Creating file test_file.114
Creating file test_file.115
Creating file test_file.116
Creating file test_file.117
Creating file test_file.118
Creating file test_file.119
Creating file test_file.120
Creating file test_file.121
Creating file test_file.122
Creating file test_file.123
Creating file test_file.124
Creating file test_file.125
Creating file test_file.126
Creating file test_file.127
5368709120 bytes written in 2.34 seconds (2189.61 MiB/sec).
```


## Disk I/O: Random R/W

```bash
root@gtinfra01:~# sysbench --threads=8 --time=60 --file-total-size=5G --file-test-mode=rndrw fileio run
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

Running the test with following options:
Number of threads: 8
Initializing random number generator from current time


Extra file open flags: (none)
128 files, 40MiB each
5GiB total file size
Block size 16KiB
Number of IO requests: 0
Read/Write ratio for combined random IO test: 1.50
Periodic FSYNC enabled, calling fsync() each 100 requests.
Calling fsync() at the end of test, Enabled.
Using synchronous I/O mode
Doing random r/w test
Initializing worker threads...

Threads started!


File operations:
    reads/s:                      2856.57
    writes/s:                     1904.38
    fsyncs/s:                     6110.28

Throughput:
    read, MiB/s:                  44.63
    written, MiB/s:               29.76

General statistics:
    total time:                          60.0711s
    total number of events:              652033

Latency (ms):
         min:                                    0.00
         avg:                                    0.74
         max:                                    7.82
         95th percentile:                        2.30
         sum:                               479699.47

Threads fairness:
    events (avg/stddev):           81504.1250/1260.27
    execution time (avg/stddev):   59.9624/0.00
```

這是一份使用 `sysbench` 進行的 **隨機讀寫磁碟 I/O 測試（fileio, random read/write）** 的報告，目的是評估系統儲存裝置的隨機存取效能，包括讀、寫、fsync 操作。以下是重點摘要與解釋：

---

## 📌 測試條件概要

| 項目           | 值                                       |
| ------------ | --------------------------------------- |
| 測試模式         | `fileio`，隨機讀寫（`--file-test-mode=rndrw`） |
| 檔案總大小        | 5 GiB（128 個檔案、每個 40 MiB）                |
| I/O block 大小 | 16 KiB                                  |
| 執行緒數         | 8                                       |
| 測試時間         | 60 秒                                    |
| Read/Write 比 | 1.5（大約 60% 讀取、40% 寫入）                   |
| fsync 呼叫頻率   | 每 100 次操作一次 fsync，加上結束後再 fsync          |
| 使用模式         | 同步 I/O（synchronous I/O）                 |

---

## 📊 效能測試結果摘要

### ✅ IOPS 與資料吞吐量

| 類型          | 數值               | 說明                      |
| ----------- | ---------------- | ----------------------- |
| reads/s     | **2,856.57** 次/秒 | 隨機讀 IOPS（越高越好）          |
| writes/s    | **1,904.38** 次/秒 | 隨機寫 IOPS                |
| fsyncs/s    | **6,110.28** 次/秒 | 每秒 fsync 操作次數（確認資料寫入磁碟） |
| read MiB/s  | **44.63 MiB/s**  | 讀取總頻寬                   |
| write MiB/s | **29.76 MiB/s**  | 寫入總頻寬                   |
| ➤ 總吞吐量      | **約 74.4 MiB/s** | 儲存系統實際承載能力              |

---

### ⏱️ Latency（延遲）

| 指標              | 數值         | 解釋                          |
| --------------- | ---------- | --------------------------- |
| min             | 0.00 ms    | 最快的操作延遲                     |
| avg             | 0.74 ms    | 每次操作的平均延遲                   |
| max             | 7.82 ms    | 最慢的操作延遲                     |
| 95th percentile | 2.30 ms    | 有 95% 的操作在 2.3ms 內完成        |
| total sum       | 479,699 ms | 全部操作累計延遲時間（約 8 執行緒 \* 60 秒） |

> 🔍 延遲穩定、可預測，平均值 < 1ms 屬於良好 I/O 效能

---

### 👥 Threads Fairness（執行緒分配公平性）

| 項目             | 數值       | 說明               |
| -------------- | -------- | ---------------- |
| events (avg)   | 81,504 次 | 每個執行緒平均完成事件數     |
| stddev         | 1,260 次  | 差異小，表示分配合理       |
| execution time | 59.96 秒  | 每個執行緒執行時間接近 60 秒 |

---

## 🧠 整體評估

| 評估面向         | 結果與解釋                                                   |
| ------------ | ------------------------------------------------------- |
| **隨機 IOPS**  | 👍 達到 **約 4,760 次/秒**（讀 + 寫），屬於 SATA SSD 水準中上，低於 NVMe   |
| **吞吐量**      | 👍 **約 74 MiB/s**，可支援中度寫入應用（例如日誌寫入、容器操作）                |
| **延遲**       | ✅ 平均 0.74ms，95% 在 2.3ms 內，反應穩定快速                        |
| **fsync 頻率** | ✅ 每秒超過 6,000 次，表示檔案系統性能佳且同步寫入處理快速                       |
| **整體**       | 💪 適合用於 **伺服器 I/O 密集型應用（如 DB, log, container storage）** |

---

## 📝 建議後續測試

你可以再針對以下進行更完整評估：

| 測試項目 | 命令建議                         | 用途說明         |
| ---- | ---------------------------- | ------------ |
| 隨機讀取 | `--file-test-mode=randread`  | 驗證快取或只讀效能    |
| 隨機寫入 | `--file-test-mode=randwrite` | 驗證日誌、寫入場景    |
| 順序寫入 | `--file-test-mode=seqwrite`  | 驗證大檔寫入如影片或備份 |
| 順序讀取 | `--file-test-mode=seqread`   | 驗證大檔載入場景     |

---

如果你提供儲存裝置類型（如 SATA SSD / NVMe / HDD），我可以幫你對照是否符合預期效能水準。需要嗎？
