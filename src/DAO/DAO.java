package DAO;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAO<T>{

    private QueryRunner queryRunner = null;
    private Class<T> type;

    public DAO(){
        queryRunner = new QueryRunner();
        type = ReflectionUtils.getSuperGenericType(getClass());
    }

    public void update(String sql, Object... args){
        Connection connection = null;
        try {
            connection = JdbcTools.getConnection();
            queryRunner.update(connection, sql, args);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcTools.releaseDB(connection);
        }
    }

    public T get(String sql, Object... args){
        Connection connection = null;
        try {
            connection = JdbcTools.getConnection();
            return queryRunner.query(connection, sql, new BeanHandler<>(type), args);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcTools.releaseDB(connection);
        }
        return null;
    }

    public List<T> getForList(String sql, Object... args){
        List<T> list = new ArrayList<T>();
        Connection connection = null;
        try {
            connection = JdbcTools.getConnection();
            return queryRunner.query(connection, sql, new BeanListHandler<>(type), args);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcTools.releaseDB(connection);
        }
        return list;
    }

    public <E> E getForValue(String sql, Object... args){
        Connection connection = null;
        try {
            connection = JdbcTools.getConnection();
            return (E)queryRunner.query(connection, sql, new ScalarHandler<>(), args);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcTools.releaseDB(connection);
        }
        return null;
    }

}
