package control;

import dao.DAO;
import entity.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AddToCartControl", urlPatterns = {"/addtocart"})
public class AddToCartControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("acc");
        
        PrintWriter out = response.getWriter();
        
        if (a == null) {
            out.print("{\"success\":false,\"message\":\"Vui lòng đăng nhập để thêm vào giỏ hàng\"}");
            return;
        }
        
        String pid = request.getParameter("pid");
        String qtyStr = request.getParameter("quantity");
        String amountStr = request.getParameter("amount");
        
        int amount = 1;
        // prefer quantity param (from form), fallback to amount (legacy)
        if (qtyStr != null && !qtyStr.isEmpty()) {
            try {
                amount = Integer.parseInt(qtyStr);
            } catch (NumberFormatException e) {
                amount = 1;
            }
        } else if (amountStr != null && !amountStr.isEmpty()) {
            try {
                amount = Integer.parseInt(amountStr);
            } catch (NumberFormatException e) {
                amount = 1;
            }
        }

        if (pid != null) {
            try {
                int productID = Integer.parseInt(pid);
                DAO dao = new DAO();
                // validate stock
                entity.Product prod = dao.getProductByID(productID);
                if (prod == null) {
                    out.print("{\"success\":false,\"message\":\"Sản phẩm không tồn tại\"}");
                    return;
                }
                int available = prod.getQuantity();
                if (available <= 0) {
                    out.print("{\"success\":false,\"message\":\"Sản phẩm đã hết hàng\"}");
                    return;
                }
                int currentInCart = dao.getCartAmount(a.getId(), productID);
                if (currentInCart + amount > available) {
                    out.print("{\"success\":false,\"message\":\"Số lượng thêm vượt quá kho. Kho hiện có: " + available + "\"}");
                    return;
                }

                dao.addToCart(a.getId(), productID, amount);
                out.print("{\"success\":true,\"message\":\"Đã thêm vào giỏ hàng thành công!\"}");
            } catch (NumberFormatException e) {
                out.print("{\"success\":false,\"message\":\"Lỗi: Sản phẩm không hợp lệ\"}");
            }
        } else {
            out.print("{\"success\":false,\"message\":\"Lỗi: Không tìm thấy sản phẩm\"}");
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

