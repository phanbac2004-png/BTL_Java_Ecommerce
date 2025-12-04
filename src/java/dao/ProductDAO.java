package dao;

import context.DBContext;
import entity.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    public List<Product> getAllProduct() {
        List<Product> list = new ArrayList<>();
        String query = "select * from product";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return list;
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("image"),
                            rs.getLong("price"),
                            rs.getString("title"),
                            rs.getString("description"),
                            rs.getInt("cateID")
                    );
                    try { p.setQuantity(rs.getInt("quantity")); } catch (Exception ignore) {}
                    list.add(p);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Product> getProductByCID(int cid) {
        List<Product> list = new ArrayList<>();
        String query = "select * from product where cateID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return list;
            ps.setInt(1, cid);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("image"),
                            rs.getLong("price"),
                            rs.getString("title"),
                            rs.getString("description"),
                            rs.getInt("cateID"));
                    try { p.setQuantity(rs.getInt("quantity")); } catch (Exception ignore) {}
                    list.add(p);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Product> getProductBySellID(int sellId) {
        List<Product> list = new ArrayList<>();
        String query = "select * from product where sell_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return list;
            ps.setInt(1, sellId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("image"),
                            rs.getLong("price"),
                            rs.getString("title"),
                            rs.getString("description"),
                            rs.getInt("cateID"));
                    try { p.setQuantity(rs.getInt("quantity")); } catch (Exception ignore) {}
                    list.add(p);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public Product getProductByID(int id) {
        String query = "select * from product where id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return null;
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Product p = new Product(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("image"),
                            rs.getLong("price"),
                            rs.getString("title"),
                            rs.getString("description"),
                            rs.getInt("cateID"));
                    try { p.setQuantity(rs.getInt("quantity")); } catch (Exception ignore) {}
                    return p;
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public Product getLast() {
        String query = "SELECT * FROM product ORDER BY id DESC LIMIT 1";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return null;
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Product(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("image"),
                            rs.getLong("price"),
                            rs.getString("title"),
                            rs.getString("description"),
                            rs.getInt("cateID")
                    );
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public void insertProduct(String name, String image, String price, String title, String description, String category, int sellId) {
        // Keep current behavior (explicit IDs) for now; will be simplified in a later pass
        // by relying on AUTO_INCREMENT.
        dao.DAO legacy = new dao.DAO();
        legacy.insertProduct(name, image, price, title, description, category, sellId);
    }

    public void editProduct(String name, String image, String price, String title, String description, String category, int pid) {
        String query = "UPDATE product SET name=?, image=?, price=?, title=?, description=?, cateID=? WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return;
            ps.setString(1, name);
            ps.setString(2, image);
            ps.setString(3, price);
            ps.setString(4, title);
            ps.setString(5, description);
            ps.setString(6, category);
            ps.setInt(7, pid);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void deleteProduct(int pid) {
        // Preserve legacy logic (including AUTO_INCREMENT reset) to avoid changing behavior now
        dao.DAO legacy = new dao.DAO();
        legacy.deleteProduct(pid);
    }

    public boolean updateQuantity(int productID, int newQuantity) {
        String query = "UPDATE product SET quantity = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return false;
            ps.setInt(1, newQuantity);
            ps.setInt(2, productID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
}
