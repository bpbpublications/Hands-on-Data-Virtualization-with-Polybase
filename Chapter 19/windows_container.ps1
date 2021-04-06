# Install PostgreSQL ODBC
msiexec /L C:\setup\out.txt /I C:\setup\psqlodbc_x64.msi

# Get ODBC
Get-OdbcDriver -Name '*postgres*'
