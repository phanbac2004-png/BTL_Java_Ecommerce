package entity;

public class OrderDetail {
    private int id;
    private int orderID;
    private int productID;
    private int amount;
    private double price;

    public OrderDetail() {
    }

    public OrderDetail(int id, int orderID, int productID, int amount, double price) {
        this.id = id;
        this.orderID = orderID;
        this.productID = productID;
        this.amount = amount;
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}

