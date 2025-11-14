package control;

import dao.DAO;
import entity.Account;
import entity.Order;
import entity.OrderDetail;
import entity.Product;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "OrderDetailControl", urlPatterns = {"/orderdetail"})
public class OrderDetailControl extends HttpServlet {

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
        
        String oid = request.getParameter("oid");
        if (oid != null) {
            try {
                int orderID = Integer.parseInt(oid);
                DAO dao = new DAO();
                List<OrderDetail> listOD = dao.getOrderDetailsByOrderID(orderID);
                
                // Lấy thông tin đơn hàng để có status
                List<Order> allOrders = dao.getAllOrders();
                Order order = null;
                for (Order o : allOrders) {
                    if (o.getId() == orderID) {
                        order = o;
                        break;
                    }
                }
                
                // Lấy thông tin sản phẩm cho mỗi chi tiết
                List<Product> listProducts = new ArrayList<>();
                for (OrderDetail od : listOD) {
                    Product p = dao.getProductByID(od.getProductID());
                    if (p != null) {
                        listProducts.add(p);
                    }
                }
                
                request.setAttribute("listOD", listOD);
                request.setAttribute("listProducts", listProducts);
                request.setAttribute("orderID", orderID);
                request.setAttribute("order", order);
                request.getRequestDispatcher("OrderDetail.jsp").forward(request, response);
                return;
            } catch (NumberFormatException e) {
                // Lỗi format số
            }
        }
        
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

