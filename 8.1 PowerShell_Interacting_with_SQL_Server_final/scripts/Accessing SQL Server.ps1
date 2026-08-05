# Task 1 - Connecting to the Database Server
# Create connection string
$connectionString = "Server=localhost;Database=master;Trusted_Connection=True;"

# Create connection
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString

try {
    $connection.Open()

    # Task 2 - Querying Data
    $command = $connection.CreateCommand()
    $command.CommandText = "SELECT * FROM sys.tables"

    $reader = $command.ExecuteReader()
    while ($reader.Read()) {
        Write-Host $reader.GetString(0)
    }
    $reader.Close()

    $query = "SELECT * FROM Products"
    $command.CommandText = $query
    $adapter = New-Object System.Data.SqlClient.SqlDataAdapter $command
    $dataset = New-Object System.Data.DataSet
    $adapter.Fill($dataset) | Out-Null
    $dataset.Tables[0] | Format-Table -AutoSize

    $reader = $command.ExecuteReader()
    while ($reader.Read()) {
        Write-Host $reader.GetString(1)
    }
    $reader.Close()
}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
finally {
    if ($connection.State -eq 'Open') {
        $connection.Close()
    }
}


