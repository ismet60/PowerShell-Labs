# Task 3: Export XML data to CSV
$xmlPath = ".\data\students.xml"
$csvPath = ".\data\students.csv"

$xmlData = [xml](Get-Content -Path $xmlPath)

$students = $xmlData.SelectNodes("//student")

$csvData = foreach ($student in $students) {
    [PSCustomObject]@{
        ID    = $student.SelectSingleNode("id").InnerText
        Name  = $student.SelectSingleNode("name").InnerText
        Age   = $student.SelectSingleNode("age").InnerText
        Grade = $student.SelectSingleNode("grade").InnerText
    }
}

$csvData | Export-Csv -Path $csvPath -NoTypeInformation

Write-Host "CSV data saved to $csvPath."
Import-Csv -Path $csvPath | Format-Table