package service;

import dao.ProductDAO;
import entity.Product;

import java.util.List;

public class ProductService {
    private final ProductDAO productDAO = new ProductDAO();

    public List<Product> getAllProduct() { return productDAO.getAllProduct(); }
    public List<Product> getProductByCID(int cid) { return productDAO.getProductByCID(cid); }
    public Product getProductByID(int id) { return productDAO.getProductByID(id); }
}
