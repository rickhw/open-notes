
```bash
apt install inxi
root@gtinfra01:~# inxi -Fxz
System:
  Kernel: 6.8.12-4-pve arch: x86_64 bits: 64 compiler: gcc v: 12.2.0 Console: pty pts/1
    Distro: Debian GNU/Linux 12 (bookworm)
Machine:
  Type: Mini-pc System: ASUSTeK product: NUC13ANH-B v: 90AR00C1-M000N0 serial: <filter>
  Mobo: ASUSTeK model: NUC13ANB-M v: 60AS0040-MB0A41 serial: <filter> UEFI: Intel
    v: ANRPL357.0030.2024.0112.0141 date: 01/12/2024
CPU:
  Info: 12-core (4-mt/8-st) model: 13th Gen Intel Core i7-1360P bits: 64 type: MST AMCP
    arch: Raptor Lake rev: 2 cache: L1: 1.1 MiB L2: 9 MiB L3: 18 MiB
  Speed (MHz): avg: 468 high: 1498 min/max: 400/5000:3700 cores: 1: 400 2: 400 3: 400
    4: 400 5: 1498 6: 400 7: 400 8: 400 9: 400 10: 400 11: 400 12: 400 13: 400 14: 400
    15: 400 16: 400 bogomips: 83558
  Flags: avx avx2 ht lm nx pae sse sse2 sse3 sse4_1 sse4_2 ssse3 vmx
Graphics:
  Device-1: Intel Raptor Lake-P [Iris Xe Graphics] driver: i915 v: kernel arch: Gen-13
    bus-ID: 00:02.0
  Display: server: No display server data found. Headless machine? tty: 89x72
  API: OpenGL Message: GL data unavailable in console for root.
Audio:
  Device-1: Intel Raptor Lake-P/U/H cAVS driver: snd_hda_intel v: kernel
    bus-ID: 00:1f.3
  API: ALSA v: k6.8.12-4-pve status: kernel-api
Network:
  Device-1: Intel Raptor Lake PCH CNVi WiFi driver: iwlwifi v: kernel bus-ID: 00:14.3
  IF: wlo1 state: down mac: <filter>
  Device-2: Intel Ethernet I226-V driver: igc v: kernel port: N/A bus-ID: 56:00.0
  IF: enp86s0 state: up speed: 1000 Mbps duplex: full mac: <filter>
  IF-ID-1: bonding_masters state: N/A speed: N/A duplex: N/A mac: N/A
  IF-ID-2: vmbr0 state: up speed: 1000 Mbps duplex: unknown mac: <filter>
Bluetooth:
  Device-1: Intel AX211 Bluetooth type: USB driver: btusb v: 0.8 bus-ID: 1-10:3
  Report: rfkill ID: hci0 rfk-id: 0 state: down bt-service: not found rfk-block:
    hardware: no software: no address: see --recommends
Drives:
  Local Storage: total: 1.82 TiB lvm-free: 16.24 GiB used: 3.05 GiB (0.2%)
  ID-1: /dev/nvme0n1 vendor: Kingston model: SNV3S2000G size: 1.82 TiB temp: 37.9 C
Partition:
  ID-1: / size: 93.93 GiB used: 3.04 GiB (3.2%) fs: ext4 dev: /dev/dm-1
    mapped: pve-root
  ID-2: /boot/efi size: 1022 MiB used: 11.7 MiB (1.1%) fs: vfat dev: /dev/nvme0n1p2
Swap:
  ID-1: swap-1 type: partition size: 8 GiB used: 0 KiB (0.0%) dev: /dev/dm-0
    mapped: pve-swap
Sensors:
  Src: /sys System Temperatures: cpu: 49.0 C mobo: N/A
  Fan Speeds (RPM): N/A
Info:
  Processes: 299 Uptime: 10m Memory: 62.36 GiB used: 2.2 GiB (3.5%) Init: systemd
  target: graphical (5) Compilers: N/A Packages: 766 Shell: Bash v: 5.2.15 inxi: 3.3.26
root@gtinfra01:~#
```

