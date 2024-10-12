


## CPU

```bash
~$ sysbench --threads=8 --time=60 cpu run
sysbench 1.0.20 (using system LuaJIT 2.1.1725453128)

Running the test with following options:
Number of threads: 8
Initializing random number generator from current time


Prime numbers limit: 10000

Initializing worker threads...

Threads started!

CPU speed:
    events per second: 88322749.21

General statistics:
    total time:                          60.0001s
    total number of events:              5299393039

Latency (ms):
         min:                                    0.00
         avg:                                    0.00
         max:                                   12.54
         95th percentile:                        0.00
         sum:                               275433.65

Threads fairness:
    events (avg/stddev):           662424129.8750/952996.09
    execution time (avg/stddev):   34.4292/0.27
```

## Memory Read

```bash
~$ sysbench --threads=8 --time=60 memory run
sysbench 1.0.20 (using system LuaJIT 2.1.1725453128)

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

Total operations: 104857600 (5029233.87 per second)

102400.00 MiB transferred (4911.36 MiB/sec)


General statistics:
    total time:                          20.8492s
    total number of events:              104857600

Latency (ms):
         min:                                    0.00
         avg:                                    0.00
         max:                                   14.55
         95th percentile:                        0.00
         sum:                               158271.24

Threads fairness:
    events (avg/stddev):           13107200.0000/0.00
    execution time (avg/stddev):   19.7839/0.02
```

## Memeory Write

```bash
~$ sysbench --threads=8 --time=60 memory --memory-oper=write run
sysbench 1.0.20 (using system LuaJIT 2.1.1725453128)

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

Total operations: 104857600 (4920948.82 per second)

102400.00 MiB transferred (4805.61 MiB/sec)


General statistics:
    total time:                          21.3080s
    total number of events:              104857600

Latency (ms):
         min:                                    0.00
         avg:                                    0.00
         max:                                   17.55
         95th percentile:                        0.00
         sum:                               161804.96

Threads fairness:
    events (avg/stddev):           13107200.0000/0.00
    execution time (avg/stddev):   20.2256/0.02
```



## I/O create

```bash
~$ sysbench --threads=8 --time=60 --file-total-size=5G fileio prepare
sysbench 1.0.20 (using system LuaJIT 2.1.1725453128)

128 files, 40960Kb each, 5120Mb total
Creating files for the test...
Extra file open flags: (none)
Creating file test_file.0
Creating file test_file.1
Creating file test_file.2
Creating file test_file.3
...
Creating file test_file.121
Creating file test_file.122
Creating file test_file.123
Creating file test_file.124
Creating file test_file.125
Creating file test_file.126
Creating file test_file.127
5368709120 bytes written in 2.61 seconds (1961.42 MiB/sec).
```


## I/O random R/W

```bash
~$ sysbench --threads=8 --time=60 --file-total-size=5G --file-test-mode=rndrw fileio run
sysbench 1.0.20 (using system LuaJIT 2.1.1725453128)

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
    reads/s:                      139804.58
    writes/s:                     93203.03
    fsyncs/s:                     298265.11

Throughput:
    read, MiB/s:                  2184.45
    written, MiB/s:               1456.30

General statistics:
    total time:                          60.0016s
    total number of events:              31876350

Latency (ms):
         min:                                    0.00
         avg:                                    0.01
         max:                                   26.45
         95th percentile:                        0.00
         sum:                               437031.31

Threads fairness:
    events (avg/stddev):           3984543.7500/13174.57
    execution time (avg/stddev):   54.6289/0.07
```

## Clean up

```bash
sysbench --file-total-size=5G fileio cleanup
```
