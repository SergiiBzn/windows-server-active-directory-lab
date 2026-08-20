# PowerShell Scripts

This folder contains PowerShell scripts used in the Windows Server / Active Directory lab.

## create-lab-vms.ps1

The script creates the five Hyper-V virtual machines used in the lab:

- Server1
- Server2
- Server3
- Client1
- Client2

The virtual machines are created from reusable Windows Server 2022 and Windows 11 VHDX templates.

The script uses Hyper-V Differencing Disks to reduce disk usage and simplify VM deployment.

## Requirements

Before running the script:

- Hyper-V must be installed and enabled
- The Hyper-V virtual switch `Privat` must already exist
- The Windows Server template must exist
- The Windows 11 template must exist
- PowerShell must be started with administrative privileges

Expected template paths:

```text
C:\HyperV\Virtual Hard Disks\Vorlagen\Vorlage-Server.vhdx
C:\HyperV\Virtual Hard Disks\Vorlagen\Vorlage-Client.vhdx
````

## Main PowerShell Commands

The script uses the following Hyper-V cmdlets:

```powershell
New-VHD
New-VM
Set-VMProcessor
Set-VMMemory
Set-VM
```

## Deployment

Run the script from an elevated PowerShell session:

```powershell
.\create-lab-vms.ps1
```

The script creates three Windows Server virtual machines and two Windows 11 client virtual machines.

## Important

The parent VHDX templates must not be moved, renamed or modified after the Differencing Disks have been created.

The child virtual disks depend on the original parent templates.
