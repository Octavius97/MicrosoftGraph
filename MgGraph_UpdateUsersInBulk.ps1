Set-ExecutionPolicy Unrestricted
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$csvUsers = Import-Csv -Path .\test9_02Cr.csv -Delimiter ";"

foreach($user in $csvUsers){
    $u = Get-MgUser -UserId $user.UPN
    $displayName = $user.DisplayName
    $Name = $user.Name
    $LastName = if($user.LastName -EQ $null) { " " } else { $user.LastName }
    $Phone = if($user.Phone -EQ $null) { " " } else { $user.Phone }
    $Department = if($user.Department -EQ $null) { " " } else { $user.Department}
    $Office = if($user.Office -EQ $null) { " " } else { $user.Office }
    $State = if($user.State -EQ $null) { " " } else { $user.State }
    $Postal = if($user.PostalCode -EQ $null) { " " } else { $user.PostalCode }
    $Dir = if($user.PostalDir -EQ $null) { " " } else { $user.PostalDir }
    $Job = if($user.Job -EQ $null) { " " } else { $user.Job }
    $Jefe = if($user.Boss -EQ $null) { " " } else { $user.Boss }
    
    Update-MgUser -UserId $u.Id -DisplayName $displayName -GivenName $Name -Surname $LastName -MobilePhone $Phone -Department $Department -OfficeLocation $Office -State $State -PostalCode $Postal -StreetAddress $Dir -JobTitle $Job -Country "Mexico" -Manager 
    Set-MgUserManagerByRef -UserId $u.Id -BodyParameter @{"@odata.id" = "https://graph.microsoft.com/v1.0/users/$($Jefe.Id)" }
}
