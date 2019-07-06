package Service.User;

import Model.User;

public interface UserService {

    User register(String username, String password, String type);

    User login(String username, String password);

    long countName(String username);

    User getUser(int userId);

}
