
https://docs.microsoft.com/zh-tw/sql/linux/quickstart-install-connect-docker?view=sql-server-ver15&pivots=cs1-bash

https://hub.docker.com/_/microsoft-mssql-server


```bash
TS=$(date +"%Y%m%d")
APP_ROOT_PASSWORD="medusa"
APP_NAME="mssql"
APP_VERSION="2019-latest"
APP_CONTAINER_NAME="${APP_NAME}-${TS}"
APP_VOLUME_DATA="/data/docker-data/${APP_CONTAINER_NAME}/data"
APP_VOLUME_CONF="/data/docker-data/${APP_CONTAINER_NAME}/config"

docker run \
  --name ${APP_CONTAINER_NAME} \
  -e "ACCEPT_EULA=Y" \
  -e "SA_PASSWORD=${APP_ROOT_PASSWORD}" \
  -p 1433:1433 \
  -d mcr.microsoft.com/mssql/server:${APP_VERSION}


docker exec ${APP_CONTAINER_NAME} \
  sh -c 'exec mysqldump --all-databases -uroot -p"$APP_ROOT_PASSWORD"' > /some/path/on/your/host/all-databases.sql
```


