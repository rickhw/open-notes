
## docker 

```bash
TS=$(date +"%Y%m%d")
APP_NAME="amazon-dynamodb-local"
CONTAINER_IMAGE_NAME="amazon/dynamodb-local"
APP_VER="1.13.4"
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
    -d ${CONTAINER_IMAGE_NAME}:${APP_VER}

```