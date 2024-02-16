# Conectarse a MSolService
$Cred = Get-Credential -UserName "admin_user@domain.com" -Message "Ingrese su contrasenia"
Connect-MsolService -Credential $Cred

#Obtener los usuarios
$users = Import-Csv -Path ".\path\to\csv\file.csv"
$date = [System.DateTime]::Today
$requeriments = @{RelyingParty = "*"; RememberDevicesNotIssuedBefore = $date; State = "Enforced"}

#Recorrer usuarios y establecer el authenticator en Enforced
foreach ($u in $users) {
    Set-MsolUser -UserPrincipalName $u.UPN -StrongAuthenticationRequirements $requeriments
}