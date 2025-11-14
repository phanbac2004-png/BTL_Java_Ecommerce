package utils;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EmailUtil {

    private static final Logger LOGGER = Logger.getLogger(EmailUtil.class.getName());
    private static final Properties CONFIG = loadConfig();

    private EmailUtil() {
    }

    public static void sendPasswordResetEmail(String recipientEmail, String username, String temporaryPassword) throws MessagingException {
        String smtpUser = requireConfig("APP_SMTP_USER");
        String smtpPass = requireConfig("APP_SMTP_PASS");
        String smtpHost = getConfigOrDefault("APP_SMTP_HOST", "smtp.gmail.com");
        String smtpPort = getConfigOrDefault("APP_SMTP_PORT", "587");
        String fromName = getConfigOrDefault("APP_SMTP_FROM_NAME", "Kiddy Shop Support");

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.starttls.required", "true");
        props.put("mail.smtp.host", smtpHost);
        props.put("mail.smtp.port", smtpPort);
        props.put("mail.smtp.ssl.trust", smtpHost);
        props.put("mail.smtp.ssl.protocols", "TLSv1.2 TLSv1.3");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(smtpUser, smtpPass);
            }
        });

        Message message = new MimeMessage(session);
        try {
            message.setFrom(new InternetAddress(smtpUser, fromName));
        } catch (UnsupportedEncodingException ex) {
            message.setFrom(new InternetAddress(smtpUser));
        }
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
        message.setSubject("Đặt lại mật khẩu - Kiddy Shop");

        StringBuilder body = new StringBuilder();
        body.append("Xin chào ").append(username == null ? "bạn" : username).append(",\n\n")
                .append("Bạn vừa yêu cầu đặt lại mật khẩu cho tài khoản tại Kiddy Shop.\n")
                .append("Mật khẩu tạm thời của bạn là: ").append(temporaryPassword).append("\n\n")
                .append("Vui lòng đăng nhập bằng mật khẩu tạm thời này và đổi mật khẩu ngay trong trang tài khoản để bảo đảm an toàn.\n\n")
                .append("Nếu bạn không thực hiện yêu cầu này, hãy bỏ qua email này hoặc liên hệ với bộ phận hỗ trợ.\n\n")
                .append("Trân trọng,\n")
                .append(fromName);

        message.setText(body.toString());
        Transport.send(message);
    }

    private static String requireConfig(String key) {
        String value = getConfig(key);
        if (value == null || value.isBlank()) {
            throw new IllegalStateException("Missing SMTP configuration for " + key + ". Please set environment variable or system property.");
        }
        return value;
    }

    private static String getConfigOrDefault(String key, String defaultValue) {
        String value = getConfig(key);
        return (value == null || value.isBlank()) ? defaultValue : value;
    }

    private static String getConfig(String key) {
        String value = System.getenv(key);
        if (value == null || value.isBlank()) {
            value = System.getProperty(key);
        }
        if ((value == null || value.isBlank()) && CONFIG != null) {
            value = CONFIG.getProperty(normalizeKey(key));
        }
        return value;
    }

    private static Properties loadConfig() {
        try (InputStream is = EmailUtil.class.getClassLoader().getResourceAsStream("smtp.properties")) {
            if (is != null) {
                Properties props = new Properties();
                props.load(is);
                LOGGER.log(Level.INFO, "Loaded SMTP configuration from classpath smtp.properties");
                return props;
            }
        } catch (IOException ex) {
            LOGGER.log(Level.WARNING, "Could not load smtp.properties: {0}", ex.getMessage());
        }
        return null;
    }

    private static String normalizeKey(String key) {
        if (key == null) {
            return null;
        }
        if (key.startsWith("APP_SMTP_")) {
            key = key.substring("APP_SMTP_".length());
        }
        return "smtp." + key.toLowerCase();
    }
}

