# Step 1: Set the SOAP service URL
$webServiceURL = 'http://www.dneonline.com/calculator.asmx'

# Step 2: Write the SOAP request (this will add 10 + 20)
$soapRequest = @"
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
    <soapenv:Header/>
    <soapenv:Body>
        <tem:Add>
            <tem:intA>10</tem:intA>
            <tem:intB>20</tem:intB>
        </tem:Add>
    </soapenv:Body>
</soapenv:Envelope>
"@

# Step 3: Send the SOAP request
$response = Invoke-WebRequest -Uri $webServiceURL -Method Post -ContentType 'text/xml; charset=utf-8' `
  -Body $soapRequest -Headers @{SOAPAction = '"http://tempuri.org/Add"'}

# Step 4: Display the response
$response.Content
