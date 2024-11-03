

## Install via Docker


https://hub.docker.com/_/postgres


```bash
TS=$(date +"%Y%m%d")
APP_NAME="psql"
APP_PASSWORD="medusa"
#APP_VER="10.0"
#APP_VER="11.6"  # port: 5432
#APP_VER="11.12"  # port: 5433
APP_VER="13.7-alpine"  # port: 5432

APP_CONTAINER_NAME="${APP_NAME}-v${APP_VER}-${TS}"
DOCKER_DATA_PATH="/data/docker"
#DOCKER_DATA_PATH="$HOME/docker"
APP_VOLUME_DATA="${DOCKER_DATA_PATH}/${APP_CONTAINER_NAME}/data"
APP_VOLUME_CONF="${DOCKER_DATA_PATH}/${APP_CONTAINER_NAME}/config"

## see: https://hub.docker.com/_/redis
## start with persistent storage
docker run \
    --name ${APP_CONTAINER_NAME} \
    -p 5432:5432 \
    -e POSTGRES_PASSWORD=${APP_PASSWORD} \
    -v ${APP_VOLUME_DATA}:/var/lib/postgresql/data \
    -v ${APP_VOLUME_CONF}/postgres.conf:/etc/postgresql/postgresql.conf \
    --restart=unless-stopped \
    -d postgres:${APP_VER}

user: postgres


## 連到
docker run -it --rm --link mypostgres:postgres postgres psql -h postgres -U postgres
docker run --rm --name mypostgres -e POSTGRES_PASSWORD=mysecretpassword -p 5432:5432 -d postgres

```

ref: https://myapollo.com.tw/zh-tw/docker-postgres/



## pgadmin4

https://www.pgadmin.org/docs/pgadmin4/latest/container_deployment.html
https://hub.docker.com/r/dpage/pgadmin4/

```bash
TS=$(date +"%Y%m%d")
#TS="20200824"
APP_NAME="pgadmin4"
#APP_VER="4.25"
#APP_VER="5.1" ## 2021/4/08
APP_VER="6.12" ## 2022/07/31
APP_USER="rick_kyhwang@hotmail.com"
APP_PASSWORD="medusa"

APP_CONTAINER_NAME="${APP_NAME}-v${APP_VER}-${TS}"

docker run \
    --name ${APP_CONTAINER_NAME} \
    -p 9080:80 \
    -e PGADMIN_DEFAULT_EMAIL=${APP_USER} \
    -e PGADMIN_DEFAULT_PASSWORD=${APP_PASSWORD} \
    --restart=unless-stopped \
    -d dpage/pgadmin4:${APP_VER}
```


---

## Q

NOTE: Configuring authentication for SERVER mode.

sudo: setrlimit(RLIMIT_CORE): Operation not permitted
[2020-08-24 07:47:10 +0000] [1] [INFO] Starting gunicorn 19.9.0
[2020-08-24 07:47:10 +0000] [1] [ERROR] Retrying in 1 second.
[2020-08-24 07:47:11 +0000] [1] [ERROR] Retrying in 1 second.
[2020-08-24 07:47:12 +0000] [1] [ERROR] Retrying in 1 second.
[2020-08-24 07:47:13 +0000] [1] [ERROR] Retrying in 1 second.
[2020-08-24 07:47:14 +0000] [1] [ERROR] Retrying in 1 second.
[2020-08-24 07:47:15 +0000] [1] [ERROR] Can't connect to ('::', 80)



```bash
TS=$(date +"%Y%m%d")
TS="20200824"
APP_NAME="pgadmin4"
APP_VER="3.6"

APP_CONTAINER_NAME="${APP_NAME}-v${APP_VER}-${TS}"

docker run \
    --name ${APP_CONTAINER_NAME} \
    -p 5050:5050 \
    --restart=unless-stopped \
    -d thajeztah/pgadmin4:${APP_VER}

```

---
# Install on VM

https://computingforgeeks.com/install-postgresql-12-on-ubuntu/

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" |sudo tee  /etc/apt/sources.list.d/pgdg.list


apt update
apt -y install postgresql-12 postgresql-client-12


systemctl status postgresql.service
systemctl status postgresql@12-main.service
systemctl is-enabled postgresql


su - postgres
psql -c "alter user postgres with password 'P@ssw0rd'"


psql
\conninfo
CREATE DATABASE mytestdb;
CREATE USER mytestuser WITH ENCRYPTED PASSWORD 'MyStr0ngP@SS';

\l


## Client: pgadmin

https://computingforgeeks.com/how-to-install-pgadmin-4-on-ubuntu/

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" |sudo tee  /etc/apt/sources.list.d/pgdg.list

apt update
apt install pgadmin4 pgadmin4-apache2


systemctl status apache2




---

# Performance

https://ithelp.ithome.com.tw/articles/10240685