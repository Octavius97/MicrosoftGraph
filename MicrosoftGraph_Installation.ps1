# Buscar el modulo desde la PSGallery
Find-Module -Name Microsoft.Graph | Select-Object -Property Name,Version,PublishedDate | Format-List

# Instalar el modulo
Install-Module Microsoft.Graph -Force

# Obtener el modulo para verificar si la instalacion fue completada satisfactorialmente.
Get-Module -ListAvailable | Where-Object Name -Like 'Microsoft.Graph.*'