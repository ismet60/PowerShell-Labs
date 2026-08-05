# Task 2: Modify XML data
$xmlPath = ".\data\students.xml"
$xmlData = [xml](Get-Content -Path $xmlPath)

# Add a new student record only if ID 4 does not already exist
$existingStudent = $xmlData.SelectSingleNode("//student[id='4']")

if (-not $existingStudent) {
    $newStudent = $xmlData.CreateElement("student")

    $id = $xmlData.CreateElement("id")
    $id.InnerText = "4"

    $name = $xmlData.CreateElement("name")
    $name.InnerText = "Mariam Ali"

    $age = $xmlData.CreateElement("age")
    $age.InnerText = "22"

    $grade = $xmlData.CreateElement("grade")
    $grade.InnerText = "A"

    $newStudent.AppendChild($id) | Out-Null
    $newStudent.AppendChild($name) | Out-Null
    $newStudent.AppendChild($age) | Out-Null
    $newStudent.AppendChild($grade) | Out-Null

    $xmlData.students.AppendChild($newStudent) | Out-Null

    Write-Host "New student added."
} else {
    Write-Host "Student ID 4 already exists."
}

# Update the age of an existing student
$studentIdToUpdate = "2"
$newAge = "22"

$studentToUpdate = $xmlData.SelectSingleNode("//student[id='$studentIdToUpdate']")

if ($studentToUpdate) {
    $studentToUpdate.SelectSingleNode("age").InnerText = $newAge
    Write-Host "Student ID $studentIdToUpdate age updated to $newAge."
} else {
    Write-Host "Student ID $studentIdToUpdate was not found."
}

# Remove a student record by ID
$studentIdToRemove = "3"

$studentToRemove = $xmlData.SelectSingleNode("//student[id='$studentIdToRemove']")

if ($studentToRemove) {
    $studentToRemove.ParentNode.RemoveChild($studentToRemove) | Out-Null
    Write-Host "Student ID $studentIdToRemove removed."
} else {
    Write-Host "Student ID $studentIdToRemove was not found."
}

# Save the modified XML file
$xmlData.Save((Resolve-Path $xmlPath))
Write-Host "XML data saved to $xmlPath."