Connect-MgGraph -Scopes User.Read.All, Organization.Read.All

$users = Get-MgBetaUser -All

$PB = Get-MgBetaSubscribedSku | Where-object SkuPartNumber -EQ ""

$users | Select-Object DisplayName, UserPrincipalName, EmployeeId -ExpandProperty AssignedLicenses | Select-Object -ExcludeProperty AdditionalProperties, DisabledPlans | Where-Object SkuId -EQ $PB.SkuId | Export-Csv -Path C:\report.csv