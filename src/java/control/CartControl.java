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

@WebServlet(name = "CartControl", urlPatterns = { "/cart" })
public class CartControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("acc");

        if (a == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        DAO dao = new DAO();
        List<Cart> list = dao.getCartByAccountID(a.getId());

        double total = 0;
        for (Cart c : list) {
            total += c.getTotalPrice();
        }

        request.setAttribute("list", list);
        request.setAttribute("total", total);
        request.getRequestDispatcher("Cart.jsp").forward(request, response);
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
