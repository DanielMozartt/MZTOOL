Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

Start-Process powershell -Verb runAs {
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
Install-PackageProvider -Name NuGet -Force
Install-Module PSWindowsUpdate -AllowClobber -Force
Import-Module PSWindowsUpdate -Force 
Get-WindowsUpdate -Download -AcceptAll -Install -ForceInstall -IgnoreReboot -Verbose
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -Install -ForceInstall -IgnoreReboot -Verbose
}

<<<<<<< HEAD
=======
#Start-Process powershell -Verb runAs {Install-Module PSWindowsUpdate -AllowClobber -Force}

#Start-Process powershell -Verb runAs {Import-Module PSWindowsUpdate -Force} 

Install-WindowsUpdate -MicrosoftUpdate -WindowsUpdate -AcceptAll -Install -ForceDownload -ForceInstall  -IgnoreReboot

#Install-PackageProvider -Name NuGet -Force

#Install-Module PSWindowsUpdate -AllowClobber -Force

#Import-Module PSWindowsUpdate -Force

>>>>>>> fe3301a6362284430666c5b0ccbf606400be16bc
PAUSE

