<#
.SYNOPSIS
Updates the profile photos of multiple Microsoft 365 users using photos from a specified folder.

.DESCRIPTION
This script connects to Microsoft Graph and updates the profile photos of users in a Microsoft 365 tenant. 
It retrieves photo files from a specified folder, matches the file names (without extensions) to user IDs, 
and updates the corresponding user's profile photo in Microsoft 365.

.PARAMETER PhotosFolder
Specifies the folder containing the photo files. Each photo file's name (excluding the extension) 
should match the User Principal Name (UPN) or ID of the user whose photo is to be updated.

.NOTES
- Requires the Microsoft Graph PowerShell SDK.
- The script assumes that the user running it has the necessary permissions to update user profile photos.
- The `Connect-MgGraph` cmdlet is used to authenticate with Microsoft Graph. Ensure that the required 
  permissions (`User.ReadWrite.All`) are granted.
- If a user cannot be found or an error occurs, the script will skip that user and log a warning.

#>

# Connect to Microsoft Graph with the required permissions
Connect-MgGraph -Scopes User.ReadWrite.All

# Set the path to the folder containing the photos
$PhotosFolder = ".\Photos"

# Get all photo files in the specified folder
$Photos = Get-ChildItem -Path $PhotosFolder -Recurse -File

# For each photo file, update the corresponding user's profile photo
$Photos | ForEach-Object {
  $UserName = $_.BaseName
  $User = Get-MgUser -UserId $UserName -ErrorAction SilentlyContinue
  if ($User -ne $null) {
    Set-MgUserPhotoContent -UserId $User.Id -InFile $_.FullName
    Write-Host "Updated photo for $UserName" -ForegroundColor Green
  } else {
    Write-Warning "Skipping: User or file path is invalid for $($_.BaseName)"
  }
}

<#
  With Microsoft Entra PowerShell Module
  The script can be modified to use the Entra module for user management and photo updates.
#>
# Connect to Microsoft Graph with the required permissions
Connect-Entra -Scopes User.ReadWrite.All

# Set the path to the folder containing the photos
$PhotosFolder = ".\Photos"

# Get all photo files in the specified folder
$Photos = Get-ChildItem -Path $PhotosFolder -Recurse -File

# For each photo file, update the corresponding user's profile photo
$Photos | ForEach-Object {
  $UserName = $_.BaseName
  $User = Get-EntraUser -UserId $UserName -ErrorAction SilentlyContinue
  if ($User -ne $null) {
    Set-EntraUserThumbnailPhoto -UserId $User.Id -FilePath $_.FullName
    Write-Host "Updated photo for $UserName" -ForegroundColor Green
  } else {
    Write-Warning "Skipping: User or file path is invalid for $($_.BaseName)"
  }
}