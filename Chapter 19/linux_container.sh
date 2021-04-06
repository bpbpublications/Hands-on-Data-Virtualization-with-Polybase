# Update package list
apt-get update

# Install vim
apt-get -y install vim

# Enable logging by modifying configuration file
# IMPORTANT!!! Restart the VM after making the changes below
# log_destination = 'csvlog'
# logging_collector = on
# log_statement = all
vim $PGDATA/postgresql.conf

# Login to PostgreSQL DB console
psql -U postgres
