# Connect with the required permissions
Connect-MgGraph -Scopes User.ReadWrite.All

# Get the Password Policies applies to a specific user
Get-MgUser -UserId 'user@domain.com' -Property UserPrincipalName, DisplayName, PasswordPolicies | Select-Object UserPrincipalName, DisplayName PasswordPolicies

# Get the Password Policies applies to all users
Get-MgUser -All -Property UserPrincipalName, DisplayName, PasswordPolicies | Select-Object UserPrincipalName, DisplayName, PasswordPolicies

# Set the Password Policies for a specific user to 'PasswordNeverExpires'
Update-MgUser -UserId '' -PasswordPolicies 'PasswordNeverExpires'

# Set the Password Policies for a specific user to 'DisableStrongPassword'
Update-MgUser -UserId '' -PasswordPolicies 'DisableStrongPassword'

# Reset the Password Policies for a specific user
Update-MgUser -UserId '' -PasswordPolicies 'None'

# Set the Password Policies for all users to 'PasswordNeverExpires'
Get-MgUser -All | ForEach-Object { Update-MgUser -UserId $_.Id -PasswordPolicies 'PasswordNeverExpires' }

# Set the Password Policies for all users to 'DisableStrongPassword'
Get-MgUser -All | ForEach-Object { Update-MgUser -UserId $_.Id -PasswordPolicies 'DisableStrongPassword' }

# Reset the Password Policies for all users
Get-MgUser -All | ForEach-Object { Update-MgUser -UserId $_.Id -PasswordPolicies 'None' }

# Set an specific Password Policies for all users loaded from a CSV file
$policies = Import-Csv -Path 'C:\Temp\PasswordPolicies.csv' # The CSV file should have the following columns: UserPrincipalName, PasswordPolicy
foreach($policy in $policies) {
    $user = Get-MgUser -UserId $policy.UserPrincipalName
    Write-Progress -Activity "Setting Password Policies" -Status "Setting Password Policies for $($user.UserPrincipalName)" -PercentComplete (($policies.IndexOf($policy) / $policies.Count) * 100)
    Update-MgUser -UserId $user.Id -PasswordPolicies $policy.PasswordPolicy
}

# ---->> End of the Script <<----

# for test purposes... skip this
$users = Get-MgUser -All
foreach($user in $users) {
  Write-Progress -Activity "Setting Password Policies" -Status "Setting Password Policies: $($(($users.IndexOf($user) / $users.Count) * 100))%" -PercentComplete (($users.IndexOf($user) / $users.Count) * 100)
  Update-MgUser -UserId $user.Id -PasswordPolicies 'None' -ErrorVariable Err -ErrorAction SilentlyContinue
  if($Err) {
    Write-Error "Error setting Password Policies for $($user.UserPrincipalName): $($Err.Exception.Message)"
  }
  else{
    Write-Host "Password Policies set for $($user.UserPrincipalName) successfully." -ForegroundColor Green
  }
}