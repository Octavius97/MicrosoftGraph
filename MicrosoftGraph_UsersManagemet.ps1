Connect-MgGraph -Scopes User.ReadWrite.All, Directory.AccessAsUser.All, Organization.Read.All -NoWelcome

$users = Get-MgUser 
$users | Select-Object -Property DisplayName, Extensions

$users = Get-MgUser 
$foto = 'C:\Users\ocMorales\Desktop\hy1.jpg'
$rdFoto = [System.IO.File]::ReadAllBytes($foto)
$pic = [System.Drawing.Image]::FromFile("C:\Users\ocMorales\Desktop\hy1.jpg")
$StrPic = [Stream]::new([System.IO.StreamReader]::new($foto))

$users = Get-MgUser 
foreach ($u in $users) {
    try {
        Set-MgUserPhotoContent -UserId $u.UserPrincipalName -InFile $foto
        Write-Output "La foto de $($u.DisplayName) se ha cambiado con exito"
    }
    catch {
        Write-Error -Exception er -Message "Error al actualizar la foto de $($u.DisplayName)\n"
    }
}

##With MSOL
Install-Module -Name MSOnline
Import-Module -Name MSOnline
Connect-MsolService

Install-Module -Name ExchangeOnlineManagement -RequiredVersion 3.4.0
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -UserPrincipalName "admin@oc365support.cloduns.org"
