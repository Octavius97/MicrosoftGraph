Connect-MgGraph -scopes User.Read.All

#Listar todos los usuarios que tienen foto
$users = Get-MgUser -All

$report = @()
foreach($u in $users){
  $photo = Get-MgUserPhoto -UserId $u.Id -ErrorAction SilentlyContinue
  if($photo -ne $null){
    $report += [PSCustomObject]@{
      UserName = $u.UserPrincipalName
      DisplayName = $u.DisplayName
      Photo = 'Has photo'
    }
  }
  else{
    $report += [PSCustomObject]@{
      UserName = $u.UserPrincipalName
      DisplayName = $u.DisplayName
      Photo = 'Has no photo'
    }
  }
}

$report | Out-GridView