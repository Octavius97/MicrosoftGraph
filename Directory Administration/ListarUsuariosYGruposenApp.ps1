# This sample script displays users and groups assigned to the specified Microsoft Entra application proxy application.
#
# .\display-users-group-of-an-app.ps1 -ObjectId <ObjectId of the service principal> (Enterprise App)
#
# Version 1.0
#
# This script requires PowerShell 5.1 (x64) or beyond and one of the following modules:
#
# Microsoft.Graph.Beta ver 2.10 or newer
#
# Before you begin:
#    
#    Required Microsoft Entra role: Global Administrator or Application Administrator
#    or appropriate custom permissions as documented https://learn.microsoft.com/en-us/azure/active-directory/roles/custom-enterprise-app-permissions
#
#

param(
  [parameter(Mandatory = $true)]
  [string] $ObjectId = "null"
)

$aadapServPrincObjId = $ObjectId

If ($aadapServPrincObjId -eq "null") {
  Write-Host "Parameter is missing." -BackgroundColor "Black" -ForegroundColor "Green"
  Write-Host " "
  Write-Host ".\display-users-group-of-an-app.ps1 -ObjectId <ObjectId of the service principal (Enterprise App)>" -BackgroundColor "Black" -ForegroundColor "Green"
  Write-Host " "
  Exit
}

Import-Module Microsoft.Graph.Beta.Applications

Connect-MgGraph -Scope Directory.Read.All -NoWelcome

Write-Host "Reading users. This operation might take longer..." -BackgroundColor "Black" -ForegroundColor "Green"

$users = Get-MgBetaUser -All

Write-Host "Reading groups. This operation might take longer..." -BackgroundColor "Black" -ForegroundColor "Green"

$groups = Get-MgBetaGroup -All

try { $app = Get-MgBetaServicePrincipalById -Id $aadapServPrincObjId }

catch {

  Write-Host "Possibly the ObjetId is incorrect." -BackgroundColor "Black" -ForegroundColor "Red"
  Write-Host " "

  Exit
}

Write-Host ("Application: " + $app.DisplayName + "(ServicePrinc. ObjID:" + $aadapServPrincObjId + ")")
Write-Host ("")
Write-Host ("Assigned (directly and through group membership) users:")
Write-Host ("")

$number = 0
$tablaUsers = @()

foreach ($item in $users) {

  $listOfAssignments = Get-MgBetaUserAppRoleAssignment -UserId $item.Id
  $assigned = $false

  foreach ($item2 in $listOfAssignments) { if ($item2.ResourceId -eq $aadapServPrincObjId) { $assigned = $true } }

  If ($assigned -eq $true) {
    Write-Host ("DisplayName: " + $item.DisplayName + " UPN: " + $item.UserPrincipalName + " ObjectID: " + $item.Id)
    $tablaUsers += [PSCustomObject]@{
      DisplayName=$item.DisplayName
      UPN = $item.UserPrincipalName
    }
    $number = $number + 1
  }
}

Write-Host ("")
Write-Host ("Number of (directly and through group membership) users: " + $number)
Write-Host ("")
Write-Host ("")
Write-Host ("Assigned groups:")
Write-Host ("")

$number = 0
$tablaGroups = @()

foreach ($item in $groups) {

  $listOfAssignments = Get-MgBetaGroupAppRoleAssignment -GroupId $item.Id

  $assigned = $false

  foreach ($item2 in $listOfAssignments) { If ($item2.ResourceID -eq $aadapServPrincObjId) { $assigned = $true } }

  If ($assigned -eq $true) {
    Write-Host ("DisplayName: " + $item.DisplayName + " ObjectID: " + $item.Id)
    $tablaGroups += [PSCustomObject]@{
      GroupName=$item.DisplayName
    }
    $number = $number + 1
  }
}

Write-Host ("")
Write-Host ("Number of assigned groups: " + $number)
Write-Host ("")

Write-Host ("")
Write-Host ("Finished.") -BackgroundColor "Black" -ForegroundColor "Green"
Write-Host ("") 
$tablaUsers | Export-Csv -Path C:\usersReport.csv
$tablaGroups | Export-Csv -Path C:\groupsReport.csv
Write-Host "To disconnect from Microsoft Graph, please use the Disconnect-MgGraph cmdlet."