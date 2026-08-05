# Setup connection string
$connectionString = "Server=localhost;Database=master;Trusted_Connection=True;"

# Create connection object
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString

# SQL query
$sqlQuery = "SELECT Name FROM LostArtifacts"

# Execute query
$command = $connection.CreateCommand()
$command.CommandText = $sqlQuery

try {
    $connection.Open()
    
    # Execute query and fetch data
    $adapter = New-Object System.Data.SqlClient.SqlDataAdapter $command
    $dataset = New-Object System.Data.DataSet
    $adapter.Fill($dataset) | Out-Null

    # Output results
    $dataset.Tables[0] | Format-Table -AutoSize
}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
finally {
    if ($connection.State -eq 'Open') {
        $connection.Close()
    }
}
