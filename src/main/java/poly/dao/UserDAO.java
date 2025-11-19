// File: src/main/java/poly/dao/UserDAO.java
package poly.dao;

import poly.entity.User;
import java.util.List;

public interface UserDAO {
    List<User> findAll();
    User findById(String id);
    void create(User user);
    void update(User user);
    void deleteById(String id);
    User findByEmail(String email);
}