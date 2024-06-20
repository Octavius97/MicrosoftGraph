# ---->> Get the Sign-in logs for all users in Microsoft Entra ID
# ------->> Requirements: The tenant must have at least one Microsoft Entra ID P1 License.

# Connect to the Microsoft Graph API with the required permissions
Connect-MgGraph -Scopes Directory.Read.All,AuditLog.Read.All

# Get all users with the specified properties
Get-MgUser -All -Property DisplayName, UserPrincipalName, SignInActivity | ForEach-Object {
    # Select the values
    Select-Object -InputObject $_ -Property DisplayName, UserPrincipalName, @{Name = 'SignInActivity'; Expression = { $_.SignInActivity } }
}

# ---->> To export the data to a CSV file, add the following line to the end of the script
# | Export-Csv -Path 'C:\path\to\export.csv' -NoTypeInformation

# Disconnect from the Microsoft Graph API
Disconnect-MgGraph

