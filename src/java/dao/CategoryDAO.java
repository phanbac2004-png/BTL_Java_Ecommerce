package dao;

import context.DBContext;
import entity.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    public List<Category> getAllCategory() {
        List<Category> list = new ArrayList<>();
        String query = "select * from Category ORDER BY cid";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return list;
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Category(rs.getInt(1), rs.getString(2)));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public void insertCategory(String cname) {
        // Preserve legacy dual-path logic (AUTO_INCREMENT vs manual) for now
        new dao.DAO().insertCategory(cname);
    }

    public void updateCategory(int cid, String cname) {
        String query = "UPDATE category SET cname = ? WHERE cid = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return;
            ps.setString(1, cname);
            ps.setInt(2, cid);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void deleteCategory(int cid) {
        // Preserve legacy check and delete behavior
        new dao.DAO().deleteCategory(cid);
    }

    public Category getCategoryByID(int cid) {
        String query = "SELECT * FROM category WHERE cid = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return null;
            ps.setInt(1, cid);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Category(rs.getInt(1), rs.getString(2));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }
}
