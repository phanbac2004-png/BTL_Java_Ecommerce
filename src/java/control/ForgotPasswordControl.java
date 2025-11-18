/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import entity.Account;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author This PC
 */
@WebServlet(name = "ForgotPasswordControl", urlPatterns = {"/forgotpassword"})
public class ForgotPasswordControl extends HttpServlet {

    // Thông tin email - sử dụng cùng cấu hình với ContactServlet
    private static final String EMAIL_USERNAME = "hoangthaiduypl@gmail.com";
    private static final String EMAIL_PASSWORD = "hqyp kdnn ewpr dtjn"; // App password

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
        
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        
        DAO dao = new DAO();
        
        if (username == null || username.trim().isEmpty() || 
            email == null || email.trim().isEmpty()) {
            request.setAttribute("forgotMess", "Vui lòng điền đầy đủ thông tin");
            request.setAttribute("forgotMessType", "danger");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra username và email có khớp không
        Account account = dao.checkUsernameAndEmail(username.trim(), email.trim());
        
        if (account == null) {
            request.setAttribute("forgotMess", "Tên đăng nhập và email không khớp. Vui lòng kiểm tra lại!");
            request.setAttribute("forgotMessType", "danger");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }
        
        // Tạo mật khẩu mới ngẫu nhiên
        String newPassword = generateRandomPassword();
        
        // Cập nhật mật khẩu mới vào database
        dao.updatePassword(username.trim(), newPassword);
        
        // Gửi email chứa mật khẩu mới
        boolean emailSent = sendPasswordEmail(email.trim(), username.trim(), newPassword);
        
        if (emailSent) {
            request.setAttribute("forgotMess", "Mật khẩu mới đã được gửi đến email của bạn. Vui lòng kiểm tra hộp thư!");
            request.setAttribute("forgotMessType", "success");
        } else {
            request.setAttribute("forgotMess", "Đã tạo mật khẩu mới nhưng không thể gửi email. Vui lòng liên hệ admin!");
            request.setAttribute("forgotMessType", "warning");
        }
        
        request.getRequestDispatcher("Login.jsp").forward(request, response);
    }
    
    private String generateRandomPassword() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder();
        
        // Tạo mật khẩu 8 ký tự
        for (int i = 0; i < 8; i++) {
            password.append(chars.charAt(random.nextInt(chars.length())));
        }
        
        return password.toString();
    }
    
    private boolean sendPasswordEmail(String toEmail, String username, String newPassword) {
        try {
            // Setup mail server properties
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");
            
            // Create session with authentication
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
                }
            });
            
            // Create email message
            Message emailMessage = new MimeMessage(session);
            emailMessage.setFrom(new InternetAddress(EMAIL_USERNAME, "KIDDY Shop"));
            emailMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            emailMessage.setSubject("[KIDDY SHOP] Mật khẩu mới của bạn");
            
            // Create email content
            String emailContent = createPasswordEmailContent(username, newPassword);
            emailMessage.setContent(emailContent, "text/html; charset=utf-8");
            
            // Send email
            Transport.send(emailMessage);
            return true;
            
        } catch (Exception e) {
            System.err.println("Failed to send password email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    private String createPasswordEmailContent(String username, String newPassword) {
        return "<!DOCTYPE html>" +
               "<html>" +
               "<head>" +
               "    <meta charset=\"UTF-8\">" +
               "    <style>" +
               "        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; margin: 0; padding: 0; }" +
               "        .container { max-width: 600px; margin: 0 auto; background: #ffffff; }" +
               "        .header { background: linear-gradient(135deg, #a366d1 0%, #9b59b6 100%); color: white; padding: 30px 20px; text-align: center; }" +
               "        .header h1 { margin: 0; font-size: 24px; }" +
               "        .content { padding: 30px; background: #f9f9f9; }" +
               "        .password-box { background: white; padding: 20px; border: 2px solid #a366d1; border-radius: 8px; margin: 20px 0; text-align: center; }" +
               "        .password-box .password { font-size: 28px; font-weight: bold; color: #9b59b6; letter-spacing: 3px; padding: 15px; background: #f5f5f5; border-radius: 5px; }" +
               "        .warning { background: #fff3cd; border-left: 4px solid #ffc107; padding: 15px; margin: 20px 0; border-radius: 4px; }" +
               "        .footer { text-align: center; margin-top: 30px; padding: 20px; background: #eee; color: #666; font-size: 12px; }" +
               "    </style>" +
               "</head>" +
               "<body>" +
               "    <div class=\"container\">" +
               "        <div class=\"header\">" +
               "            <h1>🔐 Mật khẩu mới</h1>" +
               "            <p>KIDDY Shop - Khôi phục mật khẩu</p>" +
               "        </div>" +
               "        <div class=\"content\">" +
               "            <p>Xin chào <strong>" + username + "</strong>,</p>" +
               "            <p>Chúng tôi đã nhận được yêu cầu khôi phục mật khẩu của bạn.</p>" +
               "            <p>Mật khẩu mới của bạn là:</p>" +
               "            <div class=\"password-box\">" +
               "                <div class=\"password\">" + newPassword + "</div>" +
               "            </div>" +
               "            <div class=\"warning\">" +
               "                <strong>⚠️ Lưu ý quan trọng:</strong><br>" +
               "                - Vui lòng đăng nhập bằng mật khẩu mới này<br>" +
               "                - Sau khi đăng nhập, bạn sẽ được yêu cầu đổi mật khẩu thành mật khẩu mới theo ý bạn<br>" +
               "                - Vui lòng không chia sẻ mật khẩu này với bất kỳ ai" +
               "            </div>" +
               "            <p>Nếu bạn không yêu cầu khôi phục mật khẩu, vui lòng bỏ qua email này.</p>" +
               "        </div>" +
               "        <div class=\"footer\">" +
               "            <p>© 2024 KIDDY Shop. Tất cả quyền được bảo lưu.</p>" +
               "            <p>Email này được gửi tự động, vui lòng không trả lời.</p>" +
               "        </div>" +
               "    </div>" +
               "</body>" +
               "</html>";
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
        // Redirect to login page
        response.sendRedirect("Login.jsp");
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
        return "Forgot Password Servlet";
    }// </editor-fold>

}

