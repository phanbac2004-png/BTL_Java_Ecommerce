package control.payment.vnpay;

import dao.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "VnPayIpnServlet", urlPatterns = {"/vnpay_ipn"})
public class VnPayIpnServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleIpn(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Some VNPay setups may call IPN via GET
        handleIpn(request, response);
    }

    private void handleIpn(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
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
            if (fields.containsKey("vnp_SecureHashType")) 
            {
                fields.remove(URLEncoder.encode("vnp_SecureHashType", StandardCharsets.US_ASCII));
            }
            if (fields.containsKey("vnp_SecureHash")) 
            {
                fields.remove(URLEncoder.encode("vnp_SecureHash", StandardCharsets.US_ASCII));
            }
            String signValue = Config.hashAllFields(fields);

            boolean signatureValid = signValue != null && vnp_SecureHash != null && signValue.equalsIgnoreCase(vnp_SecureHash);
            if (!signatureValid) {
                out.print("{\"RspCode\":\"97\",\"Message\":\"Invalid signature\"}");
                return;
            }

            String vnp_TxnRef = request.getParameter("vnp_TxnRef");
            String vnp_TransactionStatus = request.getParameter("vnp_TransactionStatus");
            String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");

            int orderId;
            try {
                orderId = Integer.parseInt(vnp_TxnRef);
            } catch (Exception ex) {
                out.print("{\"RspCode\":\"01\",\"Message\":\"Invalid order reference\"}");
                return;
            }

            boolean success = "00".equals(vnp_TransactionStatus) || "00".equals(vnp_ResponseCode);

            DAO dao = new DAO();
            entity.Order order = null;
            try {
                order = dao.getOrderById(orderId);
            } catch (Exception ignore) {}

            if (order == null) {
                out.print("{\"RspCode\":\"02\",\"Message\":\"Order not found\"}");
                return;
            }

            try {
                if (success) {
                    // Idempotency: if already paid/processed, acknowledge success
                    String st = order.getStatus() != null ? order.getStatus() : "";
                    boolean alreadyPaid = "Processing".equalsIgnoreCase(st) || "Shipped".equalsIgnoreCase(st)
                            || "Delivered".equalsIgnoreCase(st) || "Completed".equalsIgnoreCase(st);
                    if (!alreadyPaid) {
                        dao.updateOrderStatus(orderId, "Processing");
                        try { dao.clearCart(order.getAccountID()); } catch (Exception ignore) {}
                    }
                    out.print("{\"RspCode\":\"00\",\"Message\":\"Confirm Success\"}");
                } else {
                    dao.updateOrderStatus(orderId, "Cancelled");
                    out.print("{\"RspCode\":\"01\",\"Message\":\"Confirm Failed\"}");
                }
            } catch (Exception e) {
                out.print("{\"RspCode\":\"03\",\"Message\":\"Update error\"}");
            }
        }
    }
}
