# Download and install vim
Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression
choco install vim
refreshenv

# Use powercat to test connectivity to your Hadoop server or container
IEX (New-Object System.Net.Webclient).DownloadString('https://raw.githubusercontent.com/besimorhino/powercat/master/powercat.ps1')
powercat -c 20.186.113.240 -p 8020 -t 1 -Verbose -d

# Modify configuration files
vim 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Binn\Polybase\Hadoop\conf\yarn-site.xml'
vim 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Binn\Polybase\Hadoop\conf\mapred-site.xml'
vim 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Binn\Polybase\Hadoop\conf\hdfs-site.xml'
vim 'C:\windows\system32\drivers\etc\hosts'

# Restart SQL Server services
Restart-Service MSSQLSERVER -Force
