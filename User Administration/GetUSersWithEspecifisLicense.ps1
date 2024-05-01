Connect-MgGraph User.Read.All

$license = Get-MgSubscribedSku | Where-Object SkuPartNumber -EQ 'DEVELOPERPACK_E5'

Get-MgUser -Filter "assignedLicenses/any(x:x/skuId eq $($license.SkuId))" -All -CountVariable DevE5LicenseCount -ConsistencyLevel eventual
Write-Host "Total de usuarios = $($global:DevE5LicenseCount)"

# To view users without licenses
Get-MgUser -Filter 'assignedLicenses/$count eq 0' -All -CountVariable licensesCount -ConsistencyLevel eventual
Write-Host "Total de usuarios sin licencia = $licensesCount"