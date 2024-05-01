Connect-MgGraph -Scopes User.ReadWrite.All, UserAuthenticationMethod.ReadWrite.All

$user = Get-MgUser -UserId "ana.garcia@beemead.cloudns.biz"

#Obtener los métodos de autenticación del usuario.
Get-MgUserAuthenticationMethod -UserId $user.Id | Format-List

#Agregar autenticación por SMS
New-MgUserAuthenticationPhoneMethod -UserId $user.Id -BodyParameter @{
    PhoneNumber = "+0 00 000000"
    PhoneType = "mobile"
}

#Agregar autenticación por email
New-MgUserAuthenticationEmailMethod -UserId $user.Id -BodyParameter @{
    EmailAddress = "usuario@dominio.com"
}