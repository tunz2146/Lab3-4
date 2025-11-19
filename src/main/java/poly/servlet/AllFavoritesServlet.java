// File: src/main/java/poly/servlet/AllFavoritesServlet.java
package poly.servlet;

import poly.dao.FavoriteDAO;
import poly.daoimpl.FavoriteDAOImpl;
import poly.entity.Favorite;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/all-favorites")
public class AllFavoritesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private FavoriteDAO favoriteDAO = new FavoriteDAOImpl();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        try {
            List<Favorite> favorites = favoriteDAO.findAll();
            
            req.setAttribute("favorites", favorites);
            req.getRequestDispatcher("/views/all-favorites.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Lỗi khi tải dữ liệu: " + e.getMessage());
        }
    }
}