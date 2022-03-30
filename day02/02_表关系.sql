/*
	多对多：
		* 如：订单 和 商品
		* 一个商品对应多个订单，一个订单包含多个商品

	实现方式：建立第三张中间表，中间表至少包含两个外键，分别关联两方主键
*/

-- 订单表
CREATE TABLE tb_order (
	id int primary key auto_increment,
	payment double(10,2),
	payment_type TINYINT,
	status TINYINT
);

-- 商品表
CREATE TABLE tb_goods (
	id int primary key AUTO_INCREMENT,
	title varchar(100),
	price double(10,2)	
);

-- 订单商品中间表


