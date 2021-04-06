# Pull IBM DB2 image
docker pull ibmcom/db2

# Run IBM DB2 container
docker run --name DB2 -d --privileged=true `
  -p 50000:50000 `
  -e LICENSE=accept `
  -e DB2INST1_PASSWORD=@DB2T3st `
  -e DBNAME=DB2DB `
  -e PERSISTENT_HOME=FALSE `
  ibmcom/db2

# View IBM DB2 logs
docker logs DB2

# Login to IBM DB2 container
docker exec -it DB2 /bin/bash
