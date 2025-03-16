
Switch: Unifi 8 port (1Gbps)

---
❯ ssh root@192.168.5.235
root@192.168.5.235's password:
Linux gtinfra01 6.8.12-4-pve #1 SMP PREEMPT_DYNAMIC PMX 6.8.12-4 (2024-11-06T15:04Z) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Sat Mar 15 21:35:46 2025 from 192.168.51.250

root@gtinfra01:~# iperf -c 192.168.5.236
------------------------------------------------------------
Client connecting to 192.168.5.236, TCP port 5001
TCP window size: 16.0 KByte (default)
------------------------------------------------------------
[  1] local 192.168.5.235 port 42844 connected with 192.168.5.236 port 5001 (icwnd/mss/irtt=14/1448/430)
[ ID] Interval       Transfer     Bandwidth
[  1] 0.0000-10.0263 sec  1.10 GBytes   941 Mbits/sec
root@gtinfra01:~#

---

❯ ssh root@192.168.5.236
root@192.168.5.236's password:
Linux gtinfra02 6.8.12-4-pve #1 SMP PREEMPT_DYNAMIC PMX 6.8.12-4 (2024-11-06T15:04Z) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Sat Mar 15 21:06:29 2025 from 192.168.51.250
root@gtinfra02:~# iperf -s
------------------------------------------------------------
Server listening on TCP port 5001
TCP window size:  128 KByte (default)
------------------------------------------------------------
[  1] local 192.168.5.236 port 5001 connected with 192.168.5.235 port 42844 (icwnd/mss/irtt=14/1448/130)
[ ID] Interval       Transfer     Bandwidth
[  1] 0.0000-10.0206 sec  1.10 GBytes   941 Mbits/sec