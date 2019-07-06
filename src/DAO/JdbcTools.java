package DAO;

import org.apache.commons.dbcp2.BasicDataSourceFactory;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

public class JdbcTools {

    private static DataSource dataSource;

    static {
        Properties properties = new Properties();
        InputStream inStream = JdbcTools.class.getClassLoader().getResourceAsStream("DAO/jdbc.properties");
        try {
            properties.load(inStream);
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            dataSource = BasicDataSourceFactory.createDataSource(properties);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws Exception {
        return dataSource.getConnection();
    }

    public static void releaseDB(Connection connection){
        if (connection != null){
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
