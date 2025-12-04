package dao;

import context.DBContext;
import entity.Account;
import util.PasswordUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AccountDAO {

    public Account login(String user, String pass) {
        String query = "select * from account where user = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return null;
            ps.setString(1, user);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String hashedPassword = rs.getString("pass");
                    boolean ok = false;
                    try {
                        ok = PasswordUtil.verifyPassword(pass, hashedPassword);
                    } catch (NoClassDefFoundError e) {
                        // Fallback for deployments missing util.PasswordUtil: support legacy plain-text
                        ok = pass != null && pass.equals(hashedPassword);
                    } catch (Throwable t) {
                        // Any other unexpected error, try legacy equality
                        ok = pass != null && pass.equals(hashedPassword);
                    }
                    if (ok) {
                        return new Account(
                                rs.getInt("id"),
                                rs.getString("user"),
                                rs.getString("pass"),
                                rs.getString("phone") != null ? rs.getString("phone") : "",
                                rs.getString("email") != null ? rs.getString("email") : "",
                                rs.getInt("isSell"),
                                rs.getInt("isAdmin")
                        );
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Account checkAccountExist(String user) {
        String query = "select * from account where user = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return null;
            ps.setString(1, user);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Account(rs.getInt(1), rs.getString(2), rs.getString(3),
                            rs.getString(4) != null ? rs.getString(4) : "",
                            rs.getString(5) != null ? rs.getString(5) : "",
                            rs.getInt(6), rs.getInt(7));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public Account checkEmailExist(String email) {
        String query = "select * from account where email = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return null;
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Account(rs.getInt(1), rs.getString(2), rs.getString(3),
                            rs.getString(4) != null ? rs.getString(4) : "",
                            rs.getString(5) != null ? rs.getString(5) : "",
                            rs.getInt(6), rs.getInt(7));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public Account checkPhoneExist(String phone) {
        String query = "select * from account where phone = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return null;
            ps.setString(1, phone);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Account(rs.getInt(1), rs.getString(2), rs.getString(3),
                            rs.getString(4) != null ? rs.getString(4) : "",
                            rs.getString(5) != null ? rs.getString(5) : "",
                            rs.getInt(6), rs.getInt(7));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public void signup(String user, String phone, String email, String pass) {
        String query = "insert into account (user, phone, email, pass, isSell, isAdmin) values (?,?,?,?,0,0)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return;
            ps.setString(1, user);
            ps.setString(2, phone);
            ps.setString(3, email);
            ps.setString(4, PasswordUtil.hashPassword(pass));
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void updatePassword(String username, String newPassword) {
        String query = "UPDATE account SET pass = ? WHERE user = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return;
            ps.setString(1, PasswordUtil.hashPassword(newPassword));
            ps.setString(2, username);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void updatePasswordById(int accountId, String newPassword) {
        String query = "UPDATE account SET pass = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return;
            ps.setString(1, PasswordUtil.hashPassword(newPassword));
            ps.setInt(2, accountId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void updateUserRole(int id, int isSell, int isAdmin) {
        String query = "UPDATE account SET isSell = ?, isAdmin = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return;
            ps.setInt(1, isSell);
            ps.setInt(2, isAdmin);
            ps.setInt(3, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public Account checkUsernameAndEmail(String username, String email) {
        String query = "select * from account where user = ? and email = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return null;
            ps.setString(1, username);
            ps.setString(2, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Account(
                            rs.getInt("id"),
                            rs.getString("user"),
                            rs.getString("pass"),
                            rs.getString("phone") != null ? rs.getString("phone") : "",
                            rs.getString("email") != null ? rs.getString("email") : "",
                            rs.getInt("isSell"),
                            rs.getInt("isAdmin")
                    );
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }
}
