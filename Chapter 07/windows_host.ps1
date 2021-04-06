# Pull SQL Server 2019 on Linux
docker pull mcr.microsoft.com/mssql/server:2019-GA-ubuntu-16.04

# Pull Windows Server 2019 Core
docker pull mcr.microsoft.com/windows/servercore:ltsc2019

# Start a container with Windows Server 2019 Core
docker run -it --name ServerA -v C:\temp:C:\setup mcr.microsoft.com/windows/servercore:ltsc2019 powershell

# Login to ServerA with local administrator
docker exec -it --user "HandsOnPolybase" ServerA powershell

# View installation status through container statistics
docker stats

# Verify all consoles are exited from a container
docker ps -a

# Restart the container
docker start -a -i ServerA
