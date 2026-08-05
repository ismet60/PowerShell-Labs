# Task 2

$connectionString = "Server=localhost;Database=master;Trusted_Connection=True;"
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString

$query = "SELECT Name FROM Adventurers"

try {
    # Open connection
    $connection.Open()

    # Create SQL command
    $command = $connection.CreateCommand()
    $command.CommandText = $query

    # Execute query and fill dataset
    $adapter = New-Object System.Data.SqlClient.SqlDataAdapter $command
    $dataset = New-Object System.Data.DataSet
    $adapter.Fill($dataset) | Out-Null

    # Display adventurer names in a scroll-like fashion
    Write-Host "` Adventurers :" -ForegroundColor Cyan
    $dataset.Tables[0] | ForEach-Object {
        Write-Host " - $($_.Name)" -ForegroundColor Yellow
    }
}
catch {
    Write-Host " An error occurred while decrypting the scroll: $_" -ForegroundColor Red
}
finally {
    if ($connection.State -eq 'Open') {
        $connection.Close()
    }
}
