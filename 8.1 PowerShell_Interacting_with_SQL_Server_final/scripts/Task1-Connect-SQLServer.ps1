# Create connection string
$connectionString = "Server=localhost;Database=master;Trusted_Connection=True;"

# Create connection
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString

try {
    # Open the connection
    $connection.Open()
    Write-Host "Successfully connected to the database server." -ForegroundColor Green
}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
}