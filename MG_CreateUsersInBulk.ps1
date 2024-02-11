#Conectarse a Graph usando los permisos necesarios
Connect-MgGraph -Scopes User.ReadWrite.All

#Importar los datos desde un CSV
$users = Import-CSV -Path ".\csv_Path"