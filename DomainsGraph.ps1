Import-Module Microsoft.Graph.Identity.DirectoryManagement
Connect-MgGraph -Scopes Domain.ReadWrite.All

$dominio = 'cod-school.com'

Get-MgDomainServiceConfigurationRecord -DomainId $dominio | Select-Object @{N='Record'; E={$_.RecordType}}, @{N='Value'; E={$_.Label}}, @{N='Registro';E={$_.AdditionalProperties.Values}}