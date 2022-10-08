### Requirement 
Need to setup mysql client to connect to required mysql server without authentication.


/opt/guacamole/bin/initdb.sh

docker exec -it g_guacamole /opt/guacamole/bin/initdb.sh --mysql


MYSQL_PORT=8893
MYSQL_PORT=3306

mysql -P "${MYSQL_PORT}" -e "create database guacamole"

docker exec -it g_guacamole /opt/guacamole/bin/initdb.sh --mysql | mysql -P "${MYSQL_PORT}" -D guacamole --password=${MY_MYSQL_PASSWORD}

docker exec g_db mysql -D guacamole --password=${MY_MYSQL_PASSWORD}


if [[ -z $(mysql -P "${MYSQL_PORT}" -e "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME='sys'") ]]; then 
    mysql -P "${MYSQL_PORT}" -e "create database guacamole"
fi

docker exec -it g_guacamole /opt/guacamole/bin/initdb.sh --mysql | mysql -P "${MYSQL_PORT}" -D guacamole