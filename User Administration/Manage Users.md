# Manage Microsoft 365 users with PowerShell and Microsoft Graph

## 1. Create Users

To create users with PowerShell's Microsoft Graph module yo must use the Command `New-MgUser` and use the properly Microsoft Graph API Permissions, in this case the permission to create users is `User.ReadWrite.All`. You can check the next article: [Microsoft Graph:New-MgUser](https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.users/new-mguser?view=graph-powershell-1.0)

### 1.1. Connect to Graph
To connect with PowerShell's Microsoft Graph you must use the `User.ReadWrite.All` scope for manage users.
```Powershell
Connect-MgGraph -Scopes User.ReadWrite.All
```
> [!Note]
> You can add the `-NoWelcome` parameter to not show the Welcome to Microsoft Graph message

### 1.2. Users Attributes
To create users, the command needs some properties to fill the user attributes in Microsoft Entra ID. The next are the minimal user attributes requires to create a new user with Microsoft Graph
- **-DisplayName**: The displayname for the user
- **-GivenName**: The first name for the user
- **-SurName**: The last name for the user
- **-UserPrincipalName**: The user principal name (mail) for the user
- **-MailNickname**: The mail nick name identifier for the user
- **-PasswordProfile**: The password for the user, you can decide if the user needs to change the password in the next sign-in
- **-AccountEnabled**: To enable the user account

```PowerShell
# Create the Password Profile Hashtable
$password = @{
  Password = "$rw@4d08&*>35"
  ForceChangePasswordNextSignIn = $true
}

# Create the user
New-MgUser -DisplayName "Roham Nohansen Hyrule" -GivenName "Roham" -SurName "Hyrule" -UserPrincipalName "roham.hyrule@hyrule.com" -MailNickName "roham.hyrule" -PasswordProfile $password -AccountEnabled
```