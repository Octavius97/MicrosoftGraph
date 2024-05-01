Connect-MgGraph 

# Obtener todos los usuarios
# Importar el módulo requerido
Import-Module Microsoft.Graph

# Conectar a Graph
Connect-MgGraph

# Obtener todos los usuarios
$users = Get-MgUser -All

foreach ($user in $users) {
    # Obtener la información de la contraseña del usuario
    $passwordProfile = $user.PasswordProfile

    # Comprobar si la contraseña ha expirado
    if ($passwordProfile.PasswordPolicies -eq "DisablePasswordExpiration") {
        Write-Output "Usuario: $($user.UserPrincipalName), Estado de la contraseña: No expira"
    } else {
        Write-Output "Usuario: $($user.UserPrincipalName), Estado de la contraseña: Expirada"
    }
}
