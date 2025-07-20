
## CPU

```bash
ubuntu@u2404-dev-x86:~$ sysbench --threads=8 --time=60 cpu run
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

Running the test with following options:
Number of threads: 8
Initializing random number generator from current time


Prime numbers limit: 10000

Initializing worker threads...

Threads started!

CPU speed:
    events per second:   339.38

General statistics:
    total time:                          60.0131s
    total number of events:              20368

Latency (ms):
         min:                                    4.24
         avg:                                   23.35
         max:                                  104.44
         95th percentile:                       32.53
         sum:                               475536.75

Threads fairness:
    events (avg/stddev):           2546.0000/25.67
    execution time (avg/stddev):   59.4421/0.08
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

Total operations: 16290964 (271497.50 per second)

15909.14 MiB transferred (265.13 MiB/sec)


General statistics:
    total time:                          60.0020s
    total number of events:              16290964

Latency (ms):
         min:                                    0.00
         avg:                                    0.01
         max:                                   51.23
         95th percentile:                        0.00
         sum:                               148690.32

Threads fairness:
    events (avg/stddev):           2036370.5000/32157.60
    execution time (avg/stddev):   18.5863/0.62
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

Total operations: 16408930 (273456.43 per second)

16024.35 MiB transferred (267.05 MiB/sec)


General statistics:
    total time:                          60.0026s
    total number of events:              16408930

Latency (ms):
         min:                                    0.00
         avg:                                    0.01
         max:                                   29.18
         95th percentile:                        0.00
         sum:                               148144.94

Threads fairness:
    events (avg/stddev):           2051116.2500/77805.88
    execution time (avg/stddev):   18.5181/0.27
```


---

## Disk I/O: Write


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

Creating file test_file.122
Creating file test_file.123
Creating file test_file.124
Creating file test_file.125
Creating file test_file.126
Creating file test_file.127
5368709120 bytes written in 43.59 seconds (117.46 MiB/sec).
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
    reads/s:                      2382.77
    writes/s:                     1588.51
    fsyncs/s:                     5098.57

Throughput:
    read, MiB/s:                  37.23
    written, MiB/s:               24.82

General statistics:
    total time:                          60.1048s
    total number of events:              544133

Latency (ms):
         min:                                    0.01
         avg:                                    0.87
         max:                                   16.43
         95th percentile:                        3.19
         sum:                               475733.99

Threads fairness:
    events (avg/stddev):           68016.6250/700.54
    execution time (avg/stddev):   59.4667/0.01

```


