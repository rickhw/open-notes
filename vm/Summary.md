
## Pre-condition

- Hardware (Host Machine):
    - iMac (2020 LATE)
        - Intel: 3.6 GHz 8-Core Intel Core i9
        - 64 GB 2667 MHz DDR4
    - MacBook Pro
        - M1 Max
        - 64 GB
- Software:
    - Host Machine: macOS 15.0.1 (24A348)
    - VMWare Fusion: Player Version 12.2.5 (20904517)
    - UTM: Version 4.5.4 (100)
- Guest OS & Tools
    - Ubuntu 24.04 Server
    - sysbeanch

> additional: M1-Max (Mabbook Pro)


## Benchmark

Item \ Virtualization | Host Machine (Intel i9) | VMWare Fusion (on Intel i9)  | UTM  (on Intel i9) | UTM (M1) | Host Machine (M1)  |
---------------|---------------:|--------------------:|------------------:|--------------------:|--------------------:|
CPU speed (events per second) | 32,651,216 |  9,808 | 7,401 | 50,184 | 88,322,749 |
Memory Read: IOPS | 14,823,089 | 17,106,884 | 41,102 | 7,959,773 | 5,029,233 |
Memory Read: Throughput (MiB/sec) | 14,475| 16,705 | 40 | 7,773 | 4,911 |
Memory Write: IOPS | 15,586,652 | 17,934,555 | 40,925 | 5,185,093 | 4,920,948 |
Memory Write: Throughput (MiB/sec) |15,221  |  17,514 | 39 | 5,063 | 4,805 |
I/O: Write (MiB/sec) | 364 | 506  | 226 | 1,791 | 1,961 |
I/O: Random Read (IOPS) | 31,680  | 56,941 | 1,233 | 4,970 | 139,804 |
I/O: Random Write (IOPS) | 21,120| 37,960 | 822 | 3,313 | 93,203 |
I/O: Random Read (Throughput, MiB/s) | 495  | 889 | 19 | 77 | 2,184 |
I/O: Random Write (Throughput, MiB/s) | 330 | 593 | 12 | 51 | 1,456 |
