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
