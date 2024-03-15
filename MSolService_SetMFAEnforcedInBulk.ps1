# Conectarse a MSolService
$Cred = Get-Credential -UserName "admin_user@domain.com" -Message "Ingrese su contrasenia"
Connect-MsolService -Credential $Cred

Connect-MgGraph -Scopes DeviceManagementManagedDevices.Read.All, Device.Read.All, de

#Obtener los usuarios
$users = Import-Csv -Path ".\path\to\csv\file.csv"
$users = Get-MsolUser -All
$date = [System.DateTime]::Today
$requeriments = @{RelyingParty = "*"; RememberDevicesNotIssuedBefore = $date; State = "Enforced"}

#Recorrer usuarios y establecer el authenticator en Enforced
foreach ($u in $users) {
    Set-MsolUser -UserPrincipalName $u.UPN -StrongAuthenticationRequirements $requeriments -StrongAuthenticationMethods @{}
}

$users = Get-MsolUser -All
$requeriments = @{RelyingParty = "*"; RememberDevicesNotIssuedBefore = $date; State = "Enforced"}
foreach ($u in $users) {
    Set-MsolUser -UserPrincipalName $u.UPN -StrongAuthenticationRequirements $requeriments -StrongAuthenticationMethods @()
}