# Dummy SOAP XML response (as string)
$soapResponse = @"
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://www.example.com/webservice">
    <soapenv:Header/>
    <soapenv:Body>
        <web:GetDataResponse>
            <web:Result>Data extracted from web service response.</web:Result>
        </web:GetDataResponse>
    </soapenv:Body>
</soapenv:Envelope>
"@

# Convert the string into an XML object
[xml]$xmlDoc = $soapResponse

# Define the namespace manager
$nsMgr = New-Object System.Xml.XmlNamespaceManager($xmlDoc.NameTable)
$nsMgr.AddNamespace("soapenv", "http://schemas.xmlsoap.org/soap/envelope/")
$nsMgr.AddNamespace("web", "http://www.example.com/webservice")

# Extract the <web:Result> element value
$resultNode = $xmlDoc.SelectSingleNode("//web:Result", $nsMgr)

# Display the result
if ($resultNode -ne $null) {
    Write-Host "Extracted Result: $($resultNode.InnerText)"
} else {
    Write-Host "Result not found in the response."
}
