# Task 1: Load and query JSON data
$jsonPath = ".\data\students.json"

# Load JSON data
$jsonData = Get-Content -Path $jsonPath | ConvertFrom-Json

# Display names and ages of all students
foreach ($student in $jsonData) {
    $name = $student.name
    $age = $student.age
    Write-Host "Name: $name, Age: $age"
}

# Find and display the grade of a specific student by ID
$studentId = 1

$student = $jsonData | Where-Object { $_.id -eq $studentId }

if ($student) {
    $grade = $student.grade
    Write-Host "Student with ID $studentId has a grade of $grade"
} else {
    Write-Host "Student with ID $studentId was not found."
}