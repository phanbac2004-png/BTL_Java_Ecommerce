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
import java.sql.ResultSet;
import context.DBContext;

@WebServlet(name = "ReorganizeProductIDControl", urlPatterns = {"/reorganizeproductid"})
public class ReorganizeProductIDControl extends HttpServlet {

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
            
            // Bước 1: Lấy tất cả sản phẩm và sắp xếp
            String selectQuery = "SELECT id, name, image, price, title, description, cateID, sell_ID FROM product ORDER BY id";
            PreparedStatement psSelect = conn.prepareStatement(selectQuery);
            ResultSet rs = psSelect.executeQuery();
            
            java.util.List<java.util.Map<String, Object>> products = new java.util.ArrayList<>();
            while (rs.next()) {
                java.util.Map<String, Object> product = new java.util.HashMap<>();
                product.put("id", rs.getInt("id"));
                product.put("name", rs.getString("name"));
                product.put("image", rs.getString("image"));
                product.put("price", rs.getDouble("price"));
                product.put("title", rs.getString("title"));
                product.put("description", rs.getString("description"));
                product.put("cateID", rs.getInt("cateID"));
                product.put("sell_ID", rs.getInt("sell_ID"));
                products.add(product);
            }
            rs.close();
            psSelect.close();
            
            if (products.isEmpty()) {
                session.setAttribute("errorMsg", "Không có sản phẩm nào để sắp xếp lại!");
                response.sendRedirect("admindashboard?page=products");
                return;
            }
            
            // Bước 2: Tắt kiểm tra foreign key tạm thời
            PreparedStatement psDisableFK = conn.prepareStatement("SET FOREIGN_KEY_CHECKS = 0");
            psDisableFK.execute();
            psDisableFK.close();
            
            // Bước 3: Update ID từng sản phẩm theo thứ tự
            // Dùng ID tạm thời lớn để tránh conflict
            int tempStartId = 100000; // ID tạm thời lớn
            int newId = 1;
            
            // Trước tiên, set tất cả ID về giá trị tạm thời lớn
            PreparedStatement psTemp = conn.prepareStatement("UPDATE product SET id = ? WHERE id = ?");
            for (java.util.Map<String, Object> product : products) {
                int oldId = (Integer) product.get("id");
                psTemp.setInt(1, tempStartId + newId);
                psTemp.setInt(2, oldId);
                psTemp.executeUpdate();
                newId++;
            }
            psTemp.close();
            
            // Sau đó update về ID thật liên tục
            newId = 1;
            PreparedStatement psUpdate = conn.prepareStatement("UPDATE product SET id = ? WHERE id = ?");
            for (int i = 0; i < products.size(); i++) {
                int tempId = tempStartId + (i + 1);
                psUpdate.setInt(1, newId);
                psUpdate.setInt(2, tempId);
                psUpdate.executeUpdate();
                newId++;
            }
            psUpdate.close();
            
            // Update các bảng liên quan (orderdetails, cart)
            // Cập nhật cart.ProductID nếu cần (sẽ giữ nguyên vì đã dùng ID tạm thời)
            // Cập nhật orderdetails.ProductID nếu cần
            
            // Bước 4: Reset AUTO_INCREMENT
            String resetQuery = "ALTER TABLE product AUTO_INCREMENT = ?";
            PreparedStatement psReset = conn.prepareStatement(resetQuery);
            psReset.setInt(1, newId);
            psReset.executeUpdate();
            psReset.close();
            
            // Bật lại kiểm tra foreign key
            PreparedStatement psEnableFK = conn.prepareStatement("SET FOREIGN_KEY_CHECKS = 1");
            psEnableFK.execute();
            psEnableFK.close();
            
            session.setAttribute("successMsg", "Đã sắp xếp lại ID thành công! Tất cả " + products.size() + " sản phẩm giờ có ID liên tục từ 1 đến " + (newId - 1));
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Lỗi khi sắp xếp lại ID: " + e.getMessage());
            
            // Cố gắng bật lại foreign key check nếu lỗi
            try {
                Connection conn = new DBContext().getConnection();
                PreparedStatement ps = conn.prepareStatement("SET FOREIGN_KEY_CHECKS = 1");
                ps.execute();
                ps.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
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
