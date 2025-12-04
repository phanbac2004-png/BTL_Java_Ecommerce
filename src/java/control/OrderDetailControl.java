package control;

import dao.DAO;
import entity.Account;
import entity.Order;
import entity.OrderDetail;
import entity.Product;
import entity.ProductVariant;
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
                // Lấy chi tiết đơn hàng
                List<OrderDetail> listOD = dao.getOrderDetailsByOrderID(orderID);
                
                // Lấy thông tin đơn hàng trực tiếp (bao gồm paymentMethod nếu có)
                Order order = dao.getOrderById(orderID);
                
                // Với mỗi chi tiết đơn hàng, cố gắng ánh xạ về product và variant tương ứng
                List<Product> listProducts = new ArrayList<>();
                List<ProductVariant> listVariants = new ArrayList<>();
                for (OrderDetail od : listOD) {
                    Product p = dao.getProductByID(od.getProductID());
                    ProductVariant pv = null;
                    if (p == null) {
                        // Trường hợp schema lưu variant_id ở cột productID của orderdetails (legacy)
                        pv = dao.getVariantById(od.getProductID());
                        if (pv != null) {
                            String cName = dao.getColorNameById(pv.getColorId());
                            String sName = dao.getSizeNameById(pv.getSizeId());
                            try { pv.setColorName(cName); } catch (Exception ignore) {}
                            try { pv.setSizeName(sName); } catch (Exception ignore) {}
                            p = dao.getProductByID(pv.getProductId());
                        }
                    } else {
                        // Nếu lấy được product theo id, thử suy ra variant theo tồn tại trong orderdetails nếu có cột variant_id
                        // Không có thông tin color/size trong OrderDetail, để trống pv
                    }
                    if (p != null) {
                        listProducts.add(p);
                        listVariants.add(pv); // có thể null, JSP sẽ xử lí gracefully
                    }
                }
                
                request.setAttribute("listOD", listOD);
                request.setAttribute("listProducts", listProducts);
                request.setAttribute("listVariants", listVariants);
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

