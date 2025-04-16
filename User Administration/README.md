# Basic User Administration Using Microsoft Graph PowerShell

This guide provides an overview of how to perform basic user administration tasks using Microsoft Graph PowerShell. Microsoft Graph PowerShell allows administrators to manage users, groups, and other resources in Microsoft 365 through a powerful scripting interface.

## Prerequisites

Before you begin, ensure you have the following:

- **Microsoft Graph PowerShell Module**: Install the module by running:
  ```powershell
  Install-Module -Name Microsoft.Graph -Scope CurrentUser -Repository PSGallery -Force -AllowClobber
  ```
- **Administrator Permissions**: Ensure you have the necessary permissions to manage users in your Microsoft 365 tenant.
- **Entra ID Account**: Use an account with appropriate privileges to authenticate.

## Common User Administration Tasks

### 1. Connect to Microsoft Graph
To start, connect to Microsoft Graph using the following command:
```powershell
Connect-MgGraph -Scopes "User.ReadWrite.All"
```

> [!Note]
> The scope `User.ReadWrite.All` has the necessary permissions to read and modify all user information, such as display names, email addresses, and account settings. Ensure that you use this scope responsibly, as it grants access to sensitive user data.

### 2. List All Users
Retrieve a list of all users in your organization:
```powershell
Get-MgUser -All
```

### 3. Create a New User
Create a new user account:
```powershell
New-MgUser -DisplayName "John Doe" -UserPrincipalName "johndoe@contoso.com" -MailNickname "johndoe" -PasswordProfile @{Password="P@ssw0rd"; ForceChangePasswordNextSignIn=$true} -AccountEnabled:$true
```
> [!Note]
> This is the basic user information required to create a new user. You can specify additional parameters to define other attributes for the user. Below is a list of commonly used attributes when creating a user with the `New-MgUser` cmdlet:

- **DisplayName**: The full name of the user (e.g., "John Doe").
- **UserPrincipalName**: The user's sign-in name (e.g., "johndoe@contoso.com").
- **MailNickname**: The alias for the user's email address.
- **PasswordProfile**: An object that specifies the user's password and whether they must change it at the next sign-in.
- **AccountEnabled**: A boolean value indicating whether the account is active.
- **JobTitle**: The user's job title (e.g., "Software Engineer").
- **Department**: The department the user belongs to (e.g., "IT").
- **MobilePhone**: The user's mobile phone number.
- **OfficeLocation**: The user's office location (e.g., "Building A, Room 123").
- **GivenName**: The user's first name.
- **Surname**: The user's last name.

> Refer to the [Microsoft Graph PowerShell documentation](https://learn.microsoft.com/powershell/microsoftgraph/) for a complete list of attributes and their descriptions.

### 4. Update User Information
Update a user's display name:
```powershell
Update-MgUser -UserId "johndoe@contoso.com" -DisplayName "Johnathan Doe"
```

### 5. Delete a User
Remove a user account:
```powershell
Remove-MgUser -UserId "johndoe@contoso.com"
```

## Additional Resources

- [Microsoft Graph PowerShell Documentation](https://learn.microsoft.com/powershell/microsoftgraph/)
- [Microsoft Graph API Overview](https://learn.microsoft.com/graph/overview)

By leveraging Microsoft Graph PowerShell, administrators can efficiently manage users and streamline operations in their Microsoft 365 environment.