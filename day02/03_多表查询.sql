/*  多表查询  */

-- 准备数据
-- 创建部门表
CREATE TABLE tb_dept (
  id INT PRIMARY KEY AUTO_INCREMENT,
  NAME VARCHAR(20)
);

INSERT INTO tb_dept (NAME) VALUES ('开发部'),('市场部'),('财务部'),('销售部');


-- 创建员工表
CREATE TABLE tb_emp (
  id INT PRIMARY KEY AUTO_INCREMENT,
  NAME VARCHAR(10),
  gender CHAR(1),   -- 性别
  salary DOUBLE,   -- 工资
  join_date DATE,  -- 入职日期
  dept_id INT
);

INSERT INTO tb_emp(NAME,gender,salary,join_date,dept_id) VALUES('孙悟空','男',7200,'2013-02-24',1);
INSERT INTO tb_emp(NAME,gender,salary,join_date,dept_id) VALUES('猪八戒','男',3600,'2010-12-02',2);
INSERT INTO tb_emp(NAME,gender,salary,join_date,dept_id) VALUES('唐僧','男',9000,'2008-08-08',2);
INSERT INTO tb_emp(NAME,gender,salary,join_date,dept_id) VALUES('白骨精','女',5000,'2015-10-07',3);
INSERT INTO tb_emp(NAME,gender,salary,join_date,dept_id) VALUES('蜘蛛精','女',4500,'2011-03-14',1);
INSERT INTO tb_emp VALUES (NULL, '白龙马', '男', 1, '2020-02-02', NULL);

-- 查询孙悟空员工的信息, 包括所在的部门名称
-- 一次查询多张表
-- 左表的每条数据和右表的每条数据组合，这种效果称为笛卡尔乘积。
SELECT * FROM tb_dept,tb_emp;


-- 去掉笛卡尔积
-- 去掉笛卡尔积的条件称为: 表连接条件(隐式连接)
SELECT * FROM tb_dept,tb_emp WHERE tb_dept.id = tb_emp.dept_id;


-- 在加上查询员工名字为孙悟空
SELECT * FROM tb_dept,tb_emp WHERE tb_dept.id = tb_emp.dept_id AND tb_emp.NAME = '孙悟空';


-- 扩展:给表取别名,表取了别名后,只能使用别名啦!
SELECT * FROM tb_dept AS d,tb_emp AS e WHERE d.id = e.dept_id AND e.NAME = '孙悟空';



/* ===========显式内连接=========== */
-- 显式内连接 INNER JOIN...ON
SELECT * FROM tb_dept INNER JOIN tb_emp ON tb_dept.id = tb_emp.dept_id WHERE tb_emp.NAME = '孙悟空';

-- INNER可以省略,初学者不建议省略
SELECT * FROM tb_dept JOIN tb_emp ON tb_dept.id = tb_emp.dept_id WHERE tb_emp.NAME = '孙悟空';


/* ===========左外连接查询=========== */
-- 左外连接查询 (满足要求的显示,保证左表不满足要求的也显示)
SELECT * FROM tb_emp LEFT JOIN tb_dept ON tb_dept.id = tb_emp.dept_id;

/* ===========右外连接=========== */
-- 右外连接
SELECT * FROM tb_emp RIGHT JOIN tb_dept ON tb_dept.id = tb_emp.dept_id;

-- 一般在工作中我们都使用左外, 右外可以转成左外, 我们中国人的书写顺序,从左到右


/* ===========子查询结果=========== */
-- 子查询结果的三种情况
-- 1.单行单列(一个值)
-- 2.多行单列(多个值)
-- 3.多行多列 (虚拟的表)

/* ===========子查询的结果是单行单列=========== */
-- 查询工资最高的员工是谁？
-- 1.查询最高工资
SELECT MAX(salary) FROM tb_emp;
-- 2.通过最高工资查询员工姓名
SELECT * FROM tb_emp WHERE salary = ( SELECT MAX(salary) FROM tb_emp );

-- 子查询心得:建议先写好一条SQL,再复制到另一个SQL语句中



/* ===========子查询的结果是多行单列的时候=========== */
-- 查询工资大于5000的员工, 来自于哪些部门的名字
-- 1.查询工资大于5000的员工所在部门id

SELECT DISTINCT  id FROM tb_emp WHERE salary > 5000;

-- 2.根据部门id查找部门名称
SELECT * FROM tb_dept  WHERE id IN (1,3);


-- 子查询
SELECT * FROM tb_dept  WHERE id IN ( SELECT DISTINCT  id FROM tb_emp WHERE salary > 5000 );



/* ===========子查询的结果是多行多列=========== */
-- 查询出2011年以后入职的员工信息, 包括部门名称
-- 1.查询出2011年以后入职的员工信息
SELECT * FROM tb_emp WHERE join_date > '2011-01-01';

-- 2.找到对应的部门信息



/* ===========多表查询练习=========== */
-- 准备数据
-- 部门表
CREATE TABLE dept (
  id INT PRIMARY KEY, -- 部门id
  dname VARCHAR(50), -- 部门名称
  loc VARCHAR(50) -- 部门位置
);

-- 添加4个部门
INSERT INTO dept(id,dname,loc) VALUES 
(10,'教研部','北京'),
(20,'学工部','上海'),
(30,'销售部','广州'),
(40,'财务部','深圳');

