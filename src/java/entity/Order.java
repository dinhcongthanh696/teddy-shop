package entity;

import java.util.Date;
import java.util.List;

public class Order {
    private int id;
    private int totalCost;
    private int status; // 0: pending, 1: shipping, 2: delivered, -1: cancelled
    private int userId;
    private Date orderDate;
    private Date arrivedAt;
    private String address;
    private List<OrderDetail> details; // Order details (with product info)
    private User user; // The user who placed the order

    public Order() { }

    // Getters and setters
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public int getTotalCost() {
        return totalCost;
    }
    public void setTotalCost(int totalCost) {
        this.totalCost = totalCost;
    }
    public int getStatus() {
        return status;
    }
    public void setStatus(int status) {
        this.status = status;
    }
    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }
    public Date getOrderDate() {
        return orderDate;
    }
    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }
    public Date getArrivedAt() {
        return arrivedAt;
    }
    public void setArrivedAt(Date arrivedAt) {
        this.arrivedAt = arrivedAt;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public List<OrderDetail> getDetails() {
        return details;
    }
    public void setDetails(List<OrderDetail> details) {
        this.details = details;
    }
    public User getUser() {
        return user;
    }
    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "Order{" + "id=" + id + ", totalCost=" + totalCost + ", status=" + status + ", userId=" + userId + ", orderDate=" + orderDate + ", arrivedAt=" + arrivedAt + ", address=" + address + ", details=" + details + ", user=" + user + '}';
    }
    
}
