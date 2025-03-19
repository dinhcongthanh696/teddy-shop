package entity;

public class Cart {
    private int id;
    private int userId;
    
    // Default constructor
    public Cart() { }
    
    // Parameterized constructor (optional)
    public Cart(int id, int userId) {
        this.id = id;
        this.userId = userId;
    }
    
    // Getters and setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
}
