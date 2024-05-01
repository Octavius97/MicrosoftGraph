Install-Module -Name Microsoft.Graph

Connect-MgGraph -Scope User.ReadWrite.All,Directory.ReadWrite.All, Organization.ReadWrite.All

$users = Get-MgUser -All -Select 'PasswordPolicies','UserPrincipalName','Id'| Select-Object -Property UserPrincipalName, PasswordPolicies, Id

$users | Update-MgUser -UserId $_.Id -PasswordPolicies 'DisablePasswordExpiration'
