# Microsoft Graph PowerShell SKD for Microsoft 365 Management
Documentacion referente a Microsoft Graph PowerShell.

> [!Note]
> All examples performed on this repository were completed for testing purposes. If you use each one of those examples are **under your own responsability**.

## 1. Module Installation

You can find the module on PowerShell Gallery using the following command.
```PowerShell
Find-Module -Name Microsoft.Graph | Select-Object -Property Name,Version,PublishedDate | Format-List
```

> [!Note]
> Set the recommended execution policy for PowerShell Microsoft Graph 
```PowerShell
Set-ExecutionPolicy RemoteSigned
```

To install the latest version for Microsoft Graph PowerShell, use the following command.
```PowerShell
Install-Module Microsoft.Graph -Repository PSGallery -Force -AllowClobber
```

## 2. Connect to the Module
> [!Important]
> To connect to Microsoft Graph through PowerShell module installed you need to connect with neccesary `Scopes` for specific permissions. For more information you can validate the next [documentation](https://learn.microsoft.com/en-us/graph/permissions-reference) that explain the scopes.

To connect to Microsoft Graph PowerShell, you can use the following command
```PowerShell
Connect-MgGraph
```

If you need to connect with neccesary permissions you need to add the parameter `-Scopes` to the Connect cmdlet.
```PowerShell
Connect-MgGraph -Scopes User.Read.All
```
> [!Note]
> The `User.Read.All` scope has the neccesary permision to read all users information.
> Make sure to use the necessary scopes for the actions you will perform. If a different scope is required, you can reconnect adding the permission to the `-Scopes` parameter.

> [!Important]
> If you need to use more than one scope, you can add them by separating each with a comma (,).
