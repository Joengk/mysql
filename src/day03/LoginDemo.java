package day03;

import java.sql.*;
import java.util.Scanner;

public class LoginDemo {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/day03";


        Scanner sc = new Scanner(System.in);
        System.out.println("输入账户");
        String name = sc.next();

        System.out.println("输入密码");
        String password = sc.next();


        String sql = "select * from day03.user where `name` = '" + name + "' and password = '" + password + "'";

//        String sql = "select * from day03.user where `name` = ? and password = ?";


        try (
                Connection conn = DriverManager.getConnection(url, "root", "root");

//                //密码如果是 sql 语句例如  a'or'1'='1
//                Statement stmt = conn.createStatement();
//                ResultSet rs = stmt.executeQuery(sql);

                PreparedStatement pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery();

        ) {

            pstmt.setString(1, name);
            pstmt.setString(2, password);


            if (rs.next()) {
                System.out.println("欢迎" + name);
            } else {
                System.out.println("密码或账户错误");
            }


        } catch (Exception e) {
            e.printStackTrace();
        }


    }
}
