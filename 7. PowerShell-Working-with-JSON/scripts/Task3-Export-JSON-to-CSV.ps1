# Task 3: Export JSON Data to CSV

$jsonPath = ".\data\students.json"
$csvPath = ".\data\students.csv"

# Load JSON data
$jsonData = Get-Content -Path $jsonPath | ConvertFrom-Json

# Convert JSON data to CSV format
$csvData = $jsonData | Select-Object id, name, age, grade

# Export CSV
$csvData | Export-Csv -Path $csvPath -NoTypeInformation

Write-Host "CSV data saved to $csvPath."

# Verify CSV output
Import-Csv -Path $csvPath | Format-Table

Write-Host "CSV verification completed."