
[Cassandra: A Decentralized Structured Storage System](https://dl.acm.org/doi/10.1145/1773912.1773922)

https://cassandra.apache.org/download/
https://hub.docker.com/_/cassandra

## docker 

```bash
TS=$(date +"%Y%m%d")
APP_NAME="cassandra"
CONTAINER_IMAGE_NAME="cassandra"
APP_VER="3.11"
APP_CONTAINER_NAME="${APP_NAME}-${TS}"
APP_DATA_ROOT="/data/docker-data"
APP_VOLUME_DATA="${APP_DATA_ROOT}/${APP_CONTAINER_NAME}/data"
APP_VOLUME_CONF="${APP_DATA_ROOT}/${APP_CONTAINER_NAME}/config/cassandra.yaml"

## see: https://hub.docker.com/_/mongo
docker run \
    --name ${APP_CONTAINER_NAME} \
    -p 27017:27017 \
    -v ${APP_VOLUME_DATA}:/var/lib/cassandra \
    -v ${APP_VOLUME_CONF}:/etc/cassandra/cassandra.yaml \
    --restart=unless-stopped \
    -d ${CONTAINER_IMAGE_NAME}:${APP_VER}

```