# Troubleshooting

This document contains troubleshooting steps and verification commands used during the Windows Server / Active Directory lab.

## Network Connectivity

Basic connectivity between servers and clients was tested with `ping`.

Examples:

```powershell
ping 192.168.100.10
ping 192.168.100.20
ping 192.168.100.1
````

If a system did not respond, the following points were checked:

* Correct IPv4 address
* Correct subnet mask
* Correct Hyper-V virtual switch
* Windows Firewall rules
* DNS configuration

## Windows Firewall and ICMP

During the lab, ICMP traffic was initially blocked by Windows Defender Firewall.

To allow connectivity testing with `ping`, the inbound rule for ICMP Echo Requests was enabled.

After enabling the rule, communication between the lab systems could be tested successfully.

## IP Configuration

The following command was used to verify network settings:

```powershell
ipconfig /all
```

Important values to check:

* IPv4 address
* Subnet mask
* Default gateway
* DNS server
* DHCP server
* DNS suffix

## DHCP Troubleshooting

If a client did not receive the expected network configuration, the DHCP lease was refreshed.

```powershell
ipconfig /release
ipconfig /renew
ipconfig /all
```

The DHCP server and active leases were also checked on Server1.

Expected DHCP range:

```text
192.168.100.100 - 192.168.100.200
```

## DNS Troubleshooting

DNS resolution was tested with:

```powershell
nslookup wbstraining.internal
nslookup Server1
```

The DNS cache could be cleared with:

```powershell
ipconfig /flushdns
```

DNS registration could be refreshed with:

```powershell
ipconfig /registerdns
```

All domain systems should use Server1 as the internal DNS server:

```text
192.168.100.10
```

## Domain Troubleshooting

The current user context was checked with:

```powershell
whoami
```

The computer name was checked with:

```powershell
hostname
```

The active logon server was checked with:

```cmd
echo %logonserver%
```

This helped verify that the clients were correctly joined to the domain and communicating with the Domain Controller.

## Result

The troubleshooting process included checking network connectivity, IPv4 configuration, Windows Firewall, DHCP, DNS and domain communication.

These checks helped verify that the lab environment was functioning correctly.
