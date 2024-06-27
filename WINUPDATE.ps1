Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

Start-Process powershell -Verb runAs {

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

Install-PackageProvider -Name NuGet -Force

Install-Module PSWindowsUpdate -AllowClobber -Force

Import-Module PSWindowsUpdate -Force 

Get-WindowsUpdate -Download -AcceptAll -Install -ForceInstall -IgnoreReboot -Verbose

Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -Install -ForceInstall -IgnoreReboot -Verbose

}

PAUSE

