-- 1.使用建库语句创建数据库，创建数据库名称：book_sys。
CREATE DATABASE book_sys;

-- 2.使用建表语句完成上面三张表的创建
CREATE TABLE studen(
stuID VARCHAR(10) PRIMARY KEY,
stuName VARCHAR(10),
major VARCHAR(50)
);


CREATE TABLE book(
BID VARCHAR(10) PRIMARY KEY,
title VARCHAR(50),
author VARCHAR(20)
);


CREATE TABLE borrow(
borrowID VARCHAR(10) PRIMARY KEY,
stuID VARCHAR(10),
BID VARCHAR(10),
T_time DATETIME,
B_time DATETIME,
CONSTRAINT s_fk FOREIGN KEY (stuID) REFERENCES studen(stuID),
FOREIGN KEY (BID) REFERENCES book(BID)
);


-- 3.请参考数据表的要求设置主外键及字段类型要求,要建立外键与主键

DESC borrow;
-- 指向book 和 studen;
DESC book;

DESC studen;


-- 4.插入数据
-- 4.1 图书表book
/*
'B001', '人生若只如初见', '安意如'
'B002', '入学那天遇见你', '晴空'
'B003', '感谢折磨你的人', '如娜'
'B004', '我不是教你诈', '刘庸'
'B005', '英语四级', '白雪'
*/


INSERT INTO book
VALUES( 'B001', '人生若只如初见', '安意如'),
		('B002', '入学那天遇见你', '晴空'),
		('B003', '感谢折磨你的人', '如娜'),
		('B004', '我不是教你诈', '刘庸'),
		('B005', '英语四级', '白雪');

-- 4.2 学生信息表student
/*
'1001', '林林', '计算机'
'1002', '白杨', '计算机'
'1003', '虎子', '英语'
'1004', '北漂的雪', '工商管理'
'1005', '五月', '数学'
*/

INSERT INTO studen
VALUES ('1001', '林林', '计算机'),
('1002', '白杨', '计算机'),
('1003', '虎子', '英语'),
('1004', '北漂的雪', '工商管理'),
('1005', '五月', '数学');


-- 4.3 借阅信息表borrow
/*
'T001', '1001', 'B001', '2017-12-26 00:00:00', NULL
'T002', '1004', 'B003', '2018-01-05 00:00:00', NULL
'T003', '1005', 'B001', '2017-10-08 00:00:00', '2017-12-25 00:00:00'
'T004', '1005', 'B002', '2017-12-16 00:00:00', '2018-01-07 00:00:00'
'T005', '1002', 'B004', '2017-12-22 00:00:00', NULL
'T006', '1005', 'B005', '2018-01-06 00:00:00', NULL
'T007', '1002', 'B001', '2017-09-11 00:00:00', NULL
'T008', '1005', 'B004', '2017-12-10 00:00:00', NULL
'T009', '1004', 'B005', '2017-10-16 00:00:00', '2017-12-18 00:00:00'
'T010', '1002', 'B002', '2017-09-15 00:00:00', '2018-01-05 00:00:00'
'T011', '1004', 'B003', '2017-12-28 00:00:00', NULL
'T012', '1002', 'B003', '2017-12-30 00:00:00', NULL
*/


INSERT INTO borrow
VALUES('T001', '1001', 'B001', '2017-12-26 00:00:00', NULL),
		('T002', '1004', 'B003', '2018-01-05 00:00:00', NULL),
		('T003', '1005', 'B001', '2017-10-08 00:00:00', '2017-12-25 00:00:00'),
		('T004', '1005', 'B002', '2017-12-16 00:00:00', '2018-01-07 00:00:00'),
		('T005', '1002', 'B004', '2017-12-22 00:00:00', NULL),
		('T006', '1005', 'B005', '2018-01-06 00:00:00', NULL),
		('T007', '1002', 'B001', '2017-09-11 00:00:00', NULL),
		('T008', '1005', 'B004', '2017-12-10 00:00:00', NULL),
		('T009', '1004', 'B005', '2017-10-16 00:00:00', '2017-12-18 00:00:00'),
		('T010', '1002', 'B002', '2017-09-15 00:00:00', '2018-01-05 00:00:00'),
		('T011', '1004', 'B003', '2017-12-28 00:00:00', NULL),
		('T012', '1002', 'B003', '2017-12-30 00:00:00', NULL);


-- 5.查询“计算机”专业学生在“2017-12-15”至“2018-1-8”时间段内借书的学生编号、学生名称、图书编号、图书名称、借出日期；

SELECT s.stuID, s.stuName, bo.BID, bo.title, b.T_time FROM borrow AS b 
LEFT JOIN studen AS s ON s.stuID = b.stuID
LEFT JOIN book AS bo ON bo.BID = b.BID
WHERE s.major = '计算机' AND  b.T_time BETWEEN  '2017-12-15' AND '2018-1-8';


-- 6.查询所有借过图书的学生编号、学生名称、专业；
-- 6.1.先查询到所有借阅过图书学生的编号
-- 方式一:
SELECT s.stuID, s.stuName, s.major FROM borrow AS b
JOIN studen AS s ON  s.stuID = b.stuID GROUP BY s.stuName;

-- 方式二:
SELECT DISTINCT s.stuID, s.stuName, s.major FROM borrow AS b
JOIN studen AS s ON  s.stuID = b.stuID;


-- 6.2.根据所有借阅过图书学生的编号查询学生的信息
SELECT * FROM studen AS s WHERE s.stuID 
IN (SELECT DISTINCT s.stuID FROM borrow AS b
		JOIN studen AS s ON  s.stuID = b.stuID
	);


-- 7.查询借过作者为“安意如”的图书的学生姓名、图书名称、借出日期、归还日期；
SELECT s.stuName, bo.title, b.T_time, b.B_time FROM borrow b 
LEFT JOIN book AS bo ON bo.BID = b.BID
LEFT JOIN studen AS s ON s.stuID = b.stuID
WHERE bo.author = '安意如';


-- 8.查询目前借书但未归还图书的学生名称及未还图书数量；
-- 什么是借书但未归还图书: ?
SELECT s.stuName, COUNT(b.stuID) FROM borrow AS b
LEFT JOIN studen AS s ON s.stuID = b.stuID
WHERE b.T_time IS NOT NULL AND b.B_time IS NULL GROUP BY b.stuID;





