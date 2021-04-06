# Get the IP address
ifconfig
ip address

# View Hadoop daemons running
jps

# Run first sample Hadoop map reduce program and view the result
cd $HADOOP_PREFIX
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.0.jar grep input output 'dfs[a-z.]+'
bin/hdfs dfs -ls output/*
bin/hdfs dfs -cat output/*

# Copy file from Hadoop to local file system
bin/hdfs dfs -get output output
cat output

# Run second sample Hadoop map reduce program and view the result
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.0.jar wordcount input output2
bin/hdfs dfs -cat output2/*

# View if an application is listening on a specific port
netstat -tulapn | grep 9000

# View additional information about a process (use the PID returned from the previous command)
ps aux | grep 128

# Create PolyBase user
sudo su
useradd pdw_user

# Create folder in HDFS for the PolyBase user: first way
su hdfs
hdfs dfs -mkdir /user/pdw_user
hdfs dfs -chown pdw_user:hdfs /user/pdw_user
hdfs dfs -chmod 777 /user/pdw_user
hdfs dfs -chmod 777 /tmp

# Create folder in HDFS for the PolyBase user: second way
su hdfs
hadoop fs -mkdir /user/pdw_user
hadoop fs -chown pdw_user:hdfs /user/pdw_user
hadoop fs -chmod 777 /user/pdw_user
hadoop fs -chmod 777 /tmp
