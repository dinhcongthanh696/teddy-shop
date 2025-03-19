/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Category;
import entity.Product;
import entity.ProductImage;
import entity.ProductType;
import entity.Size;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author OS
 */
public class ProductDAO extends DBConnection {

    private CategoryDAO categoryDAO = new CategoryDAO();
    private ProductTypeDAO productTypeDAO = new ProductTypeDAO();

    public ProductDAO() {
    }

    public ArrayList<ProductImage> getProductImages(int productId) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        ArrayList<ProductImage> images = new ArrayList<>();
        String sql = "select * from ProductImage where productId = " + productId;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String source = rs.getString("source");
                images.add(new ProductImage(id, source));
            }
            return images;
        } catch (Exception ex) {
            throw ex;
        } 
    }

    public ArrayList<Size> getProductSizes(int productId) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        ArrayList<Size> sizes = new ArrayList<>();
        String sql = "select * from Size where productId = " + productId;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                int quantity = rs.getInt("quantity");
                int priceNumber = rs.getInt("price");
                DecimalFormatSymbols symbols = new DecimalFormatSymbols(Locale.getDefault());
                symbols.setGroupingSeparator('.');
                DecimalFormat decimalFormat = new DecimalFormat("#,###", symbols);
                String price = decimalFormat.format(priceNumber);
                sizes.add(new Size(id, name, quantity, price));
            }
            return sizes;
        } catch (Exception ex) {
            throw ex;
        } 
    }

    public ArrayList<Product> getAllProduct() throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<Product> productList = new ArrayList<>();
        String sql = "SELECT * FROM Product";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                ArrayList<ProductImage> images = getProductImages(id);
                ArrayList<Size> sizes = getProductSizes(id);
                int categoryId = rs.getInt("categoryId");
                int typeId = rs.getInt("typeId");
                Category category = categoryDAO.getById(categoryId);
                ProductType type = productTypeDAO.getProductTypeById(typeId);
                productList.add(new Product(id, name, images, sizes, type, category));
            }
            return productList;
        } catch (Exception ex) {
            throw ex;
        }
    }

    public ArrayList<Product> getProductByCategory(int categoryID) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<Product> productList = new ArrayList<>();
        String sql = "SELECT * FROM Product where categoryId = " + categoryID;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                ArrayList<ProductImage> images = getProductImages(id);
                ArrayList<Size> sizes = getProductSizes(id);
                int categoryId = rs.getInt("categoryId");
                int typeId = rs.getInt("typeId");
                Category category = categoryDAO.getById(categoryId);
                ProductType type = productTypeDAO.getProductTypeById(typeId);
                productList.add(new Product(id, name, images, sizes, type, category));
            }
            return productList;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    public ArrayList<Product> getProductByType(int typeID) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<Product> productList = new ArrayList<>();
        String sql = "SELECT * FROM Product where typeId = " + typeID;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                ArrayList<ProductImage> images = getProductImages(id);
                ArrayList<Size> sizes = getProductSizes(id);
                int categoryId = rs.getInt("categoryId");
                int typeId = rs.getInt("typeId");
                Category category = categoryDAO.getById(categoryId);
                ProductType type = productTypeDAO.getProductTypeById(typeId);
                productList.add(new Product(id, name, images, sizes, type, category));
            }
            return productList;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    public ArrayList<Product> getProductByText(String text) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<Product> productList = new ArrayList<>();
        String sql = "select p.*from Product p "
                + "inner join Category c on p.categoryId = c.id "
                + "inner join ProductType pt on pt.id = p.typeId "
                + "where p.name COLLATE Latin1_General_CI_AI like '%" + text + "%' "
                + "OR c.name COLLATE Latin1_General_CI_AI like '%" + text + "%'  "
                + "OR pt.name COLLATE Latin1_General_CI_AI like '%" + text + "%'";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                ArrayList<ProductImage> images = getProductImages(id);
                ArrayList<Size> sizes = getProductSizes(id);
                int categoryId = rs.getInt("categoryId");
                int typeId = rs.getInt("typeId");
                Category category = categoryDAO.getById(categoryId);
                ProductType type = productTypeDAO.getProductTypeById(typeId);
                productList.add(new Product(id, name, images, sizes, type, category));
            }
            return productList;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }

    }

    public List<Product> getProductsWithParam(String searchParam, Integer categoryId, Integer typeId, Integer minPrice, Integer maxPrice) {
        List<Product> products = new ArrayList<>();
        List<Object> params = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM Product p WHERE 1=1 ");

        if (searchParam != null && !searchParam.trim().isEmpty()) {
            query.append("AND p.name LIKE ? ");
            params.add("%" + searchParam + "%");
        }
        if (categoryId != null) {
            query.append("AND p.categoryId = ? ");
            params.add(categoryId);
        }
        if (typeId != null) {
            query.append("AND p.typeId = ? ");
            params.add(typeId);
        }
        if (minPrice != null) {
            query.append("AND EXISTS (SELECT 1 FROM Size s WHERE s.productId = p.id AND s.price >= ?) ");
            params.add(minPrice);
        }
        if (maxPrice != null) {
            query.append("AND EXISTS (SELECT 1 FROM Size s WHERE s.productId = p.id AND s.price <= ?) ");
            params.add(maxPrice);
        }
        query.append("ORDER BY p.id DESC");

        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        try {
            preparedStatement = connection.prepareStatement(query.toString());
            mapParams(preparedStatement, params);
            rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int productId = rs.getInt("id");
                String name = rs.getString("name");
                ArrayList<ProductImage> images = getProductImages(productId);
                ArrayList<Size> sizes = getProductSizes(productId);
                int catId = rs.getInt("categoryId");
                int tId = rs.getInt("typeId");
                ProductType productType = productTypeDAO.getById(tId);
                Category category = categoryDAO.getById(catId);
                Product product = new Product(productId, name, images, sizes, productType, category);
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public void addProduct(Product product) {
        String sql = "INSERT INTO Product (name, categoryId, typeId) VALUES (?, ?, ?)";
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, product.getName());
            statement.setInt(2, product.getCategory().getId());
            statement.setInt(3, product.getProductType().getId());
            statement.executeUpdate();
            rs = statement.getGeneratedKeys();
            int productId = 0;
            if (rs.next()) {
                productId = rs.getInt(1);
            }

            // Insert product images
            if (product.getImages() != null && !product.getImages().isEmpty()) {
                String sqlImage = "INSERT INTO ProductImage (productId, source) VALUES (?, ?)";
                PreparedStatement imgStmt = connection.prepareStatement(sqlImage);
                for (ProductImage img : product.getImages()) {
                    imgStmt.setInt(1, productId);
                    imgStmt.setString(2, img.getSource());
                    imgStmt.addBatch();
                }
                imgStmt.executeBatch();
                imgStmt.close();
            }

            // Insert product sizes
            if (product.getSizes() != null && !product.getSizes().isEmpty()) {
                String sqlSize = "INSERT INTO Size (productId, name, quantity, price) VALUES (?, ?, ?, ?)";
                PreparedStatement sizeStmt = connection.prepareStatement(sqlSize);
                for (Size s : product.getSizes()) {
                    sizeStmt.setInt(1, productId);
                    sizeStmt.setString(2, s.getName());
                    sizeStmt.setInt(3, s.getQuantity());
                    // Assuming price is stored as a number in the DB; if not, adjust accordingly.
                    sizeStmt.setInt(4, Integer.parseInt(s.getPrice().replace(".", "")));
                    sizeStmt.addBatch();
                }
                sizeStmt.executeBatch();
                sizeStmt.close();
            }

        } catch (SQLException ex) {
            System.out.println("Error adding product: " + ex);
        }
    }

    public Product getById(int id) {
        String sql = "SELECT * FROM Product WHERE id = ?";
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            rs = statement.executeQuery();
            if (rs.next()) {
                int productId = rs.getInt("id");
                String name = rs.getString("name");
                ArrayList<ProductImage> images = getProductImages(productId);
                ArrayList<Size> sizes = getProductSizes(productId);
                int categoryId = rs.getInt("categoryId");
                int typeId = rs.getInt("typeId");
                Category category = categoryDAO.getById(categoryId);
                ProductType productType = productTypeDAO.getProductTypeById(typeId);
                return new Product(productId, name, images, sizes, productType, category);
            }
        } catch (SQLException ex) {
            System.out.println("Error fetching product: " + ex);
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return null;
    }

    public void mapParams(PreparedStatement ps, List<Object> args) throws SQLException {
        int i = 1;
        for (Object arg : args) {
            if (arg instanceof Date) {
                ps.setTimestamp(i++, new Timestamp(((Date) arg).getTime()));
            } else if (arg instanceof Integer) {
                ps.setInt(i++, (Integer) arg);
            } else if (arg instanceof Long) {
                ps.setLong(i++, (Long) arg);
            } else if (arg instanceof Double) {
                ps.setDouble(i++, (Double) arg);
            } else if (arg instanceof Float) {
                ps.setFloat(i++, (Float) arg);
            } else {
                ps.setString(i++, (String) arg);
            }

        }
    }

    public List<Product> Paging(List<Product> products, int page, int pageSize) {
        int fromIndex = (page - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, products.size());

        if (fromIndex > toIndex) {
            // Handle the case where fromIndex is greater than toIndex
            fromIndex = toIndex;
        }

        return products.subList(fromIndex, toIndex);
    }

}
