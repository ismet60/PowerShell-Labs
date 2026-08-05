# Unearthing the Relic of Insertion
# In your journey, you will need to insert your name into the "Adventurers" table as a brave quest-taker.
# Use PowerShell to insert your adventurer name into the database.

# STEP 1: Create connection string to the database
$connectionString = "Server=localhost;Database=master;Trusted_Connection=True;"

# STEP 2: Initialize SQL connection object
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString

# STEP 3: SQL to create the Adventurers table
# — This is the Adventurers table definition —
$createAdventurersTable = "
DROP TABLE IF EXISTS Adventurers;
CREATE TABLE Adventurers (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL
);
"

# STEP 4: Define the initial insert block
# — These are the initial legendary adventurers —
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
    ('Count Flapdoodle');
"

try {
    # STEP 5: Open connection
    $connection.Open()

    # STEP 6: Execute table creation
    $command = $connection.CreateCommand()
    $command.CommandText = $createAdventurersTable
    $command.ExecuteNonQuery()

    # STEP 7: Execute the initial insert block (legendary heroes)
    $command.CommandText = $adventurersValues
    $rowsInserted = $command.ExecuteNonQuery()
    Write-Host "Inserted $rowsInserted sample records into Adventurers table" -ForegroundColor Green

    # STEP 8: Insert your adventurer name — the Relic of Insertion 🗡️
    $yourName = "Sir ChatGPT the Helpful"  # <== Change this to your own legendary name!
    $command.CommandText = "INSERT INTO Adventurers (Name) VALUES ('$yourName')"
    $command.ExecuteNonQuery()
    Write-Host "Inserted your adventurer name: $yourName" -ForegroundColor Cyan

    # STEP 9: Display the contents of the Adventurers table
    $command.CommandText = "SELECT * FROM Adventurers"
    $adapter = New-Object System.Data.SqlClient.SqlDataAdapter $command
    $dataset = New-Object System.Data.DataSet
    $adapter.Fill($dataset) | Out-Null
    $dataset.Tables[0] | Format-Table -AutoSize
}
catch {
    # STEP 10: Handle any errors
    Write-Host "Error: $_" -ForegroundColor Red
}
finally {
    # STEP 11: Close the connection if it's still open
    if ($connection.State -eq 'Open') {
        $connection.Close()
    }
}
