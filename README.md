# MicrosoftGraph
Documentatcion referente a Microsoft Graph PowerShell.

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
SetExecution-Policy Unrestricted
```

> [!Info]
> Para conectar al modulo, hay que establecer permisos nevesarios según las acciones a realizar. Para ello se usan `Scopes` que definen los permisos, para más información, puede acceder al CSV con todos los permisos y su descripción.