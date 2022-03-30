package day03;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.pool.DruidDataSourceFactory;
import com.alibaba.druid.pool.DruidPooledConnection;


import javax.sql.DataSource;
import java.io.FileInputStream;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;


public class ConnectPoolDemo {
    public static void main(String[] args) throws IOException, SQLException {
        DruidDataSource druidDataSource = new DruidDataSource();


        Properties prop = new Properties();
        prop.load(new FileInputStream("C:\\PROJECT\\mysql\\src\\day03\\druid.properties"));

        DataSource dataSource = null;
        try {
             dataSource = DruidDataSourceFactory.createDataSource(prop);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }


        for (int i = 0; i < 10; i++) {
            assert dataSource != null;
            Connection c1 = dataSource.getConnection();
            System.out.println(c1);
        }

    }
}
