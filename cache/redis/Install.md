
## redis

```bash
TS=$(date +"%Y%m%d")
APP_NAME="redis"
APP_VER="6.0"
APP_CONTAINER_NAME="${APP_NAME}-v${APP_VER}-${TS}"
APP_VOLUME_DATA="/data/docker/${APP_CONTAINER_NAME}/data"
APP_VOLUME_CONF="/data/docker/${APP_CONTAINER_NAME}/config"

## see: https://hub.docker.com/_/redis
## start with persistent storage
docker run -d \
    --name ${APP_CONTAINER_NAME} \
    -p 6379:6379 \
    -v ${APP_VOLUME_DATA}:/data \
    -v ${APP_VOLUME_CONF}:/usr/local/etc/redis/redis.conf \
    --restart=unless-stopped \
    redis:${APP_VER} redis-server

```

conf: https://redis.io/topics/config

## phpRedisAdmin

https://github.com/erikdubbelboer/phpRedisAdmin

```bash
TS=$(date +"%Y%m%d")
APP_NAME="phpredisadmin"
APP_VER="6.0"
APP_CONTAINER_NAME="${APP_NAME}-${TS}"
APP_VOLUME_DATA="/data/docker/${REDIS_CONTAINER_NAME}/data"
APP_VOLUME_CONF="/data/docker/${REDIS_CONTAINER_NAME}/config"
APP_ENDPOINT="10.11.1.235"
APP_HOSTNAME="nylab235"

docker run -d \
    --name ${APP_CONTAINER_NAME} \
    -e REDIS_1_HOST=${APP_ENDPOINT} \
    -e REDIS_1_NAME=${APP_HOSTNAME} \
    --restart=unless-stopped \
    -p 9998:80 \
    erikdubbelboer/phpredisadmin
```


---



## ref

- https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-redis-on-ubuntu-20-04