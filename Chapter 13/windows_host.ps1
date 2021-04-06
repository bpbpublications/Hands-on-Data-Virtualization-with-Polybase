# Login with your Docker username and password
docker login

# Pull the Oracle image
docker pull store/oracle/database-enterprise:12.2.0.1

# Start a container with the Oracle image
docker run -d -it --name OracleTest -p 1521:1521 -p 5500:5500 store/oracle/database-enterprise:12.2.0.1

# View docker container statistics
docker stats

# View Oracle container logs
docker logs OracleTest

# Login to Oracle container
docker exec -it OracleTest /bin/bash
