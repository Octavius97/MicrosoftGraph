<#
  .SUMMARY
  This is an example about how you can manage the per-user MFA with PowerShell using Microsoft Graph
#>

# Connect to Graph with right permissons
Connect-MgGraph -scopes Policy.ReadWrite.AuthenticationMethod, User.ReadWrite.All

# Get the user MFA state
$user = Get-MgUser -UserId "userName@domain.com"
Invoke-MgGraphRequest -Method GET -URI "beta/users/$($user.Id)/authentication/requirements"

# Set the user MFA state (enabled, disabled, enforced)
$body = @{ "perUserMfaState" = "enabled" }
Invoke-MgGraphRequest -Method POST -URI "beta/users/$($user.Id)/authentication/requirements" -Body $body
