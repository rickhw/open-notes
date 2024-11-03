

https://blog.csdn.net/chen123479960/article/details/86648402

https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ReadRepl.html#USER_ReadRepl.XRgn

https://aws.amazon.com/blogs/database/best-practices-for-amazon-rds-for-postgresql-cross-region-read-replicas/

https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PostgreSQL.Replication.ReadReplicas.html



* 前提條件：版本、網路、一致性的定義
* 如何驗證？
* 如何監控？觀測？
* 如果有問題，該如何處理？
* Application 如何讀取？



---
# 環境建立 (Provisioning)

## Master Node

利用 docker 搭建 postgres 服务器

```bash
export APP_VER="11.12"  # port: 5433
export APP_NAME="psql-master"
export APP_PASSWORD="medusa"
export DOCKER_DATA_PATH="${HOME}/docker-data/${APP_NAME}/data"

docker run \
    --name ${APP_NAME} \
    --restart=always\
    -v ${DOCKER_DATA_PATH}:/var/lib/postgresql/data \
    -e POSTGRES_PASSWORD=${APP_PASSWORD} \
    -p 5432:5432 \
    -d postgres:${APP_VER}

docker exec -it ${APP_NAME} /bin/bash

su postgres
psql

```


```sql
postgres@82ca14359373:/$ psql
psql (11.12 (Debian 11.12-1.pgdg90+1))
Type "help" for help.

--- 建立 replication role
postgres=# CREATE ROLE replica login replication encrypted password 'medusa';
CREATE ROLE

--- 確認
postgres=# \du
                                   List of roles
 Role name |                         Attributes                         | Member of
-----------+------------------------------------------------------------+-----------
 postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 replica   | Replication                                                | {}

--- 退出
postgres=# \q
postgres@82ca14359373:/$
```




```bash
## 安裝工具: vim
apt update
apt install vim
```

增加 hba 設定: `vi /var/lib/postgresql/data/pg_hba.conf`

安装成功之后，再次修改 pg_hba.conf 文件，进入最后部分，添加如下：

```
host   replication      replica       192.168.205.72/32          trust   #允许  205.72 机器使用 replica 用户来复制
host   replication      replica       172.17.0.0/24           trust   # 允許 docker 網路都可以做副本
```



修改 postgresql.conf

```
#------------------------------------------------------------------------------
# REPLICATION from MASTER NODE
#------------------------------------------------------------------------------
listen_addresses = '*'          # 监听所有IP
archive_mode = on               # 允许归档
archive_command = '/bin/date'   # 用该命令来归档logfile segment,这里取消归档。
wal_level = replica             # 开启热备
max_wal_senders = 32            # 这个设置了可以最多有几个流复制连接，差不多有几个从，就设置几个
wal_keep_segments = 64          # 设置流复制保留的最多的xlog数目，一份是 16M，注意机器磁盘 16M*64 = 1G
wal_sender_timeout = 60s        # 设置流复制主机发送数据的超时时间
max_connections = 200           # 这个设置要注意下，从库的max_connections必须要大于主库的
```

離開容器，重啟：

```bash
docker restart psql-master
```


## Slave Node


利用 docker 搭建 postgres 服务器

