package entity;

public class ProductVariant {
    private int variantId;
    private int productId;
    private int colorId;
    private int sizeId;
    private int quantity;
    private String sku;
    private String colorName;
    private String sizeName;

    public ProductVariant() {}

    public ProductVariant(int variantId, int productId, int colorId, int sizeId, int quantity, String sku) {
        this.variantId = variantId;
        this.productId = productId;
        this.colorId = colorId;
        this.sizeId = sizeId;
        this.quantity = quantity;
        this.sku = sku;
    }

    public ProductVariant(int variantId, int productId, int colorId, int sizeId, int quantity, String sku, String colorName, String sizeName) {
        this.variantId = variantId;
        this.productId = productId;
        this.colorId = colorId;
        this.sizeId = sizeId;
        this.quantity = quantity;
        this.sku = sku;
        this.colorName = colorName;
        this.sizeName = sizeName;
    }

    public int getVariantId() { return variantId; }
    public void setVariantId(int variantId) { this.variantId = variantId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getColorId() { return colorId; }
    public void setColorId(int colorId) { this.colorId = colorId; }

    public int getSizeId() { return sizeId; }
    public void setSizeId(int sizeId) { this.sizeId = sizeId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getSku() { return sku; }
    public void setSku(String sku) { this.sku = sku; }

    public String getColorName() { return colorName; }
    public void setColorName(String colorName) { this.colorName = colorName; }

    public String getSizeName() { return sizeName; }
    public void setSizeName(String sizeName) { this.sizeName = sizeName; }
}
