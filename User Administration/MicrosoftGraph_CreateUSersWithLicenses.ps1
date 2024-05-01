# Conectarse a Graph usando los permisos necesarios
Connect-MgGraph -Scopes User.ReadWrite.All, Organization.Read.All

# Leer la licencia
$license = Get-MgSubscribedSku | Where-Object SkuPartNumber -EQ "SKU_NAME" #cambiar el sku name
# Importar los datos desde un CSV
# Se asume que el csv contiene los siguiente headers (ninguno vacío)
# UPN | DisplayName | FirstName | LastName | Job | Department | Password 
$users = Import-CSV -Path ".\csv_Path"

# Recorrer cada fila para crear el usuario y asignarle la licencia
foreach($u in $users){
    New-MgUser -UserPrincipalName $u.UPN -MailNickName $u.UPN.Split('@')[0] -GivenName $u.FirstName -SurName $u.LastName -JobTitle $u.Job -Departmen $u.Department -PasswordProfile @{
        ForceChangePasswordNextSignIn = $true
        Password = $u.Password
    } -AccountEnabled -AssignedLicenses @{SkuId = $license.SkuId}
}
