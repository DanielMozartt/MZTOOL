Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$TOOL = "C:\TOOL"

[System.IO.Directory]::CreateDirectory($TOOL)
$TOOLFOLDER = Get-Item $TOOL
$TOOLFOLDER.Attributes = "Hidden"

#$progressPreference = 'silentlyContinue'
Write-Information "Downloading WinGet and its dependencies..."
Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx
Invoke-WebRequest -Uri https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx -OutFile Microsoft.UI.Xaml.2.8.x64.appx
Add-AppxPackage Microsoft.VCLibs.x64.14.00.Desktop.appx
Add-AppxPackage Microsoft.UI.Xaml.2.8.x64.appx
Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle

Start-Process powershell -Verb runAs -WindowStyle hidden {winget add "Adobe.Acrobat.Reader.64-bit" --accept-source-agreements --accept-package-agreements --silent} | Out-Null

Start-Process powershell -Verb runAs -WindowStyle hidden {winget add "Microsoft.Powershell" --accept-source-agreements --accept-package-agreements --silent} | Out-Null

Start-Process powershell -Verb runAs -WindowStyle hidden {iwr -Uri "https://download.anydesk.com/AnyDesk-CM.exe" -OutFile "$home\Desktop\AnyDesk.exe"} | Out-Null

Start-Process powershell -Verb runAs -WindowStyle hidden{

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
Install-PackageProvider -Name NuGet -Force
Install-Module PSWindowsUpdate -AllowClobber -Force
Import-Module PSWindowsUpdate -Force 
Get-WindowsUpdate -Download -AcceptAll -Install -ForceInstall -IgnoreReboot -Verbose
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -Install -ForceInstall -IgnoreReboot -Verbose

}

Start-Process powershell -Verb runAs -WindowStyle hidden {winget add "Google.Chrome" --accept-source-agreements --accept-package-agreements --silent} | Out-Null

$webClient = New-Object -TypeName System.Net.WebClient
$task = $webClient.DownloadFileTaskAsync('https://seulink.net/TOOLZIP', "$TOOL\#TOOL#ZIP.zip")

Register-ObjectEvent -InputObject $webClient -EventName DownloadProgressChanged -SourceIdentifier WebClient.DownloadProgressChanged | Out-Null

Start-Sleep -Seconds 3

while (!($task.IsCompleted)) {
    $EventData = Get-Event -SourceIdentifier WebClient.DownloadProgressChanged | Select-Object -ExpandProperty "SourceEventArgs" -Last 1

    $ReceivedData = ($EventData | Select-Object -ExpandProperty "BytesReceived")
    $TotalToReceive = ($EventData | Select-Object -ExpandProperty "TotalBytesToReceive")
    $TotalPercent = $EventData | Select-Object -ExpandProperty "ProgressPercentage"

    Start-Sleep -Seconds 2

function convertFileSize {
    param(
        $bytes
    )

    if ($bytes -lt 1MB) {
        return "$([Math]::Round($bytes / 1KB, 2)) KB"
    }
    elseif ($bytes -lt 1GB) {
        return "$([Math]::Round($bytes / 1MB, 2)) MB"
    }
    elseif ($bytes -lt 1TB) {
        return "$([Math]::Round($bytes / 1GB, 2)) GB"
    }
}
    Write-Progress -Activity "Downloading File" -Status "Percent Complete: $($TotalPercent)%" -CurrentOperation "Downloaded $(convertFileSize -bytes $ReceivedData) / $(convertFileSize -bytes $TotalToReceive)" -PercentComplete $TotalPercent

}

Unregister-Event -SourceIdentifier WebClient.DownloadProgressChanged
$webClient.Dispose()

Expand-Archive -LiteralPath $TOOL\#TOOL#ZIP.zip -DestinationPath $TOOL

Start-Process powershell -Verb runAs -WindowStyle hidden {iwr -Uri "https://download.anydesk.com/AnyDesk-CM.exe" -OutFile "$TOOL\#TOOL#ZIP\AnyDesk.exe"}

REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f

del $TOOL\#TOOL#ZIP.zip

Expand-Archive -LiteralPath $TOOL\#TOOL#ZIP\DRIVER_BOOSTER_7.5_PORTABLE.zip -DestinationPath $TOOL\#TOOL#ZIP\

start $TOOL\#TOOL#ZIP\DRIVER_BOOSTER_7.5_PORTABLE\DriverBoosterPortable.exe

Invoke-Command -ScriptBlock {Start-Process "$TOOL\OFFICE\2007\SaveAsPdf.EXE" -ArgumentList "/quiet" -Wait}

msiexec /i $TOOL\OFFICE\2007\ODF\OdfAddInForOfficeSetup.msi /q ALLUSERS=1

Invoke-Command -ScriptBlock {Start-Process "$TOOL\OFFICE\2007\SETUP\setup.exe" -ArgumentList "/adminfile Silent.msp" -Wait}

winget upgrade --all --accept-source-agreements --accept-package-agreements --silent --purge --skip-dependencies --include-unknown

Start-Sleep -Seconds 20

Remove-Item -Path $env:TEMP\* -Recurse -Force -ErrorAction SilentlyContinue 

Remove-Item -Path $env:C:\Windows\temp\* -Recurse -Force -ErrorAction SilentlyContinue

Remove-Item -Path $env:C:\Windows\Prefetch\* -Recurse -Force -ErrorAction SilentlyContinue

taskkill /f /IM DriverBooster.exe /T

Start-Sleep -Seconds 5

Remove-Item -Path $TOOL\#TOOL#ZIP\DRIVER_BOOSTER_7.5_PORTABLE -Recurse -Force -ErrorAction SilentlyContinue

#Remove-Item -Path $TOOL -Recurse -Force -ErrorAction SilentlyContinue

#[Environment]::SetEnvironmentVariable("TOOL", "C:\TOOL", "Machine")

REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f

exit