Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

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
    $OPTION1 = Start-Process "Powershell" -Verb runAs {irm https://raw.githubusercontent.com/DanielMozartt/MZTOOL/main/INSTALL.ps1 | iex}
    DisplayMenu
    }
    2 {
    #OPÇÃO 1 - DIAGNÓSTICO DE HARDWARE E SISTEMA.
    $OPTION2 = Write-Host "EM DESENVOLVIMENTO - SELECIONE UMA NOVA OPÇÃO"
    Start-Sleep -Seconds 5
    DisplayMenu
    }
    3 {
    #OPÇÃO 3 - ENCERRAR SISTEMA.
    $OPTION3
    Write-Host "ENCERRANDO MZTOOL"
    Start-Sleep -Seconds 5
    Break
    }
    default {
    #ENTRADA INVÁLIDA.
    Write-Host "OPÇÃO INVÁLIDA. INSIRA O NÚMERO CORRESPONDENTE A OPÇÃO DESEJADA"
    Start-Sleep -Seconds 2
    Exit
    }
    }
}
    DisplayMenu

    Exit