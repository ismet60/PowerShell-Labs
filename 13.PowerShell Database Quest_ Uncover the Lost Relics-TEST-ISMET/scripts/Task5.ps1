# Create connection string
$connectionString = "Server=localhost;Database=master;Trusted_Connection=True;"

# Create connection
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString

# Define SQL to update artifact status
$updateArtifactStatus = "
UPDATE LostArtifacts
SET ArtifactStatus = 'Restored'  -- Update the ArtifactStatus to 'Restored'
WHERE ArtifactStatus = 'Lost';   -- Condition: only for those artifacts marked as 'Lost'
"

try {
    # Open the connection to the database
    $connection.Open()

    # Execute the update command to restore all 'Lost' artifacts
    $command = $connection.CreateCommand()
    $command.CommandText = $updateArtifactStatus  # Use the update query to restore artifacts
    $rowsUpdated = $command.ExecuteNonQuery()  # Executes the query and returns the number of rows affected
    Write-Host "Restored $rowsUpdated lost artifacts to 'Restored' status" -ForegroundColor Green

    # Query to verify the artifacts with their new status
    $command.CommandText = "SELECT * FROM LostArtifacts WHERE ArtifactStatus = 'Restored'"
    $adapter = New-Object System.Data.SqlClient.SqlDataAdapter $command
    $dataset = New-Object System.Data.DataSet
    $adapter.Fill($dataset) | Out-Null

    # Display results in a formatted table
    $dataset.Tables[0] | Format-Table -AutoSize
}
catch {
    # Error handling
    Write-Host "Error: $_" -ForegroundColor Red
}
finally {
    # Close the connection if it's still open
    if ($connection.State -eq 'Open') {
        $connection.Close()
    }
}
