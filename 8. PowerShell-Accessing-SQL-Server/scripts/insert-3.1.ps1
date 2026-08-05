# Create connection string
$connectionString = "Server=localhost;Database=master;Trusted_Connection=True;"

# Create SQL connection object
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString

try {
    # Open the connection
    $connection.Open()
    Write-Host "Connected to SQL Server" -ForegroundColor Green

    # Define the insert query
    $insertQuery = @"
INSERT INTO Products (ProductName, Category, Price, StockQuantity)
VALUES 
    ('Smartwatch', 'Electronics', 199.99, 20),
    ('Desk Lamp', 'Furniture', 49.99, 15),
    ('Notebook', 'Stationery', 2.99, 100)
"@

    # Create and execute the SQL command
    $command = $connection.CreateCommand()
    $command.CommandText = $insertQuery
    $rowsInserted = $command.ExecuteNonQuery()

    Write-Host "Inserted $rowsInserted record(s) into Products table." -ForegroundColor Cyan

    Write-Host "Inserted $rowsInserted record(s) into Products table." -ForegroundColor Cyan

    # SHOW table content
    $command.CommandText = "SELECT * FROM Products"
    $adapter = New-Object System.Data.SqlClient.SqlDataAdapter $command
    $dataset = New-Object System.Data.DataSet
    $adapter.Fill($dataset) | Out-Null

    Write-Host "`n--- Current Products Table ---" -ForegroundColor Yellow
    $dataset.Tables[0] | Format-Table -AutoSize
}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
finally {
    if ($connection.State -eq 'Open') {
        $connection.Close()
        Write-Host "Connection closed." -ForegroundColor Yellow
    }
}
