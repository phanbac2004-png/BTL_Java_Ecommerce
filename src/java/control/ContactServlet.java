package control;

import java.io.*;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Thông tin email - cần cấu hình
    private static final String EMAIL_USERNAME = "hoangthaiduypl@gmail.com";
    private static final String EMAIL_PASSWORD = "hqyp kdnn ewpr dtjn"; // App password
    private static final String TO_EMAIL = "hoangthaiduypl@gmail.com";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("=== CONTACT SERVLET STARTED ===");
        
        // Set UTF-8 encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        
        // Get form data
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");
        
        System.out.println("Received data:");
        System.out.println("FullName: " + fullName);
        System.out.println("Phone: " + phone);
        System.out.println("Email: " + email);
        System.out.println("Subject: " + subject);
        System.out.println("Message: " + message);
        
        PrintWriter out = response.getWriter();
        
        try {
            // Validate required fields
            if (fullName == null || fullName.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                subject == null || subject.trim().isEmpty() ||
                message == null || message.trim().isEmpty()) {
                
                System.out.println("Validation failed: Missing required fields");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\": false, \"message\": \"Vui lòng điền đầy đủ thông tin\"}");
                return;
            }
            
            // Validate email format
            if (!isValidEmail(email)) {
                System.out.println("Validation failed: Invalid email format");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\": false, \"message\": \"Email không hợp lệ\"}");
                return;
            }
            
            // Send email
            System.out.println("Attempting to send email...");
            boolean emailSent = sendEmail(fullName, phone, email, subject, message);
            
            if (emailSent) {
                // Log the contact for admin
                logContactSubmission(fullName, phone, email, subject, message);
                
                System.out.println("Email sent successfully");
                response.setStatus(HttpServletResponse.SC_OK);
                out.print("{\"success\": true, \"message\": \"Gửi yêu cầu thành công! Chúng tôi sẽ liên hệ lại với bạn sớm nhất.\"}");
            } else {
                System.out.println("Failed to send email");
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print("{\"success\": false, \"message\": \"Có lỗi xảy ra khi gửi email. Vui lòng thử lại sau.\"}");
            }
            
        } catch (Exception e) {
            System.err.println("Error in contact servlet: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\": false, \"message\": \"Lỗi server: \" + e.getMessage()}");
        } finally {
            System.out.println("=== CONTACT SERVLET FINISHED ===");
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect về trang contact.jsp khi truy cập bằng GET
        response.sendRedirect("Contact.jsp");
    }
    
    private boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        return email != null && email.matches(emailRegex);
    }
    
    private boolean sendEmail(String fullName, String phone, String fromEmail, String subject, String message) {
        try {
            System.out.println("Setting up email properties...");
            
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
            
            // Enable debug to see what's happening
            session.setDebug(true);
            
            System.out.println("Creating email message...");
            
            // Create email message
            Message emailMessage = new MimeMessage(session);
            emailMessage.setFrom(new InternetAddress(EMAIL_USERNAME, "KIDDY Website"));
            emailMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(TO_EMAIL));
            emailMessage.setSubject("[KIDDY CONTACT] " + subject);
            
            // Create email content
            String emailContent = createEmailContent(fullName, phone, fromEmail, subject, message);
            emailMessage.setContent(emailContent, "text/html; charset=utf-8");
            
            System.out.println("Sending email...");
            
            // Send email
            Transport.send(emailMessage);
            System.out.println("Email sent successfully to: " + TO_EMAIL);
            return true;
            
        } catch (Exception e) {
            System.err.println("Failed to send email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    private String createEmailContent(String fullName, String phone, String email, String subject, String message) {
        // Giữ nguyên nội dung email HTML của bạn
        return "<!DOCTYPE html>" +
               "<html>" +
               "<head>" +
               "    <meta charset=\"UTF-8\">" +
               "    <style>" +
               "        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; margin: 0; padding: 0; }" +
               "        .container { max-width: 600px; margin: 0 auto; background: #ffffff; }" +
               "        .header { background: linear-gradient(135deg, #ff4da6 0%, #ff0066 100%); color: white; padding: 30px 20px; text-align: center; }" +
               "        .header h1 { margin: 0; font-size: 24px; }" +
               "        .header p { margin: 10px 0 0 0; opacity: 0.9; }" +
               "        .content { padding: 30px; background: #f9f9f9; }" +
               "        .info-table { width: 100%; border-collapse: collapse; margin: 20px 0; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }" +
               "        .info-table td { padding: 12px 16px; border-bottom: 1px solid #eee; }" +
               "        .info-table td:first-child { font-weight: bold; width: 30%; color: #ff0066; background: #fff5f8; }" +
               "        .info-table tr:last-child td { border-bottom: none; }" +
               "        .message-box { background: white; padding: 20px; border-left: 4px solid #ff4da6; margin: 20px 0; border-radius: 4px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }" +
               "        .message-box h3 { margin: 0 0 10px 0; color: #ff0066; }" +
               "        .footer { text-align: center; margin-top: 30px; padding: 20px; background: #eee; color: #666; font-size: 12px; }" +
               "        .logo { font-family: 'Fredoka One', cursive; font-size: 18px; color: #ff0066; margin-bottom: 10px; }" +
               "    </style>" +
               "</head>" +
               "<body>" +
               "    <div class=\"container\">" +
               "        <div class=\"header\">" +
               "            <h1>📧 Liên hệ mới từ KIDDY</h1>" +
               "            <p>Thông tin khách hàng cần hỗ trợ</p>" +
               "        </div>" +
               "        <div class=\"content\">" +
               "            <div class=\"logo\">" +
               "                <i class=\"fas fa-crown\"></i> KIDDY - Thời trang trẻ em cao cấp" +
               "            </div>" +
               "            <table class=\"info-table\">" +
               "                <tr><td>Họ và tên:</td><td>" + escapeHtml(fullName) + "</td></tr>" +
               "                <tr><td>Số điện thoại:</td><td>" + escapeHtml(phone) + "</td></tr>" +
               "                <tr><td>Email:</td><td>" + escapeHtml(email) + "</td></tr>" +
               "                <tr><td>Tiêu đề:</td><td>" + escapeHtml(subject) + "</td></tr>" +
               "                <tr><td>Thời gian:</td><td>" + new java.util.Date() + "</td></tr>" +
               "            </table>" +
               "            <div class=\"message-box\">" +
               "                <h3>Nội dung tin nhắn:</h3>" +
               "                <p>" + escapeHtml(message).replace("\n", "<br>") + "</p>" +
               "            </div>" +
               "        </div>" +
               "        <div class=\"footer\">" +
               "            <p>Email được gửi tự động từ hệ thống KIDDY</p>" +
               "            <p>© 2025 KIDDY - Thời trang trẻ em cao cấp</p>" +
               "        </div>" +
               "    </div>" +
               "</body>" +
               "</html>";
    }
    
    private String escapeHtml(String text) {
        if (text == null) return "";
        return text.replace("&", "&amp;")
                  .replace("<", "&lt;")
                  .replace(">", "&gt;")
                  .replace("\"", "&quot;")
                  .replace("'", "&#39;");
    }
    
    private void logContactSubmission(String fullName, String phone, String email, String subject, String message) {
        // Log contact submission for admin purposes
        System.out.println("=== CONTACT FORM SUBMISSION ===");
        System.out.println("Time: " + new java.util.Date());
        System.out.println("Name: " + fullName);
        System.out.println("Phone: " + phone);
        System.out.println("Email: " + email);
        System.out.println("Subject: " + subject);
        System.out.println("Message: " + message);
        System.out.println("===============================");
    }
}