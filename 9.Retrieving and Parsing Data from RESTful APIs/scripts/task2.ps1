$jsonData = '{
    "employeelist" : [

        {
            "id" :  101,
            "firstName" : "John",
            "LastName" : "Bason",
            "department" : "HR"
        },
        {
            "id" : "102",
            "firstName" : "Mr. PBC",
            "LastName" : "MXZ",
            "department" : "IT" 
        },
        {
            "id" : "103",
            "firstName" : "Mr. ABC",
            "LastName" : "XYZ",
            "department" : "Admin" 
        
        }
    ]   


}'

$data = $jsonData | ConvertFrom-Json

foreach ($employee in $data.employeelist) {
    Write-Host "Employee Name: $($employee.firstName) $($employee.lastName)"

}


