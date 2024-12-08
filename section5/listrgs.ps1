Connect-AzAccount -Identity
$resourceGroups = Get-AzResourceGroup
foreach ($rg in $resourceGroups) {
    Write-Output "Resources in Resource Group: $($rg.ResourceGroupName)"
    $resources = Get-AzResource -ResourceGroupName $rg.ResourceGroupName

    foreach ($resource in $resources) {
        Write-Output "`t $($resource.Name) - $($resource.ResourceType)"
    }
}