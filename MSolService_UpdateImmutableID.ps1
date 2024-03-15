# Conectar al módulo
Connect-MsolService
# Establecer el valor al usuario nube
Set-MsolUser -UserPrincipalName "" -ImmutableId ""

# Conectar a Microsoft Graph
Connect-MgGraph -Scopes User.ReadWrite.All
# Obtener la instancia del usuario
$user = Get-MgUser -UserId "user@domain.com"
# Actualizar el immutableID del usuario
Update-MgUser -UserId $user.Id -OnPremisesImmutableId ""