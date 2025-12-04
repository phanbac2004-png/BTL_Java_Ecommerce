package control;

import dao.DAO;
import entity.Account;
import entity.Cart;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CheckoutControl", urlPatterns = { "/checkout", "/buy" })
public class CheckoutControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("acc");

        if (a == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        DAO dao = new DAO();
        List<Cart> list = dao.getCartByAccountID(a.getId());

        if (list.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        // Tính tổng tiền
        long totalPrice = 0;
        for (Cart c : list) {
            totalPrice += c.getTotalPrice();
        }

        // Nếu là GET request, hiển thị form nhập thông tin
        if ("GET".equals(request.getMethod())) {
            request.setAttribute("list", list);
            request.setAttribute("total", totalPrice);
            request.getRequestDispatcher("Checkout.jsp").forward(request, response);
            return;
        }

        // Nếu là POST request, xử lý đặt hàng
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("paymentMethod");

        if (phone == null || phone.trim().isEmpty() ||
                address == null || address.trim().isEmpty()) {
            // Thiếu thông tin, quay lại form
            request.setAttribute("list", list);
            request.setAttribute("total", totalPrice);
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            request.getRequestDispatcher("Checkout.jsp").forward(request, response);
            return;
        }

        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            paymentMethod = "cod"; // Mặc định là COD
        }

        // Tạo đơn hàng với thông tin giao hàng - Phân biệt theo phương thức thanh toán
        String orderStatus;
        if ("vnpay".equals(paymentMethod)) {
            // VNPay: tạo đơn ở trạng thái chờ thanh toán (sẽ cập nhật khi VNPay trả về)
            orderStatus = "Pending";
        } else {
            // COD = chưa thanh toán = Processing (đang xử lí)
            orderStatus = "Processing";
        }
        int orderID = dao.createOrder(a.getId(), phone.trim(), address.trim(), totalPrice, orderStatus, paymentMethod);

        if (orderID > 0) {
            // First: verify stock for all items (variant-aware)
            for (Cart c : list) {
                if (c.getVariant() != null) {
                    int available = c.getVariant().getQuantity();
                    if (available < c.getAmount()) {
                        HttpSession s = request.getSession();
                        s.setAttribute("errorMessage",
                                "Không thể đặt hàng vì một hoặc nhiều sản phẩm không đủ số lượng trong kho.");
                        response.sendRedirect("cart");
                        return;
                    }
                } else {
                    entity.Product p = dao.getProductByID(c.getProduct().getId());
                    if (p == null || p.getQuantity() < c.getAmount()) {
                        HttpSession s = request.getSession();
                        s.setAttribute("errorMessage",
                                "Không thể đặt hàng vì một hoặc nhiều sản phẩm không đủ số lượng trong kho.");
                        response.sendRedirect("cart");
                        return;
                    }
                }
            }

            // Second: decrement stock for all items (best-effort; consider DB transaction
            // for production)
            for (Cart c : list) {
                if (c.getVariant() != null) {
                    int variantId = c.getVariant().getVariantId();
                    int newQty = c.getVariant().getQuantity() - c.getAmount();
                    if (newQty < 0)
                        newQty = 0;
                    dao.updateVariantQuantity(variantId, newQty);
                } else {
                    int pid = c.getProduct().getId();
                    entity.Product p = dao.getProductByID(pid);
                    int newQty = p.getQuantity() - c.getAmount();
                    if (newQty < 0)
                        newQty = 0;
                    dao.updateQuantity(pid, newQty);
                }
            }

            // Create order details (variant-aware)
            for (Cart c : list) {
                if (c.getVariant() != null) {
                    dao.createOrderDetailVariant(orderID, c.getVariant().getVariantId(), c.getAmount(),
                            c.getProduct().getPrice());
                } else {
                    // legacy: write order detail with NULL variant_id
                    dao.createOrderDetail(orderID, c.getProduct().getId(), c.getAmount(), c.getProduct().getPrice());
                }
            }

            // Nếu chọn VNPay, không xóa giỏ hàng ngay (giữ đến khi VNPay trả về thành công)
            if ("vnpay".equals(paymentMethod)) {
                // Redirect with query params; VnPayGatewayServlet supports GET and POST
                String redirectUrl = "vnpay_gateway?orderId=" + orderID + "&totalAmount=" + totalPrice;
                response.sendRedirect(redirectUrl);
                return;
            } else {
                // Non-VNPay: clear cart and redirect to order confirmation
                dao.clearCart(a.getId());
                response.sendRedirect("order?oid=" + orderID);
            }
        } else {
            response.sendRedirect("cart");
        }
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
