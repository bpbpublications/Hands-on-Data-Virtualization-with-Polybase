# Install Visual Studio 2019 Redistributable
& C:\setup\VC_redist.x64.exe /install /passive /norestart

# Install MySql ODBC
msiexec /L C:\setup\out.txt /I C:\setup\mysql-connector-odbc-8.0.21-winx64.msi

# Get installed ODBC
Get-OdbcDriver -Name '*MySql*'
