package control;

import dao.DAO;
import entity.Account;
import entity.Order;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdminRevenueControl", urlPatterns = {"/adminrevenue"})
public class AdminRevenueControl extends HttpServlet {

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
        
        // Lấy period từ request (day, week, month, year)
        String period = request.getParameter("period");
        
        // Lấy ngày hiện tại làm mặc định
        LocalDate today = LocalDate.now();
        
        // Lấy ngày/tháng/năm cụ thể từ request, nếu không có thì dùng ngày hôm nay
        String dayParam = request.getParameter("day");
        String monthParam = request.getParameter("month");
        String yearParam = request.getParameter("year");
        
        String day, month, year;
        
        // Nếu không có giá trị từ request, dùng ngày hôm nay
        if (dayParam == null || dayParam.isEmpty()) {
            day = String.valueOf(today.getDayOfMonth());
        } else {
            day = dayParam;
        }
        if (monthParam == null || monthParam.isEmpty()) {
            month = String.valueOf(today.getMonthValue());
        } else {
            month = monthParam;
        }
        if (yearParam == null || yearParam.isEmpty()) {
            year = String.valueOf(today.getYear());
        } else {
            year = yearParam;
        }
        
        // Lấy doanh thu theo các khoảng thời gian
        double totalRevenue = dao.getTotalRevenue();
        double revenueToday;
        double revenueThisWeek;
        double revenueThisMonth;
        double revenueThisYear;
        double customRevenue = 0;
        
        // Kiểm tra xem có ngày được chọn từ form không
        boolean hasSelectedDate = (dayParam != null && !dayParam.isEmpty() && 
                                  monthParam != null && !monthParam.isEmpty() && 
                                  yearParam != null && !yearParam.isEmpty());
        
        if (hasSelectedDate) {
            // Nếu có ngày được chọn từ form, tính doanh thu theo ngày đó
            try {
                int y = Integer.parseInt(year);
                int m = Integer.parseInt(month);
                int d = Integer.parseInt(day);
                
                // Tính doanh thu theo ngày/tháng/năm được chọn
                revenueToday = dao.getRevenueBySelectedDate(y, m, d);
                revenueThisWeek = dao.getRevenueBySelectedWeek(y, m, d);
                revenueThisMonth = dao.getRevenueBySelectedMonth(y, m, d);
                revenueThisYear = dao.getRevenueBySelectedYear(y, m, d);
                customRevenue = revenueToday; // Doanh thu custom là doanh thu của ngày được chọn
                
            } catch (NumberFormatException e) {
                // Nếu parse lỗi, dùng ngày hiện tại
                revenueToday = dao.getRevenueToday();
                revenueThisWeek = dao.getRevenueThisWeek();
                revenueThisMonth = dao.getRevenueThisMonth();
                revenueThisYear = dao.getRevenueThisYear();
            }
        } else {
            // Nếu không có ngày được chọn, dùng ngày hiện tại
            revenueToday = dao.getRevenueToday();
            revenueThisWeek = dao.getRevenueThisWeek();
            revenueThisMonth = dao.getRevenueThisMonth();
            revenueThisYear = dao.getRevenueThisYear();
        }
        
        // Lấy danh sách đơn hàng theo period hoặc ngày/tháng/năm cụ thể
        List<Order> listOrders;
        
        if (hasSelectedDate) {
            // Có ngày/tháng/năm cụ thể
            try {
                int y = Integer.parseInt(year);
                int m = Integer.parseInt(month);
                int d = Integer.parseInt(day);
                listOrders = dao.getOrdersByDate(y, m, d);
            } catch (NumberFormatException e) {
                listOrders = dao.getAllOrders();
            }
        } else if (period != null && !period.isEmpty()) {
            listOrders = dao.getOrdersByPeriod(period);
        } else {
            listOrders = dao.getAllOrders();
        }
        
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("revenueToday", revenueToday);
        request.setAttribute("revenueThisWeek", revenueThisWeek);
        request.setAttribute("revenueThisMonth", revenueThisMonth);
        request.setAttribute("revenueThisYear", revenueThisYear);
        request.setAttribute("customRevenue", customRevenue);
        request.setAttribute("listOrders", listOrders);
        request.setAttribute("selectedPeriod", period != null ? period : "");
        request.setAttribute("selectedDay", day != null ? day : "");
        request.setAttribute("selectedMonth", month != null ? month : "");
        request.setAttribute("selectedYear", year != null ? year : "");
        request.setAttribute("contentPage", "AdminRevenueContent.jsp");
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