# Liberar el equipo del registro de Entra Join
dsregcmd /leave

# Instalar Graph (Una sola vez)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser #Cambiar la politica de ejecución
Install-Module Microsoft.Graph #Instalar el modulo 

#Conectarse a Graph
Connect-MgGraph -Scopes DeviceManagementManagedDevices.Read.All, Device.Read.All 

# Exportar los dispositivos que están pendientes
Get-MgDevice -All -Filter "TrustType eq 'ServerAd'" | Where-Object{($_.ProfileType -ne "RegisteredDevice") -and (-not $_.AlternativeSecurityIds)} | select-object -Property AccountEnabled, Id, DeviceId, DisplayName, OperatingSystem, OperatingSystemVersion, TrustType | export-csv 'C:\pendingdevicelist-summary.csv' -NoTypeInformation