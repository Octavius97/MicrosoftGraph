Install-Module -Name Microsoft.Graph

Connect-MgGraph -Scope User.ReadWrite.All,Directory.ReadWrite.All, Organization.ReadWrite.All

$users = Get-MgUser -All

get-MgUser -UserId 'vSambrana@beemead.cloudns.biz'

Get-MgUser -All -Select 'PasswordPolicies','UserPrincipalName'| Select-Object -Property UserPrincipalName, PasswordPolicies


Update-MgUser -UserId 'ad5d92e4-774f-42a1-a762-2aca6e32bb97' -PasswordPolicies 'DisablePasswordExpiration'

# update the schools for user
Get-MgUser -UserId '0f55fc3f-2e3d-4da6-b06a-c13fd634bebc' -Property 'SignInActivity','UserPrincipalName','DisplayName' | Select-Object @{N='UserPrincipalName';E={$_.UserPrincipalName}},@{N='DisplayName';E={$_.DisplayName}},@{N='SignInActivity';E={$_.SignInActivity.LastSignInDateTime}}