$TenantId = "250292f0-cc4b-4bbe-b66d-f0c28ecc3839"
$URL = "https://login.microsoftonline.com/$TenantId/oauth2/token"

$Params = @{}
$Params.Add("URI",$URL)
$Params.Add("Method","POST")

$Body = @{ "grant_type" = "srv_challenge"}
$Result = Invoke-RestMethod @Params -UseBasicParsing -Body $Body
$Result.Nonce

