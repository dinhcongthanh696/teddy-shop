/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4TestClass.java to edit this template
 */

import dao.DBConnection;
import dao.ProductDAO;
import entity.Category;
import entity.Product;
import entity.ProductImage;
import entity.ProductType;
import entity.Size;
import java.util.ArrayList;
import java.util.Collections;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import static org.junit.Assert.*;

/**
 *
 * @author Admin
 */
public class AddProductTests extends DBConnection {

    public AddProductTests() {
    }

    @BeforeClass
    public static void setUpClass() {
    }

    @AfterClass
    public static void tearDownClass() {
    }

    @Before
    public void setUp() {
    }

    @After
    public void tearDown() {
    }

    @Test
    public void caseNormal() {
        int quantity = 50;
        String price = "300";
        String name = "Baby Three";
        Product product = new Product();
        Category category = new Category();
        ProductType type = new ProductType();
        category.setId(6);
        type.setId(1);
        ArrayList<ProductImage> images = new ArrayList<>();
        images.add(new ProductImage(0, "anh.png"));
        ArrayList<Size> sizes = new ArrayList<>();
        sizes.add(new Size(0, "M (10 cm)", quantity, price));
        product.setName(name);
        product.setImages(images);
        product.setSizes(sizes);
        product.setCategory(category);
        product.setProductType(type);
        ProductDAO productDAO = new ProductDAO();
        productDAO.addProduct(product);
        String countSql = "SELECT COUNT(1) as total FROM Product WHERE name = ?";
        Connection conn = getConnection();
        int actual = 0;
        try {
            PreparedStatement pre = conn.prepareStatement(countSql);
            pre.setString(1, name);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                actual = rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(AddProductTests.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(actual == 0) {
            assertTrue(false);
            return;
        }
        try {
            String deleteSql = "DELETE FROM Size WHERE productid = (select top 1 id from product order by id desc)";
            PreparedStatement pre = conn.prepareStatement(deleteSql);
            pre.executeUpdate();
            deleteSql = "DELETE FROM ProductImage WHERE productid = (select top 1 id from product order by id desc)";
            pre = conn.prepareStatement(deleteSql);
            pre.executeUpdate();
            deleteSql = "DELETE FROM Product WHERE name = ?";
            pre = conn.prepareStatement(deleteSql);
            pre.setString(1, name);
            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AddProductTests.class.getName()).log(Level.SEVERE, null, ex);
        }
        assertTrue(true);
    }
    
    @Test
    public void caseProductNameTooLong() {
        int quantity = 50;
        String price = "300";
        String name = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmno";
        Product product = new Product();
        Category category = new Category();
        ProductType type = new ProductType();
        category.setId(6);
        type.setId(1);
        ArrayList<ProductImage> images = new ArrayList<>();
        images.add(new ProductImage(0, "anh.png"));
        ArrayList<Size> sizes = new ArrayList<>();
        sizes.add(new Size(0, "M (10 cm)", quantity, price));
        product.setName(name);
        product.setImages(images);
        product.setSizes(sizes);
        product.setCategory(category);
        product.setProductType(type);
        ProductDAO productDAO = new ProductDAO();
        productDAO.addProduct(product);
        String countSql = "SELECT COUNT(1) as total FROM Product WHERE name = ?";
        Connection conn = getConnection();
        int actual = 0;
        try {
            PreparedStatement pre = conn.prepareStatement(countSql);
            pre.setString(1, name);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                actual = rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(AddProductTests.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(actual == 0){
            assertTrue(true);
            return;
        }
        try {
            String deleteSql = "DELETE FROM Size WHERE productid = (select top 1 id from product order by id desc)";
            PreparedStatement pre = conn.prepareStatement(deleteSql);
            pre.executeUpdate();
            deleteSql = "DELETE FROM ProductImage WHERE productid = (select top 1 id from product order by id desc)";
            pre = conn.prepareStatement(deleteSql);
            pre.executeUpdate();
            deleteSql = "DELETE FROM Product WHERE name = ?";
            pre = conn.prepareStatement(deleteSql);
            pre.setString(1, name);
            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AddProductTests.class.getName()).log(Level.SEVERE, null, ex);
        }
        assertTrue(false);
    }
    
    @Test
    public void caseProductNameIsNotValid() {
        int quantity = 50;
        String price = "300";
        String name = "123@";
        Product product = new Product();
        Category category = new Category();
        ProductType type = new ProductType();
        category.setId(6);
        type.setId(1);
        ArrayList<ProductImage> images = new ArrayList<>();
        images.add(new ProductImage(0, "anh.png"));
        ArrayList<Size> sizes = new ArrayList<>();
        sizes.add(new Size(0, "M (10 cm)", quantity, price));
        product.setName(name);
        product.setImages(images);
        product.setSizes(sizes);
        product.setCategory(category);
        product.setProductType(type);
        ProductDAO productDAO = new ProductDAO();
        productDAO.addProduct(product);
        String countSql = "SELECT COUNT(1) as total FROM Product WHERE name = ?";
        Connection conn = getConnection();
        int actual = 0;
        try {
            PreparedStatement pre = conn.prepareStatement(countSql);
            pre.setString(1, name);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                actual = rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(AddProductTests.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(actual == 0) {
            assertTrue(true);
            return;
        }
        try {
            String deleteSql = "DELETE FROM Size WHERE productid = (select top 1 id from product order by id desc)";
            PreparedStatement pre = conn.prepareStatement(deleteSql);
            pre.executeUpdate();
            deleteSql = "DELETE FROM ProductImage WHERE productid = (select top 1 id from product order by id desc)";
            pre = conn.prepareStatement(deleteSql);
            pre.executeUpdate();
            deleteSql = "DELETE FROM Product WHERE name = ?";
            pre = conn.prepareStatement(deleteSql);
            pre.setString(1, name);
            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AddProductTests.class.getName()).log(Level.SEVERE, null, ex);
        }
        assertTrue(false);
    }
    
    @Test
    public void caseProductNameIsEmpty() {
        int quantity = 50;
        String price = "300";
        String name = " ";
        Product product = new Product();
        Category category = new Category();
        ProductType type = new ProductType();
        category.setId(6);
        type.setId(1);
        ArrayList<ProductImage> images = new ArrayList<>();
        images.add(new ProductImage(0, "anh.png"));
        ArrayList<Size> sizes = new ArrayList<>();
        sizes.add(new Size(0, "M (10 cm)", quantity, price));
        product.setName(name);
        product.setImages(images);
        product.setSizes(sizes);
        product.setCategory(category);
        product.setProductType(type);
        ProductDAO productDAO = new ProductDAO();
        productDAO.addProduct(product);
        String countSql = "SELECT COUNT(1) as total FROM Product WHERE name = ?";
        Connection conn = getConnection();
        int actual = 0;
        try {
            PreparedStatement pre = conn.prepareStatement(countSql);
            pre.setString(1, name);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                actual = rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(AddProductTests.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(actual == 0) {
            assertTrue(true);
            return;
        }
        try {
            String deleteSql = "DELETE FROM Size WHERE productid = (select top 1 id from product order by id desc)";
            PreparedStatement pre = conn.prepareStatement(deleteSql);
            pre.executeUpdate();
            deleteSql = "DELETE FROM ProductImage WHERE productid = (select top 1 id from product order by id desc)";
            pre = conn.prepareStatement(deleteSql);
            pre.executeUpdate();
            deleteSql = "DELETE FROM Product WHERE name = ?";
            pre = conn.prepareStatement(deleteSql);
            pre.setString(1, name);
            pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AddProductTests.class.getName()).log(Level.SEVERE, null, ex);
        }
        assertTrue(false);
    }
}
