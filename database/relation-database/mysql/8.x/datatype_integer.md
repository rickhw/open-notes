
## Integer

```sql
-- default is signed.
-- https://www.mysqltutorial.org/mysql-int/

CREATE TABLE `datatype_tinyint`
(
    `id`         TINYINT NOT NULL      AUTO_INCREMENT,
    `datetime`   timestamp  NULL          DEFAULT CURRENT_TIMESTAMP,
    `value`      int(11)                  DEFAULT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `datatype_smallint`
(
    `id`         SMALLINT NOT NULL      AUTO_INCREMENT,
    `datetime`   timestamp  NULL          DEFAULT CURRENT_TIMESTAMP,
    `value`      int(11)                  DEFAULT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `datatype_mediumint`
(
    `id`         MEDIUMINT NOT NULL      AUTO_INCREMENT,
    `datetime`   timestamp  NULL          DEFAULT CURRENT_TIMESTAMP,
    `value`      int(11)                  DEFAULT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `datatype_int`
(
    `id`         INT NOT NULL      AUTO_INCREMENT,
    `datetime`   timestamp  NULL          DEFAULT CURRENT_TIMESTAMP,
    `value`      int(11)                  DEFAULT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `datatype_bigint`
(
    `id`         BIGINT NOT NULL      AUTO_INCREMENT,
    `datetime`   timestamp  NULL          DEFAULT CURRENT_TIMESTAMP,
    `value`      int(11)                  DEFAULT NULL,
    PRIMARY KEY (`id`)
);

```

## test datatype


```sql
---
DELIMITER $$
CREATE PROCEDURE test_datatype_integer (
  IN table_name varchar(255),
  IN amount INT(255)
)
  
BEGIN
  DECLARE i INT DEFAULT 0;
  SET @table_name = table_name;

  WHILE i < amount DO
--    SET @sql_text1 = concat('SELECT MIN(',@keyField,') INTO @a FROM ',@table_name);
    SET @sql_string = concat('INSERT INTO ', @table_name, '(`datetime`, `value`) VALUES (FROM_UNIXTIME(UNIX_TIMESTAMP("2014-01-01 01:00:00")+FLOOR(RAND()*31536000)),ROUND(RAND()*100,2))');

    PREPARE stmt FROM @sql_string;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- INSERT INTO table_name (`datetime`,`value`,`channel`) VALUES (
    --   FROM_UNIXTIME(UNIX_TIMESTAMP('2014-01-01 01:00:00')+FLOOR(RAND()*31536000)),
    --   ROUND(RAND()*100,2),
    --   1
    -- );
    SET i = i + 1;
  END WHILE;
END$$
DELIMITER ;
```


## Run test

```sql

-- byte: 1 = 2 ^ 8
-- signed: -128	127
-- unsigned: 0	255
CALL test_datatype_integer("datatype_tinyint", 200);
mysql> CALL test_datatype_integer("datatype_tinyint", 200);
ERROR 1062 (23000): Duplicate entry '127' for key 'datatype_tinyint.PRIMARY'

-- byte: 2 = 2 ^ 16
-- signed: -32768	32767
-- unsigned: 0	65535
mysql> CALL test_datatype_integer("datatype_smallint", 65536);
ERROR 1062 (23000): Duplicate entry '32767' for key 'datatype_smallint.PRIMARY'

-- byte: 3 = 2^24
-- signed: -8388608	8388607
-- unsiged: 0	16777215
mysql> CALL test_datatype_integer("datatype_mediumint", 8388607 );