Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

$Host.UI.RawUI.BackgroundColor = "DarkBlue"

#Variável Global $TOOL.

$TOOL = "C:\TOOL"

#MENU MZTOOL -----------------------------------------------------

function DisplayMenu {
    Clear-Host
    Write-Host "
    ______________________________________________________
    |                                                    |
    |                      MZTOOL                        |
    | _________________________________________________  | 
    |                                                    |
    |                                                    |
    | |1| INSTALAR SOFTWARES E ATUALIZAÇÕES DO SISTEMA   |
    | |2| DIAGNÓSTICO DE HARDWARE E SISTEMA              |
    | |3| SAIR                                           |
    |                                                    |
    |                                                    |
    |                 MOZART INFORMÁTICA | DANIEL MOZART |
    |____________________________________________________|
    "
    
    $MENU = Read-Host "INSIRA O NÚMERO CORRESPONDENTE A OPÇÃO DESEJADA"
    Switch ($MENU)
    {

    1 {
    #OPÇÃO 1 - INSTALAR SOFTWARES E ATUALIZAÇÕES DO SISTEMA.

    Clear-Host
    Write-Host "
    
    ______________________________________________________
    |                                                    |
    |                      MZTOOL                        |
    | _________________________________________________  | 
    |                                                    |
    |                                                    |
    |                                                    |
    |                   EM INSTALAÇÃO                    |
    |                                                    |
    |                                                    |
    |                 MOZART INFORMÁTICA                 |
    |                   DANIEL MOZART                    |
    |____________________________________________________|
    "
    Start-Process "Powershell" -Verb runAs -Wait {Invoke-RestMethod https://raw.githubusercontent.com/DanielMozartt/MZTOOL/main/INSTALL.ps1 | Invoke-Expression}
    Clear-Host
    Write-Host "
    ______________________________________________________
    |                                                    |
    |                      MZTOOL                        |
    | _________________________________________________  | 
    |                                                    |
    |                                                    |
    |                                                    |
    |     INSTALAÇÃO CONCLUÍDA - ENCERRANDO MZTOOL       |
    |                                                    |
    |                                                    |
    |                 MOZART INFORMÁTICA                 |
    |                   DANIEL MOZART                    |
    |____________________________________________________|
    "
    Start-Sleep -Seconds 5
    Exit
    }

    2 {
    #OPÇÃO 2 - DIAGNÓSTICO DE HARDWARE E SISTEMA.
    Write-Host "EM DESENVOLVIMENTO, SELECIONE UMA NOVA OPÇÃO."
    Start-Sleep -Seconds 5
    DisplayMenu

    }
    

    3 {
    #OPÇÃO 3 - ENCERRAR SISTEMA.

    Write-Host "ENCERRANDO MZTOOL"
    Start-Sleep -Seconds 5
    Break
    }

    default {
    #ENTRADA INVÁLIDA.

    Write-Host "OPÇÃO INVÁLIDA. INSIRA O NÚMERO CORRESPONDENTE A OPÇÃO DESEJADA"
    Start-Sleep -Seconds 3
    DisplayMenu
    }
    }
}


#FUNÇÕES-------------------------

function DownloadMztool {

    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
    
    #Criação do diretório C:\TOOL.

    $TOOL = "C:\TOOL"
    
    #Se o diretório C:\TOOL já existir, é deletado.

    if ($TOOL) {
        Remove-Item -Path $TOOL -Recurse -Force -ErrorAction SilentlyContinue
    }

    [System.IO.Directory]::CreateDirectory($TOOL) | Out-Null
    $TOOLFOLDER = Get-Item $TOOL 
    $TOOLFOLDER.Attributes = "Hidden" 
    
    #Download do arquivo MZTOOL.zip

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

    #Deletar o arquivo MZTOOL.zip.

    Remove-Item $TOOL\MZTOOL.zip    
     
}

function DesativarUAC {
    Start-Process "Powershell" -Verb runAs -WindowStyle Hidden -Wait{      
    #DESATIVAR O UAC.
    REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f        
    }
}

function ReativarUAC {
    Start-Process "Powershell" -Verb runAs -WindowStyle Hidden -Wait{
    #REATIVAR O UAC.
    REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f
    }
}

function EnvTool {
    
    #Adicionar $env:Tool.
    [Environment]::SetEnvironmentVariable("TOOL", "C:\TOOL", "Machine")
    
}

function Diagnostics {
    
    #Iniciar softwares de diagnóstico.    
    Start-Process $env:TOOL\MZTOOL\AIDA_64\aida64.exe
    Start-Process $TOOL\MZTOOL\AIDA_64\aida64.exe
        
}

    DisplayMenu

Exit