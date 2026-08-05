# Task 2: Modify JSON Data

$jsonPath = ".\data\students.json"

# Load JSON data
$jsonData = Get-Content -Path $jsonPath | ConvertFrom-Json

# Add a new student entry
$newStudent = [PSCustomObject]@{
    id    = 4
    name  = "Mariam Ali"
    age   = 22
    grade = "C"
}

$jsonData += $newStudent

Write-Host "New student added in memory."

# Update the age of an existing student
$studentIdToUpdate = 2
$newAge = 23

$studentToUpdate = $jsonData | Where-Object { $_.id -eq $studentIdToUpdate }

if ($studentToUpdate) {
    $studentToUpdate.age = $newAge
    Write-Host "Student with ID $studentIdToUpdate updated to age $newAge."
} else {
    Write-Host "Student with ID $studentIdToUpdate was not found."
}
# Remove a student entry by ID
$studentIdToRemove = 4

$studentExists = $jsonData | Where-Object { $_.id -eq $studentIdToRemove }

if ($studentExists) {
    $jsonData = $jsonData | Where-Object { $_.id -ne $studentIdToRemove }
    Write-Host "Student with ID $studentIdToRemove removed."
} else {
    Write-Host "Student with ID $studentIdToRemove was not found."
}

# Save the modified JSON file
$jsonData | ConvertTo-Json -Depth 10 | Set-Content -Path ".\data\students.json"

Write-Host "JSON data saved to .\data\students.json."
# Task 3: Export JSON data to CSV

$jsonPath = ".\data\students.json"
$csvPath = ".\data\students.csv"

# Load JSON data
$jsonData = Get-Content -Path $jsonPath | ConvertFrom-Json

# Convert JSON data to CSV format
$csvData = $jsonData | Select-Object id, name, age, grade

# Export to CSV
$csvData | Export-Csv -Path $csvPath -NoTypeInformation

Write-Host "CSV data saved to $csvPath."
