# Create table if not exists
$createTableQuery = @"
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Products')
BEGIN
    CREATE TABLE Products (
        ProductID INT IDENTITY(1,1) PRIMARY KEY,
        ProductName NVARCHAR(100) NOT NULL,
        Category NVARCHAR(50) NOT NULL,
        Price DECIMAL(10, 2) NOT NULL,
        StockQuantity INT DEFAULT 0,
        DateAdded DATETIME DEFAULT GETDATE(),
        IsActive BIT DEFAULT 1
    )
    PRINT 'Products table created successfully'
END
ELSE
BEGIN
    PRINT 'Products table already exists'
END
"@

try {
    # Execute the table creation query
    $command = $connection.CreateCommand()
    $command.CommandText = $createTableQuery
    $command.ExecuteNonQuery()

    # Insert sample data (only if table was just created)
    $insertDataQuery = @"
    INSERT INTO Products (ProductName, Category, Price, StockQuantity)
    VALUES 
        ('Laptop', 'Electronics', 999.99, 10),
        ('Smartphone', 'Electronics', 699.99, 15),
        ('Desk Chair', 'Furniture', 149.99, 5),
        ('Coffee Mug', 'Kitchen', 9.99, 50),
        ('Wireless Headphones', 'Electronics', 129.99, 8)
"@
    $command.CommandText = $insertDataQuery
    $rowsInserted = $command.ExecuteNonQuery()
    Write-Host "Inserted $rowsInserted sample records" -ForegroundColor Green

    # Query and display data
    $command.CommandText = "SELECT * FROM Products"
    $adapter = New-Object System.Data.SqlClient.SqlDataAdapter $command
    $dataset = New-Object System.Data.DataSet
    $adapter.Fill($dataset) | Out-Null
    $dataset.Tables[0] | Format-Table -AutoSize
}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
finally {
    # Close the connection if it was opened
    if ($connection.State -eq 'Open') {
        $connection.Close()
    }
}
