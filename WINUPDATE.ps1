Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

Start-Process powershell -Verb runAs {Install-PackageProvider -Name NuGet -Force}

Start-Process powershell -Verb runAs {Install-Module PSWindowsUpdate -AllowClobber -Force}

Start-Process powershell -Verb runAs {Import-Module PSWindowsUpdate -Force} 

Get-WindowsUpdate -Install -Verbose

#Install-PackageProvider -Name NuGet -Force

#Install-Module PSWindowsUpdate -AllowClobber -Force

#Import-Module PSWindowsUpdate -Force

PAUSE

