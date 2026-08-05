# Install SQL Server
Install-WindowsFeature -Name 'MSSQL-Server'

# Example Configuration: Set SQL Server authentication mode (Windows authentication)
# You can modify the configuration to your needs (e.g., set instance name, authentication mode)

$instanceName = "MSSQLSERVER"  # Change this if you have a named instance
$authMode = "SQL"  # Choose "SQL" for mixed mode or "Windows" for Windows authentication

# Set the SQL Server authentication mode
Invoke-Sqlcmd -Query "sp_configure 'show advanced options', 1; RECONFIGURE;" -ServerInstance $instanceName
Invoke-Sqlcmd -Query "sp_configure 'mixed authentication mode', 1; RECONFIGURE;" -ServerInstance $instanceName

# Start the SQL Server service
Start-Service -Name 'MSSQLSERVER'

# Verify if the SQL Server service is running
Get-Service -Name 'MSSQLSERVER'
