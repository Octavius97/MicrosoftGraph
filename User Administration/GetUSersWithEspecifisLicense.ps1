Connect-MgGraph User.Read.All

$license = Get-MgSubscribedSku | Where-Object SkuPartNumber -EQ 'DEVELOPERPACK_E5'

Get-MgUser -Filter "assignedLicenses/any(x:x/skuId eq $($license.SkuId))" -All 
Write-Host "Total de usuarios = $($global:DevE5LicenseCount)"

# To view users without licenses
Get-MgUser -Filter 'assignedLicenses/$count eq 0' -All -CountVariable licensesCount -ConsistencyLevel eventual
Write-Host "Total de usuarios sin licencia = $licensesCount"

##----------->> Quitar Microsoft E1 de una lista de usuarios y asignar E3
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Install-Module Microsoft.Graph
Connect-MgGraph -Scopes User.ReadWrite.All, Organization.Read.All
$licenseE1 = Get-MgSubscribedSku | Where-Object SkuPartNumber -EQ 'STANDARDPACK'
$licenseE3 = Get-MgSubscribedSku | Where-Object SkuPartNumber -EQ 'ENTERPRISEPACK'

$users = Get-MgUser -Filter "assignedLicenses/any(x:x/skuId eq $($licenseE1.SkuId))" -All
$removeReport = @()
$assignReport = @()
$users | ForEach-Object {
  $rem = Set-MgUserLicense -UserId $_.Id -AddLicenses @{} -RemoveLicenses @($licenseE1.SkuId) -ErrorAction SilentlyContinue -ErrorVariable err
  if($err -ne $null) { Write-Host "Error al quitar licencia E1 a $($_.UserPrincipalName)" -ForegroundColor Red }
  else{ Write-Host "Licencia E1 quitada a $($_.UserPrincipalName)" -ForegroundColor Green }
  $ass = Set-MgUserLicense -UserId $_.Id -AddLicenses @{SkuId = $licenseE3.SkuId} -RemoveLicenses @() -ErrorAction SilentlyContinue -ErrorVariable err
  if($err -ne $null) { Write-Host "Error al asignar licencia E5 a $($_.UserPrincipalName)" -ForegroundColor Red }
  else{ Write-Host "Licencia E5 asignada a $($_.UserPrincipalName)" -ForegroundColor Green }
  $removeReport += [PSCustomObject]@{
    UPN = $rem.UserPrincipalName
    Status = $rem.LicenseDetails.SkuPartNumber
  }

  $assignReport += [PSCustomObject]@{
    UPN = $ass.UserPrincipalName
    Status = $ass.LicenseDetails.SkuPartNumber
  }
}

$removeReport | Format-Table
$assignReport | Format-Table

##----------->> Obtener los usuarios que tengan la licencia F1 y o Kiosk
$F1License = Get-MgSubscribedSku | Where-Object SkuPartNumber -EQ 'M365_F1'
$KioskLicense = Get-MgSubscribedSku | Where-Object SkuPartNumber -EQ 'EXCHANGEDESKLESS'

$users = Get-MgUser -All | Where-Object { $_.AssignedLicenses.SkuId -contains $F1License.SkuId -or $_.AssignedLicenses.SkuId -contains $KioskLicense.SkuId }

