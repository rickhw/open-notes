

# Configuration

## Permission

https://stackoverflow.com/questions/50570592/mysql-8-remote-access

```sql
CREATE USER 'root'@'%' IDENTIFIED BY 'P@ssw0rd';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';

CREATE USER 'root'@'127.0.0.1' IDENTIFIED BY 'P@ssw0rd';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1';


SELECT user, host FROM user;

SHOW GRANTS FOR 'root'@'%';
```

## Remote Access



## Log

```
## 2020/02/02, added by Rick.
bind-address    = 0.0.0.0

# Log

## Error
log-error       = /var/log/mysql/error.log

## Enable SlowLog
slow_query_log         = 1
slow_query_log_file    = /var/log/mysql/mysql-slow.log
# Log the query over 2 second.
long_query_time = 2

## Log any queries that run without indexes.
log_queries_not_using_indexes = 1


## General Log
general_log_file   = /var/log/mysql/mysql.log
general_log        = 1
```

