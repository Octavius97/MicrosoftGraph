[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Set-ExecutionPolicy Unrestricted

Connect-MgGraph -Scopes User.Read.All, Group.ReadWrite.All, GroupMember.ReadWrite.All
$estudiantes = Get-MgUSer -All | Where-Object UserPrincipalName -Match "dominio.com"

$idGrupo = ###

foreach($e in $estudiantes){
    New-MgGroupMember -GroupId $idGrupo -DirectoryObjectId $e.Id
}

