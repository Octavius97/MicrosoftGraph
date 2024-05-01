Set-ExecutionPolicy Unrestricted
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Connect-MgGraph -Scopes User.ReadWrite.All

# Obtener la lista de los usuarios desde el csv
$usersCSV = Import-Csv -Path ".\csvFile.csv"

# Crear la politica de contraseña: Cambiar password al siguiente inicio sesion.
# Usar una contraseña que cumpla con los requisitos minimos
# 8 digitos como minimo, Mayusculas, minusculas, numeros y simbolos.
$passwordProfie = @{ForceChangePasswordNextSignIn = $true; Password = "789/*gfDG352+61"}

foreach($u in $usersCSV) {
    $usuario = Get-MgUser -UserId $u.UPN
    Update-MgUser -UserId $usuario.Id -PasswordProfile $passwordProfie
}