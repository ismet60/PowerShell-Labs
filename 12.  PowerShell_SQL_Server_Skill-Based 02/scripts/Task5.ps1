# Create connection string
$connectionString = "Server=localhost;Database=master;Trusted_Connection=True;"

# Create connection
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString

# SQL to update all lost artifacts
$restoreLostArtifacts = "
UPDATE LostArtifacts
SET ArtifactStatus = 'Restored'
WHERE ArtifactStatus = 'Lost';
"

# SQL to verify restoration
$verifyRestoration = "
SELECT * FROM LostArtifacts WHERE ArtifactStatus = 'Restored';
"

try {
    # Open connection
    $connection.Open()

    # Create and execute update command
    $command = $connection.CreateCommand()
    $command.CommandText = $restoreLostArtifacts
    $rowsUpdated = $command.ExecuteNonQuery()
    Write-Host "✨ Restored $rowsUpdated lost artifact(s) to their former glory." -ForegroundColor Green

    # Display all restored artifacts
    $command.CommandText = $verifyRestoration
    $adapter = New-Object System.Data.SqlClient.SqlDataAdapter $command
    $dataset = New-Object System.Data.DataSet
    $adapter.Fill($dataset) | Out-Null

    Write-Host "`n📜 All Restored Artifacts:" -ForegroundColor Cyan
    $dataset.Tables[0] | Format-Table -AutoSize
}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
finally {
    # Close connection
    if ($connection.State -eq 'Open') {
        $connection.Close()
    }
}
