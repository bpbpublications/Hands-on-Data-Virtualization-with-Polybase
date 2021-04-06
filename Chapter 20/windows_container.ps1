# Install MariaDB ODBC
# IMPORTANT!!! Specify valid location and filenames
msiexec /L C:\setup\out.txt /I C:\setup\mariadb-connector-odbc-3.1.9-win64.msi

# Get ODBC
Get-OdbcDriver -Name '*mariadb*'
