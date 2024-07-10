Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# Get the ID and security principal of the current user account
$myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($myWindowsID)
  
# Get the security principal for the Administrator role
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator
  
# Check to see if we are currently running "as Administrator"
if ($myWindowsPrincipal.IsInRole($adminRole)) {
    # We are running "as Administrator" - so change the title and background color to indicate this
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + '(Elevated)'
    $Host.UI.RawUI.BackgroundColor = 'DarkBlue'
    Clear-Host
}
else {
    # We are not running "as Administrator" - so relaunch as administrator
    
    # Create a new process object that starts PowerShell
    $newProcess = New-Object System.Diagnostics.ProcessStartInfo 'PowerShell'
    
    # Specify the current script path and name as a parameter
    $newProcess.Arguments = $myInvocation.MyCommand.Definition
    
    # Indicate that the process should be elevated
    $newProcess.Verb = 'runas'
    
    # Start the new process
    [System.Diagnostics.Process]::Start($newProcess)
    
    # Exit from the current, unelevated, process
    exit
}
  

$Host.UI.RawUI.BackgroundColor = 'DarkBlue'

[Environment]::SetEnvironmentVariable('TOOL', 'C:\TOOL', 'Machine') | Out-Null


#MENU MZTOOL -----------------------------------------------------

function DisplayMenu {
    Clear-Host
    Write-Host '
    ______________________________________________________
    |                                                    |
    |                      MZTOOL                        |
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
            DownloadMztool
            Office2007
            DriverBooster
            ModuleUpdate
            WingetInstall
            Update
            DelTemp

                     
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
            |        FERRAMENTAS DE DIAGNÓSTICO INICIADAS        |
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
                |        FERRAMENTAS DE DIAGNÓSTICO INICIADAS        |
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
                        Update 

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
                        DownloadMztool
              
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

                    Default {
                        #ENTRADA INVÁLIDA.

                        Write-Host 'OPÇÃO INVÁLIDA. INSIRA O NÚMERO CORRESPONDENTE A OPÇÃO DESEJADA'
                        Start-Sleep -Seconds 1
                        DisplayMenu4 
                    }
                }

            }
            DisplayMenu4
        } 

        0 {
            #OPÇÃO 3 - ENCERRAR SISTEMA.

            Write-Host 'ENCERRANDO MZTOOL'
            Start-Sleep -Seconds 1
            Break
            Exit-PSHostProcess
            Exit-PSSession
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

    net start w32time | Out-Null
    w32tm /resync /force | Out-Null

}
    
