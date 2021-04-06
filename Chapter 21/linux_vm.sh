# Switch to the superuser for activation
sudo su - hxeadm

# Verify status of services
HDB info

# Login to database console
# IMPORTANT!!! Use your own username and secure password
hdbsql -i 90 -d HXE -u SYSTEM -p @S4pH4n4T3st -m
