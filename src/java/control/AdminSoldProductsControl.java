package control;

import dao.DAO;
// Removed SoldProductInfo import; using variant-level SoldVariantInfo instead.
import entity.Account;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdminSoldProductsControl", urlPatterns = {"/adminsoldproducts"})
public class AdminSoldProductsControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("acc");
        
        // Kiểm tra admin
        if (a == null || a.getIsAdmin() != 1) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        DAO dao = new DAO();
        // Date range filter: today, yesterday, last7, thisMonth, lastMonth
        String range = request.getParameter("range");
        if (range == null || range.isEmpty()) {
            range = "last7"; // default to last 7 days
        }

        List<DAO.SoldVariantInfo> list = dao.getSoldProductVariantsByRange(range);
        request.setAttribute("list", list);
        request.setAttribute("range", range);
        request.setAttribute("contentPage", "AdminSoldProductsContent.jsp");
        request.getRequestDispatcher("AdminDashboardLayout.jsp").forward(request, response);
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

