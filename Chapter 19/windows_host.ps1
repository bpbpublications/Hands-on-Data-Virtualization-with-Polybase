# Pull PostgreSQL image
docker pull postgres

# Start PostgreSQL container
# IMPORTANT!!! Specify your own secure password
docker run --name Postgres -d -p 5432:5432 -e POSTGRES_PASSWORD=@P0s7gr3sT3st postgres

# Login to PostgreSQL container
docker exec -it Postgres /bin/bash

# Restart PostgreSQL container
docker stop Postgres
docker start Postgres
