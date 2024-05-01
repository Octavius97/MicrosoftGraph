Set-ExecutionPolicy Unrestricted
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Connect-MgGraph -Scopes User.ReadWrite.All, Organization.Read.All

$License = Get-MgSubscribedSku -All | Where-Object SkuPartNumber -EQ "LOOK FOR THE SKUIPARTNUMBER"

$usersCSV = Import-Csv -Path ".\users.csv" -Delimiter ";"

foreach($u in $usersCSV){
    #Leer usuario de la columna UPN del CSV
    $usuario = Get-MgUser -UserId $u.UPN

    Set-MgUserLicense -UserId $usuario.Id -AddLicenses @{SkuId = $License.SkuId} -RemoveLicenses @()
}

