package utils;

import com.alibaba.druid.pool.DruidDataSourceFactory;


import javax.sql.DataSource;
import java.io.FileInputStream;
import java.io.IOException;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

public class DruidDataSourceConnectInstance {

    private static DataSource dataSource;


    static {
        Properties prop = new Properties();
        try {
            prop.load(new FileInputStream("src\\utils\\druid.properties"));
            dataSource = DruidDataSourceFactory.createDataSource(prop);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }


    }

    // 提供方法获取对象
    public static Connection getInstance() throws SQLException {
        return dataSource.getConnection();
    }

    private DruidDataSourceConnectInstance(){}

}
