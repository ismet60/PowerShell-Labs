# Sample access token (replace this with an actual token if you have one)
$accessToken = 'QpwL5tke4Pnpja7X4'

# Set up the Authorization header with the token
$headers = @{
    'Authorization' = "Bearer $accessToken"
}

# Make the API request to the secured endpoint
$response = Invoke-RestMethod -Uri 'https://jsonplaceholder.typicode.com/posts' -Headers $headers

# Display the response
$response
