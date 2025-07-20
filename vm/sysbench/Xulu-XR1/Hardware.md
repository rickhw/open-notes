
https://xulu.store/products/xr1-max


## Overall

```bash
root@gtlab01:~# inxi -Fxz
System:
  Kernel: 6.8.12-4-pve arch: x86_64 bits: 64 compiler: gcc v: 12.2.0 Console: pty pts/0
    Distro: Debian GNU/Linux 12 (bookworm)
Machine:
  Type: Mini-pc Mobo: XULU.PRO model: XULU-XR1-DEV v: Version 1.0 serial: <filter>
    UEFI: American Megatrends LLC. v: 0.15 date: 12/23/2024
CPU:
  Info: 8-core model: AMD Ryzen 7 5825U with Radeon Graphics bits: 64 type: MT MCP
    arch: Zen 3 rev: 0 cache: L1: 512 KiB L2: 4 MiB L3: 16 MiB
  Speed (MHz): avg: 799 high: 1996 min/max: 400/4546 cores: 1: 400 2: 400 3: 400
    4: 400 5: 400 6: 1996 7: 1996 8: 400 9: 400 10: 400 11: 400 12: 400 13: 1996 14: 400
    15: 1996 16: 400 bogomips: 63881
  Flags: avx avx2 ht lm nx pae sse sse2 sse3 sse4_1 sse4_2 sse4a ssse3 svm
Graphics:
  Device-1: AMD Barcelo driver: amdgpu v: kernel arch: GCN-5 bus-ID: 04:00.0
    temp: 42.0 C
  Display: server: No display server data found. Headless machine? tty: 89x72
  API: OpenGL Message: GL data unavailable in console for root.
Audio:
  Device-1: AMD Renoir Radeon High Definition Audio driver: snd_hda_intel v: kernel
    bus-ID: 04:00.1
  Device-2: AMD Family 17h/19h HD Audio vendor: Conexant Systems
    driver: snd_hda_intel v: kernel bus-ID: 04:00.6
  API: ALSA v: k6.8.12-4-pve status: kernel-api
Network:
  Device-1: Intel Ethernet I226-V driver: igc v: kernel port: N/A bus-ID: 01:00.0
  IF: enp1s0 state: up speed: 1000 Mbps duplex: full mac: <filter>
  Device-2: Intel Wi-Fi 6 AX210/AX211/AX411 160MHz driver: iwlwifi v: kernel
    bus-ID: 02:00.0
  IF: wlp2s0 state: down mac: <filter>
  IF-ID-1: bonding_masters state: N/A speed: N/A duplex: N/A mac: N/A
  IF-ID-2: fwbr100i0 state: up speed: 10000 Mbps duplex: unknown mac: <filter>
  IF-ID-3: fwbr101i0 state: up speed: 10000 Mbps duplex: unknown mac: <filter>
  IF-ID-4: fwln100i0 state: up speed: 10000 Mbps duplex: full mac: <filter>
  IF-ID-5: fwln101i0 state: up speed: 10000 Mbps duplex: full mac: <filter>
  IF-ID-6: fwpr100p0 state: up speed: 10000 Mbps duplex: full mac: <filter>
  IF-ID-7: fwpr101p0 state: up speed: 10000 Mbps duplex: full mac: <filter>
  IF-ID-8: tap100i0 state: unknown speed: 10000 Mbps duplex: full mac: <filter>
  IF-ID-9: tap101i0 state: unknown speed: 10000 Mbps duplex: full mac: <filter>
  IF-ID-10: vmbr0 state: up speed: 10000 Mbps duplex: unknown mac: <filter>
Bluetooth:
  Device-1: Intel AX210 Bluetooth type: USB driver: btusb v: 0.8 bus-ID: 1-4:2
  Report: rfkill ID: hci0 rfk-id: 0 state: down bt-service: not found rfk-block:
    hardware: no software: no address: see --recommends
Drives:
  Local Storage: total: 1.82 TiB lvm-free: 16.24 GiB used: 11.35 GiB (0.6%)
  ID-1: /dev/nvme0n1 vendor: Fanxiang model: S630 2TB size: 1.82 TiB temp: 46.9 C
Partition:
  ID-1: / size: 93.93 GiB used: 11.34 GiB (12.1%) fs: ext4 dev: /dev/dm-1
    mapped: pve-root
  ID-2: /boot/efi size: 1022 MiB used: 11.7 MiB (1.1%) fs: vfat dev: /dev/nvme0n1p2
Swap:
  ID-1: swap-1 type: partition size: 8 GiB used: 0 KiB (0.0%) dev: /dev/dm-0
    mapped: pve-swap
Sensors:
  System Temperatures: cpu: 58.2 C mobo: N/A gpu: amdgpu temp: 40.0 C
  Fan Speeds (RPM): N/A
Info:
  Processes: 293 Uptime: 1h 0m Memory: 62.2 GiB used: 7.62 GiB (12.3%) Init: systemd
  target: graphical (5) Compilers: N/A Packages: 768 Shell: Bash v: 5.2.15 inxi: 3.3.26
```


## CPU

