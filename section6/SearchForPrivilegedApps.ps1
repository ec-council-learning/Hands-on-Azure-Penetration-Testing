# Authenticate using Azure CLI
#az login

# Get an access token for Microsoft Graph
#$token = az account get-access-token --resource "https://graph.microsoft.com" | ConvertFrom-Json

$accessToken='<REDACTED>'

# set header
$headers = @{
    'Authorization' = "Bearer $($accessToken)"
    'Content-Type' = 'application/json'
}

# Known appRoleId for the required permissions
$roleManagementReadWriteDirectory = "741f803b-c850-494e-b5df-cde7c675a1ca"
$userReadWriteAll = "9e3f62cf-ca93-4989-b6ce-bf83c28f9fe8"

# Find all app registrations
$appRegistrations = Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/applications" -Headers $headers

# Filter applications with specific permissions
$requiredApps = @()
foreach ($app in $appRegistrations.value) {
    $appId = $app.id
    $servicePrincipal = Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/servicePrincipals?`$filter=appId eq '$($app.appId)'" -Headers $headers
    
    foreach ($sp in $servicePrincipal.value) {
        $appRoleAssignments = Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/servicePrincipals/$($sp.id)/appRoleAssignments" -Headers $headers
        
        $hasRoleManagementReadWriteDirectory = $false
        $hasUserReadWriteAll = $false

        foreach ($assignment in $appRoleAssignments.value) {
            if ($assignment.appRoleId -eq $roleManagementReadWriteDirectory) {
                $hasRoleManagementReadWriteDirectory = $true
            }
            if ($assignment.appRoleId -eq $userReadWriteAll) {
                $hasUserReadWriteAll = $true
            }
        }

        if ($hasRoleManagementReadWriteDirectory -and $hasUserReadWriteAll) {
            $requiredApps += $app
            break
        }
    }
}

$requiredApps
