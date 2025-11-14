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

@WebServlet(name = "UpdateOrderStatusControl", urlPatterns = {"/updateorderstatus"})
public class UpdateOrderStatusControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("acc");
        
        // Kiểm tra admin
        if (a == null || a.getIsAdmin() != 1) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        String orderIDStr = request.getParameter("oid");
        String newStatus = request.getParameter("status");
        
        if (orderIDStr != null && newStatus != null) {
            try {
                int orderID = Integer.parseInt(orderIDStr);
                DAO dao = new DAO();
                dao.updateOrderStatus(orderID, newStatus);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        
        // Redirect về trang quản lý đơn hàng
        response.sendRedirect("adminorders");
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

