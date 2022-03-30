package day03;


import java.sql.*;
import java.util.ArrayList;

public class JDBCDemo {
    public static void main(String[] args) {
        // 注册驱动, 在sql5 之后就会自动加载, 可以不写


        // 创建链接
        // 使用完整链接
        String url = "jdbc:mysql://localhost:3306/day03";

        //使用 简化链接, 只有在使用 localhost且为3306端口才能使用
//        String url = "jdbc:mysql:///day03";

        //使用 带参链接, 指定链接时候的时区, 字符集, 加密链接


        final String username = "root";
        final String password = "root";

        ArrayList<User> usersList = new ArrayList<>();

        //执行 sql 更新语句
        String sql = "update user set name = 'hh' where id = 3 ";

        //执行 sql 插入语句
        String sql1 = "insert into user value(null,'hi',111)";


        //执行 sql 查询语句
        String sql2 = "select * from user ";


        try (
                // 创建链接
                Connection con = DriverManager.getConnection(url, username, password);
                // 创建执行对象
                Statement stmt = con.createStatement();
                //执行 sql 更新语句
                //            int i = stmt.executeUpdate(sql1);
                //执行 sql 插入语句
                ResultSet resultSet = stmt.executeQuery(sql2);
        ) {
            System.out.println(con);

            //遍历结果集
            while (resultSet.next()){
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String password1 = resultSet.getString("password");
//                System.out.printf("id:%s, name:%s, password:%s \n",id, name,password1);

                // 封装到对象里面
                usersList.add(new User(id, name,password1));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        //遍历 封装好的集合
        usersList.forEach(System.out::println);

    }
}


//@NoArgsConstructor
//@AllArgsConstructor
//@Getter
//@Setter
//@ToString
class User{
    private int id;
    private String name;
    private String password;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", password='" + password + '\'' +
                '}';
    }

    public User(int id, String name, String password) {
        this.id = id;
        this.name = name;
        this.password = password;
    }

    public User() {
    }
}
