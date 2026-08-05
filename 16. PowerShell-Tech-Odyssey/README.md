# PowerShell Tech Odyssey

A GitHub-ready PowerShell portfolio project demonstrating XML parsing, SQL Server automation, Selenium-based web automation, and Desired State Configuration (DSC).

## Project Highlights

- Parsed XML with PowerShell and generated a decrypted report.
- Connected to SQL Server, created a sample table, inserted records, and displayed query results.
- Automated a public demo login page using Selenium and PowerShell.
- Built a DSC configuration example for a Windows lab environment.
- Cleaned the documentation for public sharing by removing original branding, submission instructions, local usernames, and visible sensitive details.

## Recommended Repository Structure

```text
PowerShell-Tech-Odyssey/
├── README.md
├── .gitignore
├── scripts/
│   ├── chapter1-xml-scroll.ps1
│   ├── chapter2-sql-treasure.ps1
│   ├── chapter3-web-automation.ps1
│   ├── chapter4-dsc-config.ps1
│   └── chapter5-integration.ps1
├── assets/
│   └── screenshots/
└── docs/
    └── PowerShell_Tech_Odyssey_GitHub_Clean.docx
```

## Tools Used

- Windows PowerShell / PowerShell 7
- SQL Server Developer Edition
- Selenium PowerShell module
- ChromeDriver
- Visual Studio Code
- PowerShell Desired State Configuration

## Safety and Privacy Notes

This public version should not include:

- Original assignment pages or submission instructions
- Real credentials, tokens, keys, or environment files
- Local Windows usernames or machine names
- Generated MOF files or machine-specific DSC output
- Large installers or browser driver binaries

Use environment variables for any demo login values:

```powershell
$env:DEMO_USERNAME = "public-demo-username"
$env:DEMO_PASSWORD = "public-demo-password"
```

## Screenshots

Sanitized screenshots are stored in `assets/screenshots/` and show the folder structure, XML output, SQL Server workflow, Selenium automation, and DSC configuration.

## Suggested Commit Message

```text
Add cleaned PowerShell capstone documentation and sanitized screenshots
```

## License

Choose a license only if you want other people to reuse the code. MIT is common for portfolio labs, but leaving the repository without a license means others do not automatically receive reuse rights.
