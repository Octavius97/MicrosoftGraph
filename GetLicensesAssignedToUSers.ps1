Connect-MgGraph -Scopes "User.ReadWrite.All"

$reporte = @()
Get-MgUser -All | ForEach-Object {
  $datos = [PSCustomObject]@{
    Nombre = $_.DisplayName
    Correo = $_.UserPrincipalName
    Licencia = (Get-MgUserLicenseDetail -UserId $_.Id).SkuPartNumber -join ', '
  }
  $reporte += $datos
} | Select-Object Nombre, Correo, Licencia

$reporte | Where-Object Licencia -Match 'DEVELOPERPACK_E5'