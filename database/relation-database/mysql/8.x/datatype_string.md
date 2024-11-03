
## Integer

```sql
-- default is signed.
-- https://www.mysqltutorial.org/mysql-int/
-- https://matthung0807.blogspot.com/2019/06/mysql-varcharmaximum-length.html
-- row size: 64KB, exclode BLOB, TEXT

CREATE TABLE `datatype_string`
(
    `id`         INT      AUTO_INCREMENT,
    `fixed_char`   CHAR(10)        NOT NULL,
    `dyn_char`  VARCHAR(65535)  NOT NULL,
    PRIMARY KEY (`id`)
);
-- #1074 - Column length too big for column 'dyn_char' (max = 16383); use BLOB or TEXT instead

CREATE TABLE `facebook`.`datatype_string` (
  `id` INT NOT NULL AUTO_INCREMENT , 
  `fixed_char` CHAR(10) NOT NULL , 
  `dyn_char` VARCHAR(16383) NOT NULL , 
  
  PRIMARY KEY (`id`)) 
  ENGINE = InnoDB
  CHARACTER SET ascii
;
Query OK, 0 rows affected (0.05 sec)

CREATE TABLE `facebook`.`datatype_string2` (
  `id` INT NOT NULL AUTO_INCREMENT , 
  `fixed_char` CHAR(10) NOT NULL , 
  `dyn_char` VARCHAR(65535) NOT NULL , 
  
  PRIMARY KEY (`id`)) 
  ENGINE = InnoDB
;

-- #1118 - Row size too large. The maximum row size for the used table type, not counting BLOBs, is 65535. This includes storage overhead, check the manual. You have to change some columns to TEXT or BLOBs

CREATE TABLE `facebook`.`datatype_string3` (
  `id` INT NOT NULL AUTO_INCREMENT , 
  `fixed_char` CHAR(10) NOT NULL , 
  `dyn_char` TEXT NOT NULL , 
  
  PRIMARY KEY (`id`)) 
  ENGINE = InnoDB
;
Query OK, 0 rows affected (0.04 sec)

```

## Run test

```sql

INSERT INTO datatype_string
  SET
    fixed_char = '0123456789',
    dyn_char = '01234567890123456789012345678901234567890123456789'
;


```



## reference

- https://matthung0807.blogspot.com/2019/06/mysql-varcharmaximum-length.html