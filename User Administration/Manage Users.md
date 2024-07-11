# Manage Microsoft 365 users with PowerShell and Microsoft Graph

## 1. Create Users

To create users with PowerShell's Microsoft Graph module yo must use the Command `New-MgUser`. You can check the next article: [Microsoft Graph: New-MgUser](https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.users/new-mguser?view=graph-powershell-1.0)

> [!Important]
> To connect with PowerShell's Microsoft Graph you must use the `User.ReadWrite.All` scope for manage users.
```Powershell
Connect-MgGraph -Scopes User.ReadWrite.All
```
> [!Note]
> You can add the `-NoWelcome` parameter to not show the Welcome to Microsoft Graph message

### 1.1. Users Attributes
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
  Password = "$rw4d08&*>35"
  ForceChangePasswordNextSignIn = $true
}

# Create the user
New-MgUser -DisplayName "Roham Hyrule" -GivenName "Roham" -SurName "Hyrule" -UserPrincipalName "roham.hyrule@hyrule.com" -MailNickName "roham.hyrule" -PasswordProfile $password -AccountEnabled
```

> [!Note]
> You can also define the usage location for the user using the `-UsageLocation` parameter. The value for the usage location is required to set the license for the user and this value uses the country ISO code, for example:
> - *United States*: _US_
> - *Mexico*: _MX_
> - *Colombia*: _CO_
>
> You can check the next page for see the [Countries ISO Codes](https://www.countrycode.org/)

### 1.2. Create users in bulk from a CSV
You can load a CSV file with the users information to create them in bulk. You have to create the CSV file with the users properties, for example:

|DisplayName        |GivenName|SurName  |UserPrincipalName      |Password    |
|-------------------|---------|---------|-----------------------|------------|
|Roham Hyrule       |Roham    |Hyrule   |roham.hyrule@hyrule.com|pyglp]6}-5O7|
|Ganondorf Pendragon|Ganondorf|Pendragon|ganondorf@hyrule.com   |TS23O;1vAy  |
|Zelda Hyrule       |Zelda    |Hyrule   |zelda@hyrule.com       |nN6d[J$Z7H  |

> [!Note]
> In this example, the `USerPrincipalName` value will be use to populate the `MailNickName`

Now, you can load the CSV file using the `Import-CSV` command in the PowerShell
```PowerShell
# Import all users from the CSV and save it in a variable
$users = Import-CSV -Path "C:\users.csv"

# Foreach user in the CSV create the User
foreach($user in $users){
  $DisplayName = $user.DisplayName
  $GivenName = $user.GivenName
  $SurName = $user.SurName
  $UserPrincipalName = $user.UserPrincipalName
  $MailNickName = $UserPrincipalName.Split('@')[0]
  $Password = @{Password = $user.Password; ForceChangePasswordNextSignIn = $true}

  New-MgUser -DisplayName $DisplayName -GivenName $GivenName -SurName $SurName `
  -UserPrincipalName $UserPrincipalName -MailNickName $MailNickName -PasswordProfile $Password -AccountEnabled
}
```
This will create all users from the CSV file