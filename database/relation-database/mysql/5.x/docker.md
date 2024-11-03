
https://hub.docker.com/_/mysql

---
# Installation

## launch v5.7 with docker

```bash
TS=$(date +"%Y%m%d")
TS="20200816"
MYSQL_ROOT_PASSWORD="medusa"
MYSQL_NAME="mysql57"
MYSQL_VERSION="5.7"
MYSQL_CONTAINER_NAME="${MYSQL_NAME}-${TS}"
MYSQL_VOLUME_DATA="${HOME}/docker-data/${MYSQL_CONTAINER_NAME}/data"
MYSQL_VOLUME_CONF="${HOME}/docker-data/${MYSQL_CONTAINER_NAME}/config"
MYSQL_VOLUME_LOG="${HOME}/docker-data/${MYSQL_CONTAINER_NAME}/log"

docker run \
    --name $MYSQL_CONTAINER_NAME \
    -p 3306:3306 -d \
    -v ${MYSQL_VOLUME_DATA}:/var/lib/mysql \
    -v ${MYSQL_VOLUME_CONF}:/etc/mysql \
    -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} \
    --restart=unless-stopped \
    mysql:${MYSQL_VERSION}


docker run \
    --name $MYSQL_CONTAINER_NAME \
    -p 3306:3306 -d \
    -v ${MYSQL_VOLUME_DATA}:/var/lib/mysql \
    -v ${MYSQL_VOLUME_CONF}:/etc/mysql \
    -v ${MYSQL_VOLUME_LOG}:/var/log/mysql \
    -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} \
    --restart=unless-stopped \
    mysql:${MYSQL_VERSION}

docker exec ${MYSQL_CONTAINER_NAME} \
  sh -c 'exec mysqldump --all-databases -uroot -p"$MYSQL_ROOT_PASSWORD"' > /some/path/on/your/host/all-databases.sql

docker exec -ti mysql57-dev-20200816 mysql -u root -p


# phpMyAdmin
## https://hub.docker.com/r/phpmyadmin/phpmyadmin/
PHPMYADMIN_VERSION=""
TS="20200816"
CONTAINER_NAME="phpmyadmin-${TS}"
MYSQL_CONTAINER_NAME="mysql57-dev-20200819"

docker run \
    --name ${CONTAINER_NAME} \
    -d \
    --link ${MYSQL_CONTAINER_NAME}:db \
    --restart=unless-stopped \
    -p 9999:80 \
    phpmyadmin/phpmyadmin

```

