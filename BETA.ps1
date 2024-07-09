Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

$Host.UI.RawUI.BackgroundColor = "DarkBlue"

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
    | |1| INSTALAÇÃO COMPLETA                            |
    | |2| DIAGNÓSTICO DE HARDWARE E SISTEMA              |
    | |3| INSTALAR WINGET & WINDOWS UPDATE               |
    | |4| SAIR                                           |
    |                                                    |
    |                 MOZART INFORMÁTICA | DANIEL MOZART |
    |____________________________________________________|
    "
    
    $MENU = Read-Host "INSIRA O NÚMERO CORRESPONDENTE A OPÇÃO DESEJADA"
    Switch ($MENU) {

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
            Start-Process "Powershell" -Verb runAs -Wait { Invoke-RestMethod https://raw.githubusercontent.com/DanielMozartt/MZTOOL/main/INSTALL.ps1 | Invoke-Expression }
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
        
            function DisplayMenu2 {
    
                Clear-Host
        
                Write-Host  "
            ______________________________________________________
            |                                                    |
            |                      MZTOOL                        |
            | _________________________________________________  | 
            |                                                    |
            |                                                    |
            | |1| ARQUITETURA X64 | 64Bits                       |
            | |2| ARQUITETURA X32 | 32Bits                       |
            | |3| VOLTAR                                         |
            |                                                    |
            |                                                    |
            |                 MOZART INFORMÁTICA | DANIEL MOZART |
            |____________________________________________________|
            "
                $SUBMENU2 = Read-Host "INSIRA O NÚMERO CORRESPONDENTE A OPÇÃO DESEJADA"
                Switch ($SUBMENU2) {
                    1 {
                        Clear-Host
                        Write-Host "
            ______________________________________________________
            |                                                    |
            |                      MZTOOL                        |
            | _________________________________________________  | 
            |                                                    |
            |                                                    |
            |                                                    |
            |        FERRAMENTAS DE DIAGNÓSTICO INICIADAS        |
            |                                                    |
            |                                                    |
            |                 MOZART INFORMÁTICA                 |
            |                   DANIEL MOZART                    |
            |____________________________________________________|
            "
                        DownloadMztool
           
                        Diagnostics64

                        Start-Sleep -Seconds 1

                        DelTemp
        
                        DisplayMenu
            
                    }
        
                    2 { 
                        Clear-Host
                        Write-Host "
                ______________________________________________________
                |                                                    |
                |                      MZTOOL                        |
                | _________________________________________________  | 
                |                                                    |
                |                                                    |
                |                                                    |
                |        FERRAMENTAS DE DIAGNÓSTICO INICIADAS        |
                |                                                    |
                |                                                    |
                |                 MOZART INFORMÁTICA                 |
                |                   DANIEL MOZART                    |
                |____________________________________________________|
                "
                        DownloadMztool 
               
                        Diagnostics32 

                        Start-Sleep -1

                        DelTemp
            
                        DisplayMenu
                    }
        
                    3 {

                        DisplayMenu
                
                    }
        
                    default {
                        #ENTRADA INVÁLIDA.
            
                        Write-Host "OPÇÃO INVÁLIDA. INSIRA O NÚMERO CORRESPONDENTE A OPÇÃO DESEJADA"
                        Start-Sleep -Seconds 2
                        DisplayMenu2
                    }
             
                }
                       
            }
            DisplayMenu2
        }

        3 {
            
            Update

            DisplayMenu

        }

        4 {
            #OPÇÃO 3 - ENCERRAR SISTEMA.

            Write-Host "ENCERRANDO MZTOOL"
            Start-Sleep -Seconds 2
            Break
            Exit-PSHostProcess
            Exit-PSSession
        }

        default {
            #ENTRADA INVÁLIDA.

            Write-Host "OPÇÃO INVÁLIDA. INSIRA O NÚMERO CORRESPONDENTE A OPÇÃO DESEJADA"
            Start-Sleep -Seconds 2
            DisplayMenu
        }
    }
    
}
#FUNÇÕES---------------------------------------------------------------


    
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
        
    #DESATIVAR O UAC.
    Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0        
    
}

function ReativarUAC {
    
    #REATIVAR O UAC.
    Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 5
   
}

function EnvTool {
    
    #Adicionar $env:Tool.
    [Environment]::SetEnvironmentVariable("TOOL", "C:\TOOL", "Machine")
    
}

function Diagnostics64 {
    
    Start-Process "Powershell" -Verb runAs -WindowStyle Hidden {

        Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0
        Start-Process C:\TOOL\MZTOOL\AIDA_64\aida64.exe
        Start-Process C:\TOOL\MZTOOL\BLUE_SCREEN_VIEW\BlueScreenView.exe
        Start-Process C:\TOOL\MZTOOL\CORE_TEMP\Core_Temp_64.exe
        Start-Process C:\TOOL\MZTOOL\CPU_Z\cpuz_x64.exe
        Start-Process C:\TOOL\MZTOOL\CRYSTAL_DISK\DiskInfo64.exe
        Start-Process C:\TOOL\MZTOOL\HDSENTINEL\HDSentinel.exe
        Start-Process C:\TOOL\MZTOOL\HWINFO\HWiNFO64.exe
        Start-Process C:\TOOL\MZTOOL\GPU_Z.exe
        Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 5
        Exit
    }   
}

function Diagnostics32 {
    
    Start-Process "Powershell" -Verb runAs -WindowStyle Hidden {
    
        Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0
            
        Start-Process "Powershell" -Verb runAs -WindowStyle Hidden {

            C:\TOOL\MZTOOL\AIDA_64\aida64.exe
            C:\TOOL\MZTOOL\BLUE_SCREEN_VIEW\BlueScreenView.exe
            C:\TOOL\MZTOOL\CORE_TEMP\Core_Temp_32.exe
            C:\TOOL\MZTOOL\CPU_Z\cpuz_x32.exe
            C:\TOOL\MZTOOL\CRYSTAL_DISK\DiskInfo32.exe
            C:\TOOL\MZTOOL\HDSENTINEL\HDSentinel.exe
            C:\TOOL\MZTOOL\HWINFO\HWiNFO32.exe
            C:\TOOL\MZTOOL\GPU_Z.exe

        }

        Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 5

        DelTemp
           
        Exit
    }   
}
#}

function Update {

    
    #INSTALAÇÃO DOS MÓDULOS WINGET E WINDOWS UPDATE.

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

        #WINDOWS UPDATE 

        #Instalação de novas atualizações do Windows através do Windows update.
        Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
        Get-WindowsUpdate -MicrosoftUpdate -Download -Install -AcceptAll -ForceInstall -IgnoreReboot 
              
    }
          
}

function Office2007 {

    Start-Process powershell -Verb runAs -WindowStyle hidden -Wait { 

        Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0

        Invoke-Command -ScriptBlock { Start-Process "$TOOL\OFFICE\2007\Setup.exe" -ArgumentList "/adminfile Silent.msp" -Wait }
   
    }
}

function DelTemp {

    #Remover arquivos temporários.

    Start-Sleep 3

    Remove-Item -Path $env:TEMP\* -Recurse -Force -ErrorAction SilentlyContinue 

    Remove-Item -Path $env:C:\Windows\temp\* -Recurse -Force -ErrorAction SilentlyContinue

    Remove-Item -Path $env:C:\Windows\Prefetch\* -Recurse -Force -ErrorAction SilentlyContinue
}

DisplayMenu  

Exit