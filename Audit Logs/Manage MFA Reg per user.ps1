# Import the required module
Import-Module Microsoft.Graph.Reports

# Connect to Microsoft Graph with necessary permissions
Connect-MgGraph -Scopes AuditLog.Read.All, Reports.Read.All

Get-MgReportAuthenticationMethodUserRegistrationDetail | ForEach-Object {
  Select-Object -InputObject $_ @{N="UserPrincipalName";E={$_.UserPrincipalName}},@{N="DisplayName";E={$_.UserDisplayName}},@{N="IsMfaRegistered";E={$_.IsMfaRegistered}},@{N="Ultima Actualizacion";E={$_.LastUpdatedDateTime}}, @{N="Methods";E={$_.MethodsRegistered -join " - "}}
} | Export-Csv -Path "C:\MFA_Users_Graph.csv" -NoTypeInformation




######## MSOL

Connect-MsolService

Get-MsolUser -All | ForEach-Object {
  Select-Object -InputObject $_ @{N="UserPrincipalName";E={$_.UserPrincipalName}},@{N="DisplayName";E={$_.DisplayName}},@{N="IsMfaRegistered";E={$_.StrongAuthenticationRequirements.State}}
} | Export-Csv -Path "C:\MFA_Users_MSOL.csv" -NoTypeInformation