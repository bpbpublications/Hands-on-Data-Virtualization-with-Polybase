# Pull MongoDB image
docker pull mongo

# Start container with Mongo image
docker run --name Mongo -d -p 27017:27017 -v c:\temp:/tmp/json mongo

# Login to Mongo container
docker exec -it Mongo /bin/bash
