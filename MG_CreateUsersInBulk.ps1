# Conectarse a Graph usando los permisos necesarios
Connect-MgGraph -Scopes User.ReadWrite.All

# Importar los datos desde un CSV
# Se asume que el csv contiene los siguiente headers (ninguno vacío)
# UPN | DisplayName | FirstName | LastName | Job | Department | Password 
$users = Import-CSV -Path ".\csv_Path"

# Recorrer cada fila para crear el usuario
foreach($u in $users){
    New-MgUser -UserPrincipalName $u.UPN -MailNickName $u.UPN.Split('@')[0] -GivenName $u.FirstName -SurName $u.LastName -JobTitle $u.Job -Departmen $u.Department -PasswordProfile @{
        ForceChangePasswordNextSignIn = $true
        Password = $u.Password
    } -AccountEnabled
}