```bash
export APP_VER="11.12"
export APP_NAME="psql_${APP_VER}_slave"
export APP_PASSWORD="medusa"
export APP_PORT="5434"
export DOCKER_DATA_PATH="${HOME}/docker-data/${APP_NAME}/data"

docker run \
    --name ${APP_NAME} \
    --restart=always\
    -v ${DOCKER_DATA_PATH}:/var/lib/postgresql/data \
    -e POSTGRES_PASSWORD=${APP_PASSWORD} \
    -p ${APP_PORT}:5432 \
    -d postgres:${APP_VER}

# 進去 Slave Node
docker exec -it ${APP_NAME} /bin/bash

su postgres

## 確認現在的 data
postgres@a8b477195d57:~/data$ ls
backup_label  pg_commit_ts  pg_ident.conf  pg_notify	pg_snapshots  pg_subtrans  PG_VERSION  postgresql.auto.conf
base	      pg_dynshmem   pg_logical	   pg_replslot	pg_stat       pg_tblspc    pg_wal      postgresql.conf
global	      pg_hba.conf   pg_multixact   pg_serial	pg_stat_tmp   pg_twophase  pg_xact


## 刪除所有料
postgres@a8b477195d57:~/data$ rm -rf /var/lib/postgresql/data/*
postgres@a8b477195d57:~/data$ ls -ls
total 0

## 執行副本操作
postgres@a8b477195d57:~/data$ pg_basebackup -D $PGDATA -Fp -Xs -v -P -h 172.17.0.8 -U replica -W
Password:
pg_basebackup: initiating base backup, waiting for checkpoint to complete
pg_basebackup: checkpoint completed
pg_basebackup: write-ahead log start point: 0/5000028 on timeline 1
pg_basebackup: starting background WAL receiver
pg_basebackup: created temporary replication slot "pg_basebackup_50"
23732/23732 kB (100%), 1/1 tablespace
pg_basebackup: write-ahead log end point: 0/50000F8
pg_basebackup: waiting for background process to finish streaming ...
pg_basebackup: base backup completed
postgres@a8b477195d57:~/data$ %


## 完成後，就被踢出去
  ~ ······················································································································· ✘ KILL took  2m 37s at  10:36:32 ─╮
❯

```


执行完上述命令之后，容器自动退出



## Host Node

回到 host node

```bash
cd ${DOCKER_DATA_PATH}

# 增加 recovery.conf 設定檔
vi ${DOCKER_DATA_PATH}/recovery.conf
```

設定內容：

```
standby_mode = on
primary_conninfo = 'host=172.17.0.8 port=5432 user=replica password=medusa'
recovery_target_timeline = 'latest'
```

修改 postgresql.conf: `vi ${DOCKER_DATA_PATH}/postgresql.conf`

```
wal_level = replica
max_connections = 1000
hot_standby = on
max_standby_streaming_delay = 30s
wal_receiver_status_interval = 10s
hot_standby_feedback = on
```


执行docker ps -a
docker stop test_pg
通过 docker start test_pg再次启动容器


---

# 驗證


## 方法一

到 192.168.200.153 主服务器地址上校验主从是否部署成功
通过 docker exec -it test_pg /bin/bash 进入容器内部

su postgres
psql

通过上诉命令进入 postgres 控制台，然后执行：

```bash
❯ docker exec -it ${APP_NAME} /bin/bash
root@82ca14359373:/# su postgres
postgres@82ca14359373:/$ psql
psql (11.12 (Debian 11.12-1.pgdg90+1))
Type "help" for help.

postgres=# select client_addr,sync_state from pg_stat_replication;
 client_addr | sync_state
-------------+------------
 172.17.0.9  | async
(1 row)

postgres=#

```

主从配置成功


> Q: 如果沒有成功？

進去之後得到以下：

```
root@82ca14359373://var/lib/postgresql# su postgres
postgres@82ca14359373://var/lib/postgresql$ psql
psql (11.12 (Debian 11.12-1.pgdg90+1))
Type "help" for help.

postgres=# select client_addr,sync_state from pg_stat_replication;
 client_addr | sync_state
-------------+------------
(0 rows)

postgres=# exit
```

重新啟動 container。


## 驗證二


主库上：

```bash
root@82ca14359373:/# ps -ef | grep wal
postgres    31     1  0 02:51 ?        00:00:00 postgres: walwriter
postgres    36     1  0 02:51 ?        00:00:00 postgres: walsender replica 172.17.0.9(54808) streaming 0/70000D0
root       118    37  0 02:55 pts/0    00:00:00 grep wal
```

备库上：

```bash
root@a8b477195d57:/# ps -ef | grep wal
postgres    32     1  0 02:51 ?        00:00:00 postgres: walreceiver   streaming 0/70000D0
root       363    33  0 02:56 pts/0    00:00:00 grep wal
```

