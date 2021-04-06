# Create local administrator account
New-LocalUser -Name HandsOnPolybase -NoPassword -AccountNeverExpires -UserMayNotChangePassword | Set-LocalUser -PasswordNeverExpires $true
Add-LocalGroupMember -Group "Administrators" -Member "HandsOnPolybase"

# Run SQL Server installer
# IMPORTANT!!! Change the SaPwd to a secure password of your own
& "c:\setup\setup.exe" /Q /Action=Install /IAcceptSQLServerLicenseTerms /IndicateProgress /Features=SQLEngine,Conn,Polybase /InstanceName=MSSQLSERVER /TcpEnabled=1 /SecurityMode=SQL /SaPwd=@Sq1T3st /SqlSysAdminAccounts="HandsOnPolybase"

# View installation status in logs
cd "c:\Program Files\Microsoft SQL Server\150\Setup Bootstrap\Log"

# Exit container
exit

# Login to SQL Server
# IMPORTANT!!! Use your own secure SaPwd
sqlcmd -Usa -P@Sq1T3st

# Export statistics from a table
# IMPORTANT!!! Use your own secure SaPwd, specify a valid file location and a unique filename
Import-Module sqlps -DisableNameChecking
$conn = new-object Microsoft.SqlServer.Management.Common.ServerConnection
$conn.ServerInstance = "."
$conn.LoginSecure = $false
$conn.Login = "sa"
$conn.Password = "@Sq1T3st"
$server = new-object Microsoft.SqlServer.Management.SMO.Server $conn
$scripter = new-object Microsoft.SqlServer.Management.SMO.Scripter ($server)
$scripter.Options.AllowSystemObjects = $true
$scripter.Options.OptimizerData = $true
$scripter.Options.ScriptData = $false
$scripter.Options.ToFileOnly = $true
$scripter.Options.FileName = "c:\setup\script.sql"
$database = $server.Databases['DatabaseC']
$table = $database.Tables | where {$_.schema -eq 'dbo' -and $_.name -eq 'TableC'}
foreach ($stat in $table.Statistics) {
  $scripter.Script($stat)
}

# Create parallel jobs to load data
# IMPORTANT!!! Use your own secure SaPwd
Start-Job {sqlcmd -SServerA -Usa -P@Sq1T3st -Q " `
USE [DatabaseA] `
GO `
SELECT COUNT(1) FROM [TableC] WHERE [RandomInt] <= 5"}
Start-Job {sqlcmd -SServerA -Usa -P@Sq1T3st -Q " `
USE [DatabaseA] `
GO `
SELECT COUNT(1) FROM [TableC] WHERE [RandomInt] > 5"}

# View PolyBase errors in logs
cd "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\log\Polybase"
