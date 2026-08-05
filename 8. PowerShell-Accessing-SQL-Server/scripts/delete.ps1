# Create connection string
$connectionString = "Server=localhost;Database=master;Trusted_Connection=True;"

# Create connection
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString

try {
    # Open the connection
    $connection.Open()
    Write-Host "Connected to the database." -ForegroundColor Green

    # SQL DELETE query
    $deleteQuery = @"
    DELETE FROM Products
    WHERE ProductName = 'Coffee Mug'
"@

    # Create command and execute deletion
    $command = $connection.CreateCommand()
    $command.CommandText = $deleteQuery
    $rowsDeleted = $command.ExecuteNonQuery()

    Write-Host "$rowsDeleted record(s) deleted." -ForegroundColor Yellow

    # Confirm deletion by querying the table
    $command.CommandText = "SELECT * FROM Products WHERE ProductName = 'Coffee Mug'"
    $adapter = New-Object System.Data.SqlClient.SqlDataAdapter $command
    $dataset = New-Object System.Data.DataSet
    $adapter.Fill($dataset) | Out-Null

    if ($dataset.Tables[0].Rows.Count -eq 0) {
        Write-Host "✅ Record successfully deleted. 'Coffee Mug' no longer exists in the table." -ForegroundColor Green
    } else {
        Write-Host "⚠️ Record still exists. Deletion may have failed." -ForegroundColor Red
        $dataset.Tables[0] | Format-Table -AutoSize
    }
}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
finally {
    if ($connection.State -eq 'Open') {
        $connection.Close()
        Write-Host "Connection closed." -ForegroundColor Green
    }
}
