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

@WebServlet(name = "UserPurchasedProductsControl", urlPatterns = {"/mypurchasedproducts"})
public class UserPurchasedProductsControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("acc");
        
        // Kiểm tra đăng nhập
        if (a == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        DAO dao = new DAO();
        
        // Lấy tất cả đơn hàng của user (chỉ đơn không bị hủy)
        List<Order> userOrders = dao.getOrdersByAccountID(a.getId());
        
        // Tạo danh sách đơn hàng với chi tiết sản phẩm
        List<OrderWithDetails> orderList = new ArrayList<>();
        
        for (Order order : userOrders) {
            if (!"Cancelled".equals(order.getStatus())) {
                List<OrderDetail> orderDetails = dao.getOrderDetailsByOrderID(order.getId());
                List<OrderDetailWithProduct> detailsWithProducts = new ArrayList<>();
                
                // Lấy thông tin sản phẩm cho mỗi order detail
                for (OrderDetail od : orderDetails) {
                    Product product = dao.getProductByID(od.getProductID());
                    if (product != null) {
                        detailsWithProducts.add(new OrderDetailWithProduct(od, product));
                    }
                }
                
                if (!detailsWithProducts.isEmpty()) {
                    orderList.add(new OrderWithDetails(order, detailsWithProducts));
                }
            }
        }
        
        request.setAttribute("orderList", orderList);
        request.getRequestDispatcher("UserPurchasedProducts.jsp").forward(request, response);
    }
    
    // Class để chứa thông tin đơn hàng kèm chi tiết sản phẩm
    public static class OrderWithDetails {
        private Order order;
        private List<OrderDetailWithProduct> details;
        
        public OrderWithDetails(Order order, List<OrderDetailWithProduct> details) {
            this.order = order;
            this.details = details;
        }
        
        public Order getOrder() { return order; }
        public List<OrderDetailWithProduct> getDetails() { return details; }
    }
    
    // Class để chứa OrderDetail kèm thông tin sản phẩm
    public static class OrderDetailWithProduct {
        private OrderDetail orderDetail;
        private Product product;
        
        public OrderDetailWithProduct(OrderDetail orderDetail, Product product) {
            this.orderDetail = orderDetail;
            this.product = product;
        }
        
        public OrderDetail getOrderDetail() { return orderDetail; }
        public Product getProduct() { return product; }
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

