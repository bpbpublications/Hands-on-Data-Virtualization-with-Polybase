# View Oracle TNSNames
cat $TNS_ADMIN/tnsnames.ora

# Append to Oracle SQLNet
# IMPORTANT!!! The first line is a command, the second line is text being appended to the file, once you're done press Ctrl+D to finish editing
cat >> $TNS_ADMIN/sqlnet.ora
SQLNET.ALLOWED_LOGON_VERSION_SERVER=11

# Login to Oracle
sqlplus sys/Oradoc_db1@ORCLCDB as sysdba
