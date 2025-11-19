// File: src/main/java/poly/servlet/LoginServlet.java
package poly.servlet;

import poly.entity.User;
import poly.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private AuthService authService = new AuthService();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        // Nếu đã login thì redirect về home
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("currentUser") != null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        
        // Hiển thị trang login
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String remember = req.getParameter("remember");
        
        // Validate input
        if (username == null || password == null || 
            username.trim().isEmpty() || password.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }
        
        // Authenticate
        User user = authService.authenticate(username, password);
        
        if (user != null) {
            // Đăng nhập thành công
            HttpSession session = req.getSession(true);
            session.setAttribute("currentUser", user);
            session.setMaxInactiveInterval(30 * 60); // 30 minutes
            
            // Remember me (optional - lưu cookie)
            if ("on".equals(remember)) {
                // TODO: Implement remember me with cookie
            }
            
            // Redirect về trang trước đó hoặc home
            String returnUrl = (String) session.getAttribute("returnUrl");
            if (returnUrl != null) {
                session.removeAttribute("returnUrl");
                resp.sendRedirect(returnUrl);
            } else {
                resp.sendRedirect(req.getContextPath() + "/");
            }
            
        } else {
            // Đăng nhập thất bại
            req.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}