# View Cassandra cluster status
nodetool status

# Login to database console
cqlsh

# Install DataStax dsbulk
curl -OL https://downloads.datastax.com/dsbulk/dsbulk-1.6.0.tar.gz
tar -xzvf dsbulk-1.6.0.tar.gz
cd dsbulk-1.6.0/bin

# Load JSON data into Cassandra
./dsbulk load --connector.json.url /tmp/generated.json -c json -k MyKeyspace -t RandomData --connector.json.mode SINGLE_DOCUMENT --schema.allowMissingFields true

# View help from dsbulk
./dsbulk help dsbulk.connector.json

# Run command against Cassandra database
cqlsh -e "SELECT * FROM \"MyKeyspace\".\"RandomData\" LIMIT 1;"

# Enable monitoring queries being executed against Cassandra
nodetool settraceprobability 1
nodetool gettraceprobability
