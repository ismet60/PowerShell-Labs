# Create connection string
$connectionString = "Server=localhost;Database=master;Trusted_Connection=True;"

# Create connection
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString

$createTableQuery = "
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'TreasureTable')
BEGIN
    CREATE TABLE TreasureTable (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(100) NOT NULL,
        Value DECIMAL(10, 2) NOT NULL,
    )
    PRINT 'TreasureTable table created successfully'
END
ELSE
BEGIN
    DROP TABLE TreasureTable
END
"

try {
    $connection.Open()
    
    # Creating the 'Products' table.
    $command = $connection.CreateCommand()
    $command.CommandText = $createTableQuery
    
    $result = $command.ExecuteNonQuery()
    
    # Inserting data into the 'Products' table.
    $insertDataQuery = " 
    INSERT INTO TreasureTable (Name, Value) VALUES 
    ('Golden Rubber Chicken', 499.99),
    ('Diamond-Encrusted Whoopee Cushion', 1250.00),
    ('Solid Platinum Fidget Spinner', 899.95),
    ('Ancient Scroll of Dad Jokes', 42.42),
    ('Mysterious Bag of Missing Socks', 17.76),
    ('Unicorn Horn (allegedly)', 750.50),
    ('Pirate''s Last Rolo', 0.99),
    ('The Holy Grail (travel mug edition)', 19.99),
    ('Elvis''s Lost Sideburns', 650.00),
    ('Invisible Cloak (just regular air)', 999.99),
    ('Dragon''s Breath Mints', 3.50),
    ('Mermaid''s Hairbrush', 45.00),
    ('Yeti Footprint Cast', 120.00),
    ('Leprechaun''s IOU Note', 1.00),
    ('Bigfoot''s Hair Gel', 28.75),
    ('Chunk of the Moon (meteorite)', 500.25),
    ('Narwhal Tusk Toothpick', 350.00),
    ('Sasquatch Scented Candle', 15.99),
    ('Fountain of Youth Water Bottle', 79.95),
    ('Thor''s Screwdriver Set', 89.50),
    ('Medusa''s Hair Care Kit', 65.00),
    ('Minotaur''s Maze GPS', 199.99),
    ('Phoenix Feather Duster', 55.25),
    ('Loch Ness Selfie Stick', 22.50),
    ('Genie''s Empty Lamp', 249.99),
    ('Kraken Ink Cartridge', 30.00),
    ('Cyclops''s Reading Glasses', 75.00),
    ('Midas Touch Hand Sanitizer', 12.99),
    ('Werewolf Nail Clippers', 8.50),
    ('Vampire Sunscreen SPF ∞', 24.95),
    ('Zombie Brain Protein Shake', 5.99),
    ('Ghost''s Favorite Sheet', 35.00),
    ('Wizard''s Broken Wand', 10.00),
    ('Fairy Dust (glitter)', 2.99),
    ('Troll''s Bridge Toll Receipt', 0.01),
    ('Dragon Hoard Tax Bill', 1000000.00),
    ('Mermaid''s Tail Fin Flip Flops', 39.99),
    ('Centaur''s Horseshoes (set of 4)', 120.00),
    ('Griffin Feather Quill Pen', 45.50),
    ('Harpy''s Nail File', 7.25),
    ('Sphinx''s Riddle Book', 18.00),
    ('Chimera''s Comb (3-sided)', 22.75),
    ('Pegasus Airline Miles', 150.00),
    ('Gorgon''s Hair Serum', 32.99),
    ('Banshee''s Karaoke Microphone', 59.95),
    ('Kappa''s Water Bowl', 14.50),
    ('Jackalope Antler Polish', 9.99),
    ('Basilisk''s Sunglasses', 85.00),
    ('Hippogriff Saddle', 299.99),
    ('Cerberus Dog Treats (3-pack)', 12.50),
    ('Dwarven Beard Oil', 21.99);"

    $command.CommandText = $insertDataQuery
    $rowsInserted = $command.ExecuteNonQuery()
    Write-Host "Inserted $rowsInserted sample records" -ForegroundColor Green

    # Display the contents of the 'Products' table.
    $command.CommandText = "SELECT * FROM TreasureTable"
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
