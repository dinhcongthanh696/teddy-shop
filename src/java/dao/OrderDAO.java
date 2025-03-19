package dao;

import entity.Order;
import entity.OrderDetail;
import entity.Product;
import entity.ProductImage;
import entity.Size;
import entity.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class OrderDAO extends DBConnection {

    public OrderDAO() {
    }

    // Inserts an order and returns the generated order ID.
    public int createOrder(Order order) throws Exception {
        int generatedId = -1;
        String sql = "INSERT INTO [Order] (totalCost, status, userId, orderDate) VALUES (?, ?, ?, GETDATE())";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, order.getTotalCost());
            ps.setInt(2, order.getStatus());
            ps.setInt(3, order.getUserId());
            ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                generatedId = rs.getInt(1);
            }
        } finally {
            closeResultSet(rs);
            closePreparedStatement(ps);
            closeConnection(conn);
        }
        return generatedId;
    }

    // Inserts multiple order details for a given order.
    public void createOrderDetails(int orderId, List<OrderDetail> details) throws Exception {
        String sql = "INSERT INTO OrderDetail (orderId, productId, quantity) VALUES (?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            for (OrderDetail detail : details) {
                ps.setInt(1, orderId);
                ps.setInt(2, detail.getProductId());
                ps.setInt(3, detail.getQuantity());
                ps.addBatch();
            }
            ps.executeBatch();
        } finally {
            closePreparedStatement(ps);
            closeConnection(conn);
        }
    }

    // Creates an order with its details in a single transaction.
    public void createOrderWithDetails(Order order, List<OrderDetail> details) throws Exception {
        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            int orderId = -1;
            String sqlOrder = "INSERT INTO [Order] (totalCost, status, userId, orderDate) VALUES (?, ?, ?, GETDATE())";
            try (PreparedStatement psOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS)) {
                psOrder.setInt(1, order.getTotalCost());
                psOrder.setInt(2, order.getStatus());
                psOrder.setInt(3, order.getUserId());
                psOrder.executeUpdate();
                try (ResultSet rs = psOrder.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderId = rs.getInt(1);
                    }
                }
            }

            String sqlDetail = "INSERT INTO OrderDetail (orderId, productId, quantity) VALUES (?, ?, ?)";
            try (PreparedStatement psDetail = conn.prepareStatement(sqlDetail)) {
                for (OrderDetail detail : details) {
                    psDetail.setInt(1, orderId);
                    psDetail.setInt(2, detail.getProductId());
                    psDetail.setInt(3, detail.getQuantity());
                    psDetail.addBatch();
                }
                psDetail.executeBatch();
            }

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                closeConnection(conn);
            }
        }
    }

    public List<Order> getOrdersByUserSearch(int userId, String search, int offset, int pageSize) throws Exception {
        List<Order> orders = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT o.id, o.totalCost, o.status, o.userId, o.orderDate, o.arrivedAt ")
                .append("FROM [Order] o ")
                .append("WHERE o.userId = ? ");
        if (search != null && !search.trim().isEmpty()) {
            // Filter orders that have at least one product whose name matches the search text
            sql.append("AND o.id IN (")
                    .append("SELECT DISTINCT od.orderId FROM OrderDetail od ")
                    .append("JOIN Product p ON od.productId = p.id ")
                    .append("WHERE p.name COLLATE Latin1_General_CI_AI LIKE ?")
                    .append(") ");
        }
        sql.append("ORDER BY o.orderDate DESC ")
                .append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql.toString());
            ps.setInt(1, userId);
            int paramIndex = 2;
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + search + "%");
            }
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex, pageSize);
            rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setTotalCost(rs.getInt("totalCost"));
                order.setStatus(rs.getInt("status"));
                order.setUserId(rs.getInt("userId"));
                order.setOrderDate(rs.getTimestamp("orderDate"));
                order.setArrivedAt(rs.getTimestamp("arrivedAt"));

                orders.add(order);
            }
        } finally {
            closeResultSet(rs);
            closePreparedStatement(ps);
            closeConnection(conn);
        }
        return orders;
    }

    public List<OrderDetail> getOrderDetails(int orderId) throws Exception {
        List<OrderDetail> details = new ArrayList<>();
        String sql = "SELECT od.id, od.orderId, od.productId, od.quantity, p.name, "
                + "       (SELECT TOP 1 price FROM Size WHERE productId = p.id ORDER BY id) AS price, "
                + "       (SELECT TOP 1 [source] FROM ProductImage WHERE productId = p.id ORDER BY id) AS image "
                + "FROM OrderDetail od "
                + "JOIN Product p ON od.productId = p.id "
                + "WHERE od.orderId = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetail detail = new OrderDetail();
                detail.setId(rs.getInt("id"));
                detail.setOrderId(rs.getInt("orderId"));
                detail.setProductId(rs.getInt("productId"));
                detail.setQuantity(rs.getInt("quantity"));

                // Build minimal product info
                Product product = new Product();
                product.setId(rs.getInt("productId"));
                product.setName(rs.getString("name"));

                // Set default price in a new Size object
                ArrayList<Size> sizes = new ArrayList<>();
                Size size = new Size();
                size.setPrice(rs.getString("price"));
                sizes.add(size);
                product.setSizes(sizes);

                // Set default image in an ArrayList
                ArrayList<ProductImage> images = new ArrayList<>();
                String imageSrc = rs.getString("image");
                if (imageSrc != null) {
                    ProductImage pi = new ProductImage();
                    pi.setSource(imageSrc);
                    images.add(pi);
                }
                product.setImages(images);

                detail.setProduct(product);
                details.add(detail);
            }
        } finally {
            closeResultSet(rs);
            closePreparedStatement(ps);
            closeConnection(conn);
        }
        return details;
    }

    // Count the total number of orders for a user (with optional product name filter)
    public int countOrdersByUserSearch(int userId, String search) throws Exception {
        int count = 0;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) AS total FROM [Order] o ")
                .append("WHERE o.userId = ? ");
        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND o.id IN (")
                    .append("SELECT DISTINCT od.orderId FROM OrderDetail od ")
                    .append("JOIN Product p ON od.productId = p.id ")
                    .append("WHERE p.name COLLATE Latin1_General_CI_AI LIKE ?")
                    .append(") ");
        }
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql.toString());
            ps.setInt(1, userId);
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(2, "%" + search + "%");
            }
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } finally {
            closeResultSet(rs);
            closePreparedStatement(ps);
            closeConnection(conn);
        }
        return count;
    }

    // Cancel an order (only if it is pending: status = 0)
    public void cancelOrder(int orderId) throws Exception {
        String sql = "UPDATE [Order] SET status = 3 WHERE id = ? AND status = 0";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.executeUpdate();
        } finally {
            closePreparedStatement(ps);
            closeConnection(conn);
        }
    }

    public Order getOrderById(int orderId) throws Exception {
        Order order = null;
        String sql = "SELECT o.id, o.totalCost, o.status, o.userId, o.orderDate, o.arrivedAt,  "
                + "u.userName, u.email, u.phoneNumber, u.location, u.profilePic "
                + "FROM [Order] o "
                + "JOIN [User] u ON o.userId = u.id "
                + "WHERE o.id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();
            if (rs.next()) {
                order = new Order();
                order.setId(rs.getInt("id"));
                order.setTotalCost(rs.getInt("totalCost"));
                order.setStatus(rs.getInt("status"));
                order.setUserId(rs.getInt("userId"));
                order.setOrderDate(rs.getTimestamp("orderDate"));
                order.setArrivedAt(rs.getTimestamp("arrivedAt"));

                // Build the User object from the joined user info
                User user = new User();
                user.setId(rs.getInt("userId"));
                user.setUserName(rs.getString("userName"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNumber(rs.getString("phoneNumber"));
                user.setLocation(rs.getString("location"));
                user.setProfilePic(rs.getString("profilePic"));

                order.setUser(user);
            }
        } finally {
            closeResultSet(rs);
            closePreparedStatement(ps);
            closeConnection(conn);
        }
        return order;
    }
    // Count all orders that match a search (search can match username or product name)

    public int countAllOrdersWithSearch(String search) throws Exception {
        int count = 0;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(DISTINCT o.id) AS total ")
                .append("FROM [Order] o ")
                .append("JOIN [User] u ON o.userId = u.id ")
                .append("WHERE 1=1 ");
        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND (u.userName COLLATE Latin1_General_CI_AI LIKE ? ")
                    .append("OR o.id IN (")
                    .append("    SELECT DISTINCT od.orderId FROM OrderDetail od ")
                    .append("    JOIN Product p ON od.productId = p.id ")
                    .append("    WHERE p.name COLLATE Latin1_General_CI_AI LIKE ?")
                    .append(") ) ");
        }

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql.toString());
            int paramIndex = 1;
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
            }
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } finally {
            closeResultSet(rs);
            closePreparedStatement(ps);
            closeConnection(conn);
        }
        return count;
    }