## CPU

```bash
root@gtinfra01:~# lscpu
Architecture:             x86_64
  CPU op-mode(s):         32-bit, 64-bit
  Address sizes:          39 bits physical, 48 bits virtual
  Byte Order:             Little Endian
CPU(s):                   16
  On-line CPU(s) list:    0-15
Vendor ID:                GenuineIntel
  BIOS Vendor ID:         Intel(R) Corporation
  Model name:             13th Gen Intel(R) Core(TM) i7-1360P
    BIOS Model name:      13th Gen Intel(R) Core(TM) i7-1360P To Be Filled By O.E.M. CPU
                          @ 4.4GHz
    BIOS CPU family:      198
    CPU family:           6
    Model:                186
    Thread(s) per core:   2
    Core(s) per socket:   12
    Socket(s):            1
    Stepping:             2
    CPU(s) scaling MHz:   17%
    CPU max MHz:          5000.0000
    CPU min MHz:          400.0000
    BogoMIPS:             5222.40
    Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov p
                          at pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscal
                          l nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts r
                          ep_good nopl xtopology nonstop_tsc cpuid aperfmperf tsc_known_f
                          req pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 s
                          dbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt t
                          sc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowpr
                          efetch cpuid_fault epb ssbd ibrs ibpb stibp ibrs_enhanced tpr_s
                          hadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx
                          2 smep bmi2 erms invpcid rdseed adx smap clflushopt clwb intel_
                          pt sha_ni xsaveopt xsavec xgetbv1 xsaves split_lock_detect user
                          _shstk avx_vnni dtherm ida arat pln pts hwp hwp_notify hwp_act_
                          window hwp_epp hwp_pkg_req hfi vnmi umip pku ospke waitpkg gfni
                           vaes vpclmulqdq rdpid movdiri movdir64b fsrm md_clear serializ
                          e arch_lbr ibt flush_l1d arch_capabilities
Virtualization features:
  Virtualization:         VT-x
Caches (sum of all):
  L1d:                    448 KiB (12 instances)
  L1i:                    640 KiB (12 instances)
  L2:                     9 MiB (6 instances)
  L3:                     18 MiB (1 instance)
NUMA:
  NUMA node(s):           1
  NUMA node0 CPU(s):      0-15
Vulnerabilities:
  Gather data sampling:   Not affected
  Itlb multihit:          Not affected
  L1tf:                   Not affected
  Mds:                    Not affected
  Meltdown:               Not affected
  Mmio stale data:        Not affected
  Reg file data sampling: Vulnerable: No microcode
  Retbleed:               Not affected
  Spec rstack overflow:   Not affected
  Spec store bypass:      Mitigation; Speculative Store Bypass disabled via prctl
  Spectre v1:             Mitigation; usercopy/swapgs barriers and __user pointer sanitiz
                          ation
  Spectre v2:             Mitigation; Enhanced / Automatic IBRS; IBPB conditional; RSB fi
                          lling; PBRSB-eIBRS SW sequence; BHI BHI_DIS_S
  Srbds:                  Not affected
  Tsx async abort:        Not affected
root@gtinfra01:~#
```


## Memory

```bash
root@gtinfra01:~# free -h
               total        used        free      shared  buff/cache   available
Mem:            62Gi       2.1Gi        59Gi        89Mi       1.4Gi        60Gi
Swap:          8.0Gi          0B       8.0Gi
```


## Disk

