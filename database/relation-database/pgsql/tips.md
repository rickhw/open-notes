
## 如合修改 Serial 現在的值？



```sql
-- 取得目前的值
-- https://www.postgresqltutorial.com/postgresql-serial/
select currval(pg_get_serial_sequence('account','id'));

-- 調整目前的 seq to max
-- https://stackoverflow.com/questions/8745051/postgres-manually-alter-sequence
SELECT setval(pg_get_serial_sequence('account','id'), coalesce(max(id), 0)+1 , false)
    FROM account;
```



## 如合授權？

https://tableplus.com/blog/2018/04/postgresql-how-to-grant-access-to-users.html

```sql
CREATE USER portal_shell_admin with encrypted password 'mypass';

SET AUTOCOMMIT = ON
CREATE DATABASE portal_shell_backoffice
    WITH
        OWNER = portal_shell_admin
        ENCODING = 'UTF8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;


GRANT ALL PRIVILEGES ON DATABASE portal_shell_backoffice TO portal_shell_admin;
GRANT USAGE ON SCHEMA portal_shell_v0_96 TO portal_shell_admin;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA portal_shell_v0_96 TO portal_shell_admin;

-- 2021/07/06 grant user to schema in database
GRANT ALL PRIVILEGES ON DATABASE portal_shell_backoffice TO ims_qa_fufu;
GRANT USAGE ON SCHEMA portal_shell_v0_96 TO ims_qa_fufu;

-- 2021/07/30
GRANT USAGE ON SCHEMA portal_shell_v0_98 TO ims_qa_fufu;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA portal_shell_v0_98 TO ims_qa_fufu;

```

