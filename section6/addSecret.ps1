$accessToken='<REDACTED>'

$headers = @{
    'Authorization' = "Bearer $($accessToken)"
    'Content-Type' = 'application/json'
}

$appId = "316ef1f0-3917-4cfe-bceb-73543ba6c97a"

# Define the new secret
$secretStartDate = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssZ")
$secretEndDate = (Get-Date).AddYears(2).ToString("yyyy-MM-ddTHH:mm:ssZ")
$secretDisplayName = "NewAppSecret"

$body = @{
    passwordCredential = 
        @{
            displayName = $secretDisplayName
        }
} | ConvertTo-Json

# Add the new secret to the app
$response = Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/servicePrincipals(appId='$appId')/addPassword" -Headers $headers -Method Post -Body $body

$response