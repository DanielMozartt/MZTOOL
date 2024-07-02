Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

#Sincroniza o Horário do Sistema com o servidor Time.Windows.

net start w32time
w32tm /resync /force

#Criação do diretório C:\TOOL.

$TOOL = "C:\TOOL"

[System.IO.Directory]::CreateDirectory($TOOL)
$TOOLFOLDER = Get-Item $TOOL 
$TOOLFOLDER.Attributes = "Hidden" 

#Instalação do software AnyDesk Portátil na área de trabalho do usuário.

Start-Process powershell -Verb runAs -WindowStyle hidden {Invoke-WebRequest -Uri "https://download.anydesk.com/AnyDesk-CM.exe" -OutFile "$home\Desktop\AnyDesk.exe"} | Out-Null

Start-Process powershell -Verb runAs {

#Instalação do Winget.

Install-PackageProvider -Name NuGet -Force | Out-Null
Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null
Repair-WinGetPackageManager

#Instalação dos softwares Acrobat Reader, Microsoft Powershell 7+, Google Chrome. 

winget add "Adobe.Acrobat.Reader.64-bit" "Microsoft.Powershell" "Google.Chrome"  --accept-source-agreements --accept-package-agreements

winget add "Adobe.Acrobat.Reader.64-bit" "Microsoft.Powershell" "Google.Chrome"  --accept-source-agreements --accept-package-agreements

winget add "Adobe.Acrobat.Reader.64-bit" "Microsoft.Powershell" "Google.Chrome"  --accept-source-agreements --accept-package-agreements

exit

}

Start-Process powershell -Verb runAs {

#Instalação do módulo Windows Update.    

#Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
Install-PackageProvider -Name NuGet -Force
Install-Module PSWindowsUpdate -AllowClobber -Force
Import-Module PSWindowsUpdate -Force 

#Instalação de novas atualizações do Windows através do Windows update.

#Get-WindowsUpdate -Download -AcceptAll -Install -ForceInstall -IgnoreReboot -Verbose
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -Install -ForceInstall -IgnoreReboot -Verbose

exit

}

#Download do arquivo MZTOOL.zip.

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

#Extração do arquivo MZTOOL.zip para a pasta $TOOL.

Expand-Archive -LiteralPath $TOOL\MZTOOL.zip -DestinationPath $TOOL

#Instalação do software AnyDesk Portátil na pasta $TOOL\MZTOOL.

Start-Process powershell -Verb runAs -WindowStyle hidden {Invoke-WebRequest -Uri "https://download.anydesk.com/AnyDesk-CM.exe" -OutFile "$TOOL\MZTOOL\AnyDesk.exe"}

#Desativar o UAC.

REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f

#Deletar o arquivo MZTOOL.zip.

Remove-Item $TOOL\MZTOOL.zip

#Extração e inicialização do software Driver Booster.

Expand-Archive -LiteralPath $TOOL\MZTOOL\DRIVER_BOOSTER.zip -DestinationPath $TOOL\MZTOOL\

Start-Process $TOOL\MZTOOL\DRIVER_BOOSTER\DriverBoosterPortable.exe

#Intalação do software Microsoft Office 2007 e ADD-in's SaveAsPDF e ODFAddIn.

Invoke-Command -ScriptBlock {Start-Process "$TOOL\OFFICE\2007\Setup.exe" -ArgumentList "/adminfile Silent.msp" -Wait}

#Verificação e instalação de atualizações de softwares instalados e do Windows via Winget.

winget upgrade --all --accept-source-agreements --accept-package-agreements --silent --purge --skip-dependencies --include-unknown

Start-Sleep -Seconds 20

#Remover arquivos temporários.

Remove-Item -Path $env:TEMP\* -Recurse -Force -ErrorAction SilentlyContinue 

Remove-Item -Path $env:C:\Windows\temp\* -Recurse -Force -ErrorAction SilentlyContinue

Remove-Item -Path $env:C:\Windows\Prefetch\* -Recurse -Force -ErrorAction SilentlyContinue

Start-Sleep -Seconds 500

#Finaliza o serviço do software Driver Booster e deleta a pasta temporária do mesmo.

taskkill /f /IM DriverBooster.exe /T

Start-Sleep -Seconds 20

Remove-Item -Path $TOOL\MZTOOL\DRIVER_BOOSTER -Recurse -Force -ErrorAction SilentlyContinue

#Adiciona variável de ambiente %TOOL%.

[Environment]::SetEnvironmentVariable("TOOL", "C:\TOOL", "Machine")

#Reativar UAC.

REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f

exit

