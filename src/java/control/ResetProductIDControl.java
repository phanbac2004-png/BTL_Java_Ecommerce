package control;

import dao.DAO;
import entity.Account;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import context.DBContext;

@WebServlet(name = "ResetProductIDControl", urlPatterns = {"/resetproductid"})
public class ResetProductIDControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("acc");
        
        // Kiểm tra admin
        if (a == null || a.getIsAdmin() != 1) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        try {
            Connection conn = new DBContext().getConnection();
            
            // Lấy ID lớn nhất hiện tại
            String maxQuery = "SELECT MAX(id) FROM product";
            PreparedStatement ps = conn.prepareStatement(maxQuery);
            java.sql.ResultSet rs = ps.executeQuery();
            int maxId = 0;
            if (rs.next()) {
                maxId = rs.getInt(1);
            }
            rs.close();
            ps.close();
            
            // Reset AUTO_INCREMENT về maxId + 1
            String resetQuery = "ALTER TABLE product AUTO_INCREMENT = ?";
            ps = conn.prepareStatement(resetQuery);
            ps.setInt(1, maxId + 1);
            ps.executeUpdate();
            ps.close();
            
            session.setAttribute("successMsg", "Đã reset AUTO_INCREMENT thành công! ID tiếp theo sẽ là " + (maxId + 1));
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Lỗi khi reset: " + e.getMessage());
        }
        
        response.sendRedirect("admindashboard?page=products");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