```bash
root@gtlab01:~# lscpu
Architecture:             x86_64
  CPU op-mode(s):         32-bit, 64-bit
  Address sizes:          48 bits physical, 48 bits virtual
  Byte Order:             Little Endian
CPU(s):                   16
  On-line CPU(s) list:    0-15
Vendor ID:                AuthenticAMD
  BIOS Vendor ID:         Advanced Micro Devices, Inc.
  Model name:             AMD Ryzen 7 5825U with Radeon Graphics
    BIOS Model name:      AMD Ryzen 7 5825U with Radeon Graphics          Unknown CPU @ 2
                          .0GHz
    BIOS CPU family:      107
    CPU family:           25
    Model:                80
    Thread(s) per core:   2
    Core(s) per socket:   8
    Socket(s):            1
    Stepping:             0
    CPU(s) scaling MHz:   17%
    CPU max MHz:          4546.0000
    CPU min MHz:          400.0000
    BogoMIPS:             3992.57
    Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov p
                          at pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_op
                          t pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpui
                          d extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma c
                          x16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_l
                          m cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnow
                          prefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_n
                          b bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba
                           ibrs ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 erms invp
                          cid cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt x
                          savec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mb
                          m_local user_shstk clzero irperf xsaveerptr rdpru wbnoinvd cppc
                           arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbya
                          sid decodeassists pausefilter pfthreshold avic v_vmsave_vmload
                          vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overflow_
                          recov succor smca fsrm debug_swap
Virtualization features:
  Virtualization:         AMD-V
Caches (sum of all):
  L1d:                    256 KiB (8 instances)
  L1i:                    256 KiB (8 instances)
  L2:                     4 MiB (8 instances)
  L3:                     16 MiB (1 instance)
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
  Reg file data sampling: Not affected
  Retbleed:               Not affected
  Spec rstack overflow:   Mitigation; Safe RET
  Spec store bypass:      Mitigation; Speculative Store Bypass disabled via prctl
  Spectre v1:             Mitigation; usercopy/swapgs barriers and __user pointer sanitiz
                          ation
  Spectre v2:             Mitigation; Retpolines; IBPB conditional; IBRS_FW; STIBP always
                          -on; RSB filling; PBRSB-eIBRS Not affected; BHI Not affected
  Srbds:                  Not affected
  Tsx async abort:        Not affected
```

## Memory

```bash
root@gtlab01:~# free -h
               total        used        free      shared  buff/cache   available
Mem:            62Gi       7.6Gi        54Gi        48Mi       955Mi        54Gi
Swap:          8.0Gi          0B       8.0Gi
root@gtlab01:~# cat /proc/meminfo
MemTotal:       65223248 kB
MemFree:        56984008 kB
MemAvailable:   57280884 kB
```


## Disk

```bash
root@gtlab01:~# lsblk -o NAME,SIZE,MODEL
NAME                          SIZE MODEL
nvme0n1                       1.8T Fanxiang S630 2TB
├─nvme0n1p1                  1007K
├─nvme0n1p2                     1G
└─nvme0n1p3                   1.8T
  ├─pve-swap                    8G
  ├─pve-root                   96G
  ├─pve-data_tmeta           15.9G
  │ └─pve-data-tpool          1.7T
  │   ├─pve-data              1.7T
  │   ├─pve-vm--100--disk--0  100G
  │   └─pve-vm--101--disk--0  100G
  └─pve-data_tdata            1.7T
    └─pve-data-tpool          1.7T
      ├─pve-data              1.7T
      ├─pve-vm--100--disk--0  100G
      └─pve-vm--101--disk--0  100G


root@gtlab01:~# smartctl -i /dev/nvme0n1
smartctl 7.3 2022-02-28 r5338 [x86_64-linux-6.8.12-4-pve] (local build)
Copyright (C) 2002-22, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Model Number:                       Fanxiang S630 2TB
Serial Number:                      FXS630244130033
Firmware Version:                   W0914D0
PCI Vendor/Subsystem ID:            0x126f
IEEE OUI Identifier:                0x486834
Total NVM Capacity:                 2,000,398,934,016 [2.00 TB]
Unallocated NVM Capacity:           0
Controller ID:                      1
NVMe Version:                       1.4
Number of Namespaces:               1
Namespace 1 Size/Capacity:          2,000,398,934,016 [2.00 TB]
Namespace 1 Formatted LBA Size:     512
Namespace 1 IEEE EUI-64:            486834 0000000000
Local Time is:                      Sun Mar  9 08:28:07 2025 CST
```

## Motherboard and BIOS


```bash
root@gtlab01:~# dmidecode -t system

Getting SMBIOS data from sysfs.
SMBIOS 3.3.0 present.

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: XULU.PRO
	Product Name: XULU XR1 PC
	Version: Version 1.0
	Serial Number: Default string
	UUID: 3b075b80-428b-11ef-bac4-144e9b6b3700
	Wake-up Type: Power Switch
	SKU Number: XULU-XR1
	Family: XULU RYZEN SERIES

Handle 0x0006, DMI type 12, 5 bytes
System Configuration Options
	Option 1: Default string

Handle 0x0007, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

root@gtlab01:~# dmidecode -t bios
# dmidecode 3.4
Getting SMBIOS data from sysfs.
SMBIOS 3.3.0 present.

Handle 0x0000, DMI type 0, 26 bytes
BIOS Information
	Vendor: American Megatrends International, LLC.
	Version: 0.15
	Release Date: 12/23/2024
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 16 MB
	Characteristics:
		PCI is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		BIOS boot specification is supported
		Targeted content distribution is supported
		UEFI is supported
	BIOS Revision: 0.15
	Firmware Revision: 0.12

Handle 0x002B, DMI type 13, 22 bytes
BIOS Language Information
	Language Description Format: Long
	Installable Languages: 1
		en|US|iso8859-1
	Currently Installed Language: en|US|iso8859-1
```