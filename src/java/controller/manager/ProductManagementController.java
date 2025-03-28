package controller.manager;

import dao.CategoryDAO;
import dao.ProductDAO;
import dao.ProductTypeDAO;
import entity.Product;
import entity.ProductImage;
import entity.Size;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@WebServlet(name = "ProductManagementController", urlPatterns = {"/manager/product-management"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, 
    maxFileSize = 1024 * 1024 * 10,        
    maxRequestSize = 1024 * 1024 * 50        
)
public class ProductManagementController extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final ProductTypeDAO productTypeDAO = new ProductTypeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // (Filtering and pagination logic remains similar)
        String search = request.getParameter("search");
        String categoryIdStr = request.getParameter("categoryId");
        String typeIdStr = request.getParameter("typeId");
        String priceRange = request.getParameter("priceRange");
        String pageStr = request.getParameter("page");

        Integer categoryId = (categoryIdStr != null && !categoryIdStr.isEmpty()) ? Integer.parseInt(categoryIdStr) : null;
        Integer typeId = (typeIdStr != null && !typeIdStr.isEmpty()) ? Integer.parseInt(typeIdStr) : null;
        Integer minPrice = null, maxPrice = null;

        if (priceRange != null && !priceRange.isEmpty()) {
            if (priceRange.equals("1000000+")) {
                minPrice = 1000000;
            } else {
                String[] priceParts = priceRange.split("-");
                minPrice = Integer.parseInt(priceParts[0]);
                maxPrice = Integer.parseInt(priceParts[1]);
            }
        }

        int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        int pageSize = 12;

        List<Product> allProducts = productDAO.getProductsWithParam(search, categoryId, typeId, minPrice, maxPrice);
        int totalProducts = allProducts.size();
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        List<Product> paginatedProducts = productDAO.Paging(allProducts, page, pageSize);

        request.setAttribute("products", paginatedProducts);
        request.setAttribute("categories", categoryDAO.getAllCategories());
        request.setAttribute("productTypes", productTypeDAO.getAllProductTypes());
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        // Preserve filter parameters
        request.setAttribute("search", search);
        request.setAttribute("categoryId", categoryId);
        request.setAttribute("typeId", typeId);
        request.setAttribute("priceRange", priceRange);

        request.getRequestDispatcher("product-management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            // Retrieve basic product data
            String name = request.getParameter("name");

            // --- Process multiple image uploads ---
            List<ProductImage> imageList = new ArrayList<>();
            Collection<Part> parts = request.getParts();
            // Look for parts with name "images"
            for (Part part : parts) {
                if ("images".equals(part.getName()) && part.getSize() > 0) {
                    // Get only file name (avoiding full path)
                    String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    String uploadPath = request.getServletContext().getRealPath("") + File.separator + "images";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdir();
                    }
                    String imagePath = "images" + File.separator + fileName;
                    part.write(uploadPath + File.separator + fileName);
                    imageList.add(new ProductImage(0, imagePath)); // id will be generated by DB
                }
            }
            
            // --- Process sizes ---
            // Assume inputs are sent as arrays with names: sizeName, sizeQuantity, sizePrice
            String[] sizeNames = request.getParameterValues("sizeName");
            String[] sizeQuantities = request.getParameterValues("sizeQuantity");
            String[] sizePrices = request.getParameterValues("sizePrice");
            List<Size> sizes = new ArrayList<>();
            if (sizeNames != null) {
                for (int i = 0; i < sizeNames.length; i++) {
                    String sName = sizeNames[i];
                    int sQuantity = Integer.parseInt(sizeQuantities[i]);
                    // Store the price as a plain string (formatting will be done when displaying)
                    String sPrice = sizePrices[i];
                    sizes.add(new Size(0, sName, sQuantity, sPrice));
                }
            }
            
            // Retrieve category and type
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            int typeId = Integer.parseInt(request.getParameter("typeId"));

            Product newProduct = new Product();
            newProduct.setName(name);
            newProduct.setImages((ArrayList<ProductImage>) imageList);
            newProduct.setSizes((ArrayList<Size>) sizes);
            newProduct.setCategory(categoryDAO.getById(categoryId));
            newProduct.setProductType(productTypeDAO.getById(typeId));

            productDAO.addProduct(newProduct);
            session.setAttribute("notification", "Product added successfully!");
        } catch (Exception e) {
            session.setAttribute("notificationErr", "Error adding product: " + e.getMessage());
        }
        response.sendRedirect("product-management");
    }
}
