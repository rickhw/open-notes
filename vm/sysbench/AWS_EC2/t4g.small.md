
2core, 2G

## CPU

```bash
ubuntu@ip-172-31-5-179:~$ sysbench --threads=2 --time=60 cpu run
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

Running the test with following options:
Number of threads: 2
Initializing random number generator from current time


Prime numbers limit: 10000

Initializing worker threads...

Threads started!

CPU speed:
    events per second:  5569.62

General statistics:
    total time:                          60.0003s
    total number of events:              334187

Latency (ms):
         min:                                    0.35
         avg:                                    0.36
         max:                                    5.25
         95th percentile:                        0.38
         sum:                               119931.28

Threads fairness:
    events (avg/stddev):           167093.5000/1230.50
    execution time (avg/stddev):   59.9656/0.00
```


## Memory Read

```bash
~$ sysbench --threads=2 --time=60 memory run
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

Running the test with following options:
Number of threads: 2
Initializing random number generator from current time


Running memory speed test with the following options:
  block size: 1KiB
  total size: 102400MiB
  operation: write
  scope: global

Initializing worker threads...

Threads started!

Total operations: 104857600 (4126112.27 per second)

102400.00 MiB transferred (4029.41 MiB/sec)


General statistics:
    total time:                          25.4117s
    total number of events:              104857600

Latency (ms):
         min:                                    0.00
         avg:                                    0.00
         max:                                    2.13
         95th percentile:                        0.00
         sum:                                32337.50

Threads fairness:
    events (avg/stddev):           52428800.0000/0.00
    execution time (avg/stddev):   16.1688/0.01
```

## Memory Write

```bash
~$ sysbench --threads=2 --time=60 memory --memory-oper=write run
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

Running the test with following options:
Number of threads: 2
Initializing random number generator from current time


Running memory speed test with the following options:
  block size: 1KiB
  total size: 102400MiB
  operation: write
  scope: global

Initializing worker threads...

Threads started!

Total operations: 104857600 (4060966.23 per second)

102400.00 MiB transferred (3965.79 MiB/sec)


General statistics:
    total time:                          25.8194s
    total number of events:              104857600

Latency (ms):
         min:                                    0.00
         avg:                                    0.00
         max:                                    0.50
         95th percentile:                        0.00
         sum:                                33120.42

Threads fairness:
    events (avg/stddev):           52428800.0000/0.00
    execution time (avg/stddev):   16.5602/0.01

```


## Disk I/O: Write

```bash
~$ sysbench --threads=2 --time=60 --file-total-size=5G fileio prepare
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

128 files, 40960Kb each, 5120Mb total
Creating files for the test...
Extra file open flags: (none)
Creating file test_file.0
Creating file test_file.1
Creating file test_file.2
Creating file test_file.3
Creating file test_file.4
...
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
5368709120 bytes written in 39.96 seconds (128.11 MiB/sec).
```


## Disk I/O: Random R/W


```bash
~$ sysbench --threads=2 --time=60 --file-total-size=5G --file-test-mode=rndrw fileio run
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

Running the test with following options:
Number of threads: 2
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
    reads/s:                      1828.88
    writes/s:                     1219.23
    fsyncs/s:                     3904.69

Throughput:
    read, MiB/s:                  28.58
    written, MiB/s:               19.05

General statistics:
    total time:                          60.0207s
    total number of events:              417066

Latency (ms):
         min:                                    0.00
         avg:                                    0.29
         max:                                   28.99
         95th percentile:                        0.95
         sum:                               119733.01

Threads fairness:
    events (avg/stddev):           208533.0000/299.00
    execution time (avg/stddev):   59.8665/0.00
```