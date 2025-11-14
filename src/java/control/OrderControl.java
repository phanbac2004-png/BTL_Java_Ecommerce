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

@WebServlet(name = "OrderControl", urlPatterns = {"/order"})
public class OrderControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("acc");
        
        if (a == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        String oid = request.getParameter("oid");
        String payment = request.getParameter("payment");
        String success = request.getParameter("success");
        
        if (oid != null) {
            try {
                int orderID = Integer.parseInt(oid);
                DAO dao = new DAO();
                
                // Lấy thông tin đơn hàng (kiểm tra xem có phải của user này không hoặc là admin)
                List<Order> userOrders = dao.getOrdersByAccountID(a.getId());
                Order order = null;
                for (Order o : userOrders) {
                    if (o.getId() == orderID) {
                        order = o;
                        break;
                    }
                }
                
                // Nếu là admin, có thể xem tất cả đơn
                if (order == null && a.getIsAdmin() == 1) {
                    List<Order> allOrders = dao.getAllOrders();
                    for (Order o : allOrders) {
                        if (o.getId() == orderID) {
                            order = o;
                            break;
                        }
                    }
                }
                
                if (order != null) {
                    List<OrderDetail> listOD = dao.getOrderDetailsByOrderID(orderID);
                    
                    // Lấy thông tin sản phẩm cho mỗi chi tiết
                    List<Product> listProducts = new ArrayList<>();
                    for (OrderDetail od : listOD) {
                        Product p = dao.getProductByID(od.getProductID());
                        if (p != null) {
                            listProducts.add(p);
                        }
                    }
                    
                    // Nếu order thiếu phone/address, query lại để lấy đầy đủ
                    if (order.getPhone() == null || order.getAddress() == null) {
                        DAO dao2 = new DAO();
                        List<Order> allOrders = dao2.getAllOrders();
                        for (Order o : allOrders) {
                            if (o.getId() == orderID) {
                                order.setPhone(o.getPhone());
                                order.setAddress(o.getAddress());
                                break;
                            }
                        }
                    }
                    
                    request.setAttribute("order", order);
                    request.setAttribute("listOD", listOD);
                    request.setAttribute("listProducts", listProducts);
                    
                    // Set message
                    request.setAttribute("successMessage", "Đặt hàng thành công!");
                    
                    request.getRequestDispatcher("OrderSuccess.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                // Lỗi format số
            }
        }
        
        // Nếu không tìm thấy đơn hàng, redirect về trang chủ
        response.sendRedirect("home");
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

