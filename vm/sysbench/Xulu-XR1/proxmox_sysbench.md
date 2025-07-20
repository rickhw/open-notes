
## Overall
ubuntu@gtlab101:~$ inxi -Fxz
System:
  Kernel: 6.11.0-19-generic arch: x86_64 bits: 64 compiler: gcc v: 13.3.0
  Console: pty pts/0 Distro: Ubuntu 24.04.2 LTS (Noble Numbat)
Machine:
  Type: Kvm System: QEMU product: Standard PC (i440FX + PIIX, 1996) v: pc-i440fx-9.0
    serial: <superuser required>
  Mobo: N/A model: N/A serial: N/A BIOS: SeaBIOS
    v: rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org date: 04/01/2014
CPU:
  Info: 8-core model: QEMU Virtual version 2.5+ bits: 64 type: MCP arch: K8 rev: 1
    cache: L1: 1024 KiB L2: 4 MiB L3: 16 MiB
  Speed (MHz): avg: 1996 min/max: N/A cores: 1: 1996 2: 1996 3: 1996 4: 1996 5: 1996
    6: 1996 7: 1996 8: 1996 bogomips: 31939
  Flags: ht lm nx pae sse sse2 sse3 sse4_1 sse4_2 ssse3
Graphics:
  Device-1: vendor: Red Hat driver: bochs-drm v: N/A bus-ID: 00:02.0
  Display: server: X.org v: 1.21.1.11 with: Xwayland v: 23.2.6 driver: gpu: bochs-drm
    tty: 89x72 resolution: 1280x800
  API: EGL v: 1.5 drivers: swrast platforms: active: surfaceless,device
    inactive: gbm,wayland,x11
  API: OpenGL v: 4.5 vendor: mesa v: 24.2.8-1ubuntu1~24.04.1
    note: console (EGL sourced) renderer: llvmpipe (LLVM 19.1.1 128 bits)
Audio:
  Message: No device data found.
  API: ALSA v: k6.11.0-19-generic status: kernel-api
  Server-1: PipeWire v: 1.0.5 status: active
Network:
  Device-1: Intel 82371AB/EB/MB PIIX4 ACPI vendor: Red Hat Qemu virtual machine
    type: network bridge driver: piix4_smbus v: N/A port: N/A bus-ID: 00:01.3
  Device-2: Red Hat Virtio network driver: virtio-pci v: 1 port: f060 bus-ID: 00:12.0
  IF: ens18 state: up speed: -1 duplex: unknown mac: <filter>
Drives:
  Local Storage: total: 100 GiB used: 9.44 GiB (9.4%)
  ID-1: /dev/sda vendor: QEMU model: HARDDISK size: 100 GiB
Partition:
  ID-1: / size: 97.87 GiB used: 9.44 GiB (9.6%) fs: ext4 dev: /dev/sda2
Swap:
  ID-1: swap-1 type: file size: 4 GiB used: 0 KiB (0.0%) file: /swap.img
Sensors:
  Src: lm-sensors+/sys Message: No sensor data found using /sys/class/hwmon or
    lm-sensors.
Info:
  Memory: total: 8 GiB available: 7.75 GiB used: 894.2 MiB (11.3%)
  Processes: 230 Uptime: 2m Init: systemd target: graphical (5)
  Packages: 1517 Compilers: N/A Shell: Bash v: 5.2.21 inxi: 3.3.34


## CPU

```bash
ubuntu@gtlab101:~$ sysbench --threads=8 --time=60 cpu run
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

Running the test with following options:
Number of threads: 8
Initializing random number generator from current time


Prime numbers limit: 10000

Initializing worker threads...

Threads started!

CPU speed:
    events per second: 27736.51

General statistics:
    total time:                          60.0003s
    total number of events:              1664214

Latency (ms):
         min:                                    0.19
         avg:                                    0.29
         max:                                    8.71
         95th percentile:                        0.30
         sum:                               479760.63

Threads fairness:
    events (avg/stddev):           208026.7500/68.03
    execution time (avg/stddev):   59.9701/0.00
```


## Memory Read

```bash
ubuntu@gtlab101:~$ sysbench --threads=8 --time=60 memory run
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

Total operations: 104857600 (16230626.95 per second)

102400.00 MiB transferred (15850.22 MiB/sec)


General statistics:
    total time:                          6.4600s
    total number of events:              104857600

Latency (ms):
         min:                                    0.00
         avg:                                    0.00
         max:                                    6.01
         95th percentile:                        0.00
         sum:                                20273.12

Threads fairness:
    events (avg/stddev):           13107200.0000/0.00
    execution time (avg/stddev):   2.5341/0.03
```


## Memeory Write

```bash
ubuntu@gtlab101:~$ sysbench --threads=8 --time=60 memory --memory-oper=write run
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

Total operations: 104857600 (16031344.15 per second)

102400.00 MiB transferred (15655.61 MiB/sec)


General statistics:
    total time:                          6.5403s
    total number of events:              104857600

Latency (ms):
         min:                                    0.00
         avg:                                    0.00
         max:                                    0.36
         95th percentile:                        0.00
         sum:                                21533.86

Threads fairness:
    events (avg/stddev):           13107200.0000/0.00
    execution time (avg/stddev):   2.6917/0.03```


## I/O create

```bash
ubuntu@gtlab101:~$ sysbench --threads=8 --time=60 --file-total-size=5G fileio prepare
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

Creating file test_file.123
Creating file test_file.124
Creating file test_file.125
Creating file test_file.126
Creating file test_file.127
5368709120 bytes written in 4.01 seconds (1275.94 MiB/sec).
```



## Disk I/O: Random R/W

```bash
ubuntu@gtlab101:~$ sysbench --threads=8 --time=60 --file-total-size=5G --file-test-mode=rndrw fileio run
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
    reads/s:                      6760.78
    writes/s:                     4507.19
    fsyncs/s:                     14439.03

Throughput:
    read, MiB/s:                  105.64
    written, MiB/s:               70.42

General statistics:
    total time:                          60.0104s
    total number of events:              1541674

Latency (ms):
         min:                                    0.00
         avg:                                    0.31
         max:                                   14.20
         95th percentile:                        1.32
         sum:                               479349.62

Threads fairness:
    events (avg/stddev):           192709.2500/1252.40
    execution time (avg/stddev):   59.9187/0.00
```



---

## Network Througput

```bash
Selecting previously unselected package iperf.
(Reading database ... 153124 files and directories currently installed.)
Preparing to unpack .../iperf_2.1.9+dfsg-1_amd64.deb ...
Unpacking iperf (2.1.9+dfsg-1) ...
Setting up iperf (2.1.9+dfsg-1) ...
Processing triggers for man-db (2.12.0-4build2) ...
Processing triggers for ufw (0.36.2-6) ...
ubuntu@gtlab101:~$ iperf -c 192.168.2.237
------------------------------------------------------------
Client connecting to 192.168.2.237, TCP port 5001
TCP window size: 16.0 KByte (default)
------------------------------------------------------------
[  1] local 192.168.2.251 port 58260 connected with 192.168.2.237 port 5001 (icwnd/mss/irtt=14/1448/514)
[ ID] Interval       Transfer     Bandwidth
[  1] 0.0000-10.0014 sec  52.5 GBytes  45.1 Gbits/sec
```