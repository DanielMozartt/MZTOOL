Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

#MENU MZTOOL.
function DisplayMenu {
    Clear-Host
    Write-Host "
    +===============================================+
    |  MZTOOL - MOZART INFORMÁTICA - DANIEL MOZART  | 
    +===============================================+
    |                                               |
    |1| INSTALAR SOFTWARES E ATUALIZAÇÕES DO SISTEMA|
    |2| DIAGNÓSTICO DE HARDWARE E SISTEMA           |
    |3| SAIR                                        |
    +===============================================+
    
    "
    
    $MENU = Read-Host "OPTION"
    Switch ($MENU)
    {
    1 {
    #OPÇÃO 1 - INSTALAR SOFTWARES E ATUALIZAÇÕES DO SISTEMA
    $OPTION1 = Read-Host "HOST"
    Test-Connection -ComputerName $OPTION1
    Start-Sleep -Seconds 2
    DisplayMenu
    }
    2 {
    #OPTION2 - DISPLAY MESSAGE
    $OPTION2 = Read-Host "MESSAGE"
    Write-Host "MESSAGE: $OPTION2"
    Start-Sleep -Seconds 2
    DisplayMenu
    }
    3 {
    #OPTION3 - EXIT
    Write-Host "Bye"
    Break
    }
    default {
    #DEFAULT OPTION
    Write-Host "Option not available"
    Start-Sleep -Seconds 2
    DisplayMenu
    }
    }
}
    DisplayMenu