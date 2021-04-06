# Import CosmosDB certificate
& c:\setup\importcert.ps1

# Install Data Migration Tool (dt)
Invoke-WebRequest -Uri "https://cosmosdbtools.blob.core.windows.net/datamigrationtool/2019.09.23-1.8.3/dt1.8.3.zip" -OutFile dt1.8.3.zip
Expand-Archive dt1.8.3.zip -DestinationPath dt1.8.3 -Force

# Load data into CosmosDB using dt
& c:\dt1.8.3\drop\dt.exe /s:JsonFile /s.Files:c:\setup\generated. json /t:DocumentDBBulk /t.ConnectionString:"AccountEndpoint= https://172.18.227.249:8081/; AccountKey=C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==; Database=MyDb;" /t.Collection:MyCollection /t. IdField:_id /t.PartitionKey:favoriteFruit

# Connect to CosmosDB using Mongo
# IMPORTANT!!! Only extract mongo.exe from mongodb-windows-x86_64-4.4.0.zip and copy it to the container
& c:\setup\mongo.exe --tls --host 172.17.178.105 --port 10255 --username localhost --password C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==

# Install mongoimport
# IMPORTANT!!! Specify correct paths and filenames
cd c:\setup\
msiexec.exe /l*v mdbinstall.log /qb /i mongodb-win32-x86_64-2012plus-4.2.8-signed.msi ADDLOCAL="Client,ImportExportTools" SHOULD_INSTALL_COMPASS="0"

# Load data into CosmosDB using mongoimport
& "C:\Program Files\MongoDB\Server\4.2\bin\mongoimport.exe" --ssl --host 172.17.185.225 --port 10255 --username localhost --password C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8m GGyPMbIZnqyMsEcaGQy67XIw/Jw== --db MyDb --collection MyCollection --file C:\setup\generated.json --jsonArray
