# Pull MariaDB image
docker pull mariadb

# Start container with MariaDB
# IMPORTANT!!! Specify your own user and secure password, as well as database name
docker run --name MariaDB -d -p 3306:3306 -e MYSQL_RANDOM_ROOT_PASSWORD=yes -e MYSQL_DATABASE=MariaDb -e MYSQL_USER=MariaDB -e MYSQL_PASSWORD=@Mar!aDBT3st mariadb

# Login to MariaDB container
docker exec -it MariaDB /bin/bash
