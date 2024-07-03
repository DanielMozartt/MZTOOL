Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

$Host.UI.RawUI.BackgroundColor = "DarkBlue"

#MENU MZTOOL.
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

    Write-Host "EM INSTALAÇÃO"
    Start-Process "Powershell" -Verb runAs -WindowStyle Hidden -Wait{Invoke-RestMethod https://raw.githubusercontent.com/DanielMozartt/MZTOOL/main/INSTALL.ps1 | Invoke-Expression}
    Write-Host "ENCERRANDO MZTOOL"
    Start-Sleep -Seconds 5
    Exit
    }

    2 {
    #OPÇÃO 2 - DIAGNÓSTICO DE HARDWARE E SISTEMA.

    Write-Host "EM DESENVOLVIMENTO - SELECIONE UMA NOVA OPÇÃO"
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
    DisplayMenu

Exit