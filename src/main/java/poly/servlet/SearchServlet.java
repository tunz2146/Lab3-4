// File: src/main/java/poly/servlet/SearchServlet.java
package poly.servlet;

import poly.dao.VideoDAO;
import poly.daoimpl.VideoDAOImpl;
import poly.entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private VideoDAO videoDAO = new VideoDAOImpl();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        String keyword = req.getParameter("keyword");
        
        try {
            List<Video> videos;
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                // Tìm kiếm theo keyword
                videos = videoDAO.searchByKeyword(keyword.trim());
                System.out.println("Tìm thấy " + videos.size() + " video cho từ khóa: " + keyword);
            } else {
                // Nếu không có keyword, hiển thị tất cả video
                videos = videoDAO.findAll();
            }
            
            // Truyền dữ liệu sang JSP
            req.setAttribute("videos", videos);
            req.setAttribute("keyword", keyword);
            
            // Forward đến trang search
            req.getRequestDispatcher("/views/search.jsp").forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Lỗi khi tìm kiếm: " + e.getMessage());
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        doGet(req, resp);
    }
}