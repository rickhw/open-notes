
## CPU

```bash
root@gtlab01:~# sysbench --threads=8 --time=60 cpu run
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

Running the test with following options:
Number of threads: 8
Initializing random number generator from current time


Prime numbers limit: 10000

Initializing worker threads...

Threads started!

CPU speed:
    events per second: 28757.53

General statistics:
    total time:                          60.0003s
    total number of events:              1725479

Latency (ms):
         min:                                    0.19
         avg:                                    0.28
         max:                                    2.45
         95th percentile:                        0.29
         sum:                               479761.72

Threads fairness:
    events (avg/stddev):           215684.8750/86.43
    execution time (avg/stddev):   59.9702/0.00
```


## Memory Read

```bash
root@gtlab01:~# sysbench --threads=8 --time=60 memory run
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

Total operations: 104857600 (20099672.19 per second)

102400.00 MiB transferred (19628.59 MiB/sec)


General statistics:
    total time:                          5.2164s
    total number of events:              104857600

Latency (ms):
         min:                                    0.00
         avg:                                    0.00
         max:                                    0.08
         95th percentile:                        0.00
         sum:                                32058.37

Threads fairness:
    events (avg/stddev):           13107200.0000/0.00
    execution time (avg/stddev):   4.0073/0.02
```


## Memeory Write

```bash
root@gtlab01:~# sysbench --threads=8 --time=60 memory --memory-oper=write run
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

Total operations: 104857600 (19291329.57 per second)

102400.00 MiB transferred (18839.19 MiB/sec)


General statistics:
    total time:                          5.4349s
    total number of events:              104857600

Latency (ms):
         min:                                    0.00
         avg:                                    0.00
         max:                                    0.08
         95th percentile:                        0.00
         sum:                                33794.27

Threads fairness:
    events (avg/stddev):           13107200.0000/0.00
    execution time (avg/stddev):   4.2243/0.02
```


## I/O create

```bash
root@gtlab01:~# sysbench --threads=8 --time=60 --file-total-size=5G fileio prepare
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

128 files, 40960Kb each, 5120Mb total
Creating files for the test...
Extra file open flags: (none)
Creating file test_file.0
Creating file test_file.1
Creating file test_file.2
Creating file test_file.3

Creating file test_file.121
Creating file test_file.122
Creating file test_file.123
Creating file test_file.124
Creating file test_file.125
Creating file test_file.126
Creating file test_file.127
5368709120 bytes written in 4.91 seconds (1043.23 MiB/sec).
```



## Disk I/O: Random R/W

```bash
root@gtlab01:~# sysbench --threads=8 --time=60 --file-total-size=5G --file-test-mode=rndrw fileio run
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
    reads/s:                      4550.64
    writes/s:                     3033.76
    fsyncs/s:                     9724.17

Throughput:
    read, MiB/s:                  71.10
    written, MiB/s:               47.40

General statistics:
    total time:                          60.0702s
    total number of events:              1038713

Latency (ms):
         min:                                    0.00
         avg:                                    0.46
         max:                                   13.18
         95th percentile:                        1.39
         sum:                               479642.47

Threads fairness:
    events (avg/stddev):           129839.1250/1536.20
    execution time (avg/stddev):   59.9553/0.00

```

