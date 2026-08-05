# Task 1:


$connectionString = "Server=localhost;Database=master;Trusted_Connection=True;"


$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString

try {
    $connection.Open()
    Write-Host "Connection to the SQL Server established successfully!" -ForegroundColor Green
}
catch {
    Write-Host " Connection failed: $_" -ForegroundColor Red
}
finally {
    if ($connection.State -eq 'Open') {
        $connection.Close()
        Write-Host "Connection closed." -ForegroundColor Yellow
    }
}
