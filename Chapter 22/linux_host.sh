# Switch to the superuser
su - db2inst1

# Login to database console
db2 -t ;

# Generate configuration file
db2dsdcfgfill -i db2inst1
