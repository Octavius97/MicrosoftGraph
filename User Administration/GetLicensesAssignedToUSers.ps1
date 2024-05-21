Connect-MgGraph -Scopes "User.ReadWrite.All"

$reporte = @()
Get-MgUser -All | ForEach-Object {
  $reporte += [PSCustomObject]@{
    Nombre = $_.DisplayName
    Correo = $_.UserPrincipalName
    Licencia = (Get-MgUserLicenseDetail -UserId $_.Id).SkuPartNumber -join ', '
  }
} | Select-Object Nombre, Correo, Licencia

$reporte 