# Pull Cassandra image
docker pull cassandra

# Start container with Cassandra
docker run --name Cassandra -d -p 9042:9042 -v c:\temp:/tmp cassandra

# Login to Cassandra container
docker exec -it Cassandra /bin/bash
