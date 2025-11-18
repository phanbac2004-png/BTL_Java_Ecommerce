package entity;

public class Cart {
    private Product product;
    private ProductVariant variant;
    private int amount;

    public Cart() {
    }

    public Cart(Product product, int amount) {
        this.product = product;
        this.amount = amount;
    }

    public Cart(Product product, ProductVariant variant, int amount) {
        this.product = product;
        this.variant = variant;
        this.amount = amount;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }
    
    public double getTotalPrice() {
        return product.getPrice() * amount;
    }

    public ProductVariant getVariant() {
        return variant;
    }

    public void setVariant(ProductVariant variant) {
        this.variant = variant;
    }
}

