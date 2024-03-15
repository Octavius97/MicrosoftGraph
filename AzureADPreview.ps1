#Install the module. For more information see: https://www.powershellgallery.com/packages/AzureADPreview/2.0.2.149
Install-Module -Name AzureADPreview

#Import the module.
Import-Module -name AzureADPreview

$cred = Get-Credential -UserName "admin@oc365support.cloudns.org" -Message "Ingresa tu contrase;a" -Title "BeeMead Liquours Password"
# Connect to the module.
Connect-AzureAD -Credential $cred

# Get the Directory Settings Template
Get-AzureADDirectorySettingTemplate