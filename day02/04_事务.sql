/*  事务  */
-- 创建账户表,包含 id, name, balance
CREATE TABLE account (
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(20),
	balance DOUBLE
);

-- 添加数据
INSERT INTO account VALUES 
(NULL, '张三', 1000),
(NULL, '李四', 1000);

-- 模拟张三给李四转500元钱

-- 开始事务
START TRANSACTION;

-- 1. 张三账号-500
UPDATE `account` SET balance = balance - 500 WHERE `name` = '张三';
-- 2. 李四账号+500
UPDATE `account` SET balance = balance + 500 WHERE `name` = '李四';


-- 提交事务;
COMMIT;

-- 回滚事务
ROLLBACK;


-- 恢复余额为1000
UPDATE account SET balance=1000;