Connect-MgGraph -Scopes User.Read.All, Organization.Read.All

$License = Get-MgSubscribedSku | Where-Object {$_.SkuPartNumber -eq "SKU PART NUMBER"} #Change the SKU PART NUMBER to the one you want to check

$users = Get-MgUser -Filter "assignedLicenses/any(x:x/skuId eq $($License.SkuId) )" -All -Property UserPrincipalName, DisplayName, LicenseAssignmentStates, AssignedLicenses | Select-Object DisplayName, UserPrincipalName, AssignedLicenses -ExpandProperty LicenseAssignmentStates

$report = $users | ForEach-Object {
  if($_.SkuId -eq $License.SkuId) {
    $assignmentType = if ($_.AssignedByGroup) { "Group" } else { "Direct" }
    $groupId = if ($_.AssignedByGroup) { $_.AssignedByGroup } else { "N/A" }

    [pscustomobject]@{
        User              = $_.DisplayName
        UserPrincipalName = $_.UserPrincipalName
        Assigned          = $assignmentType
        GroupId           = $groupId
    }
  }
}

$report
