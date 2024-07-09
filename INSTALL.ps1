Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

$Host.UI.RawUI.BackgroundColor = "DarkBlue"

#Sincroniza o Horário do Sistema com o servidor Time.Windows.
Start-Process powershell -Verb runAs -WindowStyle hidden {
    net start w32time | Out-Null
    w32tm /resync /force | Out-Null
}
#Criação do diretório C:\TOOL.

$TOOL = "C:\TOOL"

#Se o diretório C:\TOOL já existir, é deletado.

if ($TOOL) {
    Remove-Item -Path $TOOL -Recurse -Force -ErrorAction SilentlyContinue
}

[System.IO.Directory]::CreateDirectory($TOOL) | Out-Null
$TOOLFOLDER = Get-Item $TOOL 
$TOOLFOLDER.Attributes = "Hidden" 

#Instalação do software AnyDesk Portátil na área de trabalho do usuário.

Start-Process powershell -Verb runAs -WindowStyle hidden { Invoke-WebRequest -Uri "https://download.anydesk.com/AnyDesk-CM.exe" -OutFile "$home\Desktop\AnyDesk.exe" } | Out-Null

Start-Process powershell -Verb runAs {
        
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
    Install-PackageProvider -Name NuGet -Force 
        
    #Módulo WINGET.
    Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery 
    Repair-WinGetPackageManager
    winget source remove --name winget
    Remove-Item -Path $env:TEMP\* -Recurse -Force -ErrorAction SilentlyContinue 
    Invoke-WebRequest -Uri "https://cdn.winget.microsoft.com/cache/source.msix" -OutFile "$env:TEMP\source.msix"
    Add-AppPackage -path "$env:TEMP\source.msix"
    winget source reset --force
    winget source list       
        
    #Módulo WINDOWS UPDATE.
    Install-Module PSWindowsUpdate -AllowClobber -Force
    Import-Module PSWindowsUpdate -Force 

        
    #WINGET
                  
    #Instalação dos softwares Acrobat Reader, Microsoft Powershell 7+, Google Chrome. 
            
    while ($i -ne 5) {
                
            
        winget install --id Microsoft.Powershell --accept-source-agreements --accept-package-agreements
           
        winget install --id Adobe.Acrobat.Reader.64-bit --accept-source-agreements --accept-package-agreements

        winget install --id Google.Chrome --accept-source-agreements --accept-package-agreements

        $i++

    }

    while ($j -ne 3) {
           
        winget upgrade --all --accept-source-agreements --accept-package-agreements
            
        $j++

    }

    Start-Sleep -Seconds 5

    #Remover arquivos temporários.

    Remove-Item -Path $env:TEMP\* -Recurse -Force -ErrorAction SilentlyContinue 

    Remove-Item -Path $env:C:\Windows\temp\* -Recurse -Force -ErrorAction SilentlyContinue

    Remove-Item -Path $env:C:\Windows\Prefetch\* -Recurse -Force -ErrorAction SilentlyContinue
           

    #WINDOWS UPDATE 

    #Instalação de novas atualizações do Windows através do Windows update.
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
    Get-WindowsUpdate -MicrosoftUpdate -Download -Install -AcceptAll -ForceInstall -IgnoreReboot 

    Start-Sleep -Seconds 5

    #Remover arquivos temporários.

    Remove-Item -Path $env:TEMP\* -Recurse -Force -ErrorAction SilentlyContinue 

    Remove-Item -Path $env:C:\Windows\temp\* -Recurse -Force -ErrorAction SilentlyContinue

    Remove-Item -Path $env:C:\Windows\Prefetch\* -Recurse -Force -ErrorAction SilentlyContinue
            
        
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

Start-Process powershell -Verb runAs -WindowStyle hidden { Invoke-WebRequest -Uri "https://download.anydesk.com/AnyDesk-CM.exe" -OutFile "$TOOL\MZTOOL\AnyDesk.exe" }

#Desativar o UAC.

#Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0

#Deletar o arquivo MZTOOL.zip.

Remove-Item $TOOL\MZTOOL.zip

#Extração e inicialização do software Driver Booster.

Expand-Archive -LiteralPath $TOOL\MZTOOL\DRIVER_BOOSTER.zip -DestinationPath $TOOL\MZTOOL\DRIVER_BOOSTER

Start-Process $TOOL\MZTOOL\DRIVER_BOOSTER\DriverBoosterPortable.exe

#Intalação do software Microsoft Office 2007 e ADD-in's SaveAsPDF e ODFAddIn.

Invoke-Command -ScriptBlock { Start-Process "$TOOL\OFFICE\2007\Setup.exe" -ArgumentList "/adminfile Silent.msp" -Wait }

#Verificação e instalação de atualizações de softwares instalados e do Windows via Winget.

winget upgrade --all --accept-source-agreements --accept-package-agreements --silent --skip-dependencies --include-unknown

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

#Informa estado de ativação do Windows.

slmgr /xpr

#Reativar UAC.

#Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 5

exit

