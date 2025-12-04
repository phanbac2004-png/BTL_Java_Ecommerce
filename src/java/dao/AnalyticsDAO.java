package dao;

import context.DBContext;
import entity.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AnalyticsDAO {

    public static class SoldProductInfo {
        private Product product;
        private int totalSold;
        private double totalRevenue;
        private int processingCount;
        private int deliveredCount;

        public SoldProductInfo(Product product, int totalSold, double totalRevenue) {
            this.product = product;
            this.totalSold = totalSold;
            this.totalRevenue = totalRevenue;
        }

        public SoldProductInfo(Product product, int totalSold, double totalRevenue, int processingCount, int deliveredCount) {
            this.product = product;
            this.totalSold = totalSold;
            this.totalRevenue = totalRevenue;
            this.processingCount = processingCount;
            this.deliveredCount = deliveredCount;
        }

        public Product getProduct() { return product; }
        public int getTotalSold() { return totalSold; }
        public double getTotalRevenue() { return totalRevenue; }
        public int getProcessingCount() { return processingCount; }
        public int getDeliveredCount() { return deliveredCount; }
    }

    public List<SoldProductInfo> getSoldProducts() {
        List<SoldProductInfo> list = new ArrayList<>();
        String query = "SELECT p.id, p.name, p.image, p.price, p.title, p.description, p.cateID, " +
                "SUM(od.amount) AS totalSold, SUM(od.amount * od.price) AS totalRevenue " +
                "FROM orderdetails od " +
                "JOIN orders o ON od.orderID = o.id " +
                "JOIN product_variants pv ON od.variant_id = pv.variant_id " +
                "JOIN product p ON pv.product_id = p.id " +
                "WHERE o.status != 'Cancelled' " +
                "GROUP BY p.id, p.name, p.image, p.price, p.title, p.description, p.cateID " +
                "ORDER BY totalSold DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return list;
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product(
                            rs.getInt("id"), rs.getString("name"), rs.getString("image"),
                            rs.getLong("price"), rs.getString("title"), rs.getString("description"),
                            rs.getInt("cateID")
                    );
                    int totalSold = rs.getInt("totalSold");
                    double totalRevenue = rs.getDouble("totalRevenue");
                    list.add(new SoldProductInfo(product, totalSold, totalRevenue));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public int getNewOrdersCount() {
        String query = "SELECT COUNT(*) FROM orders WHERE status = 'Processing'";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return 0;
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public double getMonthlyRevenue() {
        String query = "SELECT COALESCE(SUM(totalPrice), 0) FROM orders WHERE status != 'Cancelled' " +
                "AND YEAR(orderDate) = YEAR(CURDATE()) AND MONTH(orderDate) = MONTH(CURDATE())";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return 0;
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    double v = rs.getDouble(1);
                    return rs.wasNull() ? 0 : v;
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public int getTotalProductsCount() {
        String query = "SELECT COUNT(*) FROM product";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return 0;
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public int getTotalCustomersCount() {
        String query = "SELECT COUNT(*) FROM account WHERE isAdmin = 0";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn != null ? conn.prepareStatement(query) : null) {
            if (ps == null) return 0;
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
}
