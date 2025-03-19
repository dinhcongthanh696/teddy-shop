/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Product;
import entity.ProductType;
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
public class ProductTypeDAO extends DBConnection {

    public ProductTypeDAO() {
    }

    public ProductType getProductTypeById(int typeId) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        String sql = "SELECT * FROM ProductType where id = " + typeId;
        try {
            ProductType type = new ProductType();
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                type.setId(id);
                type.setName(name);
            }
            return type;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    public ProductType getById(int id) {
        String sql = "SELECT * FROM ProductType WHERE id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    ProductType productType = new ProductType();
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

    public List<ProductType> getAllProductTypes() {
        List<ProductType> productTypes = new ArrayList<>();
        String sql = "SELECT * FROM ProductType";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                ProductType productType = new ProductType();
                productType.setId(rs.getInt("id"));
                productType.setName(rs.getString("name"));
                productTypes.add(productType);
            }
        } catch (SQLException ex) {
            System.out.println("Error retrieving product types: " + ex);
        }
        return productTypes;
    }
}
