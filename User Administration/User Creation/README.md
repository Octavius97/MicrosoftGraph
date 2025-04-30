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
```PasswordProfile
```
> [!Note]
> You can add more user properties if you need it. For more information you can refer to the [New-MgUser Documentation]("https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.users/new-mguser?view=graph-powershell-1.0")

