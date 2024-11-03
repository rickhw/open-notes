
## docker

## see: https://hub.docker.com/_/rabbitmq/

```bash
TS=$(date +"%Y%m%d")
APP_NAME="rabbitmq"
#APP_VER="3.10"
#APP_VER="3.11"  # 20230221
APP_VER="3.12-management-alpine"  # 20231021
APP_CONTAINER_NAME="${APP_NAME}-v${APP_VER}-${TS}"
APP_VOLUME_DATA="$HOME/docker/${APP_CONTAINER_NAME}/data"
APP_VOLUME_CONF="$HOME/docker/${APP_CONTAINER_NAME}/config"


docker run \
    --name ${APP_CONTAINER_NAME} \
    -p 5672:5672 \
    -p 15672:15672 \
    -e RABBITMQ_DEFAULT_USER=root \
    -e RABBITMQ_DEFAULT_PASS=medusa \
    -v ${APP_VOLUME_DATA}:/data/db \
    -v ${APP_VOLUME_CONF}:/data/configdb \
    --restart=unless-stopped \
    -d ${APP_NAME}:${APP_VER}


## Simple
docker run \
    --name ${APP_CONTAINER_NAME} \
    -p 15672:15672 \    # management port, id/pwd: guest/guest
    -p 5672:5672 \
    --restart=unless-stopped \
    -d ${APP_NAME}:${APP_VER}


docker run \
    --name ${APP_CONTAINER_NAME} \
    -p 15672:15672 \
    -p 5672:5672 \
    -e RABBITMQ_DEFAULT_USER=root \
    -e RABBITMQ_DEFAULT_PASS=medusa \
    -v ${APP_VOLUME_DATA}:/data/db \
    -v ${APP_VOLUME_CONF}:/data/configdb \
    --restart=unless-stopped \
    -d ${APP_NAME}:${APP_VER}


docker run -d \
    --hostname my-rabbit \
    --name some-rabbit \
    -p 5672:5672 \
    -p 15672:15672 \
    rabbitmq:3-management

```

http://localhost:15672


## Docker Compose


```yaml
rabbitmq:
  image: rabbitmq:management
  ports:
    - "5672:5672"
    - "15672:15672"
```




