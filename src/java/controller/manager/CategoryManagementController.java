package controller.manager;

import dao.CategoryDAO;
import entity.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "CategoryManagementController", urlPatterns = {"/manager/category-management"})
public class CategoryManagementController extends HttpServlet {
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Category> categories = categoryDAO.getAllCategory();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/manager/category-management.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(CategoryManagementController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        
       
        try {
            switch (action) {
                case "add" -> {
                    String name = request.getParameter("name");
                    Category newCategory = new Category();
                    newCategory.setName(name);
                    categoryDAO.addCategory(newCategory);
                    session.setAttribute("CategoryNotification", "Category added successfully!");
                }
                    
                case "edit" -> {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String name = request.getParameter("name");
                    Category category = new Category();
                    category.setId(id);
                    category.setName(name);
                    categoryDAO.updateCategory(category);
                    session.setAttribute("CategoryNotification", "Category updated successfully!");
                }
                    
                case "delete" -> {
                    int id = Integer.parseInt(request.getParameter("id"));
                    categoryDAO.toggleCategoryStatus(id);
                    session.setAttribute("CategoryNotification", "Category delete successfully!");
                }
            }
        } catch (NumberFormatException e) {
            session.setAttribute("notificationErr", "Error: " + e.getMessage());
        }
        
        response.sendRedirect("category-management");
    }
}