package day03.practices;

import utils.DruidDataSourceConnectInstance;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

public class orderTest {
    public static void main(String[] args) throws SQLException {

        //订单详情数据
        //商品1
        OrderDetail orderDetail = new OrderDetail();
        //订单中商品的名称
        orderDetail.setName("华为Meta50");
        //订单中该商品的数量
        orderDetail.setNumber(2);
        //该商品的单价
        orderDetail.setAmount(6000);

        //商品2
        OrderDetail orderDetail2 = new OrderDetail();
        //订单中商品的名称
        orderDetail2.setName("MetaBook X Pro");
        //订单中该商品的数量
        orderDetail2.setNumber(2);
        //该商品的单价
        orderDetail2.setAmount(9299);


        List<OrderDetail> list = new ArrayList<>();
        list.add(orderDetail);
        list.add(orderDetail2);


        //订单数据
        Orders orders = new Orders();

        //必须指定订单 id , 否则商品列表无法关联
        orders.setId(13);

        //使用UUID生成一个订单号
        String number = UUID.randomUUID().toString();
        orders.setNumber(number);
        //下单后默认就是 "待付款"
        orders.setStatus(1);
        //支付方式默认是 "微信支付"
        orders.setPayMethod(1);
        //下单时间即为系统当前时间
        orders.setOrderTime(new Date());
        //总金额，需要将订单中所有的商品的价格总和
        double amount = 0;
        for (OrderDetail detail : list) {
            amount += detail.getNumber() * detail.getAmount();
        }
        orders.setAmount(amount);
        //收货地址
        orders.setAddress("北京西三旗");
        //收货人手机号
        orders.setPhone("17621234235");


        //假如用户下单，需要==同时==向 `orders` 和 `order_detail` 表中添加数据。请定义一个测试方法用来模拟这一操作
        //同时向连接池传入两条 sql 语句
        //在上一个的基础上加入事务管理，保证 `订单数据` 和 `订单详情数据` 同成功，同失败

        Connection conn = null;
        PreparedStatement pstmt = null;
        PreparedStatement pstmt2 = null;
        try {

            conn = DruidDataSourceConnectInstance.getInstance();
            conn.setAutoCommit(false);

            String sql = "insert into day03.orders value (?,?,?,?,?,?,?,?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, orders.getId());
            pstmt.setString(2, orders.getNumber());
            pstmt.setInt(3, orders.getStatus());
            pstmt.setString(4, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(orders.getOrderTime()));
            pstmt.setInt(5, orders.getPayMethod());
            pstmt.setDouble(6, orders.getAmount());
            pstmt.setString(7, orders.getPhone());
            pstmt.setString(8, orders.getAddress());
            System.out.println(pstmt);
            pstmt.executeUpdate();

//        订单商品列表
            String sql2 = "insert into day03.order_detail values (null,?,?,?,?)";
            pstmt2 = conn.prepareStatement(sql2);

            for (OrderDetail detail : list) {
                pstmt2.setString(1, detail.getName());
                //订单id
                pstmt2.setInt(2, orders.getId());
                pstmt2.setInt(3, detail.getNumber());
                pstmt2.setDouble(4, detail.getAmount());
                System.out.println(pstmt2.getMetaData());
                pstmt2.executeUpdate();
            }

            conn.commit();

        } catch (SQLException e) {

            if (conn != null) {
                conn.rollback();
            }

            e.printStackTrace();

        }finally {
            if (pstmt!= null) {
                pstmt.close();
            }

            if (pstmt2!=null) {
                pstmt2.close();
            }

            if (conn!= null){
                conn.close();
            }
        }

    }


}
