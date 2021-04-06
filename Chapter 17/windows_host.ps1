# Pull CosmosDB emulator
docker pull microsoft/azure-cosmosdb-emulator

# Run CosmosDB container
docker run --name Cosmos -d -it -m 2G -v c:\temp:C:\CosmosDB.Emulator\bind-mount `
  -e AZURE_COSMOS_EMULATOR_MONGODB_ENDPOINT=true `
  -p 443:443 -p 8081:8081 -p 8900:8900 -p 8901:8901 -p 8902:8902 `
  -p 10250:10250 -p 10251:10251 -p 10252:10252 -p 10253:10253 `
  -p 10254:10254 -p 10255:10255 -p 10256:10256 -p 10350:10350 `
  microsoft/azure-cosmosdb-emulator
