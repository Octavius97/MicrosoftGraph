# Inicio del Modulo

$opcion = $null
while ($opcion -notmatch "^[1-6]$") {
    Write-Host "Seleccione el modulo a conectarse"
    Write-Host "1. Microsoft Graph"
    Write-Host "2. Azure AD Graph"
    Write-Host "3. Microsoft Online Services"
    Write-Host "4. Exchange Online"
    Write-Host "5. SharePoint Online"
    Write-Host "6. Cerrar"
    $opcion = Read-Host "Seleccione una opcion"
    if($opcion -notmatch "^[1-6]$") {
        [System.Console]::ForegroundColor = "Red"
        Write-Host "Opcion no valida"
        [System.Console]::WriteLine()
        [System.Console]::ResetColor()
    }
}


switch ($opcion) {
    1 {
        Connect-MgGraph -Scopes "User.Read.All", "Group.Read.All", "Directory.Read.All", "User.ReadWrite.All", "Group.ReadWrite.All", "Directory.ReadWrite.All"
    }
    2 {
        Import-Module AzureAD
        $username = Read-Host "Ingrese el nombre del usuario: "
        $password = Read-Host "Ingrese la contraseña: " -AsSecureString
        $credential = New-Object System.Management.Automation.PSCredential ($username, $password)
        Connect-AzureAD -Credential $credential
    }
    3 {
        Import-Module MSOnline
        $username = Read-Host "Ingrese el nombre del usuario: "
        $password = Read-Host "Ingrese la contraseña: " -AsSecureString
        $credential = New-Object System.Management.Automation.PSCredential ($username, $password)
        Connect-MsolService -Credential $credential 
    }
    4 {
        import-module ExchangeOnlineManagement
        $username = Read-Host "Ingrese el nombre del usuario: "
        $password = Read-Host "Ingrese la contraseña: " -AsSecureString
        $credential = New-Object System.Management.Automation.PSCredential ($username, $password)
        Connect-ExchangeOnline -Credential $credential
    }
    5 {
        Import-Module Microsoft.Online.SharePoint.PowerShell
        $username = Read-Host "Ingrese el nombre del usuario: "
        $password = Read-Host "Ingrese la contraseña: " -AsSecureString
        $credential = New-Object System.Management.Automation.PSCredential ($username, $password)
        $tenant = Read-Host "Ingrese el nombre del tenant: "
        Connect-SPOService -Url "https://$tenant-admin.sharepoint.com" -Credential $credential
    }
    6 {
        Write-Host "Bye"
        exit
    }
}

# Cerrar la conexión del módulo si la ventana se cierra
$null = Register-EngineEvent -SourceIdentifier ([System.Management.Automation.PSEngineEvent]::Exiting) -Action {
    switch ($opcion) {
        1 {
            Disconnect-MgGraph
        }
        2 {
            Disconnect-AzureAD
        }
        3 {
            Disconnect-MsolService
        }
        4 {
            Disconnect-ExchangeOnline
        }
        5 {
            Disconnect-SPOService
        }
    }
}
