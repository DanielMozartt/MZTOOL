md "$TOOL"

attrib +h "$TOOL"

Start-Process powershell -Verb runAs -WindowStyle hidden {winget add "Google.Chrome" --silent} | Out-Null

Start-Process powershell -Verb runAs -WindowStyle hidden {winget add "Adobe.Acrobat.Reader.64-bit" --silent} | Out-Null

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

$TOOL = "C:\TOOL"

Expand-Archive -LiteralPath '$TOOL\#TOOL#ZIP.zip' -DestinationPath $TOOL

del $TOOL\#TOOL#ZIP.zip

REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f

iwr -Uri "https://download.anydesk.com/AnyDesk-CM.exe" -OutFile "$TOOL\#TOOL#ZIP\AnyDesk.exe"

copy $TOOL\#TOOL#ZIP\TOOL.lnk $home\desktop

copy $TOOL\#TOOL#ZIP\AnyDesk.exe $home\desktop

Expand-Archive -LiteralPath '$TOOL\#TOOL#ZIP\DRIVER_BOOSTER_7.5_PORTABLE.zip' -DestinationPath $TOOL\#TOOL#ZIP\

start $TOOL\#TOOL#ZIP\DRIVER_BOOSTER_7.5_PORTABLE\DriverBoosterPortable.exe

Start-Process powershell -Verb runAs -WindowStyle hidden {Invoke-Command -ScriptBlock {Start-Process "$TOOL\OFFICE\2007\SETUP\setup.exe" -ArgumentList "/adminfile Silent.msp"}}

winget upgrade --all --accept-source-agreements --accept-package-agreements --silent

Invoke-Command -ScriptBlock {Start-Process "$TOOL\OFFICE\2007\SaveAsPdf.EXE" -ArgumentList "/quiet" -Wait}

msiexec /i $TOOL\OFFICE\2007\ODF\OdfAddInForOfficeSetup.msi /q ALLUSERS=1

timeout /t 100

Remove-Item -Path $env:TEMP\* -Recurse -Force -ErrorAction SilentlyContinue 

Remove-Item -Path $env:c:\Windows\temp\* -Recurse -Force -ErrorAction SilentlyContinue

Remove-Item -Path $env:c:\Windows\Prefetch\* -Recurse -Force -ErrorAction SilentlyContinue

taskkill /f /IM DriverBooster.exe /T

Remove-Item -Path ${TOOL}\#TOOL#ZIP\DRIVER_BOOSTER_7.5_PORTABLE -Recurse -Force -ErrorAction SilentlyContinue

REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f

exit

exit
