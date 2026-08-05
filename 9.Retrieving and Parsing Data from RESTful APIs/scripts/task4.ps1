# Define the login credentials (use a valid email and password)
$body = @{
    "email" = "eve.holt@reqres.in"
    "password" = "cityslicka"
}

# Convert the body to JSON format
$jsonBody = $body | ConvertTo-Json

# Send a POST request to get the token
$response = Invoke-RestMethod -Uri 'https://reqres.in/api/login' -Method Post -Body $jsonBody -ContentType 'application/json'

# Extract the access token from the response
$accessToken = $response.token
Write-Host "Your Access Token is: $accessToken"

# Sample access token (replace this with an actual token if you have one)
$accessToken = 'QpwL5tke4Pnpja7X4'

# Set up the Authorization header with the token
$headers = @{
    'Authorization' = "Bearer $accessToken"
}

# Make the API request to the secured endpoint
$response = Invoke-RestMethod -Uri 'https://jsonplaceholder.typicode.com/posts' -Headers $headers

# Display the response to verify if we get the secured data
if ($response) {

    Write-Host "Secured Data Retrieved Sucessfully: "
    Write-Host $response

}else{
    Write-Host "No Data Received"
}
