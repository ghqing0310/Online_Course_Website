package Service.User;

import Model.User;
import DAO.DAO;

public class UserServiceImpl extends DAO<User> implements UserService {

    @Override
    public User register(String username, String password, String type) {
        String sql = "INSERT INTO User (username, password, type) VALUES (?,?,?)";
        update(sql, username, password, type);
        return login(username, password);
    }

    @Override
    public User login(String username, String password) {
        String sql = "SELECT * FROM User WHERE username=? AND password=?";
        return get(sql, username, password);
    }

    @Override
    public long countName(String username) {
        String sql = "SELECT COUNT(id) FROM User WHERE username=?";
        return getForValue(sql, username);
    }

    @Override
    public User getUser(int userId) {
        String sql = "SELECT * FROM User WHERE id=?";
        return get(sql, userId);
    }


    public static void main(String[] args) {
        System.out.print(new UserServiceImpl().login("a", "a"));
    }
}
