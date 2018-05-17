---
layout: post
---

For convenience and to save costs stop and deallocate the development VM on Azure.

```powershell
# PowerShell -Command .\develop-vm.ps1 -PowerOn:$false
#
# Need to be able to run do set the security to unrestricted by opening
# Powershell as Administrator and running
#    Set-ExecutionPolicy Unrestricted
#
# Ensure the Powersh is available
#    Get-Module PowerShellGet -list | Select-Object Name,Version,Path
#
# The install the Powershell Azure Resource Manager
#    Install-Module AzureRM
#
# Choose between StandardLRS and PremiumLRS based on your scenario
[CmdletBinding()]
param(
  [switch]$PowerOn
)
if ($PowerOn) {
    Write-Warning "Switching to SSD and Powering Up"
    $storageType = 'PremiumLRS'
} else {
    Write-Warning "Powering Down and Switching to HDD"
	$storageType = 'StandardLRS'
}

# Create a saved context by first logging in
#    Login-AzureRMAccount
# Then save the context
#    $path = '.\develop-vm-context.json’
#    Save-AzureRmContext -Path $path -Force 
Import-AzureRmContext -Path (Get-Item -Path './develop-vm-context.json' -Verbose).FullName

# Get the VM
$rgName = 'develop-vm'
$vm = Get-AzureRmVM -ResourceGroupName $rgName -Name $rgName

# Stop and deallocate the VM before changing the storage type
Stop-AzureRmVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name -Force

# Get the disk
$diskName = 'develop-vm_OsDisk_1_9f12baf152024140aa5262b5f5d0c742'
$disk = Get-AzureRmDisk -DiskName $diskName -ResourceGroupName $rgName
# Update the storage type
$diskUpdateConfig = New-AzureRmDiskUpdateConfig -AccountType $storageType 
Update-AzureRmDisk -DiskUpdate $diskUpdateConfig -ResourceGroupName $rgName -DiskName $diskName

if ($PowerOn) {
    Write-Warning "Powering Up..."
    Start-AzureRmVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name
    Get-AzureRmRemoteDesktopFile -ResourceGroupName $rgName -Name $vm.Name -Launch
} else {
    Write-Warning "Powered Off"
}
```

Use this batch file to start.


```
PowerShell -Command .\develop-vm.ps1 -PowerOn:$true
pause
```