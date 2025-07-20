
## CPU

```bash
~$ sysbench --threads=2 --time=60 cpu run
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

Running the test with following options:
Number of threads: 2
Initializing random number generator from current time


Prime numbers limit: 10000

Initializing worker threads...

Threads started!

CPU speed:
    events per second:  1971.04

General statistics:
    total time:                          60.0007s
    total number of events:              118268

Latency (ms):
         min:                                    0.91
         avg:                                    1.01
         max:                                   14.96
         95th percentile:                        1.37
         sum:                               119926.97

Threads fairness:
    events (avg/stddev):           59134.0000/110.00
    execution time (avg/stddev):   59.9635/0.00

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

Total operations: 104857600 (4266581.87 per second)

102400.00 MiB transferred (4166.58 MiB/sec)


General statistics:
    total time:                          24.5749s
    total number of events:              104857600

Latency (ms):
         min:                                    0.00
         avg:                                    0.00
         max:                                   36.52
         95th percentile:                        0.00
         sum:                                31696.48

Threads fairness:
    events (avg/stddev):           52428800.0000/0.00
    execution time (avg/stddev):   15.8482/0.13
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

Total operations: 104857600 (3653122.75 per second)

102400.00 MiB transferred (3567.50 MiB/sec)


General statistics:
    total time:                          28.7019s
    total number of events:              104857600

Latency (ms):
         min:                                    0.00
         avg:                                    0.00
         max:                                   62.83
         95th percentile:                        0.00
         sum:                                33917.46

Threads fairness:
    events (avg/stddev):           52428800.0000/0.00
    execution time (avg/stddev):   16.9587/0.22

```

## Disk I/O: Write

```bash
:~$ sysbench --threads=2 --time=60 --file-total-size=5G fileio prepare
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
5368709120 bytes written in 20.19 seconds (253.54 MiB/sec).
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
    reads/s:                      1570.40
    writes/s:                     1046.94
    fsyncs/s:                     3354.23

Throughput:
    read, MiB/s:                  24.54
    written, MiB/s:               16.36

General statistics:
    total time:                          60.0206s
    total number of events:              358174

Latency (ms):
         min:                                    0.00
         avg:                                    0.33
         max:                                   20.78
         95th percentile:                        1.21
         sum:                               119729.65

Threads fairness:
    events (avg/stddev):           179087.0000/589.00
    execution time (avg/stddev):   59.8648/0.00
```