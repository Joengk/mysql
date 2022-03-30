/*
约束使用方式：
	一、可以在建完表之后再添加（很少这么干，了解）
	二、一般都是在创建表的时候直接加约束（经常）

为什么呢？
	因为当表创建完毕之后，有可能会添加数据。如果已添加的数据跟约束冲突了，那么此时约束就加不上去了。所以，我们一般是在创建表的时候就直接加约束了，因为在创建表的时候里面肯定是没有任何数据的。
*/


/* =========== 主键约束 =========== */
-- 创建表学生表st1, 包含字段(id, name, age)将id做为主键
-- 创建表时添加主键
CREATE TABLE st1 (
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(10),
	age INT
);

INSERT INTO st1 VALUES (1, '刘德华', 60);
INSERT INTO st1 VALUES (2, '郭富城', 58);

-- 演示主键约束: 唯一非空
INSERT INTO st1 VALUES (2, '刘德华', 60);
INSERT INTO st1 VALUES (null, '郭富城', 58);


-- 删除主键约束(了解)
ALTER TABLE st1 DROP PRIMARY KEY;

-- 在已有表中添加主键约束(了解)
ALTER TABLE st1 ADD PRIMARY KEY(id); 


/* =========== 主键自动增长 =========== */
-- 创建学生表st2, 包含字段(id, name, age)将id做为主键并自动增长
CREATE TABLE st2 (
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(10),
	age INT
);

-- 主键默认从1开始自动增长: i++
INSERT INTO st2 (NAME, age) VALUES ('貂蝉', 28);
INSERT INTO st2 (NAME, age) VALUES ('西施', 18);
INSERT INTO st2 (NAME, age) VALUES ('王昭君', 26);
INSERT INTO st2 (NAME, age) VALUES ('杨玉环', 22);

-- 修改自动增长的开始值(面试题)



/* =========== 唯一约束 =========== */
/* =========== 非空约束 =========== */
/* =========== 默认值约束 =========== */
CREATE TABLE emp (
	id INT, -- 员工id，主键且自增长
	ename VARCHAR(50), -- 员工姓名，非空并且唯一
	joindate DATE, -- 入职日期，非空
	salary DOUBLE(7,2), -- 工资，非空
	bonus DOUBLE(7,2) -- 奖金，如果没有奖金默认为1000
);


INSERT INTO emp(id, ename, joindate, salary, bonus) values(1, '张三', '1999-11-11', 8800, 5000);
INSERT INTO emp(id, ename, joindate, salary, bonus) values(2, '李四', '1999-11-11', 8800, 5000);

-- 演示非空约束
INSERT INTO emp(id, ename, joindate, salary, bonus) values(3, null, '1999-11-11', 8800, 5000);

-- 演示唯一约束
INSERT INTO emp(id, ename, joindate, salary, bonus) values(3, '李四','1999-11-11', 8800, 5000);

-- 演示默认约束
INSERT INTO emp(id, ename, joindate, salary) values(3, '王五', '1999-11-11', 8800);



-- 面试题: 主键是唯一和非空，普通的字段我们也可以添加唯一和非空,有区别吗?
/*
一张表只有一个主键
一张表可以有多个唯一非空的字段
*/




/* =========== 外键约束约束 =========== */
-- 准备数据: 见PPT
-- 创建部门表
CREATE TABLE department (
	id INT PRIMARY KEY AUTO_INCREMENT,
	dep_name VARCHAR(20),
	dep_location VARCHAR(20)
);

-- 创建员工表
CREATE TABLE employee (
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(20),
	age INT,
	dep_id INT
);

-- 添加2个部门
INSERT INTO department (dep_name, dep_location) VALUES ('研发部', '广州'), ('销售部', '深圳');

-- 添加员工,dep_id表示员工所在的部门
INSERT INTO employee (NAME, age, dep_id) VALUES 
('张三', 20, 1),
('李四', 21, 1),
('王五', 20, 1),
('老王', 20, 2),
('大王', 22, 2),
('小王', 18, 2);






-- 删除从表 employee
DROP TABLE employee;

-- 创建 employee 并添加外键约束



-- 正常添加数据


-- 添加不正常的数据,报错: Cannot add or update a child row: a foreign key constraint fails  

-- 删除外键约束(了解)

-- 在已有表添加外键约束, 外键约束可以省略: CONSTRAINT 外键约束名 (了解)
-- 省略CONSTRAINT外键约束名 数据库会自动设置外键约束的名字,我们要到 `3信息` 中查找

