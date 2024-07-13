# Script to clear the ImmutableID for cloud users.

# Connect to Microsoft Graph using the properly permissions.
Connect-MgGraph -Scopes User.ReadWrite.All, Directory.ReadWrite.All

# Create a body parameters with the ImmutableId
$body = @{ "onPremisesImmutableId" = $null }

# Get the User
$user = Get-MgUser -UserId "alejandro.romero@oc365support.cloudns.org"

# Clean the ImmutableID
Invoke-MgGraphRequest PATCH -Uri "https://graph.microsoft.com/v1.0/users/$($user.Id)" -Body $body

#<<---------If you want to clean all users' immutableID--------------->>
# Connect to Microsoft Graph using the properly permissions.
Connect-MgGraph -Scopes User.ReadWrite.All, Directory.ReadWrite.All

# Create a body parameters with the ImmutableId
$body = @{ "onPremisesImmutableId" = $null }

# Get all users which have immutableID and the sync is not enabled
$users = Get-MgUser -All -Property Id,UserPrincipalName,OnPremisesImmutableId,onPremisesSyncEnabled | Where-Object { ($_.OnPremisesImmutableId -ne $null) -and ($_.OnPremisesSyncEnabled -eq $null) } | Select-Object Id,UserPrincipalName,OnPremisesImmutableId

# Foreach user, clean the ImmutableID
foreach($user in $users){
  Invoke-MgGraphRequest PATCH -Uri "https://graph.microsoft.com/v1.0/users/$($user.Id)" -Body $body
}