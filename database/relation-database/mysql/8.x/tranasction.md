

## Isolation Level

https://ithelp.ithome.com.tw/articles/10194749


1. READ UNCOMMITTED: 
    - 寬鬆級別：A 交易更新但未確認資料，B交易不能更新只能讀取(直到A交易提交後)，確保交易更新資料不會有問題。
2. READ COMMITTED
    - 比較嚴格一些：A 交易更新並確認資料前，其他交易不能讀取該資料
    - 官網說明：READ COMMITTED 隨著 READ_COMMITTED_SNAPSHOT 設定而異，請參考最下方餐可考資料
3. REPEATABLE READ
    - 更嚴格一點的限制：讀取中資料會被鎖定，確保同一筆交易中的讀取資料必須相同
4. SERIALIZABLE
    - 最嚴謹的限制：A 交易讀取時，B交易更新要排隊；A交易更新時，B交易讀取與更新都需要排隊

## Race Condition

Race condition 可大致上分為五個現象，包含

- Dirty Read
- Non-repeatable Read (Read Skew)
- Phantom
- Lost update
- Write Skew

### Dirty Read 髒讀

所謂髒讀就是讀到髒東西，意即讀取到另一個 Transaction 尚未 commit 的值。

### 情境

假設有三個角色，資料庫、Transaction A 和 Transaction B

- 資料庫：在資料庫中存在一個值 X=0
- Transaction A：變更數值 X 為 2 但因為某些原因需要 rollback，沒有成功更新
- Transaction B：讀取數值 X

如果是正常的情況應該是 Transaction A 想將 X 變更為 2 但沒有成功，所以將 rollback 回 0 ，此時 Transaction B 讀取到的數值應該要是0，與資料庫內的數值相同。

若發生 Dirty Read 的情況時 Transaction B 讀到的數值會是2，發生競爭時的執行順序如下：

slide: https://docs.google.com/presentation/d/17lgS18nvxvveA8JPqk9t-XeZbj0AmHxMB8gJ56OXngI/edit#slide=id.g2e01abc2e9d_0_0




## Non-repeatable Read 的情境

假設有三個角色，資料庫、Transaction A和Transaction B

- 資料庫：在資料庫中存在一個值X=0
- Transaction A：變更數值X為2
- Transaction B：讀取兩次數值X

正常情況下 Transaction B 讀兩次數值應該會都是 0 或都是 2。

若發生 Non-repeatable Read，則有可能 Transaction B 在兩次讀取的期間 X 的值被改了，發生競爭時的執行順序如下：



---

## Transaction

docker exec -ti mysql-v8.0-20230825 mysql -u root -p

```sql
use x616;

-- 建立資料表
CREATE TABLE order (
  id int(5)
) engine=innodb;


select * from order;

begin;
insert into order value(8);
insert into order value(9);
update table order set id = 10 where id = 5;
commit;

select * from order;


begin;
insert into order values(7);
select * from order;
rollback;

select * from order;
```

ref: https://www.itread01.com/study/mysql-transaction.html

---

# test

https://www.slingacademy.com/article/transaction-commit-rollback-mysql8-practical-guide/


## 1. Basic Transaction

```sql
START TRANSACTION; 
INSERT INTO orders (order_date, customer_id, status) VALUES (NOW(), 1, 'Pending'); 
UPDATE products SET stock=stock-1 WHERE id=100;
COMMIT;
```

## 2. Conditional Rollback

```sql
DELIMITER //
CREATE PROCEDURE AddOrder(in customerId INT, in productId INT) 
BEGIN 
START TRANSACTION; 
INSERT INTO orders (order_date, customer_id, status) VALUES (NOW(), customerId, 'Pending'); 
UPDATE products SET stock=stock-1 WHERE id=productId;
IF stock < 0 THEN 
ROLLBACK;
ELSE 
COMMIT; 
END IF;
END;
// 
DELIMITER ;
```

## 3. Transaction with Locking

```sql
START TRANSACTION; 
SELECT * FROM accounts WHERE account_id=1 FOR UPDATE; 
UPDATE accounts SET balance=balance+1000 WHERE account_id=1; 
COMMIT;
```


## reference

- https://www.slingacademy.com/article/transaction-commit-rollback-mysql8-practical-guide/

- https://vincent87720.github.io/race-condition-intro/index.html


---
## 多版本並發控制（MVCC）




