# Step 1: Set the real SOAP web service URL
$webServiceURL = 'https://www.crcind.com/csp/samples/SOAP.Demo.cls'

# Step 2: Create the SOAP request XML (call AddInteger method)
$soapRequest = @"
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org">
    <soapenv:Header/>
    <soapenv:Body>
        <tem:AddInteger>
            <tem:Arg1>5</tem:Arg1>
            <tem:Arg2>15</tem:Arg2>
        </tem:AddInteger>
    </soapenv:Body>
</soapenv:Envelope>
"@

# Step 3: Send the request using Invoke-WebRequest
$response = Invoke-WebRequest -Uri $webServiceURL -Method Post -ContentType 'text/xml; charset=utf-8' `
  -Body $soapRequest -Headers @{SOAPAction = "AddInteger"}

# Step 4: Parse the XML response
[xml]$xmlDoc = $response.Content

# Step 5: Define the namespace manager for correct parsing
$nsMgr = New-Object System.Xml.XmlNamespaceManager($xmlDoc.NameTable)
$nsMgr.AddNamespace("soapenv", "http://schemas.xmlsoap.org/soap/envelope/")
$nsMgr.AddNamespace("ns", "http://tempuri.org")

# Step 6: Extract the <AddIntegerResult> value from the response
$resultNode = $xmlDoc.SelectSingleNode("//ns:AddIntegerResult", $nsMgr)

# Step 7: Display the result
if ($resultNode -ne $null) {
    Write-Host "✅ Result from Web Service: $($resultNode.InnerText)"
} else {
    Write-Host "❌ Could not find result in the SOAP response."
}

