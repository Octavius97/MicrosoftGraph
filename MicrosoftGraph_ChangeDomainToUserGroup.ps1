Set-ExecutionPolicy Unrestricted
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Connect-MgGraph -Scopes User.ReadWrite.All, Group.Read.All, GroupMember.Read.All

#Obtener los usuarios del grupo

$IdGrupo = #Obtener el id desde Entra

$GroupUsers = Get-MgGroupMemberAsUser -GroupId $IdGrupo

foreach($user in $GroupUsers){
    Update-MgUser -UserId $user.Id -UserPrincipalName $user.UserPrincipalName.Replace('old.domain','new.domain')
}