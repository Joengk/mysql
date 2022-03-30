package day03;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class TranDemo {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/day02";

        try (
                Connection conn = DriverManager.getConnection(url, "root", "root");
                Statement stmt = conn.createStatement();

        ) {
            //关闭自动提交
            conn.setAutoCommit(false);

            //开始事务
            stmt.execute("start transaction ");

            //提交事务;
            String sql1 = "update day02.account set balance =  balance -500 where `name` = '张三'";
            stmt.executeUpdate(sql1);

            String sql2 = "update day02.account set balance =  balance + 500 where `name` = '李四'";
            stmt.executeUpdate(sql2);



//            String sql = "select * from day02.account";
//            stmt.executeQuery(sql);

            //提交事务
            conn.commit();

        } catch (Exception e) {
            e.printStackTrace();
        }


        //开启事务


    }
}
