/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import entity.Account;
import service.AccountService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author This PC
 */
@WebServlet(name = "ChangePasswordControl", urlPatterns = {"/changepassword"})
public class ChangePasswordControl extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("acc");
        
        // Kiểm tra đăng nhập
        if (account == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Kiểm tra các trường bắt buộc
        if (currentPassword == null || currentPassword.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            session.setAttribute("changePasswordMess", "Vui lòng điền đầy đủ thông tin");
            session.setAttribute("changePasswordMessType", "danger");
            response.sendRedirect("home");
            return;
        }
        
        // Kiểm tra mật khẩu mới và xác nhận có khớp không
        if (!newPassword.equals(confirmPassword)) {
            session.setAttribute("changePasswordMess", "Mật khẩu mới và xác nhận mật khẩu không khớp");
            session.setAttribute("changePasswordMessType", "danger");
            response.sendRedirect("home");
            return;
        }
        
        // Kiểm tra độ dài mật khẩu mới
        if (newPassword.length() < 6) {
            session.setAttribute("changePasswordMess", "Mật khẩu mới phải có ít nhất 6 ký tự");
            session.setAttribute("changePasswordMessType", "danger");
            response.sendRedirect("home");
            return;
        }
        
        AccountService accountService = new AccountService();
        
        // Kiểm tra mật khẩu hiện tại có đúng không
        Account checkAccount = accountService.login(account.getUser(), currentPassword);
        if (checkAccount == null) {
            session.setAttribute("changePasswordMess", "Mật khẩu hiện tại không đúng");
            session.setAttribute("changePasswordMessType", "danger");
            response.sendRedirect("home");
            return;
        }
        
        // Cập nhật mật khẩu mới
        accountService.changePasswordById(account.getId(), newPassword);
        
        // Xóa flag yêu cầu đổi mật khẩu
        session.removeAttribute("requirePasswordChange");
        
        // No need to update account password in session since it's now hashed
        // The hashed password is already updated in the database
        
        session.setAttribute("changePasswordMess", "Đổi mật khẩu thành công!");
        session.setAttribute("changePasswordMessType", "success");
        
        response.sendRedirect("home");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws IOException if an I/O error occurs
     * @throws ServletException if a servlet-specific error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Change Password Servlet";
    }// </editor-fold>

}

