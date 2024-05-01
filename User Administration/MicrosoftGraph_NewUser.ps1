Set-ExecutionPolicy Unrestricted
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Conectarse al modulo con los permisos requeridos para la administracion de usuarios.
Connect-Graph -Scopes User.ReadWrite.All, Organization.Read.All -NoWelcome

# Crear al usuario
New-MgUser -UserPrincipalName 'user@tu.dominio.com' -DisplayName 'Nombre Usuario' -MailNickname 'userNickName' -PasswordProfile @{
    Password = 'StrongPassword'  
    ForceChangePasswordNextSignIn = $false
    ForceChangePasswordNextSignInWithMfa = $false
} -UsageLocation 'US' -AccountEnabled

# Obtener el SKU de la licncia a aplicar al usuario
$licence = Get-MgSubscribedSku -All | Where-Object -Property SkuPartNumber -EQ 'ProductName'

# Asignar la licencia al usuario
Set-MgUserLicense -UserId 'user@tu.dominio.com' -AddLicenses @{SkuId = $licence.SkuId} -RemoveLicenses @()

# Establecer la foto de perfil del usuario.
Set-MgUserPhotoContent -UserId 'user@tu.dominio.com' -InFile 'Photo Path'