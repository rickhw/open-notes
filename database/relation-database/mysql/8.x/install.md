
https://hub.docker.com/_/mysql

---
# Installation

## launch v8.0 with docker

```bash

TS=$(date +"%Y%m%d")
MYSQL_ROOT_PASSWORD="medusa"
MYSQL_NAME="mysql"
MYSQL_VERSION="8.0"
MYSQL_CONTAINER_NAME="${MYSQL_NAME}-v${MYSQL_VERSION}-${TS}"
MYSQL_VOLUME_DATA="$HOME/docker/${MYSQL_CONTAINER_NAME}/data"
MYSQL_VOLUME_CONF="$HOME/docker/${MYSQL_CONTAINER_NAME}/config"

docker run \
    --name $MYSQL_CONTAINER_NAME \
    -p 3306:3306 -d \
    -v ${MYSQL_VOLUME_DATA}:/var/lib/mysql \
    -v ${MYSQL_VOLUME_CONF}:/etc/mysql/conf.d \
    -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} \
    --restart=unless-stopped \
    mysql:${MYSQL_VERSION}


# phpMyAdmin
## https://hub.docker.com/r/phpmyadmin/phpmyadmin/
TS=$(date +"%Y%m%d")
APP_NAME="phpmyadmin"
APP_VERSION="5.2"
CONTAINER_NAME="${APP_NAME}-v${APP_VERSION}-${TS}"

docker run \
    --name ${CONTAINER_NAME} \
    -d \
    --link ${MYSQL_CONTAINER_NAME}:db \
    --restart=unless-stopped \
    -p 9999:80 \
    phpmyadmin/phpmyadmin:${APP_VERSION}
```

### FAQ

* Q: DBeaver 連線時出現 `Public Key Retrieval is not allowed`？

> `allowPublicKeyRetrieval` 設定為 `true` 即可。

