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

@WebServlet(name = "DeleteCartControl", urlPatterns = {"/deletecart"})
public class DeleteCartControl extends HttpServlet {

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

        if (variantParam != null) {
            try {
                int variantID = Integer.parseInt(variantParam);
                DAO dao = new DAO();
                dao.deleteCartVariant(a.getId(), variantID);
            } catch (NumberFormatException e) {
                // Lỗi format số
            }
        } else if (pid != null) {
            try {
                int productID = Integer.parseInt(pid);
                DAO dao = new DAO();
                dao.deleteCart(a.getId(), productID);
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

