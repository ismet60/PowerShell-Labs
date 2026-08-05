$webServiceURL = 'http://www.webservicex.net/ConvertCurrency.asmx'
$soapRequest = @"
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://www.webservicex.net">
    <soapenv:Header/>
    <soapenv:Body>
        <web:ConversionRate>
            <web:FromCurrency>USD</web:FromCurrency>
            <web:ToCurrency>EUR</web:ToCurrency>
        </web:ConversionRate>
    </soapenv:Body>
</soapenv:Envelope>
"@

$response = Invoke-WebRequest -Uri $webServiceURL -Method Post -ContentType 'text/xml' -Body $soapRequest

# Output the response to see what the service returns
$response.Content
