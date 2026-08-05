# Task 3 Script: Create Folder and Move File
New-Item -Path "C:\Users\ismet\Downloads\PowerShell\SampleFolder" -ItemType Directory -Force
Move-Item -Path "C:\Users\ismet\Downloads\PowerShell\SampleFile.txt" -Destination "C:\Users\ismet\Downloads\PowerShell\SampleFolder"
