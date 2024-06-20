# ---->> Add all users with a specific domain to a group <<----

# Connect to Microsoft Graph with the required permissions
Connect-MgGraph -Scopes User.Read.All, Group.ReadWrite.All, GroupMember.ReadWrite.All

# Get all users with a specific domain
$users = Get-MgUser -All | Where-Object UserPrincipalName -Match "dominio.com"

# Get the ID of the group where you want to add the users
$idGrupo = ### Copy the ID of the group from Entra ID ###

# Add all users with a specific domain to the group
foreach($u in $users){
    # Add the user to the group
    New-MgGroupMember -GroupId $idGrupo -DirectoryObjectId $u.Id
}

# For test purposes, view the process in the console
foreach($u in $users){
    Write-Progress -Activity "Adding users to the group" -Status "Adding user $($u.UserPrincipalName)" -PercentComplete (($users.IndexOf($u) / $users.Count) * 100)
    New-MgGroupMember -GroupId $idGrupo -DirectoryObjectId $u.Id -ErrorAction SilentlyContinue -ErrorVariable err
    if($err){
        Write-Error "Error adding user $($u.UserPrincipalName) to the group" -ForegroundColor Red
    }
    else {
        Write-Host "User $($u.UserPrincipalName) added to the group" -ForegroundColor Green
    }
}

