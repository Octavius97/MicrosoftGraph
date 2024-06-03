Connect-MgGraph -Scopes Directory.Read.All,AuditLog.Read.All
$tabla = @()
Get-MgBetaUser -All -Property 'SignInActivity' | ForEach-Object {
    $user = $_
    $tabla += [PSCustomObject]@{
        'User' = $user.DisplayName
        'User Principal Name' = $user.UserPrincipalName
        'Last Sign-In' = $user.SignInActivity.LastSignInDateTime
    }
}
$tabla | Format-Table -AutoSize