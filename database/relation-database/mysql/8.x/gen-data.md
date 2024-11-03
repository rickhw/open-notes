
# Development

## Gen the random data

https://stackoverflow.com/questions/25098747/how-to-generate-1000000-rows-with-random-data/25099275


```sql
CREATE TABLE `random_data`
(
  `id`         bigint(20) NOT NULL      AUTO_INCREMENT,
  `datetime`   timestamp  NULL          DEFAULT CURRENT_TIMESTAMP,
  `channel`    int(11)                  DEFAULT NULL,
  `value`      float                    DEFAULT NULL,

  PRIMARY KEY (`id`)
);

-- * 10,000: 02m39s
-- * 100,000: 31m19s
-- https://www.mysqltutorial.org/stored-procedures-parameters.aspx
DELIMITER $$
CREATE PROCEDURE generate_data(
  IN amount INT(255)
)

BEGIN
  DECLARE i INT DEFAULT 0;
  WHILE i < amount DO
    INSERT INTO `random_data` (`datetime`,`value`,`channel`) VALUES (
      FROM_UNIXTIME(UNIX_TIMESTAMP('2014-01-01 01:00:00')+FLOOR(RAND()*31536000)),
      ROUND(RAND()*100,2),
      1
    );
    SET i = i + 1;
  END WHILE;
END$$
DELIMITER ;

CALL generate_data(10000);
CALL generate_data(100000);
-- 一百萬筆
CALL generate_data(1000000);
-- 一千萬筆
CALL generate_data(10000000);
-- 一億筆
CALL generate_data(100000000);


drop procedure generate_data;


```

Run on MBPR M1, with docker

```bash

## 10,000
CALL generate_data(10000);
Query OK, 1 row affected (8.80 sec)

## 100,000
CALL generate_data(100000);
Query OK, 1 row affected (1 min 26.47 sec)

## 1,000,000
CALL generate_data(1000000);
Query OK, 1 row affected (14 min 33.03 sec)

```


