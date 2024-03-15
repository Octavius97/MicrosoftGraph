# Inmportar el modulo
Import-Module Mscommerce
# Conectar al modulo
Connect-MSCommerce
# Obtener la lista de los productos
$product = Get-MSCommerceProductPolicies -PolicyId AllowSelfServicePurchase
# Recorrer la lista y desactivar cada uno de ellos
foreach($p in $product){
    Update-MSCommerceProductPolicy -ProductId $p.ProductId -PolicyId AllowSelfServicePurchase -Value Disabled
}