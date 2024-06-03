#Enable TLS1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#Install Graph Module
Install-Module -Name Microsoft.Graph -Force

#Execution for Graph to RemoteSigned
Set-ExecutionPolicy RemoteSigned

#Connect to Graph
Connect-MgGraph -Scopes User.Read.All, Directory.Read.All, AuditLog.Read.All

# Search the license
# Find the SKU in the following link: https://learn.microsoft.com/en-us/entra/identity/users/licensing-service-plan-reference)
$license = Get-MgSubscribedSku | Where-Object SkuPartNumber -EQ '## Enter the SKU ##'

# Get all users with the license
Get-MgUser -All -Property "UserPrincipalName, DisplayName, SignInActivity" -Filter "assignedLicenses/any(x:x/skuId eq $($license.SkuId) )" | ForEach-Object {
  Select-Object -InputObject $_ -Property UserPrincipalName, DisplayName, @{Name = "LastLogon"; Expression = { $_.SignInActivity.LastSignInDateTime } }
} | Export-Csv -Path "C:\LastLogonForUserbyLicense.csv" -NoTypeInformation
