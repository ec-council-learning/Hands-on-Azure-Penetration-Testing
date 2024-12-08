Connect-AzAccount -Identity
$resourceGroups = Get-AzResourceGroup
foreach ($rg in $resourceGroups) {
    Write-Output "Resources in Resource Group: $($rg.ResourceGroupName)"
    $resources = Get-AzResource -ResourceGroupName $rg.ResourceGroupName

    foreach ($resource in $resources) {
        Write-Output "`t $($resource.Name) - $($resource.ResourceType)"
    }
}



$secretprojperms = Get-AzRoleAssignment -Scope /subscriptions/0c4a19a6-71ae-4a4b-8dff-18378294e015/resourceGroups/SecretProjectDEF
foreach ($roleAssignment in $secretprojperms) {
    "RoleAssignmentName : $($roleAssignment.RoleAssignmentName)"
    "RoleAssignmentId   : $($roleAssignment.RoleAssignmentId)"
    "Scope              : $($roleAssignment.Scope)"
    "DisplayName        : $($roleAssignment.DisplayName)"
    "SignInName         : $($roleAssignment.SignInName)"
    "RoleDefinitionName : $($roleAssignment.RoleDefinitionName)"
    "RoleDefinitionId   : $($roleAssignment.RoleDefinitionId)"
    "ObjectId           : $($roleAssignment.ObjectId)"
    "ObjectType         : $($roleAssignment.ObjectType)"
    "CanDelegate        : $($roleAssignment.CanDelegate)"
    "Description        : $($roleAssignment.Description)"
    "ConditionVersion   : $($roleAssignment.ConditionVersion)"
    "Condition          : $($roleAssignment.Condition)"
}
