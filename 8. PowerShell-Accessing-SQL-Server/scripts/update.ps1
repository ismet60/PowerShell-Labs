# Create connection string
$connectionString = "Server=localhost;Database=master;Trusted_Connection=True;"

# Create connection
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString

try {
    # Open the connection
    $connection.Open()
    Write-Host "Successfully connected to the database server." -ForegroundColor Green

    # Update record: Changing price and stock quantity of a product
    $updateQuery = @"
    UPDATE Products
    SET Price = 649.99, StockQuantity = 18
    WHERE ProductName = 'Smartphone'
"@

    # Create command object and execute the update query
    $command = $connection.CreateCommand()
    $command.CommandText = $updateQuery
    $rowsUpdated = $command.ExecuteNonQuery()

    # Output how many rows were updated
    Write-Host "Updated $rowsUpdated record(s)" -ForegroundColor Green

    # Query data to confirm the update
    $selectQuery = "SELECT * FROM Products WHERE ProductName = 'Smartphone'"

    $command.CommandText = $selectQuery
    $adapter = New-Object System.Data.SqlClient.SqlDataAdapter $command
    $dataset = New-Object System.Data.DataSet
    $adapter.Fill($dataset) | Out-Null

    # Display the updated data
    $dataset.Tables[0] | Format-Table -AutoSize

}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
finally {
    # Close the connection if it's open
    if ($connection.State -eq 'Open') {
        $connection.Close()
        Write-Host "Connection closed." -ForegroundColor Green
    }
}
