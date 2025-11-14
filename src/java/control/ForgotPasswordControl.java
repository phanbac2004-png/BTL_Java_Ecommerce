package control;

import dao.DAO;
import entity.Account;
import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.EmailUtil;

@WebServlet(name = "ForgotPasswordControl", urlPatterns = {"/forgot-password"})
public class ForgotPasswordControl extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ForgotPasswordControl.class.getName());
    private static final String PASSWORD_CHARS = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz23456789";
    private static final SecureRandom RANDOM = new SecureRandom();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("resetError", "Vui lòng nhập email đã đăng ký.");
            request.setAttribute("showReset", true);
            forward(request, response);
            return;
        }
        String normalizedEmail = email.trim();
        DAO dao = new DAO();
        Account account = dao.checkEmailExist(normalizedEmail);
        if (account == null) {
            request.setAttribute("resetError", "Email này chưa được đăng ký tài khoản.");
            request.setAttribute("showReset", true);
            request.setAttribute("enteredEmail", normalizedEmail);
            forward(request, response);
            return;
        }
        String oldPassword = account.getPass();
        String tempPassword = generateTemporaryPassword();
        boolean updated = dao.updatePasswordByEmail(normalizedEmail, tempPassword);
        if (!updated) {
            request.setAttribute("resetError", "Không thể cập nhật mật khẩu. Vui lòng thử lại sau.");
            request.setAttribute("showReset", true);
            request.setAttribute("enteredEmail", normalizedEmail);
            forward(request, response);
            return;
        }
        try {
            EmailUtil.sendPasswordResetEmail(normalizedEmail, account.getUser(), tempPassword);
            request.setAttribute("resetSuccess", "Mật khẩu tạm thời đã được gửi tới email của bạn. Vui lòng kiểm tra hộp thư.");
        } catch (MessagingException | IllegalStateException ex) {
            LOGGER.log(Level.SEVERE, "Failed to send reset password email to {0}", normalizedEmail);
            LOGGER.log(Level.FINE, "Email sending error", ex);
            // revert password to old one if email sending fails
            dao.updatePasswordByEmail(normalizedEmail, oldPassword);
            request.setAttribute("resetError", "Đã xảy ra lỗi khi gửi email. Vui lòng thử lại sau hoặc liên hệ quản trị viên.");
            request.setAttribute("showReset", true);
            request.setAttribute("enteredEmail", normalizedEmail);
        }
        forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("Login.jsp");
    }

    private void forward(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("Login.jsp").forward(request, response);
    }

    private String generateTemporaryPassword() {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 8; i++) {
            sb.append(PASSWORD_CHARS.charAt(RANDOM.nextInt(PASSWORD_CHARS.length())));
        }
        return sb.toString();
    }
}

