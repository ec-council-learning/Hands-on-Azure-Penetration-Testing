$bd = "client_id=316ef1f0-3917-4cfe-bceb-73543ba6c97a&client_secret=<REDACTED>&grant_type=client_credentials&scope=https://graph.microsoft.com/.default"

# Authenticate 
$newToken = Invoke-RestMethod -Uri "https://login.microsoftonline.com/250292f0-cc4b-4bbe-b66d-f0c28ecc3839/oauth2/v2.0/token" -Method POST -ContentType "application/x-www-form-urlencoded" -Body $bd

# Set header
$newHeaders = @{
    'Authorization' = "Bearer $($newToken.access_token)"
    'Content-Type' = 'application/json'
}

# Create a new user
$newUser = @{
    accountEnabled = $true
    displayName = "John Doe"
    mailNickname = "johndoe"
    userPrincipalName = "johndoe444@lastmile.so"
    passwordProfile = @{
        forceChangePasswordNextSignIn = $false
        password = "<REDACTED>"
    }
} | ConvertTo-Json

$createdUser = Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/users" -Headers $newHeaders -Method Post -Body $newUser

$roleAssignment = @{
    "@odata.type" = "#microsoft.graph.unifiedRoleAssignment"
    "principalId" = $createdUser.Id
    "roleDefinitionId" = $roleDefinitionId
    "directoryScopeId" = "/" 
}|ConvertTo-Json


Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments" -Headers $newHeaders -Method Post -Body $roleAssignment
