$xmlPath = ".\data\students.xml"
$xmlData = [xml](Get-Content -Path $xmlPath)

# Display names and ages of all students
$students = $xmlData.SelectNodes("//student")

foreach ($student in $students) {
    $name = $student.SelectSingleNode("name").InnerText
    $age = $student.SelectSingleNode("age").InnerText
    Write-Host "Name: $name, Age: $age"
}

# Find and display grade by student ID
$studentId = "1"
$student = $xmlData.SelectSingleNode("//student[id='$studentId']")

if ($student) {
    $grade = $student.SelectSingleNode("grade").InnerText
    Write-Host "Student with ID $studentId has a grade of $grade"
} else {
    Write-Host "Student with ID $studentId was not found."
}