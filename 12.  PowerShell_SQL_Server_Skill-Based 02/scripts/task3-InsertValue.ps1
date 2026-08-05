
# Create connection string
$connectionString = "Server=localhost;Database=master;Trusted_Connection=True;"

# Create connection
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString

$createAdventurersTable = "
DROP TABLE IF EXISTS Adventurers
CREATE TABLE Adventurers (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
);
"
$adventurersValues = "
INSERT INTO Adventurers (Name) VALUES
    ('Baron von Ticklebottom'),
    ('Sir Reginald Pantsalot'),
    ('Gloria Thunderbritches'),
    ('Dirk Daringly Unprepared'),
    ('Lady Wigglesworth of Oddshire'),
    ('Bongo the Mildly Concerned'),
    ('Professor McSnickerdoodle'),
    ('Slippery Pete McGuffin'),
    ('Ambrosia Laughingstock'),
    ('Captain Clumsybeard'),
    ('Flimsy McTavish'),
    ('Duchess Quirk von Bellyflop'),
    ('Snickerdoodle the Unwashed'),
    ('Lord Bumbleberry'),
    ('Gertrude Oops O Malley'),
    ('Blunderella Stumbletoe'),
    ('Sir Jangles-a-Lot'),
    ('Dame Noodlearms'),
    ('Binky the Bewildered'),
    ('Count Flapdoodle')
"

try {
    $connection.Open()

    $command = $connection.CreateCommand()
    $command.CommandText = $createAdventurersTable
    $command.ExecuteNonQuery()

    $command.CommandText = $adventurersValues
    $rowsInserted = $command.ExecuteNonQuery()
    Write-Host "Inserted $rowsInserted sample records into Adventurers table" -ForegroundColor Green

    $command.CommandText = "SELECT * FROM Adventurers"
    $adapter = New-Object System.Data.SqlClient.SqlDataAdapter $command
    $dataset = New-Object System.Data.DataSet
    $adapter.Fill($dataset) | Out-Null
    $dataset.Tables[0] | Format-Table -AutoSize

    $command = $connection.CreateCommand()
    $command.CommandText = $createLostArtifactsTable
    $command.ExecuteNonQuery()

}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
finally {
    if ($connection.State -eq 'Open') {
        $connection.Close()
    }
}
