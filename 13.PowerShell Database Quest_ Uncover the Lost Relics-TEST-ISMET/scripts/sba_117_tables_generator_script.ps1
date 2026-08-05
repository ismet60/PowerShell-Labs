
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

$createLostArtifactsTable = "
DROP TABLE IF EXISTS LostArtifacts
CREATE TABLE LostArtifacts (
    ArtifactId INT IDENTITY(1,1) PRIMARY KEY,
    ArtifactName NVARCHAR(100) NOT NULL,
    ArtifactPower NVARCHAR(100) NOT NULL,
    ArtifactStatus NVARCHAR(100) CHECK (ArtifactStatus IN ('Lost', 'Restored'))
);
"

$lostArtifactsValues = "
INSERT INTO LostArtifacts (ArtifactName, ArtifactPower, ArtifactStatus) VALUES
    ('The Scepter of Mild Annoyance', 'Causes papercuts at will', 'Lost'),
    ('Boots of Blistering Speed', 'Run fast but get terrible blisters', 'Restored'),
    ('Helm of Bad Hair Days', 'Permanently messy hair', 'Lost'),
    ('Amulet of Uncontrollable Flatulence', 'Silent but deadly magic', 'Restored'),
    ('Cloak of Invisibility (When No One Is Looking)', 'Only works when unobserved', 'Lost'),
    ('Ring of Misdirection', 'Always point the wrong way', 'Restored'),
    ('Gauntlets of Butterfingers', 'Drop everything you touch', 'Lost'),
    ('Potion of Unquenchable Thirst', 'Makes you perpetually thirsty', 'Restored'),
    ('Scroll of Nonsensical Prophecies', 'Predicts meaningless events', 'Lost'),
    ('Shield of Loud Noises', 'Makes clanging sounds when hit', 'Restored'),
    ('Wand of Unpredictable Polymorph', 'Turns target into random objects', 'Lost'),
    ('Stone of Gravity Detection', 'Falls downward when dropped', 'Restored'),
    ('Tome of Infinite Dad Jokes', 'Never-ending supply of puns', 'Lost'),
    ('Gloves of Extreme Tickling', 'Cannot touch without tickling', 'Restored'),
    ('Horn of Party Summoning', 'Attracts nearby revelers', 'Lost'),
    ('Belt of Pants Shrinking', 'Makes trousers uncomfortably tight', 'Restored'),
    ('Lute of Out-of-Tune Playing', 'Always sounds slightly off', 'Lost'),
    ('Crystal Ball of Poor Reception', 'Fuzzy visions with static', 'Restored'),
    ('Dagger of Papercut Infliction', 'Most painful office supply', 'Lost'),
    ('Chalice of Spilled Drinks', 'Never stays upright', 'Restored');
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

    $command.CommandText = $lostArtifactsValues
    $rowsInserted = $command.ExecuteNonQuery()
    Write-Host "Inserted $rowsInserted sample records into Lost Artifacts table" -ForegroundColor Green

    $command.CommandText = "SELECT * FROM LostArtifacts"
    $adapter = New-Object System.Data.SqlClient.SqlDataAdapter $command
    $dataset = New-Object System.Data.DataSet
    $adapter.Fill($dataset) | Out-Null
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
