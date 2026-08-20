# Windows Server / Active Directory Lab

Hands-on infrastructure lab created during my  
**Umschulung zum Fachinformatiker für Systemintegration (IHK)**.

The goal of this project is to build and document a small Windows domain environment using **Hyper-V, Windows Server, Active Directory, DNS, DHCP, PowerShell and Windows 11 clients**.

> **Status:** Work in progress

## Lab Overview

The current environment consists of:

| System | IP Address | Role |
|---|---|---|
| Server1 | 192.168.100.10 | Domain Controller, AD DS, DNS, DHCP |
| Server2 | 192.168.100.20 | Member Server |
| Server3 | 192.168.100.1 | Planned Gateway / Router |
| Client1 | DHCP | Windows 11 Domain Client |
| Client2 | DHCP | Windows 11 Domain Client |

**Network:** `192.168.100.0/24`  
**Domain:** `wbstraining.internal`  
**Hyper-V Switch:** Private virtual switch

---

## Architecture

```text
                    Hyper-V
                       |
                 Private Switch
                       |
                192.168.100.0/24
                       |
        +--------------+--------------+
        |              |              |
     Server1        Server2        Server3
   192.168.100.10  192.168.100.20  192.168.100.1
        |
   AD DS + DNS
      + DHCP
        |
        +-------------------------+
        |                         |
     Client1                   Client2
      DHCP                      DHCP
      Domain                    Domain
```

---

## Implemented Features

### Hyper-V & VM Templates

- Created reusable Windows Server 2022 and Windows 11 VM templates
- Used Audit Mode and Sysprep to generalize the operating system images
- Created VMs from reusable VHDX templates
- Used Differencing Disks to reduce disk usage
- Created Server1, Server2, Server3, Client1 and Client2 with PowerShell
- Configured CPU, memory and Hyper-V settings with PowerShell
- Disabled automatic checkpoints for the lab virtual machines

### Networking

- Configured a private Hyper-V network using `192.168.100.0/24`
- Assigned static IPv4 addresses to the servers
- Configured Server1 to use itself as the internal DNS server
- Configured Server2 and Server3 to use Server1 for DNS resolution
- Defined DHCP range `192.168.100.100–192.168.100.200` for Windows 11 clients
- Configured default gateway `192.168.100.1`
- Tested connectivity with `ping`, `ipconfig` and `nslookup`
- Enabled ICMP Echo Requests in Windows Firewall for troubleshooting

### Active Directory & DNS

- Installed **Active Directory Domain Services (AD DS)** and DNS on Server1
- Promoted Server1 to a Domain Controller
- Created a new Active Directory forest
- Configured the domain `wbstraining.internal`
- Configured NetBIOS name `WBSTRAINING`
- Verified domain controller functionality with `whoami`, `hostname` and `%logonserver%`
- Verified DNS resolution with `nslookup`
- Tested DNS registration and cache troubleshooting with `ipconfig /registerdns` and `ipconfig /flushdns`
