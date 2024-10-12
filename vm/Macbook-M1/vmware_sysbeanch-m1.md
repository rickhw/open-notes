
## CPU

```bash
~$ sysbench --threads=8 --time=60 cpu run
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

Running the test with following options:
Number of threads: 8
Initializing random number generator from current time


Prime numbers limit: 10000

Initializing worker threads...

Threads started!

CPU speed:
    events per second: 63873.44

General statistics:
    total time:                          60.0003s
    total number of events:              3832463

Latency (ms):
         min:                                    0.12
         avg:                                    0.12
         max:                                   17.81
         95th percentile:                        0.14
         sum:                               478750.51

Threads fairness:
    events (avg/stddev):           479057.8750/571.21
    execution time (avg/stddev):   59.8438/0.00

```



## Memory Read

```bash
~$ sysbench --threads=8 --time=60 memory run
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

Total operations: 104857600 (7952600.30 per second)

102400.00 MiB transferred (7766.21 MiB/sec)


General statistics:
    total time:                          13.1848s
    total number of events:              104857600

Latency (ms):
         min:                                    0.00
         avg:                                    0.00
         max:                                   14.94
         95th percentile:                        0.00
         sum:                                80218.37

Threads fairness:
    events (avg/stddev):           13107200.0000/0.00
    execution time (avg/stddev):   10.0273/0.02

```


## Memory Write

```bash
~$ sysbench --threads=8 --time=60 memory --memory-oper=write run
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

Total operations: 104857600 (4825686.79 per second)

102400.00 MiB transferred (4712.58 MiB/sec)


General statistics:
    total time:                          21.7284s
    total number of events:              104857600

Latency (ms):
         min:                                    0.00
         avg:                                    0.00
         max:                                   18.27
         95th percentile:                        0.00
         sum:                               122145.93

Threads fairness:
    events (avg/stddev):           13107200.0000/0.00
    execution time (avg/stddev):   15.2682/0.93

```


---

## I/O write


```bash
~$ sysbench --threads=8 --time=60 --file-total-size=5G fileio prepare
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
...
Creating file test_file.124
Creating file test_file.125
Creating file test_file.126
Creating file test_file.127
5368709120 bytes written in 3.14 seconds (1630.82 MiB/sec).
```



## I/O random R/W


```bash
~$ sysbench --threads=8 --time=60 --file-total-size=5G --file-test-mode=rndrw fileio run
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
    reads/s:                      39626.36
    writes/s:                     26417.52
    fsyncs/s:                     84550.20

Throughput:
    read, MiB/s:                  619.16
    written, MiB/s:               412.77

General statistics:
    total time:                          64.5913s
    total number of events:              9726590

Latency (ms):
         min:                                    0.00
         avg:                                    0.05
         max:                                30425.01
         95th percentile:                        0.18
         sum:                               506539.48

Threads fairness:
    events (avg/stddev):           1215823.7500/5050.09
    execution time (avg/stddev):   63.3174/0.02

```


