package controller;

import dao.ProductDAO;
import entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ProductDetailsController", urlPatterns = {"/product-details"})
public class ProductDetailsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get product ID from request parameter
            String productId = request.getParameter("id");
            
            if (productId == null || productId.trim().isEmpty()) {
                response.sendRedirect("MenuController?service=allProduct");
                return;
            }

            // Get product details from database
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getById(Integer.parseInt(productId));
            
            if (product == null) {
                response.sendRedirect("MenuController?service=allProduct");
                return;
            }

            // Set product as request attribute
            request.setAttribute("product", product);
            
            // Forward to product view page
            request.getRequestDispatcher("/jsp/productView.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            System.out.println("Error parsing product ID: " + e.getMessage());
            response.sendRedirect("MenuController?service=allProduct");
        } catch (Exception e) {
            System.out.println("Error in ProductDetailsController: " + e.getMessage());
            response.sendRedirect("MenuController?service=allProduct");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}