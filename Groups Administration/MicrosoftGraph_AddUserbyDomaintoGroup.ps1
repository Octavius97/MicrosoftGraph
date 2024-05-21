[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Set-ExecutionPolicy Unrestricted

Connect-MgGraph -Scopes User.Read.All, Group.ReadWrite.All, GroupMember.ReadWrite.All
$users = Get-MgUser -All | Where-Object UserPrincipalName -Match "dominio.com"

$idGrupo = ### Copiar ID del Grupo desde Entra

foreach($u in $users){
    New-MgGroupMember -GroupId $idGrupo -DirectoryObjectId $u.Id
}

