# Active Directory

This document describes the Active Directory Domain Services configuration used in the lab.

## Domain Overview

The lab uses a single Active Directory forest and domain.

**Domain:** `wbstraining.internal`  
**NetBIOS Name:** `WBSTRAINING`  
**Domain Controller:** `Server1`  
**Domain Controller IP:** `192.168.100.10`

## Active Directory Domain Services

The Active Directory Domain Services role was installed on Server1.

Server1 was then promoted to a Domain Controller.

A new forest was created with the domain:

```text
wbstraining.internal
````

The NetBIOS domain name was configured as:

```text
WBSTRAINING
```

## Domain Controller Roles

Server1 currently provides:

* Active Directory Domain Services
* Domain Controller services
* DNS
* DHCP

## Domain Clients

The following Windows 11 clients were joined to the domain:

* Client1
* Client2

Both clients use Server1 as their internal DNS server.

## Domain Join

Client1 and Client2 were joined to:

```text
wbstraining.internal
```

After the domain join, the systems were restarted and domain logon was tested.

## Verification

The following commands were used to verify the domain environment.

Current user:

```powershell
whoami
```

Computer name:

```powershell
hostname
```

Current logon server:

```cmd
echo %logonserver%
```

Network and DNS configuration:

```powershell
ipconfig /all
```

DNS resolution:

```powershell
nslookup wbstraining.internal
nslookup Server1
```

## Current State

The Active Directory domain is operational.

Server1 acts as the Domain Controller and both Windows 11 clients are successfully joined to the domain.
