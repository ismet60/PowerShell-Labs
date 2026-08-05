$webServiceURL = 'https://real-web-service-url.com/updateUser'  # Replace with your actual web service URL
$soapRequest = @"
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://www.real-web-service-url.com">
    <soapenv:Header/>
    <soapenv:Body>
        <web:UpdateUserInfo>
            <web:UserID>12345</web:UserID>
            <web:UserName>JaneDoe</web:UserName>
            <web:Email>janedoe@example.com</web:Email>
            <web:PhoneNumber>+11234567890</web:PhoneNumber>
            <web:Address>123 Main St, City, Country</web:Address>
        </web:UpdateUserInfo>
    </soapenv:Body>
</soapenv:Envelope>
"@

$response = Invoke-WebRequest -Uri $webServiceURL -Method Post -ContentType 'text/xml' -Body $soapRequest

# Output the response to see what the service returns
$response.Content
