Connect-MgGraph -Scopes Directory.Read.All,AuditLog.Read.All
$tabla = @()
Get-MgBetaUser -All -Property 'SignInActivity' | ForEach-Object {
    $user = $_
    $tabla += [PSCustomObject]@{
        'User' = $user.DisplayName
        'Last Sign-In' = $user.SignInActivity.LastSignInDateTime
    }
}
$tabla | Format-Table -AutoSize

Get-MgBetaUser -All -Property 'UserPrincipalName','SignInActivity','Mail','DisplayName' | Select-Object @{N='UserPrincipalName';E={$_.UserPrincipalName}}, @{N='DisplayName';E={$_.DisplayName }}, @{N='LastSignInDate';E={$_.SignInActivity.LastSignInDateTime}} 


Get-MgUser -UserId 'urbosa@oc365support.cloudns.org' -Property 'UserPrincipalName','OnPremisesImmutableId','DisplayName' | Select-Object DisplayName, UserPrincipalName, OnPremisesImmutableId

Get-MgServicePrincipal | ForEach-Object { Get-MgServicePrincipalMemberOf -ServicePrincipalId $_.Id }