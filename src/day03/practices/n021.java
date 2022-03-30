package day03.practices;


import utils.DruidDataSourceConnectInstance;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class n021 {
    public static void main(String[] args) throws SQLException {

        Connection conn = DruidDataSourceConnectInstance.getInstance();

        //查询出所有的数据，并将每一条数据封装到Student实体类对象中存储到List集合中
        String sql = "select * from day03.student";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet res = pstmt.executeQuery();

        ArrayList<Studen> stuList = new ArrayList<>();

        while (res.next()) {

            int id = res.getInt("id");
            String name = res.getString("name");
            int age = res.getInt("age");

            stuList.add(new Studen(id, name, age));

        }

        stuList.forEach(System.out::println);

        pstmt.close();


        System.out.println("-------------");

        //查询出id是 `2` 的数据并封装到一个 Student 对象中
        String sql1 = "select * from day03.student where id = ?";

        PreparedStatement pstmt1 = conn.prepareStatement(sql1);
        pstmt1.setInt(1,2);
        ResultSet res1 = pstmt1.executeQuery();


        while (res1.next()) {

            int id = res1.getInt("id");
            String name = res1.getString("name");
            int age = res1.getInt("age");

            Studen stu = new Studen(id, name, age);
            System.out.println(stu);
            stuList.add(stu);

        }
        pstmt1.close();


        System.out.println("-------------");

        //修改 `张三丰` 的家庭住址为 `北京海淀区`
        String sql2 = "update day03.student set address = ? where name = ?";

        PreparedStatement pstmt2 = conn.prepareStatement(sql2);
        pstmt2.setString(1,"北京海淀区");
        pstmt2.setString(2,"张三丰");
//        int i = pstmt2.executeUpdate();
//        System.out.println(i);
        pstmt2.close();

        System.out.println("-------------");

        //删除id为 `2` 的数据
        String sql3 = "delete from day03.student where id = ?";


        PreparedStatement pstmt3 = conn.prepareStatement(sql3);
        pstmt3.setInt(1,2);
        int i = pstmt3.executeUpdate();
        System.out.println(i);
        pstmt3.close();






    }
}


class Studen {
    private Integer id;
    private String name;
    private Integer age;

    public Studen() {
    }

    public Studen(Integer id, String name, Integer age) {
        this.id = id;
        this.name = name;
        this.age = age;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    @Override
    public String toString() {
        return "Studen{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", age=" + age +
                '}';
    }
}




