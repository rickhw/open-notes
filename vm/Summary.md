
## Pre-condition

- Hardware (Host Machine):
    - iMac (2020 LATE)
        - Intel: 3.6 GHz 8-Core Intel Core i9
        - 64 GB 2667 MHz DDR4
    - MacBook Pro
        - M1 Max
        - 64 GB
- Software:
    - Host Machine OS: macOS 15.0.1 (24A348)
    - [UTM: Version 4.5.4 (100)][r1]
    - [VMWare Fusion: Player Version 12.2.5 (20904517)][r2]
- Guest OS & Tools
    - OS: Ubuntu 24.04 Server (Minium install)
        - [x86_64](https://ubuntu.com/download/server)
        - [ARM](https://ubuntu.com/download/server/arm)
    - Resources:
        - CPU: 8core
        - memory: 16GiB
        - storage 80GiB SSD
    - sysbeanch


## Benchmark - Intel Core i9 (iMac 2019 LATE)

Item \ Virtualization | Host Machine | VMWare Fusion  | UTM  |
---------------|---------------:|--------------------:|------------------:|
CPU speed (events per second) | 32,651,216 |  9,808 | 7,401 |
Memory Read: IOPS | 14,823,089 | 17,106,884 | 41,102 |
Memory Read: Throughput (MiB/sec) | 14,475| 16,705 | 40 |
Memory Write: IOPS | 15,586,652 | 17,934,555 | 40,925 |
Memory Write: Throughput (MiB/sec) |15,221  |  17,514 | 39 |
I/O: Write (MiB/sec) | 364 | 506  | 226 |
I/O: Random Read (IOPS) | 31,680  | 56,941 | 1,233 |
I/O: Random Write (IOPS) | 21,120| 37,960 | 822 |
I/O: Random Read (Throughput, MiB/s) | 495  | 889 | 19 |
I/O: Random Write (Throughput, MiB/s) | 330 | 593 | 12 |



## Benchmark - Apple Sillicon (MacBook Pro M1 Max)

Item \ Virtualization |  Host Machine  | VMWare Fusion | UTM |
---------------|---------------:|--------------------:|------------------:|
CPU speed (events per second) | 88,322,749 | 63,873 | 50,184
Memory Read: IOPS | 5,029,233 |7,952,600 | 7,959,773
Memory Read: Throughput (MiB/sec) |   4,911 | 7,766 | 7,773 |
Memory Write: IOPS |   4,920,948 | 4,825,686 | 5,185,093 |
Memory Write: Throughput (MiB/sec) | 4,805 | 4,712 | 5,063 |
I/O: Write (MiB/sec) | 1,961 | 1,630 | 1,791 |
I/O: Random Read (IOPS) |  139,804 | 39,626 | 4,970 |
I/O: Random Write (IOPS) |  93,203 | 26,417 | 3,313 |
I/O: Random Read (Throughput, MiB/s) | 2,184 | 619 | 77 |
I/O: Random Write (Throughput, MiB/s) |  1,456 | 412 | 51 |




## download

- https://www.techspot.com/downloads/2755-vmware-fusion-mac.html
