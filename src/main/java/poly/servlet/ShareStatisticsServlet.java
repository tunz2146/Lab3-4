// File: src/main/java/poly/servlet/ShareStatisticsServlet.java
package poly.servlet;

import poly.dao.ShareDAO;
import poly.daoimpl.ShareDAOImpl;
import poly.entity.Share;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/share-statistics")
public class ShareStatisticsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ShareDAO shareDAO = new ShareDAOImpl();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        try {
            List<Share> shares = shareDAO.findAll();
            
            req.setAttribute("shares", shares);
            req.getRequestDispatcher("/views/share-statistics.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Lỗi khi tải dữ liệu: " + e.getMessage());
        }
    }
}