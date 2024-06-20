# Conectarse al modulo
Connect-MgGraph -Scopes User.ReadWrite.All, Organization.Read.All

# Obtener la licencia que se desea quitar
$license = Get-MgSubscribedSku | Where-Object {$_.skuPartNumber -eq "DEVELOPERPACK_E5"}

# Obtener los usuarios que tienen la licencia y quitarla
Get-MgUser -Filter "assignedLicenses/any(x:x/SkuId eq $($license.SkuId))" -All | ForEach-Object {
    Set-MgUserLicense -UserId $_.Id -AddLicenses @{} -RemoveLicenses @($license.SkuId)
}

