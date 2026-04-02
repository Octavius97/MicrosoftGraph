# Create users using Microsoft Graph PowerShell

To create user with Microsoft Graph PowerShell, the command needs required user information. Bellow you can find a list with the required information:
- **DisplayName**: The full name of the user (e.g., "John Doe").
- **UserPrincipalName**: The user's sign-in name (e.g., "johndoe@contoso.com").
- **MailNickname**: The alias for the user's email address.
- **PasswordProfile**: An object that specifies the user's password and whether they must change it at the next sign-in.
- **AccountEnabled**: A boolean value indicating whether the account is active.

Using this required parameter to create a user, you can use this cmdlet
```PowerShell
New-MgUser -DisplayName "Bryan May" -UserPrincipalName "bryan.may@contoso.com" -MailNickName "bryan.may" -PasswordProfile @{Password = "P@$$w0rd2025"; ForceChangePasswordNextSignIn = $true} -AccountEnabled:$true
```

You can also create a `Body Parameter` to structure the cmdlet better
```PowerShell
$bodyParameter = @{
    DisplayName = "Mario Mario"
    UserPrincipalName = "mario.bros@contoso.com"
    MailNickName = "mario.bros"
    PasswordProfile = @{
        Password = "P@$$w0rd2025"
        ForceChangePasswordNextSignIn = $true
    }
    AccountEnabled = $true
    # Additional properties can be added here
    # GivenName = "Mario"
    # Surname = "Mario"
    # JobTitle = "Plumber"
    # Department = "Maintenance"
    # OfficeLocation = "Mushroom Kingdom"
    # MobilePhone = "+1234567890"
    # BusinessPhones = @("+1234567890")
    # PreferredLanguage = "en-US"
    # UsageLocation = "US"
}
New-MgUser @bodyParameter
```

> [!Note]
> You can add more user properties if you need it. For more information you can refer to the [New-MgUser Documentation]("https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.users/new-mguser?view=graph-powershell-1.0")

## Bulk Creations

For creating multiple users at once, refer to the `BulkUsersCreations.ps1` script and the `Users.csv` file. The script reads user data from the CSV file and creates users in bulk using the Microsoft Graph PowerShell cmdlet. This approach is more efficient than creating users individually.

**Files:**
- [BulkUsersCreations.ps1](./BulkUsersCreations.ps1) - PowerShell script that handles bulk user creation
- [Users.csv](./Users.csv) - CSV file containing user information to be imported
