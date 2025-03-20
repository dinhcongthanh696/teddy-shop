/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author OS
 */
public class CategoryDAO extends DBConnection {

    public CategoryDAO() {
    }

    //Get all category
    public ArrayList<Category> getAllCategory() throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<Category> categoryList = new ArrayList<>();
        String sql = "SELECT * FROM Category where [status] = 1 or [status] is null";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                Boolean status = rs.getBoolean("status");
                categoryList.add(new Category(id, name, status));
            }
            return categoryList;
        } catch (SQLException ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    //Get a category with id
    public Category getById(int id) {

        Connection conn = getConnection();
        String sql = "SELECT * FROM Category WHERE ([status] = 1 or [status] is null) and id = ?";
        try {
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, id);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    Category productType = new Category();
                    productType.setId(rs.getInt("id"));
                    productType.setName(rs.getString("Name"));
                    return productType;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Error in product type dao " + ex);
        }
        return null;
    }

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM Category where [status] = 1 or [status] is null";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                categories.add(category);
            }
        } catch (SQLException ex) {
            System.out.println("Error retrieving categories: " + ex);
        }
        return categories;
    }

    // Add these methods to your existing CategoryDAO class
    public void addCategory(Category category) {
        Connection conn = getConnection();

        String sql = "INSERT INTO Category ([name], [status]) VALUES (?, 1)";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, category.getName());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error adding category: " + e.getMessage());
        }
    }

    public void updateCategory(Category category) {
        Connection conn = getConnection();

        String sql = "UPDATE Category SET [name] = ? WHERE id = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, category.getName());
            st.setInt(2, category.getId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error updating category: " + e.getMessage());
        }
    }

    public void toggleCategoryStatus(int id) {
        Connection conn = getConnection();

        String sql = "UPDATE Category SET [status] = 0 WHERE id = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error toggling category status: " + e.getMessage());
        }
    }
}
