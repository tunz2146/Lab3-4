// File: src/main/java/poly/daoimpl/VideoDAOImpl.java
package poly.daoimpl;

import poly.dao.VideoDAO;
import poly.entity.Video;
import poly.util.JPAUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class VideoDAOImpl implements VideoDAO {
    
    @Override
    public List<Video> findAll() {
        EntityManager em = JPAUtils.getEntityManager();
        try {
            // LEFT JOIN FETCH để load cả favorites
            TypedQuery<Video> query = em.createQuery(
                "SELECT DISTINCT v FROM Video v " +
                "LEFT JOIN FETCH v.favorites " +
                "ORDER BY v.views DESC", 
                Video.class
            );
            return query.getResultList();
        } finally {
            JPAUtils.closeEntityManager(em);
        }
    }
    
    @Override
    public Video findById(String id) {
        EntityManager em = JPAUtils.getEntityManager();
        try {
            return em.find(Video.class, id);
        } finally {
            JPAUtils.closeEntityManager(em);
        }
    }
    
    @Override
    public void create(Video video) {
        EntityManager em = JPAUtils.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(video);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            JPAUtils.closeEntityManager(em);
        }
    }
    
    @Override
    public void update(Video video) {
        EntityManager em = JPAUtils.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(video);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            JPAUtils.closeEntityManager(em);
        }
    }
    
    @Override
    public void deleteById(String id) {
        EntityManager em = JPAUtils.getEntityManager();
        try {
            em.getTransaction().begin();
            Video video = em.find(Video.class, id);
            if (video != null) {
                em.remove(video);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            JPAUtils.closeEntityManager(em);
        }
    }
    
    @Override
    public List<Video> searchByKeyword(String keyword) {
        EntityManager em = JPAUtils.getEntityManager();
        try {
            // Tìm kiếm trong title và description
            TypedQuery<Video> query = em.createQuery(
                "SELECT v FROM Video v " +
                "WHERE LOWER(v.title) LIKE LOWER(:keyword) " +
                "OR LOWER(v.description) LIKE LOWER(:keyword) " +
                "ORDER BY v.views DESC", 
                Video.class
            );
            query.setParameter("keyword", "%" + keyword + "%");
            return query.getResultList();
        } finally {
            JPAUtils.closeEntityManager(em);
        }
    }
    @Override
    public List<Video> findByTitle(String title) {
        EntityManager em = JPAUtils.getEntityManager();
        try {
            TypedQuery<Video> query = em.createQuery(
                "SELECT v FROM Video v WHERE LOWER(v.title) LIKE LOWER(:title)", 
                Video.class
            );
            query.setParameter("title", "%" + title + "%");
            return query.getResultList();
        } finally {
            JPAUtils.closeEntityManager(em);
        }
    }
    
    @Override
    public List<Video> findActiveVideos() {
        EntityManager em = JPAUtils.getEntityManager();
        try {
            TypedQuery<Video> query = em.createQuery(
                "SELECT v FROM Video v WHERE v.active = true ORDER BY v.views DESC", 
                Video.class
            );
            return query.getResultList();
        } finally {
            JPAUtils.closeEntityManager(em);
        }
    }
}