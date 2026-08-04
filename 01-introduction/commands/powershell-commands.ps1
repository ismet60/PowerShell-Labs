# Part 2 - PowerShell commands used in this lab
# Run these in PowerShell. Replace <YourUsername> with your Windows account name.

# List files and folders
Get-ChildItem

# Change directory
Set-Location C:\Users\<YourUsername>\Documents

# Write text to a file
"Hello-World" | Out-File -FilePath C:\Users\<YourUsername>\Documents\file10.txt

# Read the file back
Get-Content C:\Users\<YourUsername>\Documents\file10.txt

# Delete a file
Remove-Item C:\Users\<YourUsername>\Documents\file10.txt

# Print a message
Write-Host "Hello World!"


# Part 3 - Create a folder and a file

Set-Location C:\Users\<YourUsername>\Documents
New-Item -Name "PowerShell Scripts" -ItemType Directory
Set-Location "C:\Users\<YourUsername>\Documents\PowerShell Scripts"
New-Item -Name "test.txt" -ItemType File