apt update
apt install procps



# 測試同步



当然，稳妥起见，尝试在主库上创建并插入数据，观察备库上是否同步这些操作，我们再主库上创建一张表：

```sql
postgres=# create table test_ms(id int4);

CREATE TABLE

postgres=# insert into test_ms values(6);

INSERT 0 1
```

主库上，我们创建test_ms表，并插入了一条数据，我们就可以在备库上进行查询观察是否同步成功：

```
postgres=# select * from test_ms;
 id
----
 6
(1 row)
```

接下来，我们再主库上，再操作

```
postgres=# insert into test_ms values(9);
INSERT 0 1

postgres=# delete from test_ms where id=6;
DELETE 1
```

这个时候，我们发现备库的数据也都正常同步上了：

```sql
postgres=# select * from test_ms;
 id
----
 9
(1 row)
```

那么我们如果在备份上进行数据操作，情况会怎样呢？我们再备份上执行：

```sql
postgres=# insert into test_ms values(6);

ERROR: cannot execute INSERT in a read-only transaction
STATEMENT: insert into test_ms values(6);
ERROR: cannot execute INSERT in a read-only transaction
```


# 主備切換測試

## Promote slave as master node

確認 Slave `recovery.conf` 的狀態：

```bash
❯ ~/docker-data/psql_11.12_slave/data
❯ ls
PG_VERSION           global               pg_hba.conf          pg_multixact         pg_serial            pg_stat_tmp          pg_twophase          postgresql.auto.conf postmaster.pid
backup_label.old     pg_commit_ts         pg_ident.conf        pg_notify            pg_snapshots         pg_subtrans          pg_wal               postgresql.conf      recovery.conf
base                 pg_dynshmem          pg_logical           pg_replslot          pg_stat              pg_tblspc            pg_xact              postmaster.opts
```
`recovery.conf` 副檔名為 `conf`


進去 Slave Node:


docker exec -it ${APP_NAME} /bin/bash


```bash
root@a8b477195d57:/# su postgres

## 執行切換
postgres@a8b477195d57:/$ /usr/lib/postgresql/11/bin/pg_ctl promote -D $PGDATA
waiting for server to promote.... done
server promoted
```

確認狀態

```bash
❯ ~/docker-data/psql_11.12_slave/data
❯ ls
PG_VERSION           global               pg_hba.conf          pg_multixact         pg_serial            pg_stat_tmp          pg_twophase          postgresql.auto.conf postmaster.pid
backup_label.old     pg_commit_ts         pg_ident.conf        pg_notify            pg_snapshots         pg_subtrans          pg_wal               postgresql.conf      recovery.done
base                 pg_dynshmem          pg_logical           pg_replslot          pg_stat              pg_tblspc            pg_xact              postmaster.opts
```

`recovery.done` 副檔名為 `done`


## Join old master as slave node


例如，主库上的 recovery.conf 设置为：

```
recovery_target_timeline = 'latest'
standby_mode = on
primary_conninfo = 'host=172.17.0.9 port=5432 user=replica password=medusa'
```

我们在新主库（pghost2）上执行：

```sql
postgres=# select pg_is_in_recovery();
 pg_is_in_recovery
-------------------
 f
(1 row)
```

发现它目前的角色已经是主库了， 在新备库（pghost1）上继续执行：

```sql
postgres=# select pg_is_in_recovery();
 pg_is_in_recovery
-------------------
 t
(1 row)
```

们再pghost2上，执行数据插入操作：

```sql
postgres=# insert into test_ms values(11);
INSERT 0 1
```

这时，pghost1上也观察到数据同步成功：

```sql
postgres=# select * from test_ms;
 id
----
 9
 11
(2 rows)
```

到这里为止，主从切换的演练基本完成了



# 參考資料

* https://blog.csdn.net/chen123479960/article/details/86648402 - Work!
* https://www.jb51.net/article/148841.htm