Clear-History
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" `"$args`"" -Verb RunAs; exit }
cls
$ProgressPreference = "SilentlyContinue"
Get-Disk
sleep -Seconds 1
""
$disk = Read-Host "Select Disk Number"
""
$name = Read-Host "New Drive name"

Stop-Service -Name ShellHWDetection

""
"Removing DATA from selected device!"
Get-Disk $disk | Clear-Disk -RemoveData -RemoveOEM -Confirm:$false
sleep -Seconds 1

""
"Formatting selected device!"
New-Partition -DiskNumber $disk -UseMaximumSize -AssignDriveLetter | Format-Volume -FileSystem NTFS -NewFileSystemLabel $name

Restart-Service -Name ShellHWDetection
sleep -Seconds 1

""
"The selected drive has been formatted"

sleep -Seconds 5
Exit