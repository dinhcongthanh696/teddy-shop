package dao;

import entity.Cart;
import entity.CartItem;
import entity.Product;
import entity.ProductImage;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO extends DBConnection {

    public CartDAO() {
    }

    // Get the Cart for a given user; returns null if none exists.
    public Cart getCartByUserId(int userId) throws Exception {
        Cart cart = null;
        String sql = "SELECT * FROM Cart WHERE userId = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                cart = new Cart();
                cart.setId(rs.getInt("id"));
                cart.setUserId(rs.getInt("userId"));
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(ps);
            closeConnection(conn);
        }
        return cart;
    }

    // Create a new cart for the user and return its generated id.
    public int createCart(int userId) throws Exception {
        int generatedId = -1;
        String sql = "INSERT INTO Cart(userId) VALUES(?)";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, userId);
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    generatedId = rs.getInt(1);
                }
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(ps);
            closeConnection(conn);
        }
        return generatedId;
    }

    // Add a product to the cart (insert into CartDetail)
    public void addCartDetail(int cartId, int productId, int quantity) throws Exception {
        String sql = "INSERT INTO CartDetail(cartId, productId, quantity) VALUES(?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, cartId);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw ex;
        } finally {
            closePreparedStatement(ps);
            closeConnection(conn);
        }
    }

    // Retrieve products in the user's cart by joining Cart, CartDetail, and Product.
    public List<Product> getProductsInCart(int userId) throws Exception {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.* FROM CartDetail cd "
                + "JOIN Cart c ON cd.cartId = c.id "
                + "JOIN Product p ON cd.productId = p.id "
                + "WHERE c.userId = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                // Set additional fields (price, image, etc.) if needed.
                products.add(product);
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(ps);
            closeConnection(conn);
        }
        return products;
    }
    // In CartDAO.java

    public List<CartItem> getCartItems(int userId) throws Exception {
        List<CartItem> items = new ArrayList<>();
        // The subquery "def" selects the default size (the one with the smallest id) for each product.
        String sql = "SELECT p.id, p.name, def.price, img.[source] AS image, SUM(cd.quantity) AS totalQuantity "
                + "FROM CartDetail cd "
                + "JOIN Cart c ON cd.cartId = c.id "
                + "JOIN Product p ON cd.productId = p.id "
                + "JOIN ( "
                + "    SELECT productId, price FROM Size "
                + "    WHERE id IN (SELECT MIN(id) FROM Size GROUP BY productId) "
                + ") def ON def.productId = p.id "
                + "JOIN ( "
                + "    SELECT productId, [source] FROM ProductImage "
                + "    WHERE id IN (SELECT MIN(id) FROM ProductImage GROUP BY productId) "
                + ") img ON img.productId = p.id "
                + "WHERE c.userId = ? "
                + "GROUP BY p.id, p.name, def.price, img.[source]";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));

                // Retrieve the default image from the result set.
                String imageSource = rs.getString("image");
                ArrayList<ProductImage> images = new ArrayList<>();
                if (imageSource != null && !imageSource.isEmpty()) {
                    ProductImage pi = new ProductImage();
                    pi.setSource(imageSource);
                    images.add(pi);
                }
                product.setImages(images);

                int qty = rs.getInt("totalQuantity");
                int unitPrice = rs.getInt("price");

                CartItem cartItem = new CartItem(product, qty, unitPrice);
                items.add(cartItem);

            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(ps);
            closeConnection(conn);
        }
        return items;
    }

    public int getCartItemQuantity(int userId, int productId) throws Exception {
        int quantity = 0;
        String sql = "SELECT cd.quantity FROM CartDetail cd "
                + "JOIN Cart c ON cd.cartId = c.id "
                + "WHERE c.userId = ? AND cd.productId = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            rs = ps.executeQuery();
            if (rs.next()) {
                quantity = rs.getInt("quantity");
            }
        } finally {
            closeResultSet(rs);
            closePreparedStatement(ps);
            closeConnection(conn);
        }
        return quantity;
    }

    // Update the quantity for a cart item (assumes one row per product per cart).
    public void updateCartItemQuantity(int userId, int productId, int newQuantity) throws Exception {
        String sql = "UPDATE CartDetail SET quantity = ? "
                + "WHERE cartId = (SELECT id FROM Cart WHERE userId = ?) "
                + "AND productId = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, newQuantity);
            ps.setInt(2, userId);
            ps.setInt(3, productId);
            ps.executeUpdate();
        } finally {
            closePreparedStatement(ps);
            closeConnection(conn);
        }
    }

    // Remove a cart item.
    public void removeCartItem(int userId, int productId) throws Exception {
        String sql = "DELETE FROM CartDetail "
                + "WHERE cartId = (SELECT id FROM Cart WHERE userId = ?) "
                + "AND productId = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.executeUpdate();
        } finally {
            closePreparedStatement(ps);
            closeConnection(conn);
        }
    }

    public void clearCart(int userId) throws Exception {
        String sql = "DELETE FROM CartDetail WHERE cartId = (SELECT id FROM Cart WHERE userId = ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.executeUpdate();
        } finally {
            closePreparedStatement(ps);
            closeConnection(conn);
        }
    }

    public int getCartItemCount(int userId) throws Exception {
        int count = 0;
        String sql = "SELECT SUM(quantity) as totalQuantity "
                + "FROM CartDetail "
                + "WHERE cartId = (SELECT id FROM Cart WHERE userId = ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("totalQuantity");
            }
        } finally {
            closeResultSet(rs);
            closePreparedStatement(ps);
            closeConnection(conn);
        }
        return count;
    }

}
