# Chapter 2: The Scroll of Queries
# Task 2: Decrypting the Scroll of Queries

# Create connection string
$connectionString = "Server=localhost;Database=master;Trusted_Connection=True;"

# Create connection
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString

# SQL to create Adventurers table
$createAdventurersTable = @"
IF OBJECT_ID('Adventurers', 'U') IS NOT NULL DROP TABLE Adventurers;
CREATE TABLE Adventurers (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL
);
"@

# SQL to insert brave adventurers
$adventurersValues = @"
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
    ('Count Flapdoodle');
"@

try {
    $connection.Open()

    # Create and populate the table
    $command = $connection.CreateCommand()
    $command.CommandText = $createAdventurersTable
    $command.ExecuteNonQuery()

    $command.CommandText = $adventurersValues
    $rowsInserted = $command.ExecuteNonQuery()
    Write-Host "Inserted $rowsInserted brave adventurers into the Adventurers table." -ForegroundColor Green

    # Query and reveal the adventurers
    $command.CommandText = "SELECT Name FROM Adventurers"
    $adapter = New-Object System.Data.SqlClient.SqlDataAdapter $command
    $dataset = New-Object System.Data.DataSet
    $adapter.Fill($dataset) | Out-Null
    Write-Host "`n⚔️  Those who dared to embark on the quest:" -ForegroundColor Cyan
    $dataset.Tables[0] | Format-Table -AutoSize

}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
finally {
    if ($connection.State -eq 'Open') {
        $connection.Close()
    }
}
