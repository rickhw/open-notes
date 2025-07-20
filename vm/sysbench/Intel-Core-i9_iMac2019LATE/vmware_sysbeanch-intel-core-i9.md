
Intel: 3.6 GHz 8-Core Intel Core i9


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
    events per second:  9808.69

General statistics:
    total time:                          60.0007s
    total number of events:              588541

Latency (ms):
         min:                                    0.62
         avg:                                    0.81
         max:                                   57.02
         95th percentile:                        1.01
         sum:                               479638.34

Threads fairness:
    events (avg/stddev):           73567.6250/232.34
    execution time (avg/stddev):   59.9548/0.01
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

Total operations: 104857600 (17106884.26 per second)

102400.00 MiB transferred (16705.94 MiB/sec)


General statistics:
    total time:                          6.1282s
    total number of events:              104857600

Latency (ms):
         min:                                    0.00
         avg:                                    0.00
         max:                                   10.77
         95th percentile:                        0.00
         sum:                                36728.37

Threads fairness:
    events (avg/stddev):           13107200.0000/0.00
    execution time (avg/stddev):   4.5910/0.03
```

## Memeory Write

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

Total operations: 104857600 (17934555.23 per second)

102400.00 MiB transferred (17514.21 MiB/sec)


General statistics:
    total time:                          5.8452s
    total number of events:              104857600

Latency (ms):
         min:                                    0.00
         avg:                                    0.00
         max:                                    6.44
         95th percentile:                        0.00
         sum:                                34899.46

Threads fairness:
    events (avg/stddev):           13107200.0000/0.00
    execution time (avg/stddev):   4.3624/0.01
```



## I/O create

```bash
:~$ sysbench --threads=8 --time=60 --file-total-size=5G fileio prepare
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

Creating file test_file.120
Creating file test_file.121
Creating file test_file.122
Creating file test_file.123
Creating file test_file.124
Creating file test_file.125
Creating file test_file.126
Creating file test_file.127
5368709120 bytes written in 10.11 seconds (506.40 MiB/sec).

```


## Disk I/O: Random R/W

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
    reads/s:                      56941.36
    writes/s:                     37960.90
    fsyncs/s:                     121490.25

Throughput:
    read, MiB/s:                  889.71
    written, MiB/s:               593.14

General statistics:
    total time:                          60.0045s
    total number of events:              12983768

Latency (ms):
         min:                                    0.00
         avg:                                    0.04
         max:                                   37.39
         95th percentile:                        0.19
         sum:                               473803.43

Threads fairness:
    events (avg/stddev):           1622971.0000/34922.03
    execution time (avg/stddev):   59.2254/0.01


```