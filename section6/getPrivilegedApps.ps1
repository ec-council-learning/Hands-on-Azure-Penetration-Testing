Import-Module Az
$RequiredPermission =  "9e3f62cf-ca93-4989-b6ce-bf83c28f9fe8" # RoleManagement.ReadWrite.Directory
$servicePrincipals = Get-AzADServicePrincipal

$vulnerableServicePrincipals = @()


foreach ($sp in $servicePrincipals) {
    # Get the app role assignments for each service principal
    $appRoleAssignments = Get-AzADServicePrincipalAppRoleAssignment -ServicePrincipalId $sp.Id

    # Check if any of the app role assignments match the required permission
    $hasRequiredPermission = $appRoleAssignments | Where-Object { $_.AppRoleId -eq $RequiredPermission }

    if ($hasRequiredPermission) {
        $vulnerableServicePrincipals += $sp
    }
}