```bash
root@gtinfra01:~# lsblk -o NAME,SIZE,MODEL
NAME                SIZE MODEL
nvme0n1             1.8T KINGSTON SNV3S2000G
├─nvme0n1p1        1007K
├─nvme0n1p2           1G
└─nvme0n1p3         1.8T
  ├─pve-swap          8G
  ├─pve-root         96G
  ├─pve-data_tmeta 15.9G
  │ └─pve-data      1.7T
  └─pve-data_tdata  1.7T
    └─pve-data      1.7T
root@gtinfra01:~#

root@gtinfra01:~# smartctl -i /dev/nvme0n1
smartctl 7.3 2022-02-28 r5338 [x86_64-linux-6.8.12-4-pve] (local build)
Copyright (C) 2002-22, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Model Number:                       KINGSTON SNV3S2000G
Serial Number:                      50026B72837883FD
Firmware Version:                   SDS00101
PCI Vendor/Subsystem ID:            0x2646
IEEE OUI Identifier:                0x0026b7
Controller ID:                      1
NVMe Version:                       1.4
Number of Namespaces:               1
Namespace 1 Size/Capacity:          2,000,398,934,016 [2.00 TB]
Namespace 1 Formatted LBA Size:     512
Namespace 1 IEEE EUI-64:            0026b7 2837883fd5
Local Time is:                      Sat Jul 12 08:10:56 2025 CST


```


## Motherboard and BIOS



```bash
root@gtinfra01:~# dmidecode -t system
# dmidecode 3.4
Getting SMBIOS data from sysfs.
SMBIOS 3.5.0 present.

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: ASUSTeK COMPUTER INC.
	Product Name: NUC13ANH-B
	Version: 90AR00C1-M000N0
	Serial Number: S5ARAC016206A3M
	UUID: 5eb22633-97a2-16ec-0cc1-48210b628dbb
	Wake-up Type: Power Switch
	SKU Number: NUC13ANHi7000
	Family: AN

Handle 0x001E, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected

Handle 0x002E, DMI type 15, 73 bytes
System Event Log
	Area Length: 4095 bytes
	Header Start Offset: 0x0000
	Header Length: 16 bytes
	Data Start Offset: 0x0010
	Access Method: Memory-mapped physical 32-bit address
	Access Address: 0xFF060000
	Status: Valid, Not Full
	Change Token: 0x00000001
	Header Format: Type 1
	Supported Log Type Descriptors: 25
	Descriptor 1: Single-bit ECC memory error
	Data Format 1: Multiple-event handle
	Descriptor 2: Multi-bit ECC memory error
	Data Format 2: Multiple-event handle
	Descriptor 3: Parity memory error
	Data Format 3: None
	Descriptor 4: Bus timeout
	Data Format 4: None
	Descriptor 5: I/O channel block
	Data Format 5: None
	Descriptor 6: Software NMI
	Data Format 6: None
	Descriptor 7: POST memory resize
	Data Format 7: None
	Descriptor 8: POST error
	Data Format 8: POST results bitmap
	Descriptor 9: PCI parity error
	Data Format 9: Multiple-event handle
	Descriptor 10: PCI system error
	Data Format 10: Multiple-event handle
	Descriptor 11: CPU failure
	Data Format 11: None
	Descriptor 12: EISA failsafe timer timeout
	Data Format 12: None
	Descriptor 13: Correctable memory log disabled
	Data Format 13: None
	Descriptor 14: Logging disabled
	Data Format 14: None
	Descriptor 15: System limit exceeded
	Data Format 15: None
	Descriptor 16: Asynchronous hardware timer expired
	Data Format 16: None
	Descriptor 17: System configuration information
	Data Format 17: None
	Descriptor 18: Hard disk information
	Data Format 18: None
	Descriptor 19: System reconfigured
	Data Format 19: None
	Descriptor 20: Uncorrectable CPU-complex error
	Data Format 20: None
	Descriptor 21: Log area reset/cleared
	Data Format 21: None
	Descriptor 22: System boot
	Data Format 22: None
	Descriptor 23: End of log
	Data Format 23: None
	Descriptor 24: OEM-specific
	Data Format 24: OEM-specific
	Descriptor 25: OEM-specific
	Data Format 25: OEM-specific
```