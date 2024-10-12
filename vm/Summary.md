
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

Virtualization | VMWare Fusion | UTM                | UTM (M1)
---------------|---------------|--------------------|------------------
CPU speed (events per second) |  9808 | 7401 | 50184
Memory Read: IOPS | 17106884 | 41102 | 7959773
Memory Read: Throughput (MiB/sec) | 16705 | 40 | 7773
Memory Write: IOPS | 17934555 | 40925 | 5185093
Memory Write: Throughput (MiB/sec) | 17514 | 39 | 5063
I/O: Write (MiB/sec) | 506  | 226 | 1791
I/O: Random Read (IOPS) | 56941 | 1233 | 4970
I/O: Random Write (IOPS) | 37960 | 822 | 3313
I/O: Random Read (Throughput, MiB/s) | 889 | 19 | 77
I/O: Random Write (Throughput, MiB/s) | 593 | 12 | 51
