Install-Module -Name Microsoft.Graph
Set-ExecutionPolicy Unrestricted
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Import-Module Microsoft.Graph
Connect-MgGraph -Scopes User.Read.All, Group.ReadWrite.All, GroupMember.ReadWrite.All

$users = Import-Csv -Path ".\users.csv"

$idGrupo = #Obtener el id del grupo en Entra ID

foreach($u in $users){
    $usuario = Get-MgUser -UserId $u.UPN
    New-MgGroupMember -GroupId $idGrupo -DirectoryObjectId $usuario.Id
}