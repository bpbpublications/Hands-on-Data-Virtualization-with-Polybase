# Install SQL Server 2019 CU
# IMPORTANT!!! Specify correct path and filename
& c:\setup\SQLServer2019-KB4570012-x64.exe /QS /Action=Patch /IAcceptSQLServerLicenseTerms /InstanceName=MSSQLSERVER

# Login to SQL Server
# IMPORTANT!!! Use your own secure password
sqlcmd -Usa -P@Sq1T3st -Q "select @@version"

# Install MS Access Database Engine 2016 Redistributable
& c:\setup\accessdatabaseengine_X64.exe

# Get ODBC driver
Get-OdbcDriver -Name '*excel*'
Get-OdbcDriver -Name '*csv*'
