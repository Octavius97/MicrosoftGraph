Connect-MgGraph -Scopes User.ReadWrite.All, Organization.ReadWrite.All, Directory.AccessAsUser.All

$users = Import-Csv -Path C:\file.csv #CSV tiene las columnas UserPrincipalName, Password
foreach($u in $users){
    $user = Get-MgUser -UserId $u.UserPrincipalName
    Update-MgUser -UserId $user.Id -PasswordProfile @{ Password = $u.Password; ForceChangePasswordNextSignIn = $true;}
}

# change the password for an AD user
Set-AdAccountPassword -Identity 'SAMACCOUNTNAME' -NewPassword (ConvertTo-SecureString -String "Password#123" -AsPlainText -Force) -Reset
Set-AdUser -Identity 'SAMACCOUNTNAME' -PasswordNeverExpires $true
Update-MgUser -UserId (Get-MgUser -UserId 'mail').Id -PasswordProfile @{ Password = "#Password123"; ForceChangePasswordNextSignIn = $true;}