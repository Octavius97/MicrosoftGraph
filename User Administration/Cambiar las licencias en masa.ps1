# Instalar Microsoft Graph
Install-Module -Name Microsoft.Graph

# Establecer la ejecución de scripts como remota
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Conectarse al modulo de Microsoft Graph con permisos de lectura y escritura de usuario y lectura de organización
Connect-MgGraph -Scopes User.ReadWrite.All, Organization.Read.All

# Variable de la licencia a remover
$M365_Premium = Get-MgSubscribedSku | Where-Object {$_.SkuPartNumber -eq "SPB"}

# Variable de la licencia a agregar
$M365_Standard = Get-MgSubscribedSku | Where-Object {$_.SkuPartNumber -eq "O365_BUSINESS_PREMIUM"}

# Obtener los usuarios de un CSV
$users = Import-Csv -Path "C:\users.csv"

# Recorrer los usuarios
foreach ($user in $users) {
    # Obtener el usuario
    $u = Get-MgUser -UserId $user.UserPrincipalName

    # Remover la licencia Microsoft 365 Premium
    Set-MgUserLicense -UserId $u.Id -AddLicenses @{} -RemoveLicenses @($M365_Premium.SkuId)

    # Agregar la licencia Microsoft 365 Standard
    Set-MgUserLicense -UserId $u.Id -AddLicenses @{SkuId = $M365_Standard.SkuId} -RemoveLicenses @()
}