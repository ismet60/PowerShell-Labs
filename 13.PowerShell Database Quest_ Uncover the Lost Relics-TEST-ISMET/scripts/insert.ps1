# Task - 3 Insert
$connectionString = "Server=localhost;Database=master;Trusted_Connection=True;"
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString

# $adventurerName = "Sir Namer the Valiant"

$insertQuery = "INSERT INTO Adventurers (Name) VALUES 

    ('PowerShell Confusing'),
    ('Chat GTP HELP'),
    ('Practice more')
    "
try {
    # Open connection
    $connection.Open()

    # Create SQL command
    $command = $connection.CreateCommand()
    $command.CommandText = $insertQuery

    # Add parameter to prevent SQL injection (even in fantasy realms)
    $param = $command.Parameters.Add("@Name", [System.Data.SqlDbType]::NVarChar, 100)
    $param.Value = $adventurerName

    # Execute insert
    $rowsAffected = $command.ExecuteNonQuery()

    if ($rowsAffected -gt 0) {
        Write-Host "Successfully inserted adventurer: $adventurerName" -ForegroundColor Green
    } else {
        Write-Host " Insertion failed. !" -ForegroundColor Yellow
    }
}
catch {
    Write-Host " An error occurred: $_" -ForegroundColor Red
}
finally {
    if ($connection.State -eq 'Open') {
        $connection.Close()
    }
}
