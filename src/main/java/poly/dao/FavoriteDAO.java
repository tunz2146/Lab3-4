// File: src/main/java/poly/dao/FavoriteDAO.java
package poly.dao;

import poly.entity.Favorite;
import java.util.List;

public interface FavoriteDAO {
    List<Favorite> findAll();
    Favorite findById(Long id);
    void create(Favorite favorite);
    void update(Favorite favorite);
    void deleteById(Long id);
    List<Favorite> findByUserId(String userId);
}