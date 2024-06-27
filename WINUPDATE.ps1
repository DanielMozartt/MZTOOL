Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

Start-Process powershell -Verb runAs -WindowStyle hidden {Install-PackageProvider -Name NuGet -Force} | Out-Null

Start-Process powershell -Verb runAs -WindowStyle hidden {Install-Module PSWindowsUpdate -AllowClobber -Force} | Out-Null

Start-Process powershell -Verb runAs -WindowStyle hidden {Import-Module PSWindowsUpdate -Force} | Out-Null

#Install-PackageProvider -Name NuGet -Force

#Install-Module PSWindowsUpdate -AllowClobber -Force

#Import-Module PSWindowsUpdate -Force

PAUSE

