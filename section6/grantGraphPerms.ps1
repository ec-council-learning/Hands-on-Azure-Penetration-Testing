$TenantID="250292f0-cc4b-4bbe-b66d-f0c28ecc3839"
$GraphAppId = "00000003-0000-0000-c000-000000000000"
$DisplayNameOfMSI="AzPtSOCTriage"
$PermissionName = "RoleManagement.ReadWrite.Directory"


# Install the module
Install-Module AzureAD
Connect-AzureAD -TenantId $TenantID

$MSI = (Get-AzureADServicePrincipal -Filter "displayName eq '$DisplayNameOfMSI'")
Start-Sleep -Seconds 10

$GraphServicePrincipal = Get-AzureADServicePrincipal -Filter "appId eq '$GraphAppId'"
$AppRole = $GraphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains "Application"}
New-AzureAdServiceAppRoleAssignment -ObjectId $MSI.ObjectId -PrincipalId $MSI.ObjectId -ResourceId $GraphServicePrincipal.ObjectId -Id $AppRole.Id