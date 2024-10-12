
## Pre-condition

- Hardware (Host Machine):
    - Intel: 3.6 GHz 8-Core Intel Core i9
    - 64 GB 2667 MHz DDR4
- Software:
    - Host Machine: macOS 15.0.1 (24A348)
    - VMWare Fusion: Player Version 12.2.5 (20904517)
    - UTM: Version 4.5.4 (100)
- Guest OS & Tools
    - Ubuntu 24.04 Server
    - sysbeanch

> additional: M1-Max (Mabbook Pro)


## Beanchmark

Item \ Virtualization | VMWare Fusion | UTM                | UTM (M1) |
---------------|---------------:|--------------------:|------------------:|
CPU speed (events per second) |  9,808 | 7,401 | 50,184 |
Memory Read: IOPS | 17,106,884 | 41,102 | 7,959,773 |
Memory Read: Throughput (MiB/sec) | 16,705 | 40 | 7,773 |
Memory Write: IOPS | 17,934,555 | 40,925 | 5,185,093 |
Memory Write: Throughput (MiB/sec) | 17,514 | 39 | 5,063 |
I/O: Write (MiB/sec) | 506  | 226 | 1,791 |
I/O: Random Read (IOPS) | 56,941 | 1,233 | 4,970 |
I/O: Random Write (IOPS) | 37,960 | 822 | 3,313 |
I/O: Random Read (Throughput, MiB/s) | 889 | 19 | 77 |
I/O: Random Write (Throughput, MiB/s) | 593 | 12 | 51 |
