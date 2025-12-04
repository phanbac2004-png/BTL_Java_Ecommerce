package control;

import entity.Account;
import service.AdminService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdminDashboardControl", urlPatterns = {"/admindashboard"})
public class AdminDashboardControl extends HttpServlet {

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
        
        String page = request.getParameter("page");
        if (page == null || page.isEmpty()) {
            page = "dashboard";
        }
        
        AdminService adminService = new AdminService();
        String contentPage = "";
        
        switch (page) {
            case "dashboard":
                // Load dashboard statistics
                int newOrdersCount = adminService.getNewOrdersCount();
                double monthlyRevenue = adminService.getMonthlyRevenue();
                int totalProducts = adminService.getTotalProductsCount();
                int totalCustomers = adminService.getTotalCustomersCount();
                
                request.setAttribute("newOrdersCount", newOrdersCount);
                request.setAttribute("monthlyRevenue", monthlyRevenue);
                request.setAttribute("totalProducts", totalProducts);
                request.setAttribute("totalCustomers", totalCustomers);
                
                contentPage = "AdminDashboardMain.jsp";
                break;
                
            case "products":
                // Forward to Manager with layout
                request.getRequestDispatcher("manager?fromAdmin=true").forward(request, response);
                return;
                
            case "categories":
                // Forward to AdminCategories with layout
                request.getRequestDispatcher("admincategories").forward(request, response);
                return;
                
            case "orders":
                // Forward to AdminOrders with layout
                request.getRequestDispatcher("adminorders").forward(request, response);
                return;
                
            case "customers":
                // Forward to AdminUsers with layout
                request.getRequestDispatcher("adminusers").forward(request, response);
                return;
                
            case "soldproducts":
                // Forward to AdminSoldProducts with layout
                request.getRequestDispatcher("adminsoldproducts").forward(request, response);
                return;
                
            case "reports":
                // Forward to AdminRevenue with layout
                request.getRequestDispatcher("adminrevenue").forward(request, response);
                return;
                
            default:
                contentPage = "AdminDashboardMain.jsp";
                break;
        }
        
        request.setAttribute("contentPage", contentPage);
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
