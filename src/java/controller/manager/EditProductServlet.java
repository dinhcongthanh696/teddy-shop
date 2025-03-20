package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import dao.ProductTypeDAO;
import entity.Category;
import entity.Product;
import entity.ProductImage;
import entity.ProductType;
import entity.Size;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;
import java.io.File;

@WebServlet(name = "EditProductServlet", urlPatterns = {"/manager/edit-product"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, 
    maxFileSize = 1024 * 1024 * 10,        
    maxRequestSize = 1024 * 1024 * 50        
)
public class EditProductServlet extends HttpServlet {

    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final ProductTypeDAO productTypeDAO = new ProductTypeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productId = request.getParameter("id");
        if (productId != null && !productId.isEmpty()) {
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getById(Integer.parseInt(productId));
            request.setAttribute("product", product);
            request.setAttribute("categories", categoryDAO.getAllCategories());
            request.setAttribute("productTypes", productTypeDAO.getAllProductTypes());
            request.getRequestDispatcher("/manager/edit-product.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/manager/product-management?");
        }
    }

    private static final String UPLOAD_DIR = "images";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            // Get basic product information
            int productId = Integer.parseInt(request.getParameter("productId"));
            String name = request.getParameter("name");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            int typeId = Integer.parseInt(request.getParameter("typeId"));

            // Create product object
            Product product = new Product();
            product.setId(productId);
            product.setName(name);

            // Set category and type
            Category category = new Category();
            category.setId(categoryId);
            product.setCategory(category);

            ProductType productType = new ProductType();
            productType.setId(typeId);
            product.setProductType(productType);

            // Handle image upload
            List<ProductImage> imageList = new ArrayList<>();
            Part imagePart = request.getPart("image");
            
            if (imagePart != null && imagePart.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + 
                                Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = request.getServletContext().getRealPath("") + File.separator + "images";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                String imagePath = "images" + File.separator + fileName;
                imagePart.write(uploadPath + File.separator + fileName);
                imageList.add(new ProductImage(0, imagePath));
            } else {
                String existingImage = request.getParameter("existingImage");
                if (existingImage != null && !existingImage.isEmpty()) {
                    imageList.add(new ProductImage(0, existingImage));
                }
            }
            product.setImages((ArrayList<ProductImage>) imageList);

            // Handle sizes
            String[] sizeNames = request.getParameterValues("sizeName");
            String[] quantities = request.getParameterValues("quantity");
            String[] prices = request.getParameterValues("price");

            if (sizeNames != null && quantities != null && prices != null) {
                ArrayList<Size> sizes = new ArrayList<>();
                for (int i = 0; i < sizeNames.length; i++) {
                    if (!sizeNames[i].trim().isEmpty()) {
                        Size size = new Size();
                        size.setName(sizeNames[i]);
                        size.setQuantity(Integer.parseInt(quantities[i]));
                        size.setPrice(prices[i]);
                        sizes.add(size);
                    }
                }
                product.setSizes(sizes);
            }

            // Update product in database
            ProductDAO productDAO = new ProductDAO();
            productDAO.updateProduct(product);
            session.setAttribute("notification", "Product updated successfully!");

        } catch (Exception e) {
            session.setAttribute("notificationErr", "Error updating product: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/manager/product-management");
    }
}
