package entity;

public class CartDetail {

    private int id;
    private int cartId;
    private int productId;
    private int quantity;

    // Default constructor
    public CartDetail() {
    }

    // Parameterized constructor (optional)
    public CartDetail(int id, int cartId, int productId) {
        this.id = id;
        this.cartId = cartId;
        this.productId = productId;
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
}
