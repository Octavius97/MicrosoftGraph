# Inicio del Modulo

$opcion = $null
while ($opcion -notmatch "^[1-6]$") {
    Write-Host "Seleccione el modulo a conectarse"
    Write-Host "1. Microsoft Graph"
    Write-Host "2. Azure AD Graph"
    Write-Host "3. Microsoft Online Services"
    Write-Host "4. Exchange Online"
    Write-Host "5. SharePoint Online"
    Write-Host "6. Cerrar"
    $opcion = Read-Host "Seleccione una opcion"
}
