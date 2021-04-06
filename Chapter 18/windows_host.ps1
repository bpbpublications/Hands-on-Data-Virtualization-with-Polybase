# Pull MySql image
docker pull mysql

# Start the container with MySql
# IMPORTANT!!! Specify a secure password of your own
docker run --name MySql -d -p 3306:3306 `
  -e MYSQL_ROOT_PASSWORD=@MySq1T3st -e MYSQL_DATABASE=MySqlDb `
  mysql

# Login to MySql container
docker exec -it MySql /bin/bash
