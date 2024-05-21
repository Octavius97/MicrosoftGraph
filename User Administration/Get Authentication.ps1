Connect-MgGraph -Scopes User.Read.All, UserAuthenticationMethod.Read.All
$reporte = @()
Get-MgUser -All | ForEach-Object {
    $userId = $_.Id
    $userDisplayName = $_.DisplayName
    $userPrincipalName = $_.UserPrincipalName
    $userAuth = Get-MgUserAuthenticationMethod -UserId $userId
    $userAuth | ForEach-Object {
      $reporte += [PSCustomObject]@{
        UserId = $userId
        UserDisplayName = $userDisplayName
        UserPrincipalName = $userPrincipalName
        AuthenticationMethodId = $_.Id
        AuthenticationMethod = $_.AdditionalProperties.Values
      }
    }
}
$reporte | Select-Object UserPrincipalName, AuthenticationMethod -ExpandProperty AuthenticationMethod | Export-Csv -Path "C:\AuthenticationMethods.csv"
$reporte | Export-Csv -Path "C:\AuthenticationMethods.csv"

# Obtener todos los valores de autenticación de los usuarios
# Path: User%20Administration/Get%20Authentication.ps1
Connect-MgGraph -Scopes User.Read.All, UserAuthenticationMethod.Read.All
$reporte = @()
$users = Get-MgUser -All -Property "AuthenticationMethods", "UserPrincipalName", "DisplayName","Id"
foreach ($user in $users) {
    $userDisplayName = $user.DisplayName
    $userPrincipalName = $user.UserPrincipalName
    $userAuth = Get-MgUserAuthenticationMethod -UserId $user.Id
    foreach ($u in $userAuth) {
      $authentication = $u.AdditionalProperties.Values
      
    }
}
