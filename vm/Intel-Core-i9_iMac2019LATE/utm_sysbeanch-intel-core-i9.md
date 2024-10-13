
Intel: 3.6 GHz 8-Core Intel Core i9


## CPU

```bash
rickhwang@u2404-server:~$ sysbench --threads=8 --time=60 cpu run
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

Running the test with following options:
Number of threads: 8
Initializing random number generator from current time


Prime numbers limit: 10000

Initializing worker threads...

Threads started!

CPU speed:
    events per second:  7401.13

General statistics:
    total time:                          60.0021s
    total number of events:              444093

Latency (ms):
         min:                                    0.62
         avg:                                    1.04
         max:                                   46.84
         95th percentile:                        1.52
         sum:                               463734.41

Threads fairness:
    events (avg/stddev):           55511.6250/315.03
    execution time (avg/stddev):   57.9668/0.06
```

## Memory Read

```bash
rickhwang@u2404-server:~$ sysbench --threads=8 --time=60 memory run
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

Total operations: 2466193 (41102.12 per second)

2408.39 MiB transferred (40.14 MiB/sec)


General statistics:
    total time:                          60.0002s
    total number of events:              2466193

Latency (ms):
         min:                                    0.00
         avg:                                    0.07
         max:                                   37.42
         95th percentile:                        0.15
         sum:                               166326.96

Threads fairness:
    events (avg/stddev):           308274.1250/4556.08
    execution time (avg/stddev):   20.7909/0.13
```

## Memeory Write

```bash
rickhwang@u2404-server:~$ sysbench --threads=8 --time=60 memory --memory-oper=write run
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

Total operations: 2455858 (40925.99 per second)

2398.30 MiB transferred (39.97 MiB/sec)


General statistics:
    total time:                          60.0057s
    total number of events:              2455858

Latency (ms):
         min:                                    0.00
         avg:                                    0.07
         max:                                   35.58
         95th percentile:                        0.16
         sum:                               166010.30

Threads fairness:
    events (avg/stddev):           306982.2500/5023.01
    execution time (avg/stddev):   20.7513/0.13

```



## I/O create

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

...

Creating file test_file.125
Creating file test_file.126
Creating file test_file.127
5368709120 bytes written in 22.58 seconds (226.78 MiB/sec).
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
    reads/s:                      1233.88
    writes/s:                     822.59
    fsyncs/s:                     2648.26

Throughput:
    read, MiB/s:                  19.28
    written, MiB/s:               12.85

General statistics:
    total time:                          60.3191s
    total number of events:              282767

Latency (ms):
         min:                                    0.01
         avg:                                    1.61
         max:                                   76.46
         95th percentile:                        4.57
         sum:                               456214.25

Threads fairness:
    events (avg/stddev):           35345.8750/420.27
    execution time (avg/stddev):   57.0268/0.03

```