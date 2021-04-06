# Install ODBC
# IMPORTANT!!! Specify valid locations and filenames
msiexec /L c:\setup\out.txt /I C:\setup\SparkODBC64.msi

# Get installed ODBC
Get-OdbcDriver -Name '*Spark*'
