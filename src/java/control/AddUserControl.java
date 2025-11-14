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

@WebServlet(name = "AddUserControl", urlPatterns = {"/adduser"})
public class AddUserControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("acc");
        
        if (a == null || a.getIsAdmin() != 1) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        String user = request.getParameter("user");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        String isSell = request.getParameter("isSell");
        String role = request.getParameter("role");
        String isAdmin = request.getParameter("isAdmin");
        
        // Nếu có role thì dùng role, không thì dùng isAdmin
        if (role != null && !role.isEmpty()) {
            isAdmin = role.equals("admin") ? "1" : "0";
            // Nếu Role = User thì isSell phải = 0
            if (role.equals("user")) {
                isSell = null; // Để set isSell = 0 ở dưới
            }
        }
        
        if (user == null || user.trim().isEmpty() || 
            phone == null || phone.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            pass == null || pass.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            DAO dao = new DAO();
            request.setAttribute("list", dao.getAllAccounts());
            request.getRequestDispatcher("AdminUsers.jsp").forward(request, response);
            return;
        }
        
        DAO dao = new DAO();
        
        // Kiểm tra user đã tồn tại
        Account existingUser = dao.checkAccountExist(user);
        if (existingUser != null) {
            request.setAttribute("error", "Tên người dùng đã tồn tại!");
            request.setAttribute("list", dao.getAllAccounts());
            request.getRequestDispatcher("AdminUsers.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra email đã tồn tại
        Account existingEmail = dao.checkEmailExist(email);
        if (existingEmail != null) {
            request.setAttribute("error", "Email đã được sử dụng!");
            request.setAttribute("list", dao.getAllAccounts());
            request.getRequestDispatcher("AdminUsers.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra phone đã tồn tại
        Account existingPhone = dao.checkPhoneExist(phone);
        if (existingPhone != null) {
            request.setAttribute("error", "Số điện thoại đã được sử dụng!");
            request.setAttribute("list", dao.getAllAccounts());
            request.getRequestDispatcher("AdminUsers.jsp").forward(request, response);
            return;
        }
        
        // Nếu Role = User thì isSell phải = 0
        // Nếu Role = Admin thì isSell có thể = 1 (mặc định checked)
        int admin = (isAdmin != null && isAdmin.equals("1")) ? 1 : 0;
        int sell;
        if (admin == 0) {
            // Role = User → isSell = 0
            sell = 0;
        } else {
            // Role = Admin → isSell theo checkbox (mặc định checked = 1)
            sell = (isSell != null && isSell.equals("on")) ? 1 : 1; // Mặc định là 1 cho admin
        }
        
        dao.addUserByAdmin(user, phone, email, pass, sell, admin);
        response.sendRedirect("adminusers");
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
