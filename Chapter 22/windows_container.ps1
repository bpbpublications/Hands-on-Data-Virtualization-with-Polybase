# Decompress IBM DB2 ODBC
# IMPORTANT!!! Specify correct path and filename
Expand-Archive c:\setup\v11.5.4_ntx64_odbc_cli.zip -Destination c:\ -Force

# Install 32-bit ODBC
& c:\clidriver\bin\db2cli32.exe install -setup

# Install 64-bit ODBC
& c:\clidriver\bin\db2cli.exe install -setup

# Create configuration file
# IMPORTANT!!! Use your IBM DB2 IP address
$content = @"
<configuration>
  <dsncollection>
    <dsn alias="DB2DB" name="DB2DB" host="192.168.1.9" port="50000">
      <parameter name="CommProtocol" value="IPC"/>
      <parameter name="IPCInstance" value="db2inst1"/>
    </dsn>
  </dsncollection>
  <databases>
    <database name="DB2DB" host="192.168.1.9" port="50000"/>
  </databases>
</configuration>
"@
$content > C:\ProgramData\IBM\DB2\C_clidriver\cfg\db2dsdriver.cfg

# Test connectivity to IBM DB2
# IMPORTANT!!! Use your IBm DB2 IP address, username and secure password
& c:\clidriver\bin\db2cli.exe validate -database DB2DB:192.168.1.9:50000 -connect -user db2inst1 -passwd @DB2T3st -displaylic

# Install Visual Studio 2017 Redistributable and Microsoft OLE DB provider for DB2
# IMPORTANT!!! Specify correct path and filenames
& c:\setup\vcredist_x86.exe /install /passive /norestart
& c:\setup\vcredist_x64.exe /install /passive /norestart
msiexec /L C:\setup\out.txt /I C:\setup\DB2OLEDBv6_EN_x64.msi

# List OLE DB providers installed
foreach ($provider in [System.Data.OleDb.OleDbEnumerator]::GetRootEnumerator())
{
  $v = New-Object PSObject
  for ($i = 0; $i -lt $provider.FieldCount; $i++)
  {
    Add-Member -in $v NoteProperty $provider.GetName($i)
    $provider.GetValue($i)
  }
  $v
}
