# Create a network and connect it to ServerA
docker network create -d nat --gateway 172.8.128.1 --subnet 172.8.128.0/20 -o com.docker.network.windowsshim.dnsservers=4.4.4.4,8.8.8.8 -o com.docker.network.windowsshim.disable_gatewaydns=true mynat
docker network list
docker network connect mynat ServerA

# Pull SequenceIQ Hadoop
docker pull sequenceiq/hadoop-docker

# Run a container with SequenceIQ Hadoop
docker run --name hadoop-local -d -it `
  -p 2122:2122 -p 8020:8020 -p 8030:8030 -p 8031:8031 -p 8032:8032 `
  -p 8033:8033 -p 8040:8040 -p 8042:8042 -p 8050:8050 -p 8088:8088 `
  -p 9000:9000 -p 10020:10020 -p 19888:19888 -p 50010:50010 `
  -p 50020:50020 -p 50070:50070 -p 50075:50075 -p 50090:50090 `
  sequenceiq/hadoop-docker /etc/bootstrap.sh -bash

# Identify which process is listening on a specific port
Get-Process -Id (Get-NetTCPConnection -LocalPort 9000).OwningProcess

# Reserve ports so another application doesn't use them
netsh int ipv4 add excludedportrange protocol=tcp startport=9000 numberofports=1

# In case your container doesn't start due to ports in use, run this command before starting the container
net stop winnat

# In case your container doesn't start due to ports in use, run this command after starting the container
net start winnat

# Login to Hadoop container
docker exec -it hadoop-local bash

# Copy local file to Hadoop container, then copy it into Hadoop file system (HDFS)
docker cp input.csv hadoop-local:/tmp
docker exec -t hadoop-local /usr/local/hadoop/bin/hdfs dfs -put /tmp/input.csv /user/root/input/input.csv

# Connect to a remote HDP sandbox using password
# IMPORTANT!!! Use the public IP of the VM and the username you specified
ssh pabechevb@20.186.113.240

# Connect to a remote HDP VM using private key
# IMPORTANT!!! Use the public IP of the VM and valid path and filename of the private key
ssh -i C:\privatekeyOpenSSH cloudbreak@52.147.160.141
