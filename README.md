````markdown
# Windows Server / Active Directory Lab

Hands-on infrastructure lab created during my  
**Umschulung zum Fachinformatiker für Systemintegration (IHK)**.

The goal of this project is to build and document a small Windows domain environment using **Hyper-V, Windows Server 2022, Active Directory, DNS, DHCP, PowerShell and Windows 11 clients**.

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
**NetBIOS:** `WBSTRAINING`  
**Hyper-V Switch:** Private virtual switch

---

## Architecture

```text
                         Hyper-V Host
                              |
                       Private vSwitch
                              |
                     192.168.100.0/24
                              |
        +-----------+---------+---------+-----------+
        |           |                   |           |
     Server1     Server2             Server3     Client1/2
  192.168.100.10 192.168.100.20   192.168.100.1     DHCP
        |           |                   |           |
 AD DS / DNS /   Member Server     Gateway       Windows 11
     DHCP                          planned       Domain Clients
````

---

## Implemented Features

### Hyper-V & VM Templates

* Created reusable Windows Server 2022 and Windows 11 VM templates
* Used Audit Mode and Sysprep to generalize the operating system images
* Created VMs from reusable VHDX templates
* Used Differencing Disks to reduce disk usage
* Created Server1, Server2, Server3, Client1 and Client2 with PowerShell
* Configured CPU, memory and Hyper-V settings with PowerShell
* Disabled automatic checkpoints for the lab virtual machines

### Networking

* Configured a private Hyper-V network using `192.168.100.0/24`
* Assigned static IPv4 addresses to the servers
* Configured Server1 to use itself as the internal DNS server
* Configured Server2 and Server3 to use Server1 for DNS resolution
* Defined DHCP range `192.168.100.100–192.168.100.200` for Windows 11 clients
* Configured default gateway `192.168.100.1`
* Tested connectivity with `ping`, `ipconfig` and `nslookup`
* Enabled ICMP Echo Requests in Windows Firewall for troubleshooting

### Active Directory & DNS

* Installed **Active Directory Domain Services (AD DS)** and DNS on Server1
* Promoted Server1 to a Domain Controller
* Created a new Active Directory forest
* Configured the domain `wbstraining.internal`
* Configured NetBIOS name `WBSTRAINING`
* Verified Domain Controller functionality with `whoami`, `hostname` and `%logonserver%`
* Verified DNS resolution with `nslookup`
* Tested DNS registration and cache troubleshooting with `ipconfig /registerdns` and `ipconfig /flushdns`

### DHCP & Domain Clients

* Installed and authorized the DHCP Server role on Server1
* Created DHCP scope `LAB-Clients`
* Configured address range `192.168.100.100–192.168.100.200`
* Configured gateway `192.168.100.1`
* Configured DNS server `192.168.100.10`
* Configured DNS suffix `wbstraining.internal`
* Configured Client1 and Client2 to obtain IP and DNS settings automatically
* Verified DHCP leases with `ipconfig /renew` and `ipconfig /all`
* Joined Client1 and Client2 to the domain `wbstraining.internal`
* Verified domain logon with `whoami` and `%logonserver%`

### Verification & Troubleshooting

The lab environment was verified using standard Windows networking and domain tools.

* Checked network configuration with `ipconfig /all`
* Tested connectivity between servers and clients with `ping`
* Verified DNS resolution with `nslookup`
* Verified the current user context with `whoami`
* Verified the active Domain Controller with `%logonserver%`
* Checked DHCP leases on Server1
* Confirmed that Client1 and Client2 received addresses from the configured DHCP scope
* Verified that both Windows 11 clients successfully joined the domain
* Troubleshot blocked ICMP traffic by enabling the Windows Firewall rule for Echo Requests

---

## Skills Demonstrated

* Windows Server 2022
* Hyper-V
* Active Directory Domain Services
* DNS
* DHCP
* TCP/IP and IPv4
* Windows 11 Domain Clients
* PowerShell
* Domain Join
* Windows Firewall
* Troubleshooting
* IT Documentation

---

## Documentation

Detailed documentation for the lab:

* [Lab Architecture](docs/architecture.md)
* [Hyper-V Setup](docs/hyper-v-setup.md)
* [Networking](docs/networking.md)
* [Active Directory](docs/active-directory.md)
* [DNS and DHCP](docs/dns-dhcp.md)
* [Troubleshooting](docs/troubleshooting.md)
* [PowerShell Scripts](powershell/README.md)

---

## Repository Structure

```text
windows-server-active-directory-lab/
├── README.md
├── docs/
│   ├── architecture.md
│   ├── hyper-v-setup.md
│   ├── networking.md
│   ├── active-directory.md
│   ├── dns-dhcp.md
│   └── troubleshooting.md
└── powershell/
    ├── README.md
    └── create-lab-vms.ps1
```