// Get a paged list of orders with search (by username or product name)
    public List<Order> getOrdersWithSearch(String search, int offset, int pageSize) throws Exception {
        List<Order> orders = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT DISTINCT o.id, o.totalCost, o.status, o.userId, o.orderDate, o.arrivedAt, ")
                .append("       u.userName, u.email, u.phoneNumber, u.location, u.profilePic ")
                .append("FROM [Order] o ")
                .append("JOIN [User] u ON o.userId = u.id ")
                .append("WHERE 1=1 ");
        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND (u.userName COLLATE Latin1_General_CI_AI LIKE ? ")
                    .append("OR o.id IN (")
                    .append("    SELECT DISTINCT od.orderId FROM OrderDetail od ")
                    .append("    JOIN Product p ON od.productId = p.id ")
                    .append("    WHERE p.name COLLATE Latin1_General_CI_AI LIKE ?")
                    .append(") ) ");
        }
        sql.append("ORDER BY o.orderDate DESC ")
                .append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql.toString());
            int paramIndex = 1;
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
            }
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex, pageSize);
            rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setTotalCost(rs.getInt("totalCost"));
                order.setStatus(rs.getInt("status"));
                order.setUserId(rs.getInt("userId"));
                order.setOrderDate(rs.getTimestamp("orderDate"));
                order.setArrivedAt(rs.getTimestamp("arrivedAt"));

                // Build the User object
                User user = new User();
                user.setId(rs.getInt("userId"));
                user.setUserName(rs.getString("userName"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNumber(rs.getString("phoneNumber"));
                user.setLocation(rs.getString("location"));
                user.setProfilePic(rs.getString("profilePic"));
                order.setUser(user);

                orders.add(order);
            }
        } finally {
            closeResultSet(rs);
            closePreparedStatement(ps);
            closeConnection(conn);
        }
        return orders;
    }

// Update order status from pending (0) to shipping (1)
    public void acceptOrder(int orderId) throws Exception {
        String sql = "UPDATE [Order] SET status = 1 WHERE id = ? AND status = 0";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.executeUpdate();
        } finally {
            closePreparedStatement(ps);
            closeConnection(conn);
        }
    }

// Update order status from shipping (1) to delivered (2)
    public void markDelivered(int orderId) throws Exception {
        String sql = "UPDATE [Order] SET status = 2 WHERE id = ? AND status = 1";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.executeUpdate();
        } finally {
            closePreparedStatement(ps);
            closeConnection(conn);
        }
    }

    public static void main(String[] args) {
        OrderDAO o = new OrderDAO();
        try {
            System.out.println(o.getOrderById(1));
        } catch (Exception ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
