# Networking

This document describes the network configuration used in the Windows Server / Active Directory lab.

## Network Overview

The lab uses a private Hyper-V virtual network.

**Network:** `192.168.100.0/24`  
**Subnet Mask:** `255.255.255.0`  
**Hyper-V Switch:** Private virtual switch

All servers and clients are connected to the same virtual network.

## IP Address Plan

| System | IP Address | Configuration |
|---|---|---|
| Server1 | 192.168.100.10 | Static |
| Server2 | 192.168.100.20 | Static |
| Server3 | 192.168.100.1 | Static |
| Client1 | DHCP | Dynamic |
| Client2 | DHCP | Dynamic |

## Server1 Network Configuration

Server1 uses a static IPv4 configuration.

```text
IP Address:      192.168.100.10
Subnet Mask:     255.255.255.0
Default Gateway: 192.168.100.1
DNS Server:      192.168.100.10
````

Server1 uses itself as the DNS server because it provides the DNS role for the Active Directory domain.

## Server2 Network Configuration

Server2 uses a static IPv4 configuration.

```text
IP Address:      192.168.100.20
Subnet Mask:     255.255.255.0
Default Gateway: 192.168.100.1
DNS Server:      192.168.100.10
```

Server2 uses Server1 for internal DNS resolution.

## Server3 Network Configuration

Server3 uses:

```text
IP Address:      192.168.100.1
Subnet Mask:     255.255.255.0
DNS Server:      192.168.100.10
```

Server3 is intended to be used as the gateway / router for the lab.

## Client Network Configuration

Client1 and Client2 are configured to receive their network configuration automatically through DHCP.

Expected configuration:

```text
IP Address:      192.168.100.100 - 192.168.100.200
Subnet Mask:     255.255.255.0
Default Gateway: 192.168.100.1
DNS Server:      192.168.100.10
DNS Suffix:      wbstraining.internal
```

## Connectivity Testing

Basic connectivity was tested with:

```powershell
ping 192.168.100.10
ping 192.168.100.20
ping 192.168.100.1
```

Network configuration was checked with:

```powershell
ipconfig /all
```

DNS resolution was tested with:

```powershell
nslookup wbstraining.internal
nslookup Server1
```

## Firewall Troubleshooting

During testing, ICMP traffic was blocked by Windows Defender Firewall.

The corresponding inbound firewall rule for ICMP Echo Requests was enabled to allow `ping` testing between the lab systems.

## Result

The servers and clients can communicate within the private Hyper-V network.

The network configuration provides the foundation for Active Directory, DNS, DHCP and domain communication.
