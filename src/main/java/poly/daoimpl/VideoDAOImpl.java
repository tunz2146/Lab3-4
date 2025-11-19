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
            TypedQuery<Video> query = em.createQuery("SELECT v FROM Video v", Video.class);
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
}