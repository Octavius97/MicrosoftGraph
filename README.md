# Microsoft Graph PowerShell
Documentacion referente a Microsoft Graph PowerShell.

> [!Note]
> Este repositorio toma en cuenta ejemplos realizados como practica y/o prueba. Todo lo que realices de manera personal queda **bajo tu propia responsabilidad**.

## 1. Instalacion del Modulo

Buscamos el modulo en la Galeria de Modulos de PowerShell
```PowerShell
Find-Module -Name Microsoft.Graph | Select-Object -Property Name,Version,PublishedDate | Format-List
```
Este comando te muestra la informacion del modulo disponible en la galeria de PowerShell. Para proceder a instalar el modulo escribimos el siguiente comando
```PowerShell
Install-Module Microsoft.Graph -Force
```

> [!Note]
> Para ejecutar procesos con Microsoft Graph PowerShell SDK hay que establecer la política de ejecución del PowerShell sin restricciones
```PowerShell
Set-ExecutionPolicy Unrestricted
```

> [!Important]
> Para conectar al modulo, hay que establecer permisos nevesarios según las acciones a realizar. Para ello se usan `Scopes` que definen los permisos, para más información, puede acceder a la [documentación](https://learn.microsoft.com/en-us/graph/permissions-reference) que contiene todos los permisos y su descripción.

> [!Caution]
> Asegúrese usar los scopes necesarios, en caso de requerir un scope diferente puede volver a conectarse.

## 2. Ejemplos realizados

- Agregar un usuario 👉 [New-MgUser](MicrosoftGraph_NewUser.ps1)
- Agregar usuarios en masa 👉 [ForEach - New-MgUser](MicrosoftGraph_NewUserBulk.ps1)
- Agregar usuarios a un grupo 👉 [ForEach - New-MgGroupMember](MicrosoftGraph_AddUsersToGroupInBulk.ps1)
- Actualizar usuarios en masa 👉 [ForEach - Update-MgUser](MicrosoftGraph_UpdateUsersInBulk.ps1)
- Actualizar el dominio de un grupo de usuarios 👉 [ForEach - Update-MgUser](MicrosoftGraph_ChangeDomainToUserGroup.ps1)
- Agregar métodos de autenticación a un usuario 👉 [New-MgUserAuthentication](MicrosoftGraph_AssignAuthenticationMethod.ps1)
- Asignar licencias a usuarios en masa 👉 [ForEach - Set-MgUserLicense](MicrosoftGraph_UserAssignLicense.ps1)

> [!Important]
> Para asignar las licencias, se deben de usar el Nombre SKU de la licencia. Para más información al respecto puede acceder a la documentación de los nombres SKU de licencias [Para Empresas](https://learn.microsoft.com/en-us/entra/identity/users/licensing-service-plan-reference) o [Para Escuelas](https://learn.microsoft.com/en-us/microsoftteams/sku-reference-edu)

> [!Caution]
> Para asignar licencias en masas, es necesario usar como identificador el ´Id´ del usuario en vez de su ´UPN´. Vea el ejemplo [!INCLUDE [Asignar licencias en masa](MicrosoftGraph_UserAssignLicense.ps1)]