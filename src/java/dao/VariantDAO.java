package dao;

import context.DBContext;
import entity.ProductVariant;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class VariantDAO {

    public List<ProductVariant> getVariantsByProductId(int productId) {
        List<ProductVariant> list = new ArrayList<>();
        String query = "SELECT variant_id, product_id, color_id, size_id, quantity, sku FROM product_variants WHERE product_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return list;
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new ProductVariant(
                            rs.getInt("variant_id"),
                            rs.getInt("product_id"),
                            rs.getInt("color_id"),
                            rs.getInt("size_id"),
                            rs.getInt("quantity"),
                            rs.getString("sku")
                    ));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public ProductVariant getVariantByProductColorSize(int productId, int colorId, int sizeId) {
        String query = "SELECT variant_id, product_id, color_id, size_id, quantity, sku FROM product_variants WHERE product_id = ? AND color_id = ? AND size_id = ? LIMIT 1";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return null;
            ps.setInt(1, productId);
            ps.setInt(2, colorId);
            ps.setInt(3, sizeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new ProductVariant(
                            rs.getInt("variant_id"),
                            rs.getInt("product_id"),
                            rs.getInt("color_id"),
                            rs.getInt("size_id"),
                            rs.getInt("quantity"),
                            rs.getString("sku")
                    );
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public ProductVariant getVariantById(int variantId) {
        String query = "SELECT variant_id, product_id, color_id, size_id, quantity, sku FROM product_variants WHERE variant_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return null;
            ps.setInt(1, variantId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new ProductVariant(
                            rs.getInt("variant_id"),
                            rs.getInt("product_id"),
                            rs.getInt("color_id"),
                            rs.getInt("size_id"),
                            rs.getInt("quantity"),
                            rs.getString("sku")
                    );
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }
}
