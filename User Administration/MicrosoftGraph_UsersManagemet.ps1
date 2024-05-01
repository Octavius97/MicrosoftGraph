Connect-MgGraph -Scopes User.ReadWrite.All, Directory.AccessAsUser.All, Organization.Read.All -NoWelcome

$users = Get-MgUser 
$users | Select-Object -Property DisplayName, Extensions

