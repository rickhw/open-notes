
## docker 

```bash
TS=$(date +"%Y%m%d")
APP_NAME="mongo"
APP_VER="4.4"
APP_CONTAINER_NAME="${APP_NAME}-${TS}"
APP_DATA_ROOT="/data/docker-data"
APP_VOLUME_DATA="${APP_DATA_ROOT}/${APP_CONTAINER_NAME}/data"
APP_VOLUME_CONF="${APP_DATA_ROOT}/${APP_CONTAINER_NAME}/config"

## see: https://hub.docker.com/_/mongo
docker run \
    --name ${APP_CONTAINER_NAME} \
    -p 27017:27017 \
    -v ${APP_VOLUME_DATA}:/data/db \
    -v ${APP_VOLUME_CONF}:/data/configdb \
    --restart=unless-stopped \
    -d mongo:${APP_VER}

```


## create user

```bash
docker exec -it mongo-20200908 mongo -u admin -p medusa

use tw-91app-erp_portal;
db.createUser(
   {
     user: "admin",
     pwd: "medusa",
     roles: [ "readWrite", "dbAdmin" ]
   }
)

```

https://medium.com/@polo13999/docker-mongo-%E8%A8%AD%E5%AE%9A%E5%AD%B8%E7%BF%92%E6%89%8B%E9%9B%9C-10ea93574199


{"t":{"$date":"2020-12-15T09:15:28.426+00:00"},"s":"I",  "c":"ACCESS",   "id":20249,   "ctx":"conn10","msg":"Authentication failed","attr":{"mechanism":"SCRAM-SHA-1","principalName":"portal-admin","authenticationDatabase":"tw-91app-erp_portal","client":"10.11.90.25:61135","result":"UserNotFound: Could not find user \"portal-admin\" for db \"tw-91app-erp_portal\""}}