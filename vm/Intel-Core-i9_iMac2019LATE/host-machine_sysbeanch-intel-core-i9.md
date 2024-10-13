
Intel: 3.6 GHz 8-Core Intel Core i9


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
    events per second: 32651216.63

General statistics:
    total time:                          60.0001s
    total number of events:              1959114171

Latency (ms):
         min:                                    0.00
         avg:                                    0.00
         max:                                   49.95
         95th percentile:                        0.00
         sum:                               127938.19

Threads fairness:
    events (avg/stddev):           244889271.3750/2891511.74
    execution time (avg/stddev):   15.9923/0.27
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

Total operations: 104857600 (14823089.32 per second)

102400.00 MiB transferred (14475.67 MiB/sec)


General statistics:
    total time:                          7.0729s
    total number of events:              104857600

Latency (ms):
         min:                                    0.00
         avg:                                    0.00
         max:                                   24.34
         95th percentile:                        0.00
         sum:                                37137.37

Threads fairness:
    events (avg/stddev):           13107200.0000/0.00
    execution time (avg/stddev):   4.6422/0.02
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

Total operations: 104857600 (15586652.61 per second)

102400.00 MiB transferred (15221.34 MiB/sec)


General statistics:
    total time:                          6.7264s
    total number of events:              104857600

Latency (ms):
         min:                                    0.00
         avg:                                    0.00
         max:                                   33.27
         95th percentile:                        0.00
         sum:                                35327.17

Threads fairness:
    events (avg/stddev):           13107200.0000/0.00
    execution time (avg/stddev):   4.4159/0.02

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

Creating file test_file.123
Creating file test_file.124
Creating file test_file.125
Creating file test_file.126
Creating file test_file.127
5368709120 bytes written in 14.06 seconds (364.04 MiB/sec).

```


## Disk I/O: Random R/W

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
    reads/s:                      31680.46
    writes/s:                     21120.28
    fsyncs/s:                     67600.85

Throughput:
    read, MiB/s:                  495.01
    written, MiB/s:               330.00

General statistics:
    total time:                          60.0019s
    total number of events:              7223426

Latency (ms):
         min:                                    0.00
         avg:                                    0.07
         max:                                   49.23
         95th percentile:                        0.22
         sum:                               472801.29

Threads fairness:
    events (avg/stddev):           902928.2500/2253.31
    execution time (avg/stddev):   59.1002/0.02

```