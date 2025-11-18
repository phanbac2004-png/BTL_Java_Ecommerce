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

@WebServlet(name = "UpdateCartControl", urlPatterns = {"/updatecart"})
public class UpdateCartControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("acc");
        
        if (a == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        String pid = request.getParameter("pid");
        String variantParam = request.getParameter("variant");
        String amountStr = request.getParameter("amount");
        
        if ((variantParam != null || pid != null) && amountStr != null) {
            try {
                int amount = Integer.parseInt(amountStr);
                DAO dao = new DAO();
                if (amount <= 0) {
                    // delete by variant if provided, otherwise by product
                    if (variantParam != null) {
                        int variantID = Integer.parseInt(variantParam);
                        dao.deleteCartVariant(a.getId(), variantID);
                    } else {
                        int productID = Integer.parseInt(pid);
                        dao.deleteCart(a.getId(), productID);
                    }
                } else {
                    if (variantParam != null) {
                        int variantID = Integer.parseInt(variantParam);
                        // Validate against variant stock
                        entity.ProductVariant pv = dao.getVariantById(variantID);
                        if (pv == null) {
                            dao.deleteCartVariant(a.getId(), variantID);
                        } else {
                            int available = pv.getQuantity();
                            if (amount > available) {
                                HttpSession s = request.getSession();
                                s.setAttribute("errorMessage", "Không thể cập nhật: số lượng yêu cầu vượt quá kho (" + available + ")");
                                response.sendRedirect("cart");
                                return;
                            }
                            dao.updateCartVariant(a.getId(), variantID, amount);
                        }
                    } else {
                        int productID = Integer.parseInt(pid);
                        entity.Product prod = dao.getProductByID(productID);
                        if (prod == null) {
                            dao.deleteCart(a.getId(), productID);
                        } else {
                            int available = prod.getQuantity();
                            if (amount > available) {
                                HttpSession s = request.getSession();
                                s.setAttribute("errorMessage", "Không thể cập nhật: số lượng yêu cầu vượt quá kho (" + available + ")");
                                response.sendRedirect("cart");
                                return;
                            }
                            dao.updateCart(a.getId(), productID, amount);
                        }
                    }
                }
            } catch (NumberFormatException e) {
                // Lỗi format số
            }
        }
        
        response.sendRedirect("cart");
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

