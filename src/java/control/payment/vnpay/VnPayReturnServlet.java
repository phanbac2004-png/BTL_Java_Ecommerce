package control.payment.vnpay;

import dao.DAO;
import entity.Order;
import entity.OrderDetail;
import entity.Product;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "VnPayReturnServlet", urlPatterns = {"/vnpay_return"})
public class VnPayReturnServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleReturn(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleReturn(request, response);
    }

    private void handleReturn(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        Map<String, String> fields = new HashMap<>();
        for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements();) {
            String rawName = params.nextElement();
            String encodedName = URLEncoder.encode(rawName, StandardCharsets.US_ASCII.toString());
            String rawValue = request.getParameter(rawName);
            String encodedValue = rawValue != null ? URLEncoder.encode(rawValue, StandardCharsets.US_ASCII.toString()) : null;
            if (encodedValue != null && !encodedValue.isEmpty()) {
                fields.put(encodedName, encodedValue);
            }
        }

        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        if (fields.containsKey("vnp_SecureHashType")) {
            fields.remove(URLEncoder.encode("vnp_SecureHashType", StandardCharsets.US_ASCII));
        }
        if (fields.containsKey("vnp_SecureHash")) {
            fields.remove(URLEncoder.encode("vnp_SecureHash", StandardCharsets.US_ASCII));
        }
        String signValue = Config.hashAllFields(fields);

        // Extract params
        String vnp_TxnRef = request.getParameter("vnp_TxnRef");
        String vnp_Amount = request.getParameter("vnp_Amount");
        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        String vnp_OrderInfo = request.getParameter("vnp_OrderInfo");
        String vnp_TransactionNo = request.getParameter("vnp_TransactionNo");
        String vnp_BankCode = request.getParameter("vnp_BankCode");
        String vnp_PayDate = request.getParameter("vnp_PayDate");
        String vnp_TransactionStatusParam = request.getParameter("vnp_TransactionStatus");

        boolean signatureValid = signValue != null && vnp_SecureHash != null && signValue.equalsIgnoreCase(vnp_SecureHash);
        boolean responseOk = "00".equals(vnp_ResponseCode);
        boolean txnStatusOk = "00".equals(vnp_TransactionStatusParam);
        boolean txnSuccess = signatureValid && (responseOk || txnStatusOk);
        String vnp_TransactionStatusText = !signatureValid ? "invalid signature" : (txnSuccess ? "Thành công" : "Không thành công");

        // Format amount (VNPay sends amount in minor units *100)
        String amountDisplay = null;
        try {
            long minor = Long.parseLong(vnp_Amount != null ? vnp_Amount : "0");
            long majorInt = minor / 100;
            long cents = Math.abs(minor % 100);
            amountDisplay = String.format("%d.%02d", majorInt, cents);
        } catch (NumberFormatException ignored) { amountDisplay = vnp_Amount; }

        // Server-side order check + prepare data for OrderSuccess.jsp
        DAO dao = new DAO();
        Order order = null;
        boolean orderExists = false;
        boolean orderPaid = false;
        boolean updatedByReturn = false;
        Integer orderId = null;
        try {
            if (vnp_TxnRef != null) {
                orderId = Integer.valueOf(vnp_TxnRef);
                // No direct getById in DAO: iterate all orders to find match
                List<Order> all = dao.getAllOrders();
                for (Order o : all) {
                    if (o.getId() == orderId) {
                        order = o;
                        break;
                    }
                }
                if (order != null) {
                    orderExists = true;
                    String status = order.getStatus();
                    orderPaid = "Processing".equalsIgnoreCase(status) || "Shipped".equalsIgnoreCase(status) || "Delivered".equalsIgnoreCase(status) || "Completed".equalsIgnoreCase(status);
                    if (txnSuccess && !orderPaid) {
                        dao.updateOrderStatus(orderId, "Processing");
                        updatedByReturn = true;
                        orderPaid = true;
                        // reload order
                        List<Order> all2 = dao.getAllOrders();
                        for (Order o2 : all2) if (o2.getId() == orderId) { order = o2; break; }

                        // Now that payment is confirmed, clear the buyer's cart
                        try {
                            if (order != null) {
                                dao.clearCart(order.getAccountID());
                            }
                        } catch (Exception ignore) {
                            // Clearing the cart is best-effort; don't fail the return handling if it errors
                        }
                    }
                }
            }
        } catch (Exception ignored) {}

        // Prepare order detail list, product list and variants list for JSP (if available)
        List<OrderDetail> listOD = new ArrayList<>();
        List<Product> listProducts = new ArrayList<>();
        List<entity.ProductVariant> listVariants = new ArrayList<>();
        if (orderExists && orderId != null) {
            listOD = dao.getOrderDetailsByOrderID(orderId);
            for (OrderDetail od : listOD) {
                // In current schema, OrderDetail.productID actually stores variant_id
                int maybeVariantId = od.getProductID();
                entity.ProductVariant pv = null;
                Product p = null;

                try { pv = dao.getVariantById(maybeVariantId); } catch (Exception ignore) {}
                if (pv != null) {
                    // Enrich variant with color/size names
                    try { pv.setColorName(dao.getColorNameById(pv.getColorId())); } catch (Exception ignore) {}
                    try { pv.setSizeName(dao.getSizeNameById(pv.getSizeId())); } catch (Exception ignore) {}
                    // Resolve product from variant
                    p = dao.getProductByID(pv.getProductId());
                } else {
                    // Fallback: treat stored value as product ID (legacy deployments)
                    p = dao.getProductByID(maybeVariantId);
                }

                if (p == null) {
                    p = new Product(0, "(unknown)", "", 0, "", "", 0);
                }
                listProducts.add(p);
                listVariants.add(pv); // may be null, JSP guards for null
            }
        }

        // Set attributes for JSP
        request.setAttribute("vnp_TxnRef", vnp_TxnRef);
        request.setAttribute("vnp_Amount", vnp_Amount);
        request.setAttribute("amountDisplay", amountDisplay);
        request.setAttribute("vnp_ResponseCode", vnp_ResponseCode);
        request.setAttribute("vnp_OrderInfo", vnp_OrderInfo);
        request.setAttribute("vnp_TransactionNo", vnp_TransactionNo);
        request.setAttribute("vnp_BankCode", vnp_BankCode);
        request.setAttribute("vnp_PayDate", vnp_PayDate);
        request.setAttribute("vnp_TransactionStatus", vnp_TransactionStatusText);
        request.setAttribute("signatureValid", signatureValid);
        request.setAttribute("computedHash", signValue);

        request.setAttribute("orderId", orderId);
        request.setAttribute("orderExists", orderExists);
        request.setAttribute("order", order);
        request.setAttribute("orderPaid", orderPaid);
        request.setAttribute("updatedByReturn", updatedByReturn);
        request.setAttribute("listOD", listOD);
        request.setAttribute("listProducts", listProducts);
        request.setAttribute("listVariants", listVariants);

        // Forward to order success page which will display order and details
        try {
            request.getRequestDispatcher("OrderSuccess.jsp").forward(request, response);
        } catch (Exception ex) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
