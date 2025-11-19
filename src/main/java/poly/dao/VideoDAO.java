// File: src/main/java/poly/dao/VideoDAO.java
package poly.dao;

import poly.entity.Video;
import java.util.List;

public interface VideoDAO {
    List<Video> findAll();
    Video findById(String id);
    void create(Video video);
    void update(Video video);
    void deleteById(String id);
}