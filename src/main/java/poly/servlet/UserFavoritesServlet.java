// File: src/main/java/poly/servlet/UserFavoritesServlet.java
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

@WebServlet("/user-favorites")
public class UserFavoritesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private FavoriteDAO favoriteDAO = new FavoriteDAOImpl();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        String userId = req.getParameter("userId");
        
        // Nếu không có userId, mặc định lấy user đầu tiên
        if (userId == null || userId.isEmpty()) {
            userId = "NVT01";
        }
        
        try {
            // GIẢI PHÁP: Lấy favorites qua FavoriteDAO thay vì qua User
            // Điều này tránh LazyInitializationException
            List<Favorite> favorites = favoriteDAO.findByUserId(userId);
            
            if (!favorites.isEmpty()) {
                // Lấy thông tin user từ favorite đầu tiên
                Favorite firstFavorite = favorites.get(0);
                
                req.setAttribute("user", firstFavorite.getUser());
                req.setAttribute("favorites", favorites);
                req.getRequestDispatcher("/views/user-favorites.jsp").forward(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, 
                    "Không tìm thấy dữ liệu cho user ID: " + userId);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Lỗi khi tải dữ liệu: " + e.getMessage());
        }
    }
}