function DownloadMztool {

    #Criação do diretório C:\TOOL.

    $TOOL = 'C:\TOOL'
    
    #Se o diretório C:\TOOL já existir, é deletado.

    if ($TOOL) {

        Remove-Item -Path $TOOL -Recurse -Force -ErrorAction SilentlyContinue
    }

    [System.IO.Directory]::CreateDirectory($TOOL) | Out-Null
    $TOOLFOLDER = Get-Item $TOOL 
    $TOOLFOLDER.Attributes = 'Hidden' 
    
    #Download do arquivo MZTOOL.zip

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

function DesativarUAC {
        
    #DESATIVAR O UAC.
    Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0        
    
}

function ReativarUAC {
    
    #REATIVAR O UAC.
    Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 5
   
}

function EnvTool {
    
    #Adicionar variáveis de ambiente.
    [Environment]::SetEnvironmentVariable('TOOL', 'C:\TOOL', 'Machine') 
    [Environment]::SetEnvironmentVariable('MZTOOL', 'https://seulink.net/MZTBETA', 'MACHINE') 
   
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
        
}

function Diagnostics32 {
              
    Start-Process C:\TOOL\MZTOOL\AIDA_64\aida64.exe
    Start-Process C:\TOOL\MZTOOL\BLUE_SCREEN_VIEW\BlueScreenView.exe
    Start-Process C:\TOOL\MZTOOL\CORE_TEMP\Core_Temp_32.exe
    Start-Process C:\TOOL\MZTOOL\CPU_Z\cpuz_x32.exe
    Start-Process C:\TOOL\MZTOOL\CRYSTAL_DISK\DiskInfo32.exe
    Start-Process C:\TOOL\MZTOOL\HDSENTINEL\HDSentinel.exe
    Start-Process C:\TOOL\MZTOOL\HWINFO\HWiNFO32.exe
    Start-Process C:\TOOL\MZTOOL\GPU_Z.exe
        
}


function ModuleUpdate {

    
    #INSTALAÇÃO DOS MÓDULOS WINGET E WINDOWS UPDATE.       
    
    #Pacote NuGet.
    Install-PackageProvider -Name NuGet -Force 
        
    #Módulo WINGET.
    Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery 
    Repair-WinGetPackageManager
    Winget Source Remove --Name Winget
    Remove-Item -Path $env:TEMP\* -Recurse -Force -ErrorAction SilentlyContinue 
    Invoke-WebRequest -Uri 'https://cdn.winget.microsoft.com/cache/source.msix' -OutFile "$env:TEMP\source.msix"
    Add-AppPackage -Path "$env:TEMP\source.msix"
    Winget Source Reset --Force            
        
    #Módulo WINDOWS UPDATE.
    Install-Module PSWindowsUpdate -AllowClobber -Force
    Import-Module PSWindowsUpdate -Force         
        
    #Atualização de pacotes de softwares instalados.

    #Instalação de novas atualizações do Windows através do Windows Update.
        
       
              
}

function WingetInstall {
    
    #WINGET
                  
    #Instalação dos softwares Acrobat Reader, Microsoft Powershell 7+, Google Chrome. 
           
    while ($i -ne 3) {
                
            
        Winget Install --Id Microsoft.Powershell --Accept-Source-Agreements --Accept-Package-Agreements
           
        Winget Install --Id Adobe.Acrobat.Reader.64-bit --Accept-Source-Agreements --Accept-Package-Agreements

        Winget Install --Id Google.Chrome --Accept-Source-Agreements --Accept-Package-Agreements

        $i++

    }
}
function Update { 
    
    #Atualização de pacotes de softwares instalados.
    Winget Upgrade --All --Accept-Source-Agreements --Accept-Package-Agreements --Include-Unknown
    
    #Instalação de novas atualizações do Windows através do Windows Update.
    Get-WindowsUpdate -MicrosoftUpdate -Download -Install -AcceptAll -ForceInstall -IgnoreReboot
      
}

function AnyDesk {

    Invoke-WebRequest -Uri 'https://download.anydesk.com/AnyDesk-CM.exe' -OutFile "$home\Desktop\AnyDesk.exe"
       
}

function Office365 {

    $TOOL = 'C:\TOOL'

    [xml]$XML = @'
<Configuration ID="646616bb-84c9-4354-9908-8abd74c04f4c">
  <Add OfficeClientEdition="64" Channel="Current" MigrateArch="TRUE">
    <Product ID="O365BusinessEEANoTeamsRetail">
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

    #Winget Install --Id 9WZDNCRD29V9 --Override "/configure $365XML" --Accept-Source-Agreements --Accept-Package-Agreements
    Winget Install --Id 9WZDNCRD29V9 --Accept-Source-Agreements --Accept-Package-Agreements
 
}
    
function Office2007 {

    $TOOL = 'C:\TOOL'
   
    Start-Process "$TOOL\OFFICE\2007\Setup.exe" -ArgumentList '/adminfile Silent.msp'

    Start-Process 'winword'
      
}

function DriverBooster {
    
    $TOOL = 'C:\TOOL'

    Expand-Archive -LiteralPath "$TOOL\MZTOOL\DRIVER_BOOSTER.zip" -DestinationPath "$TOOL\MZTOOL\DRIVER_BOOSTER"

    Start-Process "$TOOL\MZTOOL\DRIVER_BOOSTER\DriverBoosterPortable.exe"

    Start-Sleep -Seconds 30

    #Finaliza o serviço do software Driver Booster e deleta a pasta temporária do mesmo.

    Stop-Process -Name 'DriverBooster' -Force

    Start-Sleep -Seconds 10

    Remove-Item -Path "$TOOL\MZTOOL\DRIVER_BOOSTER" -Recurse -Force -ErrorAction SilentlyContinue

}



function DelTemp {

    #Remover arquivos temporários.

    Remove-Item -Path $env:TEMP\* -Recurse -Force -ErrorAction SilentlyContinue 

    Remove-Item -Path $env:C:\Windows\temp\* -Recurse -Force -ErrorAction SilentlyContinue

    Remove-Item -Path $env:C:\Windows\Prefetch\* -Recurse -Force -ErrorAction SilentlyContinue
}


DelTemp

EnvTool

DisplayMenu 

Exit

# Run your code that needs to be elevated here
Write-Host -NoNewline 'Press any key to continue...'
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')

Exit