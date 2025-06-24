<#
  .SUMMARY
  This is an example about how you can manage the per-user MFA with PowerShell using Microsoft Graph
#>

# Connect to Graph with right permissons
Connect-MgGraph -scopes Policy.ReadWrite.AuthenticationMethod, User.ReadWrite.All

# Get the user MFA state
$user = Get-MgUser -UserId "userName@domain.com"
Invoke-MgGraphRequest -Method GET -URI "beta/users/$($user.Id)/authentication/requirements"

# Get the all users MFA state
Get-MgUser -All | Foreach-Object {
  $user = $_
  $userMFAstate = Invoke-MgGraphRequest -Method GET -URI "beta/users/$($user.Id)/authentication/requirements"
  [PSCustomObject]@{
    UserPrincipalName = $user.UserPrincipalName
    DisplayName = $user.DisplayName
    "MFA State" = $userMFAstate.perUserMfaState
  }
}

# Set the user MFA state (enabled, disabled, enforced)
$body = @{ "perUserMfaState" = "enabled" }
Invoke-MgGraphRequest -Method POST -URI "beta/users/$($user.Id)/authentication/requirements" -Body $body

<#
  For multiple users in a CSV file
#>

# Get the users from the CSV file (Header with UPN)
Import-CSV -Path "C:\temp\user.csv" | Foreach-Object {
  $user = Get-MgUser -UserId $_.UPN
  # Set the user MFA state (enabled, disabled, enforced)
  $body = @{ "perUserMfaState" = "enabled" }
  Invoke-MgGraphRequest -Method POST -URI "beta/users/$($user.Id)/authentication/requirements" -Body $body
}