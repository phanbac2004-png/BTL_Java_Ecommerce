/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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

/**
 *
 * @author This PC
 */
@WebServlet(name = "SignUpControl", urlPatterns = {"/signup"})
public class SignUpControl extends HttpServlet {

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
        String user = request.getParameter("user");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        String re_pass = request.getParameter("repass");
        String agreeTerms = request.getParameter("agreeTerms");
        
        // Kiểm tra đồng ý điều khoản
        if (agreeTerms == null || !agreeTerms.equals("on")) {
            request.setAttribute("thongbao", "Vui lòng đồng ý với các điều khoản và điều kiện!");
            request.setAttribute("username", user);
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra password
        if (!pass.equals(re_pass)) {
            request.setAttribute("thongbao", "Mật khẩu nhập lại không khớp!");
            request.setAttribute("username", user);
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra phone và email
        if (phone == null || phone.trim().isEmpty()) {
            request.setAttribute("thongbao", "Vui lòng nhập số điện thoại!");
            request.setAttribute("username", user);
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }
        
        if (email == null || email.trim().isEmpty() || !email.contains("@")) {
            request.setAttribute("thongbao", "Vui lòng nhập email hợp lệ!");
            request.setAttribute("username", user);
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }
        
        DAO dao = new DAO();
        
        // Kiểm tra tên người dùng đã tồn tại
        Account a = dao.checkAccountExist(user);
        if (a != null) {
            request.setAttribute("thongbao", "Tên người dùng đã tồn tại!");
            request.setAttribute("username", user);
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra email đã tồn tại
        Account emailAccount = dao.checkEmailExist(email);
        if (emailAccount != null) {
            request.setAttribute("thongbao", "Email này đã được sử dụng!");
            request.setAttribute("username", user);
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra số điện thoại đã tồn tại
        Account phoneAccount = dao.checkPhoneExist(phone);
        if (phoneAccount != null) {
            request.setAttribute("thongbao", "Số điện thoại này đã được sử dụng!");
            request.setAttribute("username", user);
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }
        
        // Tất cả đều hợp lệ, tạo tài khoản
        dao.signup(user, phone, email, pass);
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
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
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
        return "Short description";
    }// </editor-fold>

}
