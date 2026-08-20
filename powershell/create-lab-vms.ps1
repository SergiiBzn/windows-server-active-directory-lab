# Windows Server / Active Directory Lab
# Hyper-V VM deployment script
# Creates three Windows Server VMs and two Windows 11 client VMs
# using differencing disks based on reusable VHDX templates.

$ServerTemplate = "C:\HyperV\Virtual Hard Disks\Vorlagen\Vorlage-Server.vhdx"
$ClientTemplate = "C:\HyperV\Virtual Hard Disks\Vorlagen\Vorlage-Client.vhdx"

$VMPath = "C:\HyperV\Virtual Machines"
$VHDPath = "C:\HyperV\Virtual Hard Disks"

$SwitchName = "Privat"

$VMs = @(
    @{
        Name     = "Server1"
        Template = $ServerTemplate
        VHD      = "$VHDPath\Server1.vhdx"
        Memory   = 4GB
        CPU      = 2
    },
    @{
        Name     = "Server2"
        Template = $ServerTemplate
        VHD      = "$VHDPath\Server2.vhdx"
        Memory   = 4GB
        CPU      = 2
    },
    @{
        Name     = "Server3"
        Template = $ServerTemplate
        VHD      = "$VHDPath\Server3.vhdx"
        Memory   = 4GB
        CPU      = 2
    },
    @{
        Name     = "Client1"
        Template = $ClientTemplate
        VHD      = "$VHDPath\Client1.vhdx"
        Memory   = 4GB
        CPU      = 2
    },
    @{
        Name     = "Client2"
        Template = $ClientTemplate
        VHD      = "$VHDPath\Client2.vhdx"
        Memory   = 4GB
        CPU      = 2
    }
)

foreach ($vm in $VMs) {

    Write-Host "Creating $($vm.Name)..."

    New-VHD `
        -Path $vm.VHD `
        -ParentPath $vm.Template `
        -Differencing

    New-VM `
        -Name $vm.Name `
        -Generation 2 `
        -MemoryStartupBytes $vm.Memory `
        -VHDPath $vm.VHD `
        -Path $VMPath `
        -SwitchName $SwitchName

    Set-VMProcessor `
        -VMName $vm.Name `
        -Count $vm.CPU

    Set-VMMemory `
        -VMName $vm.Name `
        -DynamicMemoryEnabled $false

    Set-VM `
        -Name $vm.Name `
        -AutomaticCheckpointsEnabled $false
}

Write-Host "Lab virtual machines created successfully."
