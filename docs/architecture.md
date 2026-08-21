# Lab Architecture

This document describes the current architecture of the Windows Server / Active Directory lab.

## Network

**Network:** `192.168.100.0/24`  
**Subnet Mask:** `255.255.255.0`  
**Hyper-V Switch:** Private virtual switch  
**Domain:** `wbstraining.internal`

## IP Address Plan

| System | IP Address | Configuration | Role |
|---|---|---|---|
| Server1 | 192.168.100.10 | Static | Domain Controller, AD DS, DNS, DHCP |
| Server2 | 192.168.100.20 | Static | Member Server |
| Server3 | 192.168.100.1 | Static | Gateway / Router planned |
| Client1 | DHCP | Dynamic | Windows 11 Domain Client |
| Client2 | DHCP | Dynamic | Windows 11 Domain Client |

## DHCP Scope

```text
Network:       192.168.100.0/24
Start:         192.168.100.100
End:           192.168.100.200
Gateway:       192.168.100.1
DNS Server:    192.168.100.10
DNS Suffix:    wbstraining.internal
```

## Server Roles

### Server1

Primary infrastructure server.

Roles:

* Active Directory Domain Services
* Domain Controller
* DNS Server
* DHCP Server

### Server2

Current role:

* Active Directory Member Server

Possible future use:

* File Server

### Server3

Current network address:

`192.168.100.1`

Intended role:

* Gateway
* Router

## Domain Clients

### Client1

* Windows 11
* Receives IPv4 configuration through DHCP
* Uses Server1 as DNS server
* Member of `wbstraining.internal`

### Client2

* Windows 11
* Receives IPv4 configuration through DHCP
* Uses Server1 as DNS server
* Member of `wbstraining.internal`

## Architecture Diagram

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
```
