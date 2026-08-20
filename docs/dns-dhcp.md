# DNS and DHCP

This document describes the DNS and DHCP configuration used in the lab.

## DNS Overview

DNS is installed on Server1 together with Active Directory Domain Services.

**DNS Server:** `Server1`  
**IP Address:** `192.168.100.10`  
**Domain:** `wbstraining.internal`

All domain members use Server1 as their internal DNS server.

## DNS Configuration

Server1 uses itself as the preferred DNS server:

```text
DNS Server: 192.168.100.10
````

Server2, Server3, Client1 and Client2 also use Server1 for internal DNS resolution.

This allows the systems to resolve Active Directory domain names and locate the Domain Controller.

## DNS Testing

DNS resolution was tested with:

```powershell
nslookup wbstraining.internal
nslookup Server1
```

The DNS client cache was cleared with:

```powershell
ipconfig /flushdns
```

DNS registration was refreshed with:

```powershell
ipconfig /registerdns
```

## DHCP Overview

The DHCP Server role is installed on Server1.

The DHCP server was authorized in Active Directory before the scope was used.

## DHCP Scope

The following DHCP scope was configured:

```text
Scope Name:      LAB-Clients
Network:         192.168.100.0/24
Start Address:   192.168.100.100
End Address:     192.168.100.200
Subnet Mask:     255.255.255.0
```

## DHCP Options

The following options were configured:

```text
Default Gateway: 192.168.100.1
DNS Server:      192.168.100.10
DNS Domain:      wbstraining.internal
```

## DHCP Clients

Client1 and Client2 are configured to obtain their network settings automatically.

The following commands were used during testing:

```powershell
ipconfig /release
ipconfig /renew
ipconfig /all
```

After renewal, the clients received addresses from the configured DHCP scope.

## Verification

DHCP leases were checked on Server1 to confirm that both clients received valid addresses.

The expected client configuration is:

```text
IPv4 Address:    192.168.100.100 - 192.168.100.200
Subnet Mask:     255.255.255.0
Default Gateway: 192.168.100.1
DNS Server:      192.168.100.10
DNS Suffix:      wbstraining.internal
```

## Result

DNS and DHCP are operational in the lab.

DNS provides name resolution for the Active Directory domain, while DHCP automatically provides network configuration to the Windows 11 clients.