-- 职务表, 职务名称, 职务描述
CREATE TABLE job (
  id INT PRIMARY KEY,
  jname VARCHAR(20),
  description VARCHAR(50)
);

-- 添加4个职务
INSERT INTO job (id, jname, description) VALUES
(1, '董事长', '管理整个公司, 接单'),
(2, '经理', '管理部门员工'),
(3, '销售员', '向客人推销产品'),
(4, '文员', '使用办公软件');

-- 员工表
CREATE TABLE emp (
  id INT PRIMARY KEY, -- 员工id
  ename VARCHAR(50), -- 员工姓名
  job_id INT, -- 职务id
  mgr INT , -- 上级领导
  joindate DATE, -- 入职日期
  salary DECIMAL(7,2), -- 工资
  bonus DECIMAL(7,2), -- 奖金
  dept_id INT, -- 所在部门编号
  CONSTRAINT emp_jobid_ref_job_id_fk FOREIGN KEY (job_id) REFERENCES job (id),
  CONSTRAINT emp_deptid_ref_dept_id_fk FOREIGN KEY (dept_id) REFERENCES dept (id)
);

-- 添加员工
INSERT INTO emp(id,ename,job_id,mgr,joindate,salary,bonus,dept_id) VALUES 
(1001,'孙悟空',4,1004,'2000-12-17','8000.00',NULL,20),
(1002,'卢俊义',3,1006,'2001-02-20','16000.00','3000.00',30),
(1003,'林冲',3,1006,'2001-02-22','12500.00','5000.00',30),
(1004,'唐僧',2,1009,'2001-04-02','29750.00',NULL,20),
(1005,'李逵',4,1006,'2001-09-28','12500.00','14000.00',30),
(1006,'宋江',2,1009,'2001-05-01','28500.00',NULL,30),
(1007,'刘备',2,1009,'2001-09-01','24500.00',NULL,10),
(1008,'猪八戒',4,1004,'2007-04-19','30000.00',NULL,20),
(1009,'罗贯中',1,NULL,'2001-11-17','50000.00',NULL,10),
(1010,'吴用',3,1006,'2001-09-08','15000.00','0.00',30),
(1011,'沙僧',4,1004,'2007-05-23','11000.00',NULL,20),
(1012,'李逵',4,1006,'2001-12-03','9500.00',NULL,30),
(1013,'小白龙',4,1004,'2001-12-03','30000.00',NULL,20),
(1014,'关羽',4,1007,'2002-01-23','13000.00',NULL,10);

-- 工资等级表
CREATE TABLE salarygrade (
  grade INT PRIMARY KEY,
  losalary INT,
  hisalary INT
);

-- 添加5个工资等级
INSERT INTO salarygrade(grade,losalary,hisalary) VALUES 
(1,7000,12000),
(2,12010,14000),
(3,14010,20000),
(4,20010,30000),
(5,30010,99990);


-- 多表查询规律
-- 1.根据需求明确查询哪些表
-- 2.明确表连接条件去掉笛卡尔积
-- 3.后续的查询


-- 练习1
-- 查询所有员工信息。显示员工编号, 员工姓名, 工资, 职务名称, 职务描述
-- 1.根据需求明确查询哪些表: emp, job
SELECT e.id, e.ename, e.salary, j.jname, j.description FROM emp AS e
LEFT JOIN job AS j ON e.job_id = j.id;

-- 2.明确表连接条件去掉笛卡尔积
-- 3.后续的查询


-- 练习2
-- 查询所有员工信息。显示员工编号, 员工姓名, 工资, 职务名称, 职务描述, 部门名称, 部门位置
-- 1.根据需求明确查询哪些表: emp, job, dept
SELECT e.id, e.ename, e.salary, j.jname, j.description d.dname, d.loc FROM emp AS e
LEFT JOIN job AS j ON e.job_id = j.id
LEFT JOIN dept AS d ON e.dept_id = d.id;
-- 2.明确表连接条件去掉笛卡尔积
-- 3.后续的查询


-- 练习3
-- 查询经理的信息。显示员工姓名, 工资, 职务名称, 职务描述, 部门名称, 部门位置, 工资等级
-- 1.根据需求明确查询哪些表: emp, job, dept, salarygrade
SELECT e.id, e.ename, e.salary, j.jname, j.description ,d.dname, d.loc, s.grade FROM emp AS e
LEFT JOIN job AS j ON e.job_id = j.id
LEFT JOIN dept AS d ON e.dept_id = d.id
LEFT JOIN salarygrade AS s ON e.salary BETWEEN s.losalary AND s.hisalary
WHERE j.jname = '经理';
-- 2.明确表连接条件去掉笛卡尔积
-- 3.后续的查询


-- 练习4
-- 查询出部门编号、部门名称、部门位置、部门人数
-- 1.根据需求明确查询哪些表: emp, dept
SELECT d.id, d.dname, d.loc, COUNT( e.ename ) AS emp_num
FROM dept AS d LEFT JOIN emp AS e ON d.id = e.dept_id
GROUP BY e.dept_id;

-- 2.明确表连接条件去掉笛卡尔积
-- 3.后续的查询

-- 练习5
-- 列出所有员工的姓名及其直接上级领导的姓名, 没有上级领导的员工也需要显示,显示自己的名字和领导的名字
-- 1.根据需求明确查询哪些表: emp pt, emp ld
-- 2.明确表连接条件去掉笛卡尔积
-- 3.后续的查询
