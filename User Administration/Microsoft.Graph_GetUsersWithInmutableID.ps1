Set-ExecutionPolicy Unrestricted
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Connect-MgGraph -Scopes User.ReadWrite.All, OnPremDirectorySynchronization.ReadWrite.All 

Get-MgUser -All | Where-Object UserPrincipalName -Match "onmicrosoft.com" | Select-Object DisplayName, UserPrincipalName, OnPremisesImmutableId

$oct = Get-mguser -UserId "admin@oc365support.cloudns.org"

$oct.OnPremisesImmutableId
