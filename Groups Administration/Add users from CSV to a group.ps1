# ------>> Add users to a group in bulk using Microsoft Graph <<------

# Connect to Microsoft Graph with the required permissions
Connect-MgGraph -Scopes User.Read.All, Group.ReadWrite.All, GroupMember.ReadWrite.All

# Import the list of users from a CSV file
$users = Import-Csv -Path ".\users.csv" # The CSV file should have a column named UPN with the user's UPN

$idGrupo = #Copy the ID of the group from the Microsoft Entra Admin Center

# Add each user to the group
foreach($u in $users){
    New-MgGroupMember -GroupId $idGrupo -DirectoryObjectId (Get-MgUser -UserId $u.UPN).Id
}

# ---->> Get the members of the group to confirm <<------
Get-MgGroupMemberAsUser -GroupId $idGrupo | Select-Object UserPrincipalName, DisplayName

# Disconnect from Microsoft Graph
Disconnect-MgGraph

### ---->> For tests purposes... <<------
foreach($u in $users){
    Write-Progress -Activity "Adding users to the group" -Status "Adding user $($u.UPN)" -PercentComplete (($users.IndexOf($u) / $users.Count) * 100)
    New-MgGroupMember -GroupId $idGrupo -DirectoryObjectId (Get-MgUser -UserId $u.UPN).Id -ErrorAction SilentlyContinue -ErrorVariable Error
    if($Error){
        Write-Error "Error adding user $($u.UPN): $($Error)"
    }
    else{
        Write-Host "User $($u.UPN) added successfully" -ForegroundColor Green
    }
}