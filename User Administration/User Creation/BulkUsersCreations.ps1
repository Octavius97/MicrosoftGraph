<#
    .SYNOPSIS
    This script can be used to create multiple users in bulk using a CSV file as input.

    .DESCRIPTION
    The script reads user information from a CSV file and creates user accounts in Entra ID.

    .PARAMETER CSVFilePath
    The .CSV file path containing user information. The CSV file should have the following columns: DisplayName, FirstName, LastName, UserPrincipalName, Password

    .EXAMPLE
    .\BulkUsersCreations.ps1 -CSVFilePath "C:\Temp\Users.csv"
    This example creates user accounts based on the information provided in the Users.csv file.

    .OUTPUTS
    The script outputs the results of the user creation process in an Out-GridView and also exports the results to a CSV file.

    .NOTES
    Version: 1.0
    Author: Octavio Morales
    Date: 2024-06-01
#>

# Parameter definition for the script
param (
    [Parameter(Mandatory = $true)]
    [string]$CSVFilePath
)

# Import the CSV file and create users in bulk
try {

    # Import the CSV File
    $usersList = Import-Csv -Path $CSVFilePath

    # Check if the CSV file is empty
    if ($usersList.Count -eq 0) {
        Write-Error "The CSV file is empty. Please provide a valid CSV file with user information."
        exit
    }

    # Check if the required columns are present in the CSV file
    $requiredColumns = @("DisplayName", "UserPrincipalName", "Password")
    foreach ($column in $requiredColumns) {
        if (-not ($usersList | Get-Member -Name $column)) {
            Write-Error "The CSV file is missing the required column: $column. Please ensure the CSV file has all the required columns."
            exit
        }
    }

    # Table to store the results of user creation
    $resultsTable = @()

    # Connect to the Microsoft Graph API
    Set-MgGraphOption -DisableLoginByWAM $true
    Connect-MgGraph -Scopes "User.ReadWrite.All" -ContextScope Process

    # Loop through each user in the CSV and create the user account
    foreach ($user in $usersList) {
        $params = @{
            AccountEnabled = $true
            DisplayName = $user.DisplayName
            GivenName = $user.FirstName
            Surname = $user.LastName
            UserPrincipalName = $user.UserPrincipalName
            MailNickname = $user.UserPrincipalName.Split('@')[0]
            PasswordProfile = @{
                ForceChangePasswordNextSignIn = $true
                Password = $user.Password
            }
        }
        try {
            New-MgUser @params -ErrorAction Stop
            Write-Host "User '$($user.DisplayName)' created successfully." -ForegroundColor Green
            $resultsTable += [PSCustomObject]@{
                DisplayName = $user.DisplayName
                UserPrincipalName = $user.UserPrincipalName
                Status = "Success"
                Message = "User created successfully."
            }
        } catch {
            Write-Error "Failed to create user '$($user.DisplayName)'. Error: $($_.Exception.Message)"
            $resultsTable += [PSCustomObject]@{
                DisplayName = $user.DisplayName
                UserPrincipalName = $user.UserPrincipalName
                Status = "Failed"
                Message = $_.Exception.Message
            }
        }
    }
} catch{
    Write-Error "Failed to import CSV file. Please check the file path and format. Error: $($_.Exception.Message)"
    exit
}

# Display the results in an Out-GridView for better visualization
$resultsTable | Out-GridView -Title "Bulk User Creation Results"
$currentPath = Get-Location
$resultsPath = Join-Path -Path $currentPath -ChildPath "BulkUserCreationResults_$(Get-Date -Format 'yyyyMMdd_HHmmss').csv"
$resultsTable | Export-Csv -Path $resultsPath -NoTypeInformation
Write-Host "The results were exported to $resultsPath"