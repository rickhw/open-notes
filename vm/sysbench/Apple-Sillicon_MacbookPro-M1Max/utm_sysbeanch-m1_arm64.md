
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
    events per second: 50184.36

General statistics:
    total time:                          60.0003s
    total number of events:              3011155

Latency (ms):
         min:                                    0.11
         avg:                                    0.16
         max:                                   19.41
         95th percentile:                        0.41
         sum:                               478569.48

Threads fairness:
    events (avg/stddev):           376394.3750/1613.04
    execution time (avg/stddev):   59.8212/0.00
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

Total operations: 104857600 (7959773.68 per second)

102400.00 MiB transferred (7773.22 MiB/sec)


General statistics:
    total time:                          13.1729s
    total number of events:              104857600

Latency (ms):
         min:                                    0.00
         avg:                                    0.00
         max:                                    9.71
         95th percentile:                        0.00
         sum:                                80927.55

Threads fairness:
    events (avg/stddev):           13107200.0000/0.00
    execution time (avg/stddev):   10.1159/0.03
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

Total operations: 104857600 (5185093.48 per second)

102400.00 MiB transferred (5063.57 MiB/sec)


General statistics:
    total time:                          20.2222s
    total number of events:              104857600

Latency (ms):
         min:                                    0.00
         avg:                                    0.00
         max:                                   16.10
         95th percentile:                        0.00
         sum:                               113786.07

Threads fairness:
    events (avg/stddev):           13107200.0000/0.00
    execution time (avg/stddev):   14.2233/0.79
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
Creating file test_file.6
Creating file test_file.7

...

Creating file test_file.121
Creating file test_file.122
Creating file test_file.123
Creating file test_file.124
Creating file test_file.125
Creating file test_file.126
Creating file test_file.127
5368709120 bytes written in 2.86 seconds (1791.07 MiB/sec).
```



## Disk I/O: Random R/W


```bash
~$ sysbench --threads=8 --tilme=60 --file-total-size=5G --file-test-mode=rndrw fileio run
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
    reads/s:                      4970.77
    writes/s:                     3313.84
    fsyncs/s:                     10621.32

Throughput:
    read, MiB/s:                  77.67
    written, MiB/s:               51.78

General statistics:
    total time:                          60.0988s
    total number of events:              1135211

Latency (ms):
         min:                                    0.00
         avg:                                    0.42
         max:                                   12.84
         95th percentile:                        1.32
         sum:                               478884.94

Threads fairness:
    events (avg/stddev):           141901.3750/1102.58
    execution time (avg/stddev):   59.8606/0.00
```


