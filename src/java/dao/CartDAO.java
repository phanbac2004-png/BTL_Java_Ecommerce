package dao;

import context.DBContext;
import entity.Cart;
import entity.Product;
import entity.ProductVariant;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    public int getCartAmountByVariant(int accountID, int variantID) {
        String query = "SELECT Amount FROM cart WHERE AccountID = ? AND variant_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return 0;
            ps.setInt(1, accountID);
            ps.setInt(2, variantID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("Amount");
            }
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public void addToCartVariant(int accountID, int variantID, int amount) {
        String checkQuery = "SELECT Amount FROM cart WHERE AccountID = ? AND variant_id = ?";
        String insertQuery = "INSERT INTO cart (AccountID, variant_id, Amount) VALUES (?,?,?)";
        String updateQuery = "UPDATE cart SET Amount = Amount + ? WHERE AccountID = ? AND variant_id = ?";
        try (Connection conn = DBContext.getConnection()) {
            if (conn == null) return;
            try (PreparedStatement psCheck = conn.prepareStatement(checkQuery)) {
                psCheck.setInt(1, accountID);
                psCheck.setInt(2, variantID);
                try (ResultSet rs = psCheck.executeQuery()) {
                    if (rs.next()) {
                        try (PreparedStatement psUpd = conn.prepareStatement(updateQuery)) {
                            psUpd.setInt(1, amount);
                            psUpd.setInt(2, accountID);
                            psUpd.setInt(3, variantID);
                            psUpd.executeUpdate();
                        }
                    } else {
                        try (PreparedStatement psIns = conn.prepareStatement(insertQuery)) {
                            psIns.setInt(1, accountID);
                            psIns.setInt(2, variantID);
                            psIns.setInt(3, amount);
                            psIns.executeUpdate();
                        }
                    }
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void addToCart(int accountID, int productID, int amount) {
        String checkQuery = "SELECT Amount FROM cart WHERE AccountID = ? AND ProductID = ?";
        String insertQuery = "INSERT INTO cart (AccountID, ProductID, Amount) VALUES (?,?,?)";
        String updateQuery = "UPDATE cart SET Amount = Amount + ? WHERE AccountID = ? AND ProductID = ?";
        try (Connection conn = DBContext.getConnection()) {
            if (conn == null) return;
            try (PreparedStatement psCheck = conn.prepareStatement(checkQuery)) {
                psCheck.setInt(1, accountID);
                psCheck.setInt(2, productID);
                try (ResultSet rs = psCheck.executeQuery()) {
                    if (rs.next()) {
                        try (PreparedStatement psUpd = conn.prepareStatement(updateQuery)) {
                            psUpd.setInt(1, amount);
                            psUpd.setInt(2, accountID);
                            psUpd.setInt(3, productID);
                            psUpd.executeUpdate();
                        }
                    } else {
                        try (PreparedStatement psIns = conn.prepareStatement(insertQuery)) {
                            psIns.setInt(1, accountID);
                            psIns.setInt(2, productID);
                            psIns.setInt(3, amount);
                            psIns.executeUpdate();
                        }
                    }
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
    }

    public List<Cart> getCartByAccountID(int accountID) {
        List<Cart> list = new ArrayList<>();
        String query = "SELECT p.id, p.name, p.image, p.price, p.title, p.description, p.cateID, " +
                "pv.variant_id, pv.color_id, pv.size_id, pv.quantity AS var_quantity, pv.sku, co.color_name, si.size_name, c.Amount " +
                "FROM cart c " +
                "INNER JOIN product_variants pv ON c.variant_id = pv.variant_id " +
                "INNER JOIN product p ON pv.product_id = p.id " +
                "LEFT JOIN color co ON pv.color_id = co.color_id " +
                "LEFT JOIN size si ON pv.size_id = si.size_id " +
                "WHERE c.AccountID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return list;
            ps.setInt(1, accountID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product(rs.getInt("id"), rs.getString("name"), rs.getString("image"),
                            rs.getLong("price"), rs.getString("title"), rs.getString("description"), rs.getInt("cateID"));
                    try { p.setQuantity(rs.getInt("var_quantity")); } catch (Exception ignore) {}
                    int variantId = rs.getInt("variant_id");
                    int colorId = rs.getInt("color_id");
                    int sizeId = rs.getInt("size_id");
                    int varQuantity = rs.getInt("var_quantity");
                    String sku = rs.getString("sku");
                    String colorName = null; String sizeName = null;
                    try { colorName = rs.getString("color_name"); } catch (Exception ignore) {}
                    try { sizeName = rs.getString("size_name"); } catch (Exception ignore) {}
                    int amount = rs.getInt("Amount");
                    ProductVariant pv = new ProductVariant(variantId, p.getId(), colorId, sizeId, varQuantity, sku, colorName, sizeName);
                    list.add(new Cart(p, pv, amount));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public void updateCartVariant(int accountID, int variantID, int amount) {
        String query = "UPDATE cart SET Amount = ? WHERE AccountID = ? AND variant_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return;
            ps.setInt(1, amount);
            ps.setInt(2, accountID);
            ps.setInt(3, variantID);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void deleteCartVariant(int accountID, int variantID) {
        String query = "DELETE FROM cart WHERE AccountID = ? AND variant_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return;
            ps.setInt(1, accountID);
            ps.setInt(2, variantID);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void updateCart(int accountID, int productID, int amount) {
        String query = "UPDATE cart SET Amount = ? WHERE AccountID = ? AND ProductID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return;
            ps.setInt(1, amount);
            ps.setInt(2, accountID);
            ps.setInt(3, productID);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void deleteCart(int accountID, int productID) {
        String query = "DELETE FROM cart WHERE AccountID = ? AND ProductID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return;
            ps.setInt(1, accountID);
            ps.setInt(2, productID);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}
