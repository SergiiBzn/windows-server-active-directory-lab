# Hyper-V Setup

This document describes how the virtual machines for the lab were prepared and created in Hyper-V.

## Virtual Machine Templates

Reusable templates were created for:

- Windows Server 2022
- Windows 11

The templates were used as parent virtual disks for the lab virtual machines.

## Windows Server Template

The Windows Server template was created using Windows Server 2022 Standard Evaluation with Desktop Experience.

After installation, the system was prepared for reuse with:

- Audit Mode
- Sysprep
- Generalize
- OOBE
- Shutdown

This created a clean reusable Windows Server image.

## Windows 11 Template

A Windows 11 template was prepared using the same general approach.

The template was later used to create the Windows 11 domain clients.

## Template Storage

The parent VHDX files were stored separately from the lab virtual machines.

Example:

```text
C:\HyperV\Virtual Hard Disks\Vorlagen\
````

Template files:

```text
Vorlage-Server.vhdx
Vorlage-Client.vhdx
```

The parent template disks should not be moved, renamed or modified while Differencing Disks depend on them.

## Differencing Disks

The lab virtual machines were created using Differencing Disks.

This allows multiple virtual machines to use a common parent template while storing their individual changes in separate virtual disks.

Benefits:

* Reduced disk usage
* Faster VM deployment
* Reusable lab environment
* Consistent base configuration

## Lab Virtual Machines

The following virtual machines were created:

| VM      | Template            |
| ------- | ------------------- |
| Server1 | Windows Server 2022 |
| Server2 | Windows Server 2022 |
| Server3 | Windows Server 2022 |
| Client1 | Windows 11          |
| Client2 | Windows 11          |

## PowerShell Automation

PowerShell was used to automate the creation and configuration of the virtual machines.

Important commands included:

```powershell
New-VHD
New-VM
Set-VMProcessor
Set-VMMemory
Set-VM
```

Differencing Disks were created with:

```powershell
New-VHD -Path $vm.VHD -ParentPath $vm.Template -Differencing
```

Automatic checkpoints were disabled for the lab virtual machines:

```powershell
Set-VM -Name $vm.Name -AutomaticCheckpointsEnabled $false
```

## Result

The Hyper-V environment contains three Windows Server virtual machines and two Windows 11 client virtual machines based on reusable templates.

This provides the foundation for the Active Directory, DNS, DHCP and networking configuration used in the rest of the lab.
