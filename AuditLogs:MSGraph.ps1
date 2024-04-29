Connect-MgGraph -Scopes AuditLog.Read.All

# Obtener los registros de cambio de contraseña de los usuarios
Get-MgAuditLogDirectoryAudit | `
  Where-Object { ($_.Category -eq "UserManagement") -AND ($_.ActivityDisplayName -match "password") } | `
  Select-Object @{N='Fecha';E={$_.ActivityDateTime}}, @{N='Actividad';E={$_.ActivityDisplayName}},`
  @{N='Usuario';E={$_.TargetResources.DisplayName}},@{N='Correo';E={$_.TargetResources.UserPrincipalName}},`
  @{N='Realizado por';E={$_.InitiatedBy.User.UserPrincipalName}} | Format-Table -AutoSize
  