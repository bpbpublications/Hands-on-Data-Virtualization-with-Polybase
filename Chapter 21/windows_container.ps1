# Install SAP HANA ODBC
& c:\setup\HDB_CLIENT_WINDOWS_X86_64\hdbinst.exe --silent

# Confirm if the ODBC folder has already been created
dir "C:\Program Files\SAP\hdbclient\"

# Get ODBC
Get-OdbcDriver -Name '*hdb*'
