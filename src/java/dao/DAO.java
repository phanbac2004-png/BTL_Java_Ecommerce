/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import context.DBContext;
import entity.Account;
import entity.Category;
import entity.Product;
import entity.Order;
import entity.OrderDetail;
import entity.Cart;
import entity.Color;
import entity.Size;
import entity.ProductVariant;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author trinh
 */
public class DAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Product> getAllProduct() {
        List<Product> list = new ArrayList<>();
        String query = "select * from product";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                // id, name, image, price, title, description, cateID, sell_ID, quantity
                Product p = new Product(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getLong("price"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getInt("cateID"));
                try { p.setQuantity(rs.getInt("quantity")); } catch (Exception ignore) {}
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get product variants by product id
    public List<ProductVariant> getVariantsByProductId(int productId) {
        List<ProductVariant> list = new ArrayList<>();
        String query = "SELECT variant_id, product_id, color_id, size_id, quantity, sku FROM product_variants WHERE product_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, productId);
            rs = ps.executeQuery();
            while (rs.next()) {
                ProductVariant pv = new ProductVariant(
                        rs.getInt("variant_id"),
                        rs.getInt("product_id"),
                        rs.getInt("color_id"),
                        rs.getInt("size_id"),
                        rs.getInt("quantity"),
                        rs.getString("sku")
                );
                list.add(pv);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ProductVariant getVariantByProductColorSize(int productId, int colorId, int sizeId) {
        String query = "SELECT variant_id, product_id, color_id, size_id, quantity, sku FROM product_variants WHERE product_id = ? AND color_id = ? AND size_id = ? LIMIT 1";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, productId);
            ps.setInt(2, colorId);
            ps.setInt(3, sizeId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new ProductVariant(rs.getInt("variant_id"), rs.getInt("product_id"), rs.getInt("color_id"), rs.getInt("size_id"), rs.getInt("quantity"), rs.getString("sku"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public ProductVariant getVariantById(int variantId) {
        String query = "SELECT variant_id, product_id, color_id, size_id, quantity, sku FROM product_variants WHERE variant_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, variantId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new ProductVariant(rs.getInt("variant_id"), rs.getInt("product_id"), rs.getInt("color_id"), rs.getInt("size_id"), rs.getInt("quantity"), rs.getString("sku"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cart helpers for variant-based cart (cart table may use variant_id)
    public int getCartAmountByVariant(int accountID, int variantID) {
        String query = "SELECT Amount FROM cart WHERE AccountID = ? AND variant_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountID);
            ps.setInt(2, variantID);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("Amount");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void addToCartVariant(int accountID, int variantID, int amount) {
        String checkQuery = "SELECT Amount FROM cart WHERE AccountID = ? AND variant_id = ?";
        String insertQuery = "INSERT INTO cart (AccountID, variant_id, Amount) VALUES (?,?,?)";
        String updateQuery = "UPDATE cart SET Amount = Amount + ? WHERE AccountID = ? AND variant_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(checkQuery);
            ps.setInt(1, accountID);
            ps.setInt(2, variantID);
            rs = ps.executeQuery();
            if (rs.next()) {
                ps = conn.prepareStatement(updateQuery);
                ps.setInt(1, amount);
                ps.setInt(2, accountID);
                ps.setInt(3, variantID);
                ps.executeUpdate();
            } else {
                ps = conn.prepareStatement(insertQuery);
                ps.setInt(1, accountID);
                ps.setInt(2, variantID);
                ps.setInt(3, amount);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<Product> getProductByCID(int cid) {
        List<Product> list = new ArrayList<>();
        String query = "select * from product where cateID = ?";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setInt(1, cid);
            rs = ps.executeQuery();
            while (rs.next()) {
                // id, name, image, price, title, description, cateID, sell_ID, quantity
                Product p = new Product(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getLong("price"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getInt("cateID"));
                try { p.setQuantity(rs.getInt("quantity")); } catch (Exception ignore) {}
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Product> getProductBySellID(int sellId) {
        List<Product> list = new ArrayList<>();
        String query = "select * from product where sell_id= ?";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setInt(1, sellId);
            rs = ps.executeQuery();
            while (rs.next()) {
                // id, name, image, price, title, description, cateID, sell_ID, quantity
                Product p = new Product(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getLong("price"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getInt("cateID"));
                try { p.setQuantity(rs.getInt("quantity")); } catch (Exception ignore) {}
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public Product getProductByID(int id) {
        String query = "select * from product where id = ?";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                // id, name, image, price, title, description, cateID, sell_ID, quantity
                Product p = new Product(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getLong("price"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getInt("cateID"));
                try { p.setQuantity(rs.getInt("quantity")); } catch (Exception ignore) {}
                return p;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Category> getAllCategory() {
        List<Category> list = new ArrayList<>();
        String query = "select * from Category ORDER BY cid";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Category(rs.getInt(1),
                        rs.getString(2)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // ========== CATEGORY MANAGEMENT (ADMIN) ==========
    public void insertCategory(String cname) {
        String query;
        try {
            conn = new DBContext().getConnection();
            
            // Thử insert với AUTO_INCREMENT trước (nếu cid có AUTO_INCREMENT)
            try {
                query = "INSERT INTO category (cname) VALUES (?)";
                ps = conn.prepareStatement(query);
                ps.setString(1, cname);
                ps.executeUpdate();
                return; // Thành công với AUTO_INCREMENT
            } catch (Exception e) {
                // Nếu lỗi (có thể do không có AUTO_INCREMENT), thử cách khác
                // Lấy cid lớn nhất và +1
                String maxQuery = "SELECT MAX(cid) FROM category";
                PreparedStatement psMax = conn.prepareStatement(maxQuery);
                ResultSet rsMax = psMax.executeQuery();
                int newCid = 1;
                if (rsMax.next()) {
                    Integer maxCid = rsMax.getInt(1);
                    if (maxCid != null && !rsMax.wasNull()) {
                        newCid = maxCid + 1;
                    }
                }
                rsMax.close();
                psMax.close();
                
                // Insert với cid cụ thể
                query = "INSERT INTO category (cid, cname) VALUES (?, ?)";
                ps = conn.prepareStatement(query);
                ps.setInt(1, newCid);
                ps.setString(2, cname);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi thêm danh mục: " + e.getMessage());
        }
    }
    
    public void updateCategory(int cid, String cname) {
        String query = "UPDATE category SET cname = ? WHERE cid = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, cname);
            ps.setInt(2, cid);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void deleteCategory(int cid) {
        // Kiểm tra xem có sản phẩm nào đang sử dụng category này không
        String checkQuery = "SELECT COUNT(*) FROM product WHERE cateID = ?";
        String deleteQuery = "DELETE FROM category WHERE cid = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(checkQuery);
            ps.setInt(1, cid);
            rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                // Có sản phẩm đang sử dụng, không cho xóa
                throw new Exception("Không thể xóa danh mục này vì còn sản phẩm đang sử dụng");
            }
            ps = conn.prepareStatement(deleteQuery);
            ps.setInt(1, cid);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
    
    public Category getCategoryByID(int cid) {
        String query = "SELECT * FROM category WHERE cid = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, cid);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Category(rs.getInt(1), rs.getString(2));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Product getLast() {
        String query = "SELECT * FROM product ORDER BY id DESC LIMIT 1";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while(rs.next()){
                // id, name, image, price, title, description, cateID, sell_ID
                return new Product(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getLong("price"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getInt("cateID"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Color> getAllColors() {
        List<Color> list = new ArrayList<>();
        String query = "SELECT color_id, color_name FROM color ORDER BY color_name";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Color(rs.getInt("color_id"), rs.getString("color_name"))); 
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Size> getAllSizes() {
        List<Size> list = new ArrayList<>();
        String query = "SELECT size_id, size_name FROM size ORDER BY size_order";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Size(rs.getInt("size_id"), rs.getString("size_name")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Product> searchByName(String txtSearch) {
        List<Product> list = new ArrayList<>();
        String query = "select * from product where name like ? ";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + txtSearch + "%");
            rs = ps.executeQuery();
            while(rs.next()){
                // id, name, image, price, title, description, cateID, sell_ID
                list.add(new Product(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getLong("price"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getInt("cateID")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public Account login(String user, String pass) {
        String query = "select * from account where user =? and pass =?";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass);
            rs = ps.executeQuery();
            while(rs.next()) {
                // id, user, pass, phone, email, isSell, isAdmin
                return new Account(rs.getInt("id"),
                        rs.getString("user"),
                        rs.getString("pass"),
                        rs.getString("phone") != null ? rs.getString("phone") : "",
                        rs.getString("email") != null ? rs.getString("email") : "",
                        rs.getInt("isSell"),
                        rs.getInt("isAdmin"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public Account checkAccountExist(String user) {
        String query = "select * from account where user =?";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            rs = ps.executeQuery();
            while(rs.next()) {
                return new Account(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),    
                        rs.getString(4) != null ? rs.getString(4) : "",
                        rs.getString(5) != null ? rs.getString(5) : "",
                        rs.getInt(6),
                        rs.getInt(7));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public Account checkEmailExist(String email) {
        String query = "select * from account where email = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            while(rs.next()) {
                return new Account(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4) != null ? rs.getString(4) : "",
                        rs.getString(5) != null ? rs.getString(5) : "",
                        rs.getInt(6),
                        rs.getInt(7));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public Account checkPhoneExist(String phone) {
        String query = "select * from account where phone = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, phone);
            rs = ps.executeQuery();
            while(rs.next()) {
                return new Account(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4) != null ? rs.getString(4) : "",
                        rs.getString(5) != null ? rs.getString(5) : "",
                        rs.getInt(6),
                        rs.getInt(7));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public void signup(String user, String phone, String email, String pass) {
        String query = "insert into account (user, phone, email, pass, isSell, isAdmin) values (?,?,?,?,0,0)";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, phone);
            ps.setString(3, email);
            ps.setString(4, pass);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void deleteProduct(int pid) {
        String query = "delete from product where id = ?";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setInt(1, pid);
            ps.executeUpdate();
            
            // Sau khi xóa, reset AUTO_INCREMENT để có thể tái sử dụng ID
            // Tìm ID lớn nhất còn lại
            String maxQuery = "SELECT COALESCE(MAX(id), 0) FROM product";
            PreparedStatement psMax = conn.prepareStatement(maxQuery);
            ResultSet rs = psMax.executeQuery();
            int maxId = 0;
            if (rs.next()) {
                maxId = rs.getInt(1);
            }
            rs.close();
            psMax.close();
            
            // Reset AUTO_INCREMENT = maxId + 1 (nhưng logic insert sẽ tự tìm ID trống)
            String resetQuery = "ALTER TABLE product AUTO_INCREMENT = ?";
            PreparedStatement psReset = conn.prepareStatement(resetQuery);
            psReset.setInt(1, maxId + 1);
            psReset.executeUpdate();
            psReset.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void insertProduct(String name, String image, String price, String title, String description, String category, int sellId) {
        try {
            conn = new DBContext().getConnection();
            
            // Tìm ID nhỏ nhất chưa được sử dụng (từ 1 đến MAX(id))
            int newId = findNextAvailableProductID();
            
            // Insert với ID cụ thể
            String query = "INSERT INTO `product`(`id`, `name`, `image`, `price`, `title`, `description`, `cateID`, `sell_ID`) VALUES (?,?,?,?,?,?,?,?)";
            ps = conn.prepareStatement(query);
            ps.setInt(1, newId);
            ps.setString(2, name);
            ps.setString(3, image);
            ps.setString(4, price);
            ps.setString(5, title);
            ps.setString(6, description);
            ps.setString(7, category);
            ps.setInt(8, sellId);
            ps.executeUpdate();
            
            // Reset AUTO_INCREMENT sau khi insert
            String resetQuery = "ALTER TABLE product AUTO_INCREMENT = ?";
            PreparedStatement psReset = conn.prepareStatement(resetQuery);
            psReset.setInt(1, newId + 1);
            psReset.executeUpdate();
            psReset.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi thêm sản phẩm: " + e.getMessage());
        }
    }
    
    // Tìm ID nhỏ nhất chưa được sử dụng
    private int findNextAvailableProductID() {
        try {
            // Lấy tất cả ID hiện tại
            String query = "SELECT id FROM product ORDER BY id";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            
            java.util.List<Integer> usedIds = new ArrayList<>();
            while (rs.next()) {
                usedIds.add(rs.getInt(1));
            }
            rs.close();
            ps.close();
            
            // Tìm ID nhỏ nhất chưa được sử dụng từ 1 trở lên
            int candidateId = 1;
            for (Integer usedId : usedIds) {
                if (candidateId == usedId.intValue()) {
                    candidateId++;
                } else if (candidateId < usedId.intValue()) {
                    // Tìm thấy khoảng trống
                    return candidateId;
                }
            }
            
            // Nếu không có khoảng trống, dùng ID tiếp theo
            return candidateId;
        } catch (Exception e) {
            e.printStackTrace();
            // Nếu lỗi, lấy MAX(id) + 1
            try {
                String maxQuery = "SELECT COALESCE(MAX(id), 0) + 1 FROM product";
                PreparedStatement ps = conn.prepareStatement(maxQuery);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1);
                }
                rs.close();
                ps.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
            return 1; // Fallback
        }
    }
    
    public void editProduct(String name, String image, String price, String title, String description, String category, int pid) {
        String query = "UPDATE `product` SET `name`=?,`image`=?,`price`=?,`title`=?,`description`=?,`cateID`=? WHERE id = ?";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, image);
            ps.setString(3, price);
            ps.setString(4, title);
            ps.setString(5, description);
            ps.setString(6, category);
            ps.setInt(7, pid);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    // Update product stock quantity
    public boolean updateQuantity(int productID, int newQuantity) {
        String query = "UPDATE product SET quantity = ? WHERE id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, newQuantity);
            ps.setInt(2, productID);
            int updated = ps.executeUpdate();
            return updated > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ========== CART METHODS ==========
    public void addToCart(int accountID, int productID, int amount) {
        // Some deployments/imports of the DB may not have a unique key on
        // (AccountID, ProductID). Relying on "ON DUPLICATE KEY" can fail
        // silently in that case (it will just insert duplicate rows). Use
        // a safe check-and-update approach that works whether or not a
        // unique constraint exists.
        String checkQuery = "SELECT Amount FROM cart WHERE AccountID = ? AND ProductID = ?";
        String insertQuery = "INSERT INTO cart (AccountID, ProductID, Amount) VALUES (?,?,?)";
        String updateQuery = "UPDATE cart SET Amount = Amount + ? WHERE AccountID = ? AND ProductID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(checkQuery);
            ps.setInt(1, accountID);
            ps.setInt(2, productID);
            rs = ps.executeQuery();
            if (rs.next()) {
                // existing entry - increment amount
                ps = conn.prepareStatement(updateQuery);
                ps.setInt(1, amount);
                ps.setInt(2, accountID);
                ps.setInt(3, productID);
                ps.executeUpdate();
            } else {
                // no entry yet - insert
                ps = conn.prepareStatement(insertQuery);
                ps.setInt(1, accountID);
                ps.setInt(2, productID);
                ps.setInt(3, amount);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<Cart> getCartByAccountID(int accountID) {
        List<Cart> list = new ArrayList<>();
        String query = "SELECT p.id, p.name, p.image, p.price, p.title, p.description, p.cateID, "
            + "pv.variant_id, pv.color_id, pv.size_id, pv.quantity AS var_quantity, pv.sku, co.color_name, si.size_name, c.Amount "
            + "FROM cart c "
            + "INNER JOIN product_variants pv ON c.variant_id = pv.variant_id "
            + "INNER JOIN product p ON pv.product_id = p.id "
            + "LEFT JOIN color co ON pv.color_id = co.color_id "
            + "LEFT JOIN size si ON pv.size_id = si.size_id "
            + "WHERE c.AccountID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountID);
            rs = ps.executeQuery();
            while (rs.next()) {
                // id, name, image, price, title, description, cateID, amount
        Product p = new Product(rs.getInt("id"),
            rs.getString("name"),
            rs.getString("image"),
            rs.getLong("price"),
            rs.getString("title"),
            rs.getString("description"),
            rs.getInt("cateID"));
        try { p.setQuantity(rs.getInt("var_quantity")); } catch (Exception ignore) {}
                int variantId = rs.getInt("variant_id");
                int colorId = rs.getInt("color_id");
                int sizeId = rs.getInt("size_id");
                int varQuantity = rs.getInt("var_quantity");
                String sku = rs.getString("sku");
                String colorName = null;
                String sizeName = null;
                try { colorName = rs.getString("color_name"); } catch (Exception ignore) {}
                try { sizeName = rs.getString("size_name"); } catch (Exception ignore) {}
                int amount = rs.getInt("Amount");
                ProductVariant pv = new ProductVariant(variantId, p.getId(), colorId, sizeId, varQuantity, sku, colorName, sizeName);
                list.add(new Cart(p, pv, amount));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Variant-aware cart update/delete helpers
    public void updateCartVariant(int accountID, int variantID, int amount) {
        String query = "UPDATE cart SET Amount = ? WHERE AccountID = ? AND variant_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, amount);
            ps.setInt(2, accountID);
            ps.setInt(3, variantID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteCartVariant(int accountID, int variantID) {
        String query = "DELETE FROM cart WHERE AccountID = ? AND variant_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountID);
            ps.setInt(2, variantID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void updateCart(int accountID, int productID, int amount) {
        String query = "UPDATE cart SET Amount = ? WHERE AccountID = ? AND ProductID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, amount);
            ps.setInt(2, accountID);
            ps.setInt(3, productID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Get current amount of a product in a user's cart
    public int getCartAmount(int accountID, int productID) {
        String query = "SELECT Amount FROM cart WHERE AccountID = ? AND ProductID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountID);
            ps.setInt(2, productID);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("Amount");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public void deleteCart(int accountID, int productID) {
        String query = "DELETE FROM cart WHERE AccountID = ? AND ProductID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountID);
            ps.setInt(2, productID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void clearCart(int accountID) {
        String query = "DELETE FROM cart WHERE AccountID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // ========== ORDER METHODS ==========
    public int createOrder(int accountID, String phone, String address, double totalPrice) {
        String query = "INSERT INTO orders (accountID, phone, address, totalPrice, status) VALUES (?,?,?,?, 'Pending')";
        int orderID = 0;
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setInt(1, accountID);
            ps.setString(2, phone);
            ps.setString(3, address);
            ps.setDouble(4, totalPrice);
            ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                orderID = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderID;
    }
    
    public int createOrder(int accountID, String phone, String address, double totalPrice, String status) {
        String query = "INSERT INTO orders (accountID, phone, address, totalPrice, status) VALUES (?,?,?,?, ?)";
        int orderID = 0;
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setInt(1, accountID);
            ps.setString(2, phone);
            ps.setString(3, address);
            ps.setDouble(4, totalPrice);
            ps.setString(5, status);
            ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                orderID = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderID;
    }

    // New: create order with explicit payment method when DB supports it.
    // Falls back to legacy insert if the column does not exist.
    public int createOrder(int accountID, String phone, String address, double totalPrice, String status, String paymentMethod) {
        String queryNew = "INSERT INTO orders (accountID, phone, address, totalPrice, status, paymentMethod) VALUES (?,?,?,?, ?, ?)";
        int orderID = 0;
        try {
            conn = new DBContext().getConnection();
            try {
                ps = conn.prepareStatement(queryNew, PreparedStatement.RETURN_GENERATED_KEYS);
                ps.setInt(1, accountID);
                ps.setString(2, phone);
                ps.setString(3, address);
                ps.setDouble(4, totalPrice);
                ps.setString(5, status);
                ps.setString(6, paymentMethod);
                ps.executeUpdate();
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    orderID = rs.getInt(1);
                }
            } catch (Exception ex) {
                // Column not found or other issue: fallback to legacy method without paymentMethod
                try { if (ps != null) ps.close(); } catch (Exception ignore) {}
                try { if (rs != null) rs.close(); } catch (Exception ignore) {}
                orderID = createOrder(accountID, phone, address, totalPrice, status);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderID;
    }
    
    public void updateOrderStatus(int orderID, String status) {
        String query = "UPDATE orders SET status = ? WHERE id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, status);
            ps.setInt(2, orderID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Fetch a single order by id
    public Order getOrderById(int orderID) {
        String query = "SELECT * FROM orders WHERE id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, orderID);
            rs = ps.executeQuery();
            if (rs.next()) {
                String status = rs.getString("status");
                String paymentMethod = null;
                try { paymentMethod = rs.getString("paymentMethod"); } catch (Exception ignore) {}
                if (paymentMethod == null || paymentMethod.isEmpty()) {
                    paymentMethod = "Pending".equalsIgnoreCase(status) ? "vnpay" : "cod";
                }
                return new Order(rs.getInt("id"),
                        rs.getInt("accountID"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getTimestamp("orderDate"),
                        rs.getDouble("totalPrice"),
                        status,
                        paymentMethod);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public void createOrderDetail(int orderID, int productID, int amount, double price) {
        // Legacy method adapted to current schema: write order detail with optional variant_id.
        // If caller has a variant id, prefer using createOrderDetailVariant.
        String query = "INSERT INTO orderdetails (orderID, variant_id, amount, price) VALUES (?,?,?,?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, orderID);
            ps.setNull(2, java.sql.Types.INTEGER); // legacy product-based calls set variant_id = NULL
            ps.setInt(3, amount);
            ps.setDouble(4, price);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void createOrderDetailVariant(int orderID, int variantID, int amount, double price) {
        String query = "INSERT INTO orderdetails (orderID, variant_id, amount, price) VALUES (?,?,?,?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, orderID);
            ps.setInt(2, variantID);
            ps.setInt(3, amount);
            ps.setDouble(4, price);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Update product_variants stock quantity
    public boolean updateVariantQuantity(int variantID, int newQuantity) {
        String query = "UPDATE product_variants SET quantity = ? WHERE variant_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, newQuantity);
            ps.setInt(2, variantID);
            int updated = ps.executeUpdate();
            return updated > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String query = "SELECT * FROM orders ORDER BY orderDate DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                String status = rs.getString("status");
                String paymentMethod = null;
                try { paymentMethod = rs.getString("paymentMethod"); } catch (Exception ignore) {}
                if (paymentMethod == null || paymentMethod.isEmpty()) {
                    paymentMethod = "Pending".equalsIgnoreCase(status) ? "vnpay" : "cod";
                }
                list.add(new Order(rs.getInt("id"),
                        rs.getInt("accountID"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getTimestamp("orderDate"),
                        rs.getDouble("totalPrice"),
                        status,
                        paymentMethod));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Order> getOrdersByDate(int year, int month, int day) {
        List<Order> list = new ArrayList<>();
        String query = "SELECT * FROM orders WHERE status != 'Cancelled' " +
                      "AND YEAR(orderDate) = ? AND MONTH(orderDate) = ? AND DAY(orderDate) = ? " +
                      "ORDER BY orderDate DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, year);
            ps.setInt(2, month);
            ps.setInt(3, day);
            rs = ps.executeQuery();
            while (rs.next()) {
                String status = rs.getString("status");
                String paymentMethod = null;
                try { paymentMethod = rs.getString("paymentMethod"); } catch (Exception ignore) {}
                if (paymentMethod == null || paymentMethod.isEmpty()) {
                    paymentMethod = "Pending".equalsIgnoreCase(status) ? "vnpay" : "cod";
                }
                list.add(new Order(rs.getInt("id"),
                        rs.getInt("accountID"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getTimestamp("orderDate"),
                        rs.getDouble("totalPrice"),
                        status,
                        paymentMethod));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Order> getOrdersByPeriod(String period) {
        List<Order> list = new ArrayList<>();
        String query;
        
        switch (period) {
            case "today":
                query = "SELECT * FROM orders WHERE status != 'Cancelled' AND DATE(orderDate) = CURDATE() ORDER BY orderDate DESC";
                break;
            case "week":
                query = "SELECT * FROM orders WHERE status != 'Cancelled' AND YEAR(orderDate) = YEAR(CURDATE()) AND WEEK(orderDate, 1) = WEEK(CURDATE(), 1) ORDER BY orderDate DESC";
                break;
            case "month":
                query = "SELECT * FROM orders WHERE status != 'Cancelled' AND YEAR(orderDate) = YEAR(CURDATE()) AND MONTH(orderDate) = MONTH(CURDATE()) ORDER BY orderDate DESC";
                break;
            case "year":
                query = "SELECT * FROM orders WHERE status != 'Cancelled' AND YEAR(orderDate) = YEAR(CURDATE()) ORDER BY orderDate DESC";
                break;
            default:
                query = "SELECT * FROM orders ORDER BY orderDate DESC";
        }
        
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                String status = rs.getString("status");
                String paymentMethod = null;
                try { paymentMethod = rs.getString("paymentMethod"); } catch (Exception ignore) {}
                if (paymentMethod == null || paymentMethod.isEmpty()) {
                    paymentMethod = "Pending".equalsIgnoreCase(status) ? "vnpay" : "cod";
                }
                list.add(new Order(rs.getInt("id"),
                        rs.getInt("accountID"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getTimestamp("orderDate"),
                        rs.getDouble("totalPrice"),
                        status,
                        paymentMethod));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Order> getOrdersByAccountID(int accountID) {
        List<Order> list = new ArrayList<>();
        String query = "SELECT * FROM orders WHERE accountID = ? ORDER BY orderDate DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountID);
            rs = ps.executeQuery();
            while (rs.next()) {
                String status = rs.getString("status");
                String paymentMethod = null;
                try { paymentMethod = rs.getString("paymentMethod"); } catch (Exception ignore) {}
                if (paymentMethod == null || paymentMethod.isEmpty()) {
                    paymentMethod = "Pending".equalsIgnoreCase(status) ? "vnpay" : "cod";
                }
                list.add(new Order(rs.getInt("id"),
                        rs.getInt("accountID"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getTimestamp("orderDate"),
                        rs.getDouble("totalPrice"),
                        status,
                        paymentMethod));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<OrderDetail> getOrderDetailsByOrderID(int orderID) {
        List<OrderDetail> list = new ArrayList<>();
        String query = "SELECT * FROM orderdetails WHERE orderID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, orderID);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new OrderDetail(rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getDouble(5)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public double getTotalRevenue() {
        String query = "SELECT SUM(totalPrice) FROM orders WHERE status != 'Cancelled'";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public double getRevenueByDay(int year, int month, int day) {
        String query = "SELECT SUM(totalPrice) FROM orders WHERE status != 'Cancelled' " +
                      "AND YEAR(orderDate) = ? AND MONTH(orderDate) = ? AND DAY(orderDate) = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, year);
            ps.setInt(2, month);
            ps.setInt(3, day);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public double getRevenueByWeek(int year, int week) {
        String query = "SELECT SUM(totalPrice) FROM orders WHERE status != 'Cancelled' " +
                      "AND YEAR(orderDate) = ? AND WEEK(orderDate, 1) = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, year);
            ps.setInt(2, week);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public double getRevenueByMonth(int year, int month) {
        String query = "SELECT SUM(totalPrice) FROM orders WHERE status != 'Cancelled' " +
                      "AND YEAR(orderDate) = ? AND MONTH(orderDate) = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, year);
            ps.setInt(2, month);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public double getRevenueByYear(int year) {
        String query = "SELECT SUM(totalPrice) FROM orders WHERE status != 'Cancelled' " +
                      "AND YEAR(orderDate) = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, year);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public double getRevenueToday() {
        // Chỉ tính đơn hàng của ngày hôm nay (reset về 0 mỗi ngày mới)
        String query = "SELECT COALESCE(SUM(totalPrice), 0) FROM orders WHERE status != 'Cancelled' " +
                      "AND DATE(orderDate) = CURDATE()";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                double result = rs.getDouble(1);
                return rs.wasNull() ? 0 : result;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public double getRevenueThisWeek() {
        // Tính từ đầu tuần (Thứ 2) đến hôm nay - giữ nguyên số liệu các ngày trước, chỉ cộng thêm hôm nay
        String query = "SELECT COALESCE(SUM(totalPrice), 0) FROM orders WHERE status != 'Cancelled' " +
                      "AND YEAR(orderDate) = YEAR(CURDATE()) " +
                      "AND WEEK(orderDate, 1) = WEEK(CURDATE(), 1) " +
                      "AND DATE(orderDate) <= CURDATE()";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                double result = rs.getDouble(1);
                return rs.wasNull() ? 0 : result;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public double getRevenueThisMonth() {
        // Tính từ đầu tháng đến hôm nay - giữ nguyên số liệu các ngày trước, chỉ cộng thêm hôm nay
        String query = "SELECT COALESCE(SUM(totalPrice), 0) FROM orders WHERE status != 'Cancelled' " +
                      "AND YEAR(orderDate) = YEAR(CURDATE()) " +
                      "AND MONTH(orderDate) = MONTH(CURDATE()) " +
                      "AND DATE(orderDate) <= CURDATE()";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                double result = rs.getDouble(1);
                return rs.wasNull() ? 0 : result;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public double getRevenueThisYear() {
        // Tính từ đầu năm đến hôm nay - giữ nguyên số liệu các ngày trước, chỉ cộng thêm hôm nay
        String query = "SELECT COALESCE(SUM(totalPrice), 0) FROM orders WHERE status != 'Cancelled' " +
                      "AND YEAR(orderDate) = YEAR(CURDATE()) " +
                      "AND DATE(orderDate) <= CURDATE()";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                double result = rs.getDouble(1);
                return rs.wasNull() ? 0 : result;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // Tính revenue theo ngày cụ thể (không phải CURDATE)
    public double getRevenueBySelectedDate(int year, int month, int day) {
        // Tính doanh thu của ngày được chọn
        String query = "SELECT COALESCE(SUM(totalPrice), 0) FROM orders WHERE status != 'Cancelled' " +
                      "AND DATE(orderDate) = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, String.format("%04d-%02d-%02d", year, month, day));
            rs = ps.executeQuery();
            if (rs.next()) {
                double result = rs.getDouble(1);
                return rs.wasNull() ? 0 : result;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public double getRevenueBySelectedWeek(int year, int month, int day) {
    // Tính doanh thu từ đầu tuần của ngày được chọn đến ngày đó
    String query = "SELECT COALESCE(SUM(totalPrice), 0) FROM orders WHERE status != 'Cancelled' " +
                  "AND YEAR(orderDate) = ? " +
                  "AND WEEK(orderDate, 1) = WEEK(?, 1) " +
                  "AND DATE(orderDate) <= ?";
    try {
        conn = new DBContext().getConnection();
        ps = conn.prepareStatement(query);
        String selectedDate = String.format("%04d-%02d-%02d", year, month, day);
        ps.setInt(1, year);
        ps.setString(2, selectedDate);
        ps.setString(3, selectedDate);
        rs = ps.executeQuery();
        if (rs.next()) {
            double result = rs.getDouble(1);
            return rs.wasNull() ? 0 : result;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}

    // Helper to get color name by id
    public String getColorNameById(int colorId) {
        String query = "SELECT color_name FROM color WHERE color_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, colorId);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getString("color_name");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Helper to get size name by id
    public String getSizeNameById(int sizeId) {
        String query = "SELECT size_name FROM size WHERE size_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, sizeId);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getString("size_name");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

public double getRevenueBySelectedMonth(int year, int month, int day) {
    // Tính doanh thu từ đầu tháng của ngày được chọn đến ngày đó
    String query = "SELECT COALESCE(SUM(totalPrice), 0) FROM orders WHERE status != 'Cancelled' " +
                  "AND YEAR(orderDate) = ? " +
                  "AND MONTH(orderDate) = ? " +
                  "AND DATE(orderDate) <= ?";
    try {
        conn = new DBContext().getConnection();
        ps = conn.prepareStatement(query);
        String selectedDate = String.format("%04d-%02d-%02d", year, month, day);
        ps.setInt(1, year);
        ps.setInt(2, month);
        ps.setString(3, selectedDate);
        rs = ps.executeQuery();
        if (rs.next()) {
            double result = rs.getDouble(1);
            return rs.wasNull() ? 0 : result;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}

public double getRevenueBySelectedYear(int year, int month, int day) {
    // Tính doanh thu từ đầu năm của ngày được chọn đến ngày đó
    String query = "SELECT COALESCE(SUM(totalPrice), 0) FROM orders WHERE status != 'Cancelled' " +
                  "AND YEAR(orderDate) = ? " +
                  "AND DATE(orderDate) <= ?";
    try {
        conn = new DBContext().getConnection();
        ps = conn.prepareStatement(query);
        String selectedDate = String.format("%04d-%02d-%02d", year, month, day);
        ps.setInt(1, year);
        ps.setString(2, selectedDate);
        rs = ps.executeQuery();
        if (rs.next()) {
            double result = rs.getDouble(1);
            return rs.wasNull() ? 0 : result;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}
//    public double getRevenueBySelectedWeek(int year, int month, int day) {
//        // Tính từ đầu tuần của ngày được chọn đến ngày đó
//        String query = "SELECT COALESCE(SUM(totalPrice), 0) FROM orders WHERE status != 'Cancelled' " +
//                      "AND YEAR(orderDate) = ? " +
//                      "AND WEEK(orderDate, 1) = WEEK(?, 1) " +
//                      "AND DATE(orderDate) <= ?";
//        try {
//            conn = new DBContext().getConnection();
//            ps = conn.prepareStatement(query);
//            String selectedDate = String.format("%04d-%02d-%02d", year, month, day);
//            ps.setInt(1, year);
//            ps.setString(2, selectedDate);
//            ps.setString(3, selectedDate);
//            rs = ps.executeQuery();
//            if (rs.next()) {
//                double result = rs.getDouble(1);
//                return rs.wasNull() ? 0 : result;
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return 0;
//    }
//    
//    public double getRevenueBySelectedMonth(int year, int month, int day) {
//        // Tính từ đầu tháng của ngày được chọn đến ngày đó
//        String query = "SELECT COALESCE(SUM(totalPrice), 0) FROM orders WHERE status != 'Cancelled' " +
//                      "AND YEAR(orderDate) = ? " +
//                      "AND MONTH(orderDate) = ? " +
//                      "AND DATE(orderDate) <= ?";
//        try {
//            conn = new DBContext().getConnection();
//            ps = conn.prepareStatement(query);
//            String selectedDate = String.format("%04d-%02d-%02d", year, month, day);
//            ps.setInt(1, year);
//            ps.setInt(2, month);
//            ps.setString(3, selectedDate);
//            rs = ps.executeQuery();
//            if (rs.next()) {
//                double result = rs.getDouble(1);
//                return rs.wasNull() ? 0 : result;
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return 0;
//    }
//    
//    public double getRevenueBySelectedYear(int year, int month, int day) {
//        // Tính từ đầu năm của ngày được chọn đến ngày đó
//        String query = "SELECT COALESCE(SUM(totalPrice), 0) FROM orders WHERE status != 'Cancelled' " +
//                      "AND YEAR(orderDate) = ? " +
//                      "AND DATE(orderDate) <= ?";
//        try {
//            conn = new DBContext().getConnection();
//            ps = conn.prepareStatement(query);
//            String selectedDate = String.format("%04d-%02d-%02d", year, month, day);
//            ps.setInt(1, year);
//            ps.setString(2, selectedDate);
//            rs = ps.executeQuery();
//            if (rs.next()) {
//                double result = rs.getDouble(1);
//                return rs.wasNull() ? 0 : result;
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return 0;
//    }
//    
    // ========== USER MANAGEMENT (ADMIN) ==========
    public List<Account> getAllAccounts() {
        List<Account> list = new ArrayList<>();
        String query = "SELECT * FROM account";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                // id, user, pass, phone, email, isSell, isAdmin
                list.add(new Account(rs.getInt("id"),
                        rs.getString("user"),
                        rs.getString("pass"),
                        rs.getString("phone") != null ? rs.getString("phone") : "",
                        rs.getString("email") != null ? rs.getString("email") : "",
                        rs.getInt("isSell"),
                        rs.getInt("isAdmin")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public void deleteAccount(int id) {
        String query = "DELETE FROM account WHERE id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void updateAccount(int id, String user, String pass, int isSell, int isAdmin) {
        String query = "UPDATE account SET user=?, pass=?, isSell=?, isAdmin=? WHERE id=?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass);
            ps.setInt(3, isSell);
            ps.setInt(4, isAdmin);
            ps.setInt(5, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void addUserByAdmin(String user, String phone, String email, String pass, int isSell, int isAdmin) {
        String query = "INSERT INTO account (user, phone, email, pass, isSell, isAdmin) VALUES (?,?,?,?,?,?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, phone);
            ps.setString(3, email);
            ps.setString(4, pass);
            ps.setInt(5, isSell);
            ps.setInt(6, isAdmin);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void updateUserRole(int id, int isSell, int isAdmin) {
        String query = "UPDATE account SET isSell=?, isAdmin=? WHERE id=?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, isSell);
            ps.setInt(2, isAdmin);
            ps.setInt(3, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // ========== FORGOT PASSWORD METHODS ==========
    public Account checkUsernameAndEmail(String username, String email) {
        String query = "select * from account where user = ? and email = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, email);
            rs = ps.executeQuery();
            while(rs.next()) {
                return new Account(rs.getInt("id"),
                        rs.getString("user"),
                        rs.getString("pass"),
                        rs.getString("phone") != null ? rs.getString("phone") : "",
                        rs.getString("email") != null ? rs.getString("email") : "",
                        rs.getInt("isSell"),
                        rs.getInt("isAdmin"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public void updatePassword(String username, String newPassword) {
        String query = "UPDATE account SET pass = ? WHERE user = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, newPassword);
            ps.setString(2, username);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void updatePasswordById(int accountId, String newPassword) {
        String query = "UPDATE account SET pass = ? WHERE id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, newPassword);
            ps.setInt(2, accountId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // ========== SOLD PRODUCTS MANAGEMENT (ADMIN) ==========
    public static class SoldProductInfo {
        private Product product;
        private int totalSold;
        private double totalRevenue;
        private int processingCount;  // Số đơn đang xử lí
        private int deliveredCount;   // Số đơn đã giao hàng

        public SoldProductInfo(Product product, int totalSold, double totalRevenue) {
            this.product = product;
            this.totalSold = totalSold;
            this.totalRevenue = totalRevenue;
            this.processingCount = 0;
            this.deliveredCount = 0;
        }
        
        public SoldProductInfo(Product product, int totalSold, double totalRevenue, int processingCount, int deliveredCount) {
            this.product = product;
            this.totalSold = totalSold;
            this.totalRevenue = totalRevenue;
            this.processingCount = processingCount;
            this.deliveredCount = deliveredCount;
        }

        public Product getProduct() {
            return product;
        }

        public int getTotalSold() {
            return totalSold;
        }

        public double getTotalRevenue() {
            return totalRevenue;
        }
        
        public int getProcessingCount() {
            return processingCount;
        }
        
        public int getDeliveredCount() {
            return deliveredCount;
        }
    }
    
    public List<SoldProductInfo> getSoldProducts() {
        List<SoldProductInfo> list = new ArrayList<>();
        // Use variant-aware join: orderdetails.variant_id -> product_variants -> product
        String query = "SELECT p.id, p.name, p.image, p.price, p.title, p.description, p.cateID, "
                     + "SUM(od.amount) AS totalSold, SUM(od.amount * od.price) AS totalRevenue "
                     + "FROM orderdetails od "
                     + "JOIN orders o ON od.orderID = o.id "
                     + "JOIN product_variants pv ON od.variant_id = pv.variant_id "
                     + "JOIN product p ON pv.product_id = p.id "
                     + "WHERE o.status != 'Cancelled' "
                     + "GROUP BY p.id, p.name, p.image, p.price, p.title, p.description, p.cateID "
                     + "ORDER BY totalSold DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                // Tạo Product object trực tiếp từ kết quả query
                Product product = new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("image"),
                    rs.getLong("price"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getInt("cateID")
                );
                int totalSold = rs.getInt("totalSold");
                double totalRevenue = rs.getDouble("totalRevenue");
                
                list.add(new SoldProductInfo(product, totalSold, totalRevenue));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<SoldProductInfo> getSoldProductsBySellID(int sellID) {
        List<SoldProductInfo> list = new ArrayList<>();
        // Variant-aware query filtered by seller id
        String query = "SELECT p.id, p.name, p.image, p.price, p.title, p.description, p.cateID, "
                     + "SUM(od.amount) AS totalSold, SUM(od.amount * od.price) AS totalRevenue, "
                     + "SUM(CASE WHEN o.status = 'Processing' THEN 1 ELSE 0 END) AS processingCount, "
                     + "SUM(CASE WHEN o.status = 'Delivered' THEN 1 ELSE 0 END) AS deliveredCount "
                     + "FROM orderdetails od "
                     + "JOIN orders o ON od.orderID = o.id "
                     + "JOIN product_variants pv ON od.variant_id = pv.variant_id "
                     + "JOIN product p ON pv.product_id = p.id "
                     + "WHERE o.status != 'Cancelled' AND p.sell_ID = ? "
                     + "GROUP BY p.id, p.name, p.image, p.price, p.title, p.description, p.cateID "
                     + "ORDER BY totalSold DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, sellID);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("image"),
                    rs.getLong("price"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getInt("cateID")
                );
                int totalSold = rs.getInt("totalSold");
                double totalRevenue = rs.getDouble("totalRevenue");
                int processingCount = rs.getInt("processingCount");
                int deliveredCount = rs.getInt("deliveredCount");
                
                list.add(new SoldProductInfo(product, totalSold, totalRevenue, processingCount, deliveredCount));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ========== DASHBOARD STATISTICS ==========
    public int getNewOrdersCount() {
        // Đếm số đơn hàng đang xử lí (Processing)
        String query = "SELECT COUNT(*) FROM orders WHERE status = 'Processing'";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public double getMonthlyRevenue() {
        // Doanh thu tháng hiện tại
        String query = "SELECT COALESCE(SUM(totalPrice), 0) FROM orders WHERE status != 'Cancelled' " +
                      "AND YEAR(orderDate) = YEAR(CURDATE()) " +
                      "AND MONTH(orderDate) = MONTH(CURDATE())";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                double result = rs.getDouble(1);
                return rs.wasNull() ? 0 : result;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public int getTotalProductsCount() {
        String query = "SELECT COUNT(*) FROM product";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Pagination: fetch products with offset and limit
    public List<Product> getProductsByPage(int offset, int limit) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM product LIMIT ? OFFSET ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, limit);
            ps.setInt(2, offset);
            rs = ps.executeQuery();
            while (rs.next()) {
        Product p = new Product(rs.getInt("id"),
            rs.getString("name"),
            rs.getString("image"),
            rs.getLong("price"),
            rs.getString("title"),
            rs.getString("description"),
            rs.getInt("cateID"));
        try { p.setQuantity(rs.getInt("quantity")); } catch (Exception ignore) {}
        list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Pagination: fetch products with offset and limit and optional sort
    public List<Product> getProductsByPageSorted(int offset, int limit, String sort) {
        List<Product> list = new ArrayList<>();
        String query = null;
        try {
            conn = new DBContext().getConnection();
            if ("popular".equals(sort)) {
                // sort by total sold (most purchases)
                query = "SELECT p.*, COALESCE(SUM(od.amount),0) as sold FROM product p LEFT JOIN orderdetails od ON p.id = od.productID GROUP BY p.id ORDER BY sold DESC LIMIT ? OFFSET ?";
                ps = conn.prepareStatement(query);
                ps.setInt(1, limit);
                ps.setInt(2, offset);
            } else if ("price_asc".equals(sort)) {
                query = "SELECT * FROM product ORDER BY price ASC LIMIT ? OFFSET ?";
                ps = conn.prepareStatement(query);
                ps.setInt(1, limit);
                ps.setInt(2, offset);
            } else if ("price_desc".equals(sort)) {
                query = "SELECT * FROM product ORDER BY price DESC LIMIT ? OFFSET ?";
                ps = conn.prepareStatement(query);
                ps.setInt(1, limit);
                ps.setInt(2, offset);
            } else {
                // default ordering
                query = "SELECT * FROM product LIMIT ? OFFSET ?";
                ps = conn.prepareStatement(query);
                ps.setInt(1, limit);
                ps.setInt(2, offset);
            }

            rs = ps.executeQuery();
            while (rs.next()) {
        Product p = new Product(rs.getInt("id"),
            rs.getString("name"),
            rs.getString("image"),
            rs.getLong("price"),
            rs.getString("title"),
            rs.getString("description"),
            rs.getInt("cateID"));
        try { p.setQuantity(rs.getInt("quantity")); } catch (Exception ignore) {}
        list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Count products matching filters (color, size, price range, optional category, optional text)
    public int getTotalProductsCountFiltered(Integer colorId, Integer sizeId, double minPrice, double maxPrice, Integer cid, String txtSearch) {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT COUNT(DISTINCT p.id) FROM product p LEFT JOIN product_variants pv ON pv.product_id = p.id WHERE p.price BETWEEN ? AND ? AND pv.quantity > 0");
        if (colorId != null && colorId > 0) {
            sb.append(" AND pv.color_id = ?");
        }
        if (sizeId != null && sizeId > 0) {
            sb.append(" AND pv.size_id = ?");
        }
        if (cid != null) {
            sb.append(" AND p.cateID = ?");
        }
        if (txtSearch != null && !txtSearch.trim().isEmpty()) {
            sb.append(" AND p.name LIKE ?");
        }

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sb.toString());
            int idx = 1;
            ps.setDouble(idx++, minPrice);
            ps.setDouble(idx++, maxPrice);
            if (colorId != null && colorId > 0) ps.setInt(idx++, colorId);
            if (sizeId != null && sizeId > 0) ps.setInt(idx++, sizeId);
            if (cid != null) ps.setInt(idx++, cid);
            if (txtSearch != null && !txtSearch.trim().isEmpty()) ps.setString(idx++, "%" + txtSearch + "%");

            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Fetch products matching filters with pagination and simple sorting (price asc/desc)
    public List<Product> getProductsByFilter(int offset, int limit, String sort, Integer colorId, Integer sizeId, double minPrice, double maxPrice, Integer cid, String txtSearch) {
        List<Product> list = new ArrayList<>();
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT DISTINCT p.* FROM product p JOIN product_variants pv ON pv.product_id = p.id WHERE p.price BETWEEN ? AND ? AND pv.quantity > 0");
        if (colorId != null && colorId > 0) {
            sb.append(" AND pv.color_id = ?");
        }
        if (sizeId != null && sizeId > 0) {
            sb.append(" AND pv.size_id = ?");
        }
        if (cid != null) {
            sb.append(" AND p.cateID = ?");
        }
        if (txtSearch != null && !txtSearch.trim().isEmpty()) {
            sb.append(" AND p.name LIKE ?");
        }

        // Sorting
        if ("price_asc".equals(sort)) {
            sb.append(" ORDER BY p.price ASC");
        } else if ("price_desc".equals(sort)) {
            sb.append(" ORDER BY p.price DESC");
        } else {
            sb.append(" ORDER BY p.id DESC");
        }

        sb.append(" LIMIT ? OFFSET ?");

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sb.toString());
            int idx = 1;
            ps.setDouble(idx++, minPrice);
            ps.setDouble(idx++, maxPrice);
            if (colorId != null && colorId > 0) ps.setInt(idx++, colorId);
            if (sizeId != null && sizeId > 0) ps.setInt(idx++, sizeId);
            if (cid != null) ps.setInt(idx++, cid);
            if (txtSearch != null && !txtSearch.trim().isEmpty()) ps.setString(idx++, "%" + txtSearch + "%");

            ps.setInt(idx++, limit);
            ps.setInt(idx++, offset);

            rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getLong("price"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getInt("cateID"));
                try { p.setQuantity(rs.getInt("quantity")); } catch (Exception ignore) {}
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Pagination for category
    public List<Product> getProductsByCIDPaginated(int cid, int offset, int limit) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM product WHERE cateID = ? LIMIT ? OFFSET ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, cid);
            ps.setInt(2, limit);
            ps.setInt(3, offset);
            rs = ps.executeQuery();
            while (rs.next()) {
        Product p = new Product(rs.getInt("id"),
            rs.getString("name"),
            rs.getString("image"),
            rs.getLong("price"),
            rs.getString("title"),
            rs.getString("description"),
            rs.getInt("cateID"));
        try { p.setQuantity(rs.getInt("quantity")); } catch (Exception ignore) {}
        list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Pagination for category with sort option
    public List<Product> getProductsByCIDPaginatedSorted(int cid, int offset, int limit, String sort) {
        List<Product> list = new ArrayList<>();
        String query = null;
        try {
            conn = new DBContext().getConnection();
            if ("popular".equals(sort)) {
                query = "SELECT p.*, COALESCE(SUM(od.amount),0) as sold FROM product p LEFT JOIN orderdetails od ON p.id = od.productID WHERE p.cateID = ? GROUP BY p.id ORDER BY sold DESC LIMIT ? OFFSET ?";
                ps = conn.prepareStatement(query);
                ps.setInt(1, cid);
                ps.setInt(2, limit);
                ps.setInt(3, offset);
            } else if ("price_asc".equals(sort)) {
                query = "SELECT * FROM product WHERE cateID = ? ORDER BY price ASC LIMIT ? OFFSET ?";
                ps = conn.prepareStatement(query);
                ps.setInt(1, cid);
                ps.setInt(2, limit);
                ps.setInt(3, offset);
            } else if ("price_desc".equals(sort)) {
                query = "SELECT * FROM product WHERE cateID = ? ORDER BY price DESC LIMIT ? OFFSET ?";
                ps = conn.prepareStatement(query);
                ps.setInt(1, cid);
                ps.setInt(2, limit);
                ps.setInt(3, offset);
            } else {
                query = "SELECT * FROM product WHERE cateID = ? LIMIT ? OFFSET ?";
                ps = conn.prepareStatement(query);
                ps.setInt(1, cid);
                ps.setInt(2, limit);
                ps.setInt(3, offset);
            }

            rs = ps.executeQuery();
            while (rs.next()) {
        Product p = new Product(rs.getInt("id"),
            rs.getString("name"),
            rs.getString("image"),
            rs.getLong("price"),
            rs.getString("title"),
            rs.getString("description"),
            rs.getInt("cateID"));
        try { p.setQuantity(rs.getInt("quantity")); } catch (Exception ignore) {}
        list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalProductsCountByCID(int cid) {
        String query = "SELECT COUNT(*) FROM product WHERE cateID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, cid);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Pagination for search
    public List<Product> searchByNamePaginated(String txtSearch, int offset, int limit) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM product WHERE name LIKE ? LIMIT ? OFFSET ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + txtSearch + "%");
            ps.setInt(2, limit);
            ps.setInt(3, offset);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getLong("price"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getInt("cateID")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Search with pagination and optional sort
    public List<Product> searchByNamePaginatedSorted(String txtSearch, int offset, int limit, String sort) {
        List<Product> list = new ArrayList<>();
        String query = null;
        try {
            conn = new DBContext().getConnection();
            if ("popular".equals(sort)) {
                query = "SELECT p.*, COALESCE(SUM(od.amount),0) as sold FROM product p LEFT JOIN orderdetails od ON p.id = od.productID WHERE p.name LIKE ? GROUP BY p.id ORDER BY sold DESC LIMIT ? OFFSET ?";
                ps = conn.prepareStatement(query);
                ps.setString(1, "%" + txtSearch + "%");
                ps.setInt(2, limit);
                ps.setInt(3, offset);
            } else if ("price_asc".equals(sort)) {
                query = "SELECT * FROM product WHERE name LIKE ? ORDER BY price ASC LIMIT ? OFFSET ?";
                ps = conn.prepareStatement(query);
                ps.setString(1, "%" + txtSearch + "%");
                ps.setInt(2, limit);
                ps.setInt(3, offset);
            } else if ("price_desc".equals(sort)) {
                query = "SELECT * FROM product WHERE name LIKE ? ORDER BY price DESC LIMIT ? OFFSET ?";
                ps = conn.prepareStatement(query);
                ps.setString(1, "%" + txtSearch + "%");
                ps.setInt(2, limit);
                ps.setInt(3, offset);
            } else {
                query = "SELECT * FROM product WHERE name LIKE ? LIMIT ? OFFSET ?";
                ps = conn.prepareStatement(query);
                ps.setString(1, "%" + txtSearch + "%");
                ps.setInt(2, limit);
                ps.setInt(3, offset);
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getLong("price"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getInt("cateID")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalProductsCountBySearch(String txtSearch) {
        String query = "SELECT COUNT(*) FROM product WHERE name LIKE ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + txtSearch + "%");
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public int getTotalCustomersCount() {
        String query = "SELECT COUNT(*) FROM account WHERE isAdmin = 0";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public static void main(String[] args) {
        DAO dao = new DAO();
        List<Product> list = dao.getAllProduct();
        List<Category> listC = dao.getAllCategory();

        for (Product o : list) {
            System.out.println(o);
        }
    }

